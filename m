From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 06:51:38 +0100
Subject: [PATCH v3 6/9] ARM: S3C64XX: Adds Touchscreen support for S3C64XX
In-Reply-To: <1274183090-16098-1-git-send-email-kgene.kim@samsung.com>
References: <1274183090-16098-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100519055138.GS26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 08:44:50PM +0900, Kukjin Kim wrote:
> From: Naveen Krishna <ch.naveen@samsung.com>
> 
> This patch adds touchscreen support for S3C64XX.
> 
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

The new tree is at for-2635-2/samsung-ts without the machine support
due to some problems after rebuild the trees.

Naveen/Kukjin, please have a look at this tree and update the unmerged
patches.

> ---
>  arch/arm/mach-s3c64xx/Kconfig         |    1 +
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |   12 +++++++
>  arch/arm/mach-s3c64xx/s3c6410.c       |    1 +
>  arch/arm/plat-samsung/Kconfig         |    5 +++
>  arch/arm/plat-samsung/Makefile        |    1 +
>  arch/arm/plat-samsung/dev-ts.c        |   55 +++++++++++++++++++++++++++++++++
>  6 files changed, 75 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/dev-ts.c
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 69e9fbf..1f2f412 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -90,6 +90,7 @@ config MACH_SMDK6410
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_I2C1
>  	select S3C_DEV_FB
> +	select SAMSUNG_DEV_TS
>  	select S3C_DEV_USB_HOST
>  	select S3C_DEV_USB_HSOTG
>  	select S3C64XX_SETUP_SDHCI
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index 2d5afd2..fb186c9 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -64,6 +64,8 @@
>  #include <plat/clock.h>
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> +#include <plat/adc.h>
> +#include <plat/ts.h>
>  
>  #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
>  #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
> @@ -262,6 +264,8 @@ static struct platform_device *smdk6410_devices[] __initdata = {
>  	&smdk6410_lcd_powerdev,
>  
>  	&smdk6410_smsc911x,
> +	&s3c_device_adc,
> +	&s3c_device_ts,
>  };
>  
>  #ifdef CONFIG_REGULATOR
> @@ -596,6 +600,12 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
>  	{ I2C_BOARD_INFO("24c128", 0x57), },	/* Samsung S524AD0XD1 */
>  };
>  
> +static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> +	.delay			= 10000,
> +	.presc			= 49,
> +	.oversampling_shift	= 2,
> +};
> +
>  static void __init smdk6410_map_io(void)
>  {
>  	u32 tmp;
> @@ -625,6 +635,8 @@ static void __init smdk6410_machine_init(void)
>  	s3c_i2c1_set_platdata(NULL);
>  	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
>  
> +	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +
>  	/* configure nCS1 width to 16 bits */
>  
>  	cs1 = __raw_readl(S3C64XX_SROM_BW) &
> diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
> index 31e53fa..4390ecb 100644
> --- a/arch/arm/mach-s3c64xx/s3c6410.c
> +++ b/arch/arm/mach-s3c64xx/s3c6410.c
> @@ -55,6 +55,7 @@ void __init s3c6410_map_io(void)
>  
>  	s3c_device_adc.name      = "s3c64xx-adc";
>  	s3c_device_nand.name = "s3c6400-nand";
> +	s3c_device_ts.name	= "s3c64xx-ts";

I'm leaving the s3c_device_ts.name field as s3c64xx-ts in the device file
to avoid having to rename it each time.

>  }
>  
>  void __init s3c6410_init_clocks(int xtal)
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 641649f..b466da8 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -196,6 +196,11 @@ config S3C64XX_DEV_SPI
>  	  Compile in platform device definitions for S3C64XX's type
>  	  SPI controllers.
>  
> +config SAMSUNG_DEV_TS
> +	bool
> +	help
> +	  Compile in platform device definition for Samsung Touch Screen.
> +
>  # DMA
>  
>  config S3C_DMA
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index 3cf30a4..695ed99 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
>  obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
>  obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
>  obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
> +obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
>  
>  # DMA support
>  
> diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
> new file mode 100644
> index 0000000..7571691
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-ts.c
> @@ -0,0 +1,55 @@
> +/* linux/arch/arm/plat-samsung/dev-ts.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *			http://www.samsung.com/
> + *			Naveen Krishna Ch <ch.naveen@samsung.com>
> + *
> + * TouchScreen Device definition for Samsung S3C, S5P serie SoCs.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <mach/map.h>
> +#include <mach/irqs.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +#include <plat/ts.h>
> +
> +static struct resource s3c_ts_resource[] = {
> +[0] = {
> +		.start = SAMSUNG_PA_ADC,
> +		.end   = SAMSUNG_PA_ADC + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_PENDN,
> +		.end   = IRQ_PENDN,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s3c_device_ts = {
> +	.name		= "samsung-ts",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
> +	.resource	= s3c_ts_resource,
> +};
> +
> +void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
> +{
> +	struct s3c2410_ts_mach_info *npd;
> +
> +	npd = kmalloc(sizeof(*npd), GFP_KERNEL);
> +	if (npd) {
> +		memcpy(npd, pd, sizeof(*npd));
> +		s3c_device_ts.dev.platform_data = npd;
> +	} else {
> +		printk(KERN_ERR "no memory for Touchscreen platform data\n");
> +	}
> +}
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
