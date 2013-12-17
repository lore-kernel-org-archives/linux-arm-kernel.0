From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Tue, 17 Dec 2013 14:19:12 +0200
Subject: [PATCH v3 7/9] mtd: nand: davinci: adjust DT properties to MTD
 generic
In-Reply-To: <20131217085027.GK12034@norris-Latitude-E6410>
References: <1386264358-9738-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386264358-9738-8-git-send-email-ivan.khoronzhuk@ti.com>
 <20131217085027.GK12034@norris-Latitude-E6410>
Message-ID: <52B04140.1060709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 10:50 AM, Brian Norris wrote:
> On Thu, Dec 05, 2013 at 07:25:55PM +0200, Ivan Khoronzhuk wrote:
>> --- a/drivers/mtd/nand/davinci_nand.c
>> +++ b/drivers/mtd/nand/davinci_nand.c
>> @@ -558,6 +557,8 @@ static struct davinci_nand_pdata
>>   			"ti,davinci-mask-chipsel", &prop))
>>   			pdata->mask_chipsel = prop;
>>   		if (!of_property_read_string(pdev->dev.of_node,
>> +			"nand-ecc-mode", &mode) ||
> 
> Is it possible to use the of_get_nand_ecc_mode() helper? It's
> unfortunate that davinci_nand had to use custom bindings in the first
> place, making this more difficult... So I can take this patch as-is.
> 

Yes, I will do nothing for that

>> +		    !of_property_read_string(pdev->dev.of_node,
>>   			"ti,davinci-ecc-mode", &mode)) {
>>   			if (!strncmp("none", mode, 4))
>>   				pdata->ecc_mode = NAND_ECC_NONE;
>> @@ -570,11 +571,15 @@ static struct davinci_nand_pdata
>>   			"ti,davinci-ecc-bits", &prop))
>>   			pdata->ecc_bits = prop;
>>   		if (!of_property_read_u32(pdev->dev.of_node,
>> +			"nand-bus-width", &prop) ||
> 
> Similar story here, with of_get_nand_bus_width().
> 

It seems for bus width I can replace it on:

prop = of_get_nand_bus_width(pdev->dev.of_node);
if ( 0 < prop || !of_property_read_u32(pdev->dev.of_node,
	     "ti,davinci-nand-buswidth", &prop))
     if (prop == 16)
	     pdata->options |= NAND_BUSWIDTH_16;


>> +		    !of_property_read_u32(pdev->dev.of_node,
>>   			"ti,davinci-nand-buswidth", &prop))
>>   			if (prop == 16)
>>   				pdata->options |= NAND_BUSWIDTH_16;
>> -		if (of_find_property(pdev->dev.of_node,
>> -			"ti,davinci-nand-use-bbt", &len))
>> +		if (of_property_read_bool(pdev->dev.of_node,
>> +			"nand-on-flash-bbt") ||
>> +		    of_property_read_bool(pdev->dev.of_node,
>> +			"ti,davinci-nand-use-bbt"))
>>   			pdata->bbt_options = NAND_BBT_USE_FLASH;
>>   	}
>>   
> 
> Brian
> 


-- 
Regards,
Ivan Khoronzhuk
