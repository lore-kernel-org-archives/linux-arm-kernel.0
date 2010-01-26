From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 14:50:08 +0000
Subject: [PATCH 1/2] ARM: SAMSUNG: Move HWMON from plat-s3c24xx to
	plat-samsung
In-Reply-To: <b2e8f9f71001260316l56cdfc7bv20944b4e3ba3fdf5@mail.gmail.com>
References: <b2e8f9f71001260316l56cdfc7bv20944b4e3ba3fdf5@mail.gmail.com>
Message-ID: <20100126145008.GB9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 12:16:13PM +0100, Maurus Cuelenaere wrote:
> Move HWMON platform definition from plat-s3c24xx to plat-samsung
> and adjust mach-bast to use the new s3c_hwmon_set_platdata().
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c2410/mach-bast.c          |    2 +-
>  arch/arm/plat-s3c24xx/devs.c               |    8 -----
>  arch/arm/plat-samsung/Kconfig              |    5 +++
>  arch/arm/plat-samsung/Makefile             |    1 +
>  arch/arm/plat-samsung/dev-hwmon.c          |   39 ++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/hwmon.h |    2 +
>  6 files changed, 48 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/dev-hwmon.c
> 
> diff --git a/arch/arm/mach-s3c2410/mach-bast.c
> b/arch/arm/mach-s3c2410/mach-bast.c
> index 02b1b62..c8786df 100644
> --- a/arch/arm/mach-s3c2410/mach-bast.c
> +++ b/arch/arm/mach-s3c2410/mach-bast.c
> @@ -634,7 +634,7 @@ static void __init bast_map_io(void)
> 
>  	s3c24xx_register_clocks(bast_clocks, ARRAY_SIZE(bast_clocks));
> 
> -	s3c_device_hwmon.dev.platform_data = &bast_hwmon_info;
> +	s3c_hwmon_set_platdata(&bast_hwmon_info);
> 
>  	s3c24xx_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
>  	s3c24xx_init_clocks(0);
> diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
> index 986d4e5..67e0db7 100644
> --- a/arch/arm/plat-s3c24xx/devs.c
> +++ b/arch/arm/plat-s3c24xx/devs.c
> @@ -319,14 +319,6 @@ struct platform_device s3c_device_adc = {
>  	.resource	  = s3c_adc_resource,
>  };
> 
> -/* HWMON */
> -
> -struct platform_device s3c_device_hwmon = {
> -	.name		= "s3c-hwmon",
> -	.id		= -1,
> -	.dev.parent	= &s3c_device_adc.dev,
> -};
> -
>  /* SDI */
> 
>  static struct resource s3c_sdi_resource[] = {
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 1c2fe91..429fe80 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -107,6 +107,11 @@ config S3C_DEV_HSMMC2
>  	help
>  	  Compile in platform device definitions for HSMMC channel 2
> 
> +config S3C_DEV_HWMON
> +	bool
> +	help
> +	    Compile in platform device definitions for HWMON
> +
>  config S3C_DEV_I2C1
>  	bool
>  	help
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index c8c8cae..e0b622e 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
>  obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
>  obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
>  obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
> +obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
>  obj-y				+= dev-i2c0.o
>  obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
>  obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
> diff --git a/arch/arm/plat-samsung/dev-hwmon.c
> b/arch/arm/plat-samsung/dev-hwmon.c
> new file mode 100644
> index 0000000..2c1080d
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-hwmon.c
> @@ -0,0 +1,39 @@
> +/* linux/arch/arm/plat-samsung/dev-hwmon.c
> + *
> + * Copyright 2010 Maurus Cuelenaere

you've forgotten the copyright attribution from the original source...

> + *
> + * Samsung series device definition for HWMON
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +#include <plat/devs.h>
> +#include <plat/hwmon.h>
> +
> +struct platform_device s3c_device_hwmon = {
> +	.name		= "s3c-hwmon",
> +	.id		= -1,
> +	.dev.parent	= &s3c_device_adc.dev,
> +};
> +
> +void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd)
> +{
> +	struct s3c_hwmon_pdata *npd;
> +
> +	if (!pd) {
> +		printk(KERN_ERR "%s: no platform data\n", __func__);
> +		return;
> +	}
> +
> +	npd = kmemdup(pd, sizeof(struct s3c_hwmon_pdata), GFP_KERNEL);
> +	if (!npd)
> +		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> +
> +	s3c_device_hwmon.dev.platform_data = npd;
> +}
> +EXPORT_SYMBOL(s3c_hwmon_set_platdata);

you don't need to EXPORT_SYMBOL() this, it is hardly likely to be used
in anything other than machine support which is compiled into the kernel.

> diff --git a/arch/arm/plat-samsung/include/plat/hwmon.h
> b/arch/arm/plat-samsung/include/plat/hwmon.h
> index 1ba88ea..352795b 100644
> --- a/arch/arm/plat-samsung/include/plat/hwmon.h
> +++ b/arch/arm/plat-samsung/include/plat/hwmon.h
> @@ -37,5 +37,7 @@ struct s3c_hwmon_pdata {
>  	struct s3c_hwmon_chcfg	*in[8];
>  };
> 
> +extern void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd);
> +
>  #endif /* __ASM_ARCH_ADC_HWMON_H */


kerneldoc on this function addition would have been nice.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
