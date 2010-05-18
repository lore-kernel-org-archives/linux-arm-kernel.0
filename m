From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 05:47:11 +0100
Subject: [PATCH v2 3/9] ARM: SAMSUNG: Implements cfg_gpio function for
	Samsung touchscreen
In-Reply-To: <1273756032-3098-1-git-send-email-kgene.kim@samsung.com>
References: <1273756032-3098-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100518044711.GY26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 10:07:12PM +0900, Kukjin Kim wrote:
> From: Naveen Krishna <ch.naveen@samsung.com>
> 
> This patch implements cfg_gpio function for Samsung touchscreen.
> And also modifies the H1940 machine respectively.
> 
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c2410/Kconfig           |    1 +
>  arch/arm/mach-s3c2410/mach-h1940.c      |    1 +
>  arch/arm/plat-s3c24xx/Kconfig           |    6 +++++
>  arch/arm/plat-s3c24xx/Makefile          |    1 +
>  arch/arm/plat-s3c24xx/setup-ts.c        |   34 +++++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/ts.h |    4 +++
>  6 files changed, 47 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c24xx/setup-ts.c
> 
> diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
> index 5547318..460ba78 100644
> --- a/arch/arm/mach-s3c2410/Kconfig
> +++ b/arch/arm/mach-s3c2410/Kconfig
> @@ -76,6 +76,7 @@ config ARCH_H1940
>  	select PM_H1940 if PM
>  	select S3C_DEV_USB_HOST
>  	select S3C_DEV_NAND
> +	select SAMSUNG_SETUP_TS

no, at best this is s3c24xx specific and should either be
S3C24XX_SETUP_TS or better still, S3C2410_SETUP_TS.

>  	help
>  	  Say Y here if you are using the HP IPAQ H1940
>  
> diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
> index 75e3ffb..e8583ec 100644
> --- a/arch/arm/mach-s3c2410/mach-h1940.c
> +++ b/arch/arm/mach-s3c2410/mach-h1940.c
> @@ -145,6 +145,7 @@ static struct s3c2410_ts_mach_info h1940_ts_cfg __initdata = {
>  		.delay = 10000,
>  		.presc = 49,
>  		.oversampling_shift = 2,
> +		.cfg_gpio = s3c24xx_ts_cfg_gpio,
>  };
>  
>  /**
> diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
> index 6e93ef8..ed6f294 100644
> --- a/arch/arm/plat-s3c24xx/Kconfig
> +++ b/arch/arm/plat-s3c24xx/Kconfig
> @@ -9,6 +9,7 @@ config PLAT_S3C24XX
>  	select NO_IOPORT
>  	select ARCH_REQUIRE_GPIOLIB
>  	select S3C_DEVICE_NAND
> +	select SAMSUNG_SETUP_TS if TOUCHSCREEN_S3C2410
>  	help
>  	  Base platform code for any Samsung S3C24XX device
>  
> @@ -157,4 +158,9 @@ config S3C24XX_SIMTEC_AUDIO
>  	help
>  	  Add audio devices for common Simtec S3C24XX boards
>  
> +config SAMSUNG_SETUP_TS
> +	bool
> +	help
> +	  Compile in platform device definition for Samsung TouchScreen.
> +
>  endif
> diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
> index c2237c4..0fecbc3 100644
> --- a/arch/arm/plat-s3c24xx/Makefile
> +++ b/arch/arm/plat-s3c24xx/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
>  
>  # device specific setup and/or initialisation
>  obj-$(CONFIG_ARCH_S3C2410)	+= setup-i2c.o
> +obj-$(CONFIG_SAMSUNG_SETUP_TS)	+= setup-ts.o
>  
>  # SPI gpio central GPIO functions
>  
> diff --git a/arch/arm/plat-s3c24xx/setup-ts.c b/arch/arm/plat-s3c24xx/setup-ts.c
> new file mode 100644
> index 0000000..ed26386
> --- /dev/null
> +++ b/arch/arm/plat-s3c24xx/setup-ts.c
> @@ -0,0 +1,34 @@
> +/* linux/arch/arm/plat-s3c24xx/setup-ts.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *                     http://www.samsung.com/
> + *
> + * Based on S3C24XX setup for i2c device
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +
> +struct platform_device; /* don't need the contents */
> +
> +#include <mach/hardware.h>
> +#include <mach/regs-gpio.h>
> +
> +/**
> + * s3c24xx_ts_cfg_gpio - configure gpio for s3c2410 systems
> + *
> + * Configure the GPIO for the S3C2410 system, where we have external FETs
> + * connected to the device (later systems such as the S3C2440 integrate
> + * these into the device).
> + */
> +void s3c24xx_ts_cfg_gpio(struct platform_device *dev)
> +{
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/ts.h b/arch/arm/plat-samsung/include/plat/ts.h
> index 8a51675..26fdb22 100644
> --- a/arch/arm/plat-samsung/include/plat/ts.h
> +++ b/arch/arm/plat-samsung/include/plat/ts.h
> @@ -14,8 +14,12 @@ struct s3c2410_ts_mach_info {
>         int             delay;
>         int             presc;
>         int             oversampling_shift;
> +	void    (*cfg_gpio)(struct platform_device *dev);
>  };
>  
>  extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
>  
> +/* defined by architecture to configure gpio */
> +extern void s3c24xx_ts_cfg_gpio(struct platform_device *dev);
> +
>  #endif /* __ASM_ARM_TS_H */
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
