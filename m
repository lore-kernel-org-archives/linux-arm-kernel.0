From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 15:34:28 +0100
Subject: [PATCH 6/8] S3C: merge ADC drivers and add support for the S3C64xx
In-Reply-To: <200911201416.16299.anarsoul@gmail.com>
References: <b2e8f9f70911200404w12cc286fw3fa763c3e04fa1f9@mail.gmail.com>
	<200911201416.16299.anarsoul@gmail.com>
Message-ID: <4B06A8F4.5070307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 20-11-09 13:16, Vasily Khoruzhick schreef:
> ? ????????? ?? 20 ?????? 2009 14:04:10 ????? Maurus Cuelenaere ???????:
>    
>> This moves the S3C24xx ADC driver to plat-s3c and adds support
>> for the S3C64xx.
>>
>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>> ---
>>   arch/arm/plat-s3c/Kconfig                 |    7 +++++
>>   arch/arm/plat-s3c/Makefile                |    4 +++
>>   arch/arm/{plat-s3c24xx =>  plat-s3c}/adc.c |   17 +++++++++--
>>   arch/arm/plat-s3c/include/plat/regs-adc.h |    3 ++
>>   arch/arm/plat-s3c24xx/Kconfig             |    7 -----
>>   arch/arm/plat-s3c24xx/Makefile            |    1 -
>>   arch/arm/plat-s3c64xx/Makefile            |    1 +
>>   arch/arm/plat-s3c64xx/dev-adc.c           |   42
>>   +++++++++++++++++++++++++++++ 8 files changed, 71 insertions(+), 11
>>   deletions(-)
>>   rename arch/arm/{plat-s3c24xx =>  plat-s3c}/adc.c (95%)
>>   create mode 100644 arch/arm/plat-s3c64xx/dev-adc.c
>>
>> diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
>> index 57e685b..4184084 100644
>> --- a/arch/arm/plat-s3c/Kconfig
>> +++ b/arch/arm/plat-s3c/Kconfig
>> @@ -159,6 +159,13 @@ config S3C_GPIO_CFG_S3C64XX
>>   	  Internal configuration to enable S3C64XX style GPIO configuration
>>   	  functions.
>>
>> +config S3C_ADC
>> +	bool "ADC common driver support"
>> +	help
>> +	  Core support for the ADC block found in the S3C SoC systems
>> +	  for drivers such as the touchscreen and hwmon to use to share
>> +	  this resource.
>> +
>>   # DMA
>>
>>   config S3C_DMA
>> diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
>> index 50444da..960fb43 100644
>> --- a/arch/arm/plat-s3c/Makefile
>> +++ b/arch/arm/plat-s3c/Makefile
>> @@ -32,6 +32,10 @@ obj-$(CONFIG_S3C2410_PM_CHECK)	+= pm-check.o
>>
>>   obj-$(CONFIG_HAVE_PWM)		+= pwm.o
>>
>> +# ADC support
>> +
>> +obj-$(CONFIG_S3C_ADC)		+= adc.o
>> +
>>   # devices
>>
>>   obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
>> diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c/adc.c
>> similarity index 95%
>> rename from arch/arm/plat-s3c24xx/adc.c
>> rename to arch/arm/plat-s3c/adc.c
>> index df47322..572b7be 100644
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
>> @@ -72,10 +72,18 @@ static LIST_HEAD(adc_pending);
>>
>>   #define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
>>
>> +#define AUTOPST (S3C2410_ADCTSC_YM_SEN | S3C2410_ADCTSC_YP_SEN | \
>> +		S3C2410_ADCTSC_XP_SEN | S3C2410_ADCTSC_AUTO_PST | \
>> +		S3C2410_ADCTSC_XY_PST(0))
>> +
>>   static inline void s3c_adc_convert(struct adc_device *adc)
>>   {
>>   	unsigned con = readl(adc->regs + S3C2410_ADCCON);
>>
>> +	if (adc->cur->is_ts)
>> +		writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST,
>> +			adc->regs + S3C2410_ADCTSC);
>> +
>>   	con |= S3C2410_ADCCON_ENABLE_START;
>>   	writel(con, adc->regs + S3C2410_ADCCON);
>>   }
>> @@ -260,6 +268,9 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
>>   	unsigned long flags;
>>   	unsigned data0, data1;
>>
>> +	/* Clear ADC interrupt */
>> +	__raw_writel(0x0, adc->regs + S3C6400_ADCCLRINT);
>> +
>>      
> s3c24xx has not ADCCLRINT register, so I suspect it'll break s3c24xx-
> compatibility
Hmm right, that doesn't seem right; this should in an if(adc->type == 
S3C64XX) check..

Also that if(adc->cur->is_ts) change above seems unrelated, let me 
resend this patch.

Regards,
Maurus Cuelenaere
