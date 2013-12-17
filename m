From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Tue, 17 Dec 2013 12:33:28 +0200
Subject: [PATCH v3 9/9] mtd: nand: davinci: don't request AEMIF address
 range
In-Reply-To: <20131217084238.GJ12034@norris-Latitude-E6410>
References: <1386264358-9738-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386264358-9738-10-git-send-email-ivan.khoronzhuk@ti.com>
 <20131217084238.GJ12034@norris-Latitude-E6410>
Message-ID: <52B02878.8090703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 10:42 AM, Brian Norris wrote:
> On Thu, Dec 05, 2013 at 07:25:57PM +0200, Ivan Khoronzhuk wrote:
>> The TI AEMIF driver registers are used to setup timings for each chip
>> select. The same registers range is used to setup NAND settings.
>> The AEMIF and NAND drivers not use the same registers in this range.
>>
>> In case with TI AEMIF driver, the memory address range is requested
>> already by AEMIF, so we cannot request it twice, just ioremap.
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Reviewed-by: Taras Kondratiuk <taras@ti.com>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   drivers/mtd/nand/davinci_nand.c |    8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>> index f7b21b8..0cd4dbc 100644
>> --- a/drivers/mtd/nand/davinci_nand.c
>> +++ b/drivers/mtd/nand/davinci_nand.c
>> @@ -636,9 +636,11 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
>>   	if (IS_ERR(vaddr))
>>   		return PTR_ERR(vaddr);
>>
>> -	base = devm_ioremap_resource(&pdev->dev, res2);
>> -	if (IS_ERR(base))
>> -		return PTR_ERR(base);
>> +	base = devm_ioremap(&pdev->dev, res2->start, resource_size(res2));
>
> Since it's important that we don't re-introduce the "request resource"
> boilerplate later, can you add a comment describing the situation?
>
>> +	if (!base) {
>> +		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res2);
>> +		return -EADDRNOTAVAIL;
>> +	}
>>
>>   	info->dev		= &pdev->dev;
>>   	info->base		= base;
>
> Thanks,
> Brian
>

Yes, I'll add the comment.

-- 
Regards,
Ivan Khoronzhuk
