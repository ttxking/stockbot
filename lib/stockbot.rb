# Anusid Wachiracharoenwong
# 6201546714

require 'open-uri'
require 'nokogiri'

class Stockbot
    
    def self.showinfo

        prefix = ['NUMBER',*'a'..'z']

        prefix.each do |e|
            html = URI.open("https://www.set.or.th/set/commonslookup.do?prefix=#{e}")
            response = Nokogiri::HTML(html)


            response.css("tr td a").each do |x|
                detail_url = 'https://www.set.or.th' + x["href"]
                detail_page = URI.open(detail_url)
                detail = Nokogiri::HTML(detail_page)
                name = detail.css("div h3").text

                # get assests
                detail_url["profile"] = "highlight"
                assests_page = URI.open(detail_url)
                assests = Nokogiri::HTML(assests_page)
                lastest_assests = assests.css("#maincontent > div > div.table-responsive > table > tbody:nth-child(3) > tr:nth-child(2) > td:nth-last-child(-n+2)").text

                unless !lastest_assests.strip.empty?
                    lastest_assests = assests.css("#maincontent > div > div.table-responsive > table > tbody:nth-child(3) > tr:nth-child(2) > td:nth-last-child(-n+2)").text
                end

                puts "#{name} : #{lastest_assests}"
            end
        end
    end 
end


