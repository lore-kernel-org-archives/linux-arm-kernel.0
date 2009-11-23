From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 23 Nov 2009 14:44:39 +0100
Subject: [PATCH 6/8 v2] S3C: merge ADC drivers and add support for the
	S3C64xx
In-Reply-To: <20091123000944.GG4808@trinity.fluff.org>
References: <b2e8f9f70911200404w12cc286fw3fa763c3e04fa1f9@mail.gmail.com>
	<200911201416.16299.anarsoul@gmail.com>
	<4B06A8F4.5070307@gmail.com>
	<b2e8f9f70911210759u6f51c8e4g66714e7fd83cab70@mail.gmail.com>
	<20091123000944.GG4808@trinity.fluff.org>
Message-ID: <4B0A91C7.7070301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 23-11-09 01:09, Ben Dooks schreef:
> On Sat, Nov 21, 2009 at 04:59:21PM +0100, Maurus Cuelenaere wrote:
>    
>> This moves the S3C24xx ADC driver to plat-s3c and adds support
>> for the S3C64xx.
>>      
> it would have been nicer to have the move then the addition in a
> seperate patch.
>    

Ok, patch can be splitted.

> secondly, I'm probably going to hold off on these changes pending actually
> trying to get some time together to fix up plat-samsung where these
> files probably should end up being moved to.
>    

Hmm, then I'll probably wait with posting a reworked version of this 
till plat-samsung gets in.

