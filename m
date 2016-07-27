From: tthayer@opensource.altera.com (Thor Thayer)
Date: Wed, 27 Jul 2016 13:43:04 -0500
Subject: [PATCH 05/10] EDAC, altera: Add Arria10 NAND EDAC support
In-Reply-To: <20160727171035.GA23851@nazgul.tnic>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
 <1468512408-5156-6-git-send-email-tthayer@opensource.altera.com>
 <20160727171035.GA23851@nazgul.tnic>
Message-ID: <579900B8.3020502@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/27/2016 12:10 PM, Borislav Petkov wrote:
> On Thu, Jul 14, 2016 at 11:06:43AM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add Altera Arria10 NAND FIFO memory EDAC support.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>>   drivers/edac/Kconfig       |    7 +++++++
>>   drivers/edac/altera_edac.c |   34 +++++++++++++++++++++++++++++++++-
>>   2 files changed, 40 insertions(+), 1 deletion(-)
>
> ...
>
>> @@ -1589,7 +1619,9 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>>   		else if ((of_device_is_compatible(child,
>>   					"altr,socfpga-a10-ocram-ecc")) ||
>>   			 (of_device_is_compatible(child,
>> -					"altr,socfpga-eth-mac-ecc")))
>> +					"altr,socfpga-eth-mac-ecc")) ||
>> +			 (of_device_is_compatible(child,
>> +						  "altr,socfpga-nand-ecc")))
>>   			altr_edac_a10_device_add(edac, child);
>>   		else if (of_device_is_compatible(child,
>>   						 "altr,sdram-edac-a10"))
>
> Can we simplify this loop like this?
>
> 	for_each_child_of_node(pdev->dev.of_node, child) {
> 		if (!of_device_is_available(child))
> 			continue;
>
> 		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc") ||
> 		    of_device_is_compatible(child, "altr,socfpga-a10-ocram-ecc") ||
> 		    of_device_is_compatible(child, "altr,socfpga-eth-mac-ecc") ||
> 		    of_device_is_compatible(child, "altr,socfpga-nand-ecc"))
>
> 			altr_edac_a10_device_add(edac, child);
>
> 		else if (of_device_is_compatible(child, "altr,sdram-edac-a10"))
> 			of_platform_populate(pdev->dev.of_node,
> 					     altr_sdram_ctrl_of_match,
> 					     NULL, &pdev->dev);
> 	}
>
> I've merged the first "if" and subsequent "else if" because they all
> do altr_edac_a10_device_add(edac, child) and added spacing for better
> readability.
>
> Look ok?
>
> Or have I fatfingered it?
>

Yes, that's better. I was trying to stay within the 80 character limit 
but missed the if/else if improvement. Thanks, Boris!

Should I re-submit?

Thanks,

Thor
