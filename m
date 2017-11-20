From: arvind.yadav.cs@gmail.com (arvindY)
Date: Mon, 20 Nov 2017 21:31:40 +0530
Subject: [alsa-devel] [PATCH 1/5 v4] ASoC: ep93xx-ac97: Fix
 platform_get_irq's error checking
In-Reply-To: <20171120133717.kscrjsb3y7gnvd2t@piout.net>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
 <20171120133717.kscrjsb3y7gnvd2t@piout.net>
Message-ID: <5A12FC64.3020205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 20 November 2017 07:07 PM, Alexandre Belloni wrote:
> On 19/11/2017 at 09:45:00 +0530, Arvind Yadav wrote:
>> The platform_get_irq() function returns negative if an error occurs.
>> zero or positive number on success. platform_get_irq() error checking
>> for zero is not correct.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>> changes in v2 :
>>                 irq was unsigned. so changed it to signed.
>> changes in v3 :
>>                Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
>> changes in v4 :
>>                Return -ENODEV insted of irq.
>>
> To ensure this doesn't get applied: platform_get_irq can return
> -EPROBE_DEFER and this must be handled properly.
>
> (Or maybe this has never caused anything and never failed at all and
> nobody cares).
Yes, you are right. We should retry to get an irq for device. But ASoC
  driver is not retrying. if platfore_get_irq() fail here, Driver is 
throwing an error.
and this patch is only to fix error checking which is not correct in 
Driver.

~arvind

>
>>   sound/soc/cirrus/ep93xx-ac97.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
>> index bbf7a92..efeecee 100644
>> --- a/sound/soc/cirrus/ep93xx-ac97.c
>> +++ b/sound/soc/cirrus/ep93xx-ac97.c
>> @@ -365,7 +365,7 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
>>   {
>>   	struct ep93xx_ac97_info *info;
>>   	struct resource *res;
>> -	unsigned int irq;
>> +	int irq;
>>   	int ret;
>>   
>>   	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>> @@ -378,7 +378,7 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
>>   		return PTR_ERR(info->regs);
>>   
>>   	irq = platform_get_irq(pdev, 0);
>> -	if (!irq)
>> +	if (irq <= 0)
>>   		return -ENODEV;
>>   
>>   	ret = devm_request_irq(&pdev->dev, irq, ep93xx_ac97_interrupt,
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel at alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
