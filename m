From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 08:43:46 +0100
Subject: [PATCH 1/5] ARM: SAMSUNG: Move WDT device definitions in
	plat-samsung
In-Reply-To: <1274340092-10706-2-git-send-email-kgene.kim@samsung.com>
References: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
	<1274340092-10706-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100520074346.GN4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 04:21:28PM +0900, Kukjin Kim wrote:
> From: Banajit Goswami <banajit.g@samsung.com>
> 
> This patch moves the definitions of watchdog timer device from
> plat-s3c24xx to plat-samsung. This will enable all Samsung S3C
> and S5P series SoC's to use common WDT device definition.
> 
> And adds HAVE_S3C2410_WATCHDOG for selecting in each machine
> without modifying Kconfig in drivers directory.
> 
> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig                         |    1 +
>  arch/arm/mach-s3c2410/include/mach/map.h |    1 +
>  arch/arm/plat-s3c24xx/devs.c             |   26 -------------------
>  arch/arm/plat-samsung/Kconfig            |    6 ++++
>  arch/arm/plat-samsung/Makefile           |    1 +
>  arch/arm/plat-samsung/dev-wdt.c          |   40 ++++++++++++++++++++++++++++++
>  drivers/watchdog/Kconfig                 |   10 ++++---

actually, please split into drivers/watchdog/Kconfig and the rest. it
would make it easier and avoid a nasty crioss-tree merge.

>  7 files changed, 55 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/dev-wdt.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3f8718f..8e2bb6b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -651,6 +651,7 @@ config ARCH_S3C2410
>  	select GENERIC_GPIO
>  	select ARCH_HAS_CPUFREQ
>  	select HAVE_CLK
> +	select HAVE_S3C2410_WATCHDOG
>  	help
>  	  Samsung S3C2410X CPU based systems, such as the Simtec Electronics
>  	  BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
> diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
> index f07d680..16fbc3c 100644
> --- a/arch/arm/mach-s3c2410/include/mach/map.h
> +++ b/arch/arm/mach-s3c2410/include/mach/map.h
> @@ -111,6 +111,7 @@
>  #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
>  #define S3C_PA_HSMMC0	    S3C2443_PA_HSMMC
>  #define S3C_PA_HSMMC1	    S3C2416_PA_HSMMC0
> +#define S3C_PA_WDT	    S3C2410_PA_WATCHDOG
>  #define S3C_PA_NAND	    S3C24XX_PA_NAND
>  
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
> index 5858373..452e184 100644
> --- a/arch/arm/plat-s3c24xx/devs.c
> +++ b/arch/arm/plat-s3c24xx/devs.c
> @@ -234,32 +234,6 @@ void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
>  	}
>  }
>  
> -
> -/* Watchdog */
> -
> -static struct resource s3c_wdt_resource[] = {
> -	[0] = {
> -		.start = S3C24XX_PA_WATCHDOG,
> -		.end   = S3C24XX_PA_WATCHDOG + S3C24XX_SZ_WATCHDOG - 1,
> -		.flags = IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start = IRQ_WDT,
> -		.end   = IRQ_WDT,
> -		.flags = IORESOURCE_IRQ,
> -	}
> -
> -};
> -
> -struct platform_device s3c_device_wdt = {
> -	.name		  = "s3c2410-wdt",
> -	.id		  = -1,
> -	.num_resources	  = ARRAY_SIZE(s3c_wdt_resource),
> -	.resource	  = s3c_wdt_resource,
> -};
> -
> -EXPORT_SYMBOL(s3c_device_wdt);
> -
>  /* IIS */
>  
>  static struct resource s3c_iis_resource[] = {
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 287e6f7..72dae49 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -185,6 +185,12 @@ config S3C_DEV_USB_HSOTG
>  	help
>  	  Compile in platform device definition for USB high-speed OtG
>  
> +config S3C_DEV_WDT
> +	bool
> +	default y if ARCH_S3C2410
> +	help
> +	  Complie in platform device definition for Watchdog Timer
> +
>  config S3C_DEV_NAND
>  	bool
>  	help
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index 0ad820a..0a92369 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
>  obj-y				+= dev-uart.o
>  obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
>  obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
> +obj-$(CONFIG_S3C_DEV_WDT)	+= dev-wdt.o
>  obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
>  
>  # DMA support
> diff --git a/arch/arm/plat-samsung/dev-wdt.c b/arch/arm/plat-samsung/dev-wdt.c
> new file mode 100644
> index 0000000..5efca87
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-wdt.c
> @@ -0,0 +1,40 @@
> +/* linux/arch/arm/plat-samsung/dev-wdt.c
> + *
> + * Copyright (c) 2004 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *
> + * S3C series device definition for the watchdog timer
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +#include <plat/devs.h>
> +
> +static struct resource s3c_wdt_resource[] = {
> +	[0] = {
> +		.start	= S3C_PA_WDT,
> +		.end	= S3C_PA_WDT + SZ_1M - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_WDT,
> +		.end	= IRQ_WDT,
> +		.flags	= IORESOURCE_IRQ,
> +	}
> +};
> +
> +struct platform_device s3c_device_wdt = {
> +	.name		= "s3c2410-wdt",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(s3c_wdt_resource),
> +	.resource	= s3c_wdt_resource,
> +};
> +EXPORT_SYMBOL(s3c_device_wdt);
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0bf5020..d52118f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -145,13 +145,15 @@ config KS8695_WATCHDOG
>  	  Watchdog timer embedded into KS8695 processor. This will reboot your
>  	  system when the timeout is reached.
>  
> +config HAVE_S3C2410_WATCHDOG
> +	bool
> +

a basic helptext here would be nice.


>  config S3C2410_WATCHDOG
>  	tristate "S3C2410 Watchdog"
> -	depends on ARCH_S3C2410
> +	depends on HAVE_S3C2410_WATCHDOG

can we either leave ARCH_S3C2410 in the depends on line for the moment
so if we fail to merge part of the arch/arm updates then this still keeps
working.

>  	help
> -	  Watchdog timer block in the Samsung S3C2410 chips. This will
> -	  reboot the system when the timer expires with the watchdog
> -	  enabled.
> +	  Watchdog timer block in the Samsung SoCs. This will reboot
> +	  the system when the timer expires with the watchdog enabled.
>  
>  	  The driver is limited by the speed of the system's PCLK
>  	  signal, so with reasonably fast systems (PCLK around 50-66MHz)
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
