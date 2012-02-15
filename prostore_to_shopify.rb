require 'rubygems'
require 'csv'

shopify_file = CSV.open("shopify_products.csv", "w")
ps_image_folder = "http://www.yobelmarket.com/catalog/"

shopify_file << "Handle,Title,Body (HTML),Vendor,Type,Tags,Option1 Name,Option1 Value,Option2 Name,Option2 Value,Option3 Name,Option3 Value,Variant SKU,Variant Grams,Variant Inventory Tracker,Variant Inventory Qty,Variant Inventory Policy,Variant Fulfillment Service,Variant Price,Variant Compare At Price,Variant Requires Shipping,Variant Taxable,Image Src".split(',')

CSV.foreach("product.csv",
			:headers => true) do |pro_stores_row|

	
	shopify_row = []
	shopify_row << pro_stores_row[1].gsub(' ', "_").downcase 	#Handle
	shopify_row << pro_stores_row[1]							#Title
	shopify_row << pro_stores_row[24]							#Body / Description

	if(pro_stores_row[4])										
		shopify_row << pro_stores_row[4]						#Vendor
	else
		shopify_row << "Yobel Market"							#Vendor
	end
	
	if(pro_stores_row[49].to_s.length > 2)						
		shopify_row << pro_stores_row[49]						#Type
	else
		shopify_row << "Default Type"							#Type
	end															
	
	shopify_row << pro_stores_row[51]							#Tags
	shopify_row << pro_stores_row[56]							#Option1 Name
	shopify_row << pro_stores_row[57]							#Option1 Value
	shopify_row << pro_stores_row[60]							#Option2 Name
	shopify_row << pro_stores_row[61]							#Option2 Value
	shopify_row << pro_stores_row[64]							#Option3 Name
	shopify_row << pro_stores_row[65]							#Option3 Value
	shopify_row << pro_stores_row[2]							#Variant SKU
	shopify_row << pro_stores_row[18]							#Variant Grams
	shopify_row << ''											#Variant Inventory Tracker
	shopify_row << 1											#Variant Inventory Qty
	shopify_row << 'deny'										#Variant Inventory Policy
	shopify_row << 'manual'										#Variant Fulfillment Service
	shopify_row << pro_stores_row[7].gsub('$','')				#Variant Price
	shopify_row << ''											#Variant Compare At Price
	
	if(pro_stores_row[12].downcase == "yes")
		shopify_row << 'true'									#Variant Requires Shipping
	else
		shopify_row << 'false'									#Variant Requires Shipping
	end

	if(pro_stores_row[9].downcase == "yes")
		shopify_row << 'true'									#Variant Taxable
	else
		shopify_row << 'false'									#Variant Taxable
	end

	if(pro_stores_row[27])
		shopify_row << (ps_image_folder + pro_stores_row[27])		#Image Src
	else
		shopify_row << ''
	end

	shopify_file << shopify_row
end