From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 4 Jun 2013 20:22:07 -0500
Subject: [PATCH] arm: ep93xx: use soc bus
In-Reply-To: <51AE7225.6000209@gmail.com>
References: <201306041130.52573.hartleys@visionengravers.com>
 <51AE7225.6000209@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DA67E47A6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 04, 2013 4:03 PM, Ryan Mallon wrote:
> On 05/06/13 04:30, H Hartley Sweeten wrote:
>> Use the soc bus to report the silicon revision and Maverick Key. Both
>> are not currently exposed to the user. In addition, fill in the SoC
>> family and machine for completeness.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>
> Hey Hartley,
>
> Looks mostly good. Couple of comments below.
>
> ~Ryan
>
>> ---
>>  arch/arm/mach-ep93xx/Kconfig                 |   1 +
>>  arch/arm/mach-ep93xx/core.c                  | 106 ++++++++++++++++++++++++++-
>>  arch/arm/mach-ep93xx/include/mach/platform.h |   3 +-
>>  3 files changed, 108 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
>> index fe3c1fa..91eee1d 100644
>> --- a/arch/arm/mach-ep93xx/Kconfig
>> +++ b/arch/arm/mach-ep93xx/Kconfig
>> @@ -5,6 +5,7 @@ menu "Cirrus EP93xx Implementation Options"
>>  config EP93XX_SOC_COMMON
>>  	bool
>>  	default y
>> +	select SOC_BUS
>>  	select LEDS_GPIO_REGISTER
>>  
>>  config CRUNCH
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index c49ed3d..d6c0c0b 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/dma-mapping.h>
>> +#include <linux/sys_soc.h>
>>  #include <linux/timex.h>
>>  #include <linux/irq.h>
>>  #include <linux/io.h>
>> @@ -42,6 +43,7 @@
>>  #include <linux/platform_data/spi-ep93xx.h>
>>  #include <mach/gpio-ep93xx.h>
>>  
>> +#include <asm/mach/arch.h>
>>  #include <asm/mach/map.h>
>>  #include <asm/mach/time.h>
>>  
>> @@ -895,8 +897,106 @@ void ep93xx_ide_release_gpio(struct platform_device *pdev)
>>  }
>>  EXPORT_SYMBOL(ep93xx_ide_release_gpio);
>>  
>> -void __init ep93xx_init_devices(void)
>> +/*************************************************************************
>> + * EP93xx Security peripheral
>> + *************************************************************************/
>> +
>> +/*
>> + * The Maverick Key is 256 bits of micro fuses blown at the factory during
>> + * manufacturing to uniquely identify a part.
>> + *
>> + * See: http://arm.cirrus.com/forum/viewtopic.php?t=486&highlight=maverick+key
>> + */
>> +#define EP93XX_SECURITY_REG(x)		(EP93XX_SECURITY_BASE + (x))
>> +#define EP93XX_SECURITY_UNIQID		EP93XX_SECURITY_REG(0x2440)
>> +#define EP93XX_SECURITY_UNIQCHK		EP93XX_SECURITY_REG(0x2450)
>> +#define EP93XX_SECURITY_SECID1		EP93XX_SECURITY_REG(0x2500)
>> +#define EP93XX_SECURITY_SECCHK1		EP93XX_SECURITY_REG(0x2520)
>> +#define EP93XX_SECURITY_SECID2		EP93XX_SECURITY_REG(0x2504)
>> +#define EP93XX_SECURITY_SECCHK2		EP93XX_SECURITY_REG(0x2524)
>> +#define EP93XX_SECURITY_FUSEFLG		EP93XX_SECURITY_REG(0x2410)
>> +#define EP93XX_SECURITY_UNIQID2		EP93XX_SECURITY_REG(0x2700)
>> +#define EP93XX_SECURITY_UNIQID3		EP93XX_SECURITY_REG(0x2704)
>> +#define EP93XX_SECURITY_UNIQID4		EP93XX_SECURITY_REG(0x2708)
>> +#define EP93XX_SECURITY_UNIQID5		EP93XX_SECURITY_REG(0x270c)
>> +#define EP93XX_SECURITY_SECFLG		EP93XX_SECURITY_REG(0x2400)
>> +#define EP93XX_SECURITY_UNIQVAL		EP93XX_SECURITY_REG(0x2460)
>
> You are only using about half of these defines. Are you expecting to use
> some more of them in the future, or could we just remove the unused ones?

The Maverick Key is not documented in the EP93xx Users Guide.
Chapter 29 - Security, just says to contact Cirrus Logic for additional information.

I would like to keep the defines here for documentation.