>   
>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>>
>> ---
>>   arch/arm/mach-s3c6400/include/mach/map.h  |    1 +
>>   arch/arm/plat-s3c/Kconfig                 |    9 +++++
>>   arch/arm/plat-s3c/Makefile                |    4 ++
>>   arch/arm/{plat-s3c24xx =>  plat-s3c}/adc.c |   21 +++++++++--
>>   arch/arm/plat-s3c/include/plat/adc.h      |    6 +++-
>>   arch/arm/plat-s3c/include/plat/regs-adc.h |    2 +
>>   arch/arm/plat-s3c24xx/Kconfig             |    7 ----
>>   arch/arm/plat-s3c24xx/Makefile            |    1 -
>>   arch/arm/plat-s3c24xx/devs.c              |   14 ++++++--
>>   arch/arm/plat-s3c64xx/Makefile            |    4 ++
>>   arch/arm/plat-s3c64xx/dev-adc.c           |   51 +++++++++++++++++++++++++++++
>>   11 files changed, 103 insertions(+), 17 deletions(-)
>>   rename arch/arm/{plat-s3c24xx =>  plat-s3c}/adc.c (96%)
>>   create mode 100644 arch/arm/plat-s3c64xx/dev-adc.c
>>
>> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
>> b/arch/arm/mach-s3c6400/include/mach/map.h
>> index fc8b223..b66bfaf 100644
>> --- a/arch/arm/mach-s3c6400/include/mach/map.h
>> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
>> @@ -42,6 +42,7 @@
>>   #define S3C64XX_PA_FB		(0x77100000)
>>   #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
>>   #define S3C64XX_PA_WATCHDOG	(0x7E004000)
>> +#define S3C64XX_PA_ADC		(0x7E00B000)
>>   #define S3C64XX_PA_SYSCON	(0x7E00F000)
>>   #define S3C64XX_PA_AC97		(0x7F001000)
>>   #define S3C64XX_PA_IIS0		(0x7F002000)
>> diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
>> index 8931c5f..82ed66d 100644
>> --- a/arch/arm/plat-s3c/Kconfig
>> +++ b/arch/arm/plat-s3c/Kconfig
>> @@ -166,6 +166,15 @@ config S3C_DMA
>>   	help
>>   	  Internal configuration for S3C DMA core
>>
>> +# ADC
>> +
>> +config S3C_ADC
>> +	bool "ADC common driver support"
>> +	help
>> +	  Core support for the ADC block found in the S3C SoC systems
>> +	  for drivers such as the touchscreen and hwmon to use to share
>> +	  this resource.
>> +
>>   # device definitions to compile in
>>
>>   config S3C_DEV_HSMMC
>> diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
>> index 3c09109..788056a 100644
>> --- a/arch/arm/plat-s3c/Makefile
>> +++ b/arch/arm/plat-s3c/Makefile
>> @@ -22,6 +22,10 @@ obj-y				+= gpio-config.o
>>
>>   obj-$(CONFIG_S3C_DMA)		+= dma.o
>>
>> +# ADC support
>> +
>> +obj-$(CONFIG_S3C_ADC)		+= adc.o
>> +
>>   # PM support
>>
>>   obj-$(CONFIG_PM)		+= pm.o
>> diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c/adc.c
>> similarity index 96%
>> rename from arch/arm/plat-s3c24xx/adc.c
>> rename to arch/arm/plat-s3c/adc.c
>> index df47322..76cb740 100644
>> --- a/arch/arm/plat-s3c24xx/adc.c
>> +++ b/arch/arm/plat-s3c/adc.c
>> @@ -1,10 +1,10 @@
>> -/* arch/arm/plat-s3c24xx/adc.c
>> +/* arch/arm/plat-s3c/adc.c
>>    *
>>    * Copyright (c) 2008 Simtec Electronics
>>    *	http://armlinux.simtec.co.uk/
>>    *	Ben Dooks<ben@simtec.co.uk>,<ben-linux@fluff.org>
>>    *
>> - * S3C24XX ADC device core
>> + * S3C ADC device core
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License as published by
>> @@ -64,6 +64,7 @@ struct adc_device {
>>   	unsigned int		 prescale;
>>
>>   	int			 irq;
>> +	struct s3c_adc_platdata* pd;
>>   };
>>
>>   static struct adc_device *adc_dev;
>> @@ -262,7 +263,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
>>
>>   	if (!client) {
>>   		dev_warn(&adc->pdev->dev, "%s: no adc pending\n", __func__);
>> -		return IRQ_HANDLED;
>> +		goto exit;
>>   	}
>>
>>   	data0 = readl(adc->regs + S3C2410_ADCDAT0);
>> @@ -289,16 +290,27 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
>>   		local_irq_restore(flags);
>>   	}
>>
>> +exit:
>> +	if(adc->pd->adc_type == 1)
>> +		writel(0, adc->regs + S3C6410_ADCCLRI);
>> +
>>      
> formattign error, if (...
>    

Will fix.

>    	return IRQ_HANDLED;
>    
>>   }
>>
>>   static int s3c_adc_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev =&pdev->dev;
>> +	struct s3c_adc_platdata *pd;
>>   	struct adc_device *adc;
>>   	struct resource *regs;
>>   	int ret;
>>
>> +	pd = pdev->dev.platform_data;
>> +	if (!pd) {
>> +		dev_err(dev, "no platform data specified\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
>>   	if (adc == NULL) {
>>   		dev_err(dev, "failed to allocate adc_device\n");
>> @@ -306,6 +318,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
>>   	}
>>
>>   	adc->pdev = pdev;
>> +	adc->pd = pd;
>>   	adc->prescale = S3C2410_ADCCON_PRSCVL(49);
>>
>>   	adc->irq = platform_get_irq(pdev, 1);
>> @@ -412,7 +425,7 @@ static int s3c_adc_resume(struct platform_device *pdev)
>>
>>   static struct platform_driver s3c_adc_driver = {
>>   	.driver		= {
>> -		.name	= "s3c24xx-adc",
>> +		.name	= "s3c-adc",
>>   		.owner	= THIS_MODULE,
>>   	},
>>   	.probe		= s3c_adc_probe,
>> diff --git a/arch/arm/plat-s3c/include/plat/adc.h
>> b/arch/arm/plat-s3c/include/plat/adc.h
>> index 5f3b1cd..a8c9f27 100644
>> --- a/arch/arm/plat-s3c/include/plat/adc.h
>> +++ b/arch/arm/plat-s3c/include/plat/adc.h
>> @@ -4,7 +4,7 @@
>>    *	http://armlinux.simnte.co.uk/
>>    *	Ben Dooks<ben@simtec.co.uk>
>>    *
>> - * S3C24XX ADC driver information
>> + * S3C ADC driver information
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License version 2 as
>> @@ -14,6 +14,10 @@
>>   #ifndef __ASM_PLAT_ADC_H
>>   #define __ASM_PLAT_ADC_H __FILE__
>>
>> +struct s3c_adc_platdata {
>> +	int adc_type;
>> +};
>> +
>>      
> change the device name for the newer devices and use that as the key.

I suppose using platform_device_id's like I did with my RTC patch will 
work too?

Regards,
Maurus Cuelenaere
