From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 26 Apr 2011 16:46:54 -0500
Subject: [RFC] ep93xx: switch gpio to early platform device
In-Reply-To: <4DB7379F.10403@bluewatersys.com>
References: <201104261357.53245.hartleys@visionengravers.com>
	<4DB7379F.10403@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D25E6392@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 26, 2011 2:23 PM, Ryan Mallon wrote:
> On 04/27/2011 08:57 AM, H Hartley Sweeten wrote:
>> Convert the ep93xx gpio support into an early platform device. 
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>
> Hi Hartley,
>
> Couple of comments below.
>
>> ---
>> 
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index 8207954..e2d9e3e 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>> @@ -241,6 +241,27 @@ unsigned int ep93xx_chip_revision(void)
>>  }
>>  
>>  /*************************************************************************
>> + * EP93xx gpio
>> + *************************************************************************/
>> +static struct platform_device ep93xx_gpio_device = {
>> +	.name		= "ep93xx-gpio",
>> +	.id		= -1,
>> +};
>> +
>> +static struct platform_device *ep93xx_early_gpio_device[] __initdata = {
>> +	&ep93xx_gpio_device,
>> +};
>
> Maybe just call this ep93xx_early_devices. That way if we add additional
> early devices it doesn't need to get renamed?

I thought about that and couldn't decide which way to go.

The way this is coded now, all the early devices would get added at the same time
but I think the *_register_all and *_probe would need to be called for each type
of early device.  I need to look into how these are handled.

Either way, I'm fine with changing the name.

>> +
>> +static void __init ep93xx_init_early_gpio(void)
>> +{
>> +	int num = ARRAY_SIZE(ep93xx_early_gpio_device);
>> +
>> +	early_platform_add_devices(ep93xx_early_gpio_device, num);
>> +	early_platform_driver_register_all("early_ep93xx_gpio");
>> +	early_platform_driver_probe("early_ep93xx_gpio", num, 0);
>> +}
>> +
>> +/*************************************************************************
>>   * EP93xx peripheral handling
>>   *************************************************************************/
>>  #define EP93XX_UART_MCR_OFFSET		(0x0100)
>> @@ -866,14 +887,12 @@ void __init ep93xx_register_ac97(void)
>>  	platform_device_register(&ep93xx_pcm_device);
>>  }
>>  
>> -extern void ep93xx_gpio_init(void);
>> -
>>  void __init ep93xx_init_devices(void)
>>  {
>>  	/* Disallow access to MaverickCrunch initially */
>>  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
>>  
>> -	ep93xx_gpio_init();
>> +	ep93xx_init_early_gpio();
>>  
>>  	amba_device_register(&uart1_device, &iomem_resource);
>>  	amba_device_register(&uart2_device, &iomem_resource);
>> diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
>> index a5a9ff7..e820316 100644
>> --- a/arch/arm/mach-ep93xx/gpio.c
>> +++ b/arch/arm/mach-ep93xx/gpio.c
>> @@ -4,6 +4,7 @@
>>   * Generic EP93xx GPIO handling
>>   *
>>   * Copyright (c) 2008 Ryan Mallon <ryan@bluewatersys.com>
>> + * Copyright (c) 2011 H Hartley Sweeten <hsweeten@visionengravers.com>
>>   *
>>   * Based on code originally from:
>>   *  linux/arch/arm/mach-ep93xx/core.c
>> @@ -13,10 +14,9 @@
>>   *  published by the Free Software Foundation.
>>   */
>>  
>> -#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> This is really a separate change. I don't mind, but wonder if it should
> be a separate patch.

True.  I just changed it now so that when the file is moved to drivers/gpio/ep93xx-gpio.c
the KBUILD_MODNAME would already be fixed.  This way when the files does move it's just a
straight copy with no edits.

>> -#include <linux/init.h>
>> -#include <linux/module.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/io.h>
>>  #include <linux/gpio.h>
>> @@ -406,10 +406,15 @@ static struct ep93xx_gpio_chip ep93xx_gpio_banks[] = {
>>  	EP93XX_GPIO_BANK("H", 0x40, 0x44, 56),
>>  };
>>  
>> -void __init ep93xx_gpio_init(void)
>> +static int __devinit ep93xx_gpio_probe(struct platform_device *pdev)
>>  {
>>  	int i;
>>  
>> +	if (!is_early_platform_device(pdev)) {
>> +		pr_info("called via non early platform\n");
>> +		return 0;
>
> pr_err? Should probably either return an error code, or just warn and
> then fall through and register anyway.

Not sure.  The at91_gpio.c conversion (already in linux-next) did it this way.

I don't think the probe can just fall through. Documentation/driver-model/platform.txt
briefly mentions the is_early_platform_device() check but doesn't say much.  I'll do
some more digging to see what is commonly done.

>> +	}
>> +
>>  	/* Set Ports C, D, E, G, and H for GPIO use */
>>  	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
>>  				 EP93XX_SYSCON_DEVCFG_GONK |
>> @@ -431,4 +436,22 @@ void __init ep93xx_gpio_init(void)
>>  
>>  		gpiochip_add(chip);
>>  	}
>> +
>> +	pr_info("subsystem initialized\n");
>
> We don't need more noise in the syslog :-).

True.  I added this to see when the early init happens and forgot to remove it.

BTW, it occurs right after the ep93xx clock information is displayed and before
the m2p dma subsystem is initialized.

>> +	return 0;
>> +}
>> +
>> +static int __devexit ep93xx_gpio_remove(struct platform_device *pdev)
>> +{
>> +	return -EBUSY;
>
> Isn't the remove function optional? From what I can tell the return type
> of driver->remove never gets checked anyway?

I'm not sure.  This driver is always built-in anyway so I don't think it can
be removed.  BTW, this is how it was done in at91_gpio.c.  Of course that
doesn't mean its' correct...

>>  }
>> +
>> +static struct platform_driver ep93xx_gpio_driver = {
>> +	.driver		= {
>> +		.name	= "ep93xx-gpio",
>> +	},
>> +	.probe		= ep93xx_gpio_probe,
>> +	.remove		= __devexit_p(ep93xx_gpio_remove),
>> +};
>> +
>> +early_platform_init("early_ep93xx_gpio", &ep93xx_gpio_driver);
>
> This can be moved to drivers/gpio/ now also right? If so, it should be a
> separate patch after this one.

I think there are a number of pending patches to gpio.c that have not yet
been merged.  I know your patch to remove the dbg_show output is still in
Russell's patch tracker and I think there are a couple from Thomas Gleixner
that are still pending.

I would like to be sure everything pending it correctly merged before applying
this patch (updated of course) and then move and rename the file.

Regards,
Hartley