>> +
>> +static const char __init *ep93xx_get_soc_id(void)
>> +{
>> +	unsigned int id, id2, id3, id4, id5;
>> +
>> +	if (__raw_readl(EP93XX_SECURITY_UNIQVAL) != 1)
>> +		return kasprintf(GFP_KERNEL, "bad Hamming code");
>> +
>> +	id = __raw_readl(EP93XX_SECURITY_UNIQID);
>> +	id2 = __raw_readl(EP93XX_SECURITY_UNIQID2);
>> +	id3 = __raw_readl(EP93XX_SECURITY_UNIQID3);
>> +	id4 = __raw_readl(EP93XX_SECURITY_UNIQID4);
>> +	id5 = __raw_readl(EP93XX_SECURITY_UNIQID5);
>> +
>> +	if (id != id2)
>> +		return kasprintf(GFP_KERNEL, "invalid");
>> +
>> +	return kasprintf(GFP_KERNEL,"%08x%08x%08x%08x",
>> +			 id2, id3, id4, id5);
>> +}
>
> You don't need to use the allocator functions here:
>
> static char soc_id[33];
>
> static const char __init *ep93xx_get_soc_id(void)
> {
>	if (...)
>		return "bad Hamming code";
>	...
>	
>	snprintf(soc_id, sizeof(soc_id), ...);
>	return soc_id;
> }

I'm not sure which is cleaner. Only one of the allocator functions actually
gets called.

>> +
>> +static const char __init *ep93xx_get_soc_rev(void)
>> +{
>> +	int rev = ep93xx_chip_revision();
>> +
>> +	switch (rev) {
>> +	case EP93XX_CHIP_REV_D0:
>> +		return "D0";
>> +	case EP93XX_CHIP_REV_D1:
>> +		return "D1";
>> +	case EP93XX_CHIP_REV_E0:
>> +		return "E0";
>> +	case EP93XX_CHIP_REV_E1:
>> +		return "E1";
>> +	case EP93XX_CHIP_REV_E2:
>> +		return "E2";
>> +	default:
>> +		return "unknown";
>> +	}
>> +}
>> +
>> +static const char __init *ep93xx_get_machine_name(void)
>> +{
>> +	return kasprintf(GFP_KERNEL,"%s", machine_desc->name);
>> +}
>> +
>> +static struct device __init *ep93xx_init_soc(void)
>> +{
>> +	struct soc_device_attribute *soc_dev_attr;
>> +	struct soc_device *soc_dev;
>> +
>> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +	if (!soc_dev_attr)
>> +		return NULL;
>> +
>> +	soc_dev_attr->machine = ep93xx_get_machine_name();
>> +	soc_dev_attr->family = "Cirrus EP93xx";
>> +	soc_dev_attr->revision = ep93xx_get_soc_rev();
>> +	soc_dev_attr->soc_id = ep93xx_get_soc_id();
>> +
>> +	soc_dev = soc_device_register(soc_dev_attr);
>> +	if (IS_ERR(soc_dev)) {
>> +		kfree(soc_dev_attr->soc_id);
>> +		kfree(soc_dev_attr->revision);
>
> Revision wasn't allocated with kmalloc.

Doh...

>> +		kfree(soc_dev_attr->machine);
>> +		kfree(soc_dev_attr);
>> +		return NULL;
>> +	}
>> +
>> +	return soc_device_to_device(soc_dev);
>> +}
>> +
>> +struct device __init *ep93xx_init_devices(void)
>>  {
>> +	struct device *parent;
>> +
>>  	/* Disallow access to MaverickCrunch initially */
>>  	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
>>  
>> @@ -907,6 +1007,8 @@ void __init ep93xx_init_devices(void)
>>  			       EP93XX_SYSCON_DEVCFG_GONIDE |
>>  			       EP93XX_SYSCON_DEVCFG_HONIDE);
>>  
>> +	parent = ep93xx_init_soc();
>> +
>>  	/* Get the GPIO working early, other devices need it */
>>  	platform_device_register(&ep93xx_gpio_device);
>>  
>> @@ -919,6 +1021,8 @@ void __init ep93xx_init_devices(void)
>>  	platform_device_register(&ep93xx_wdt_device);
>>  
>>  	gpio_led_register_device(-1, &ep93xx_led_data);
>> +
>> +	return parent;
>
> Nothing appears to use or check this return value?

Not yet. :-)

The callers can use the return value to add additional board specific
information to the soc bus. For instance the ts72xx has the FPGA
revision and some additional information that might be useful.

I'll wait to see if there are any additional comments before posting
an updated patch.

Regards,
Hartley
