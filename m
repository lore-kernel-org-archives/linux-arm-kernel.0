From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 09:48:48 +0100
Subject: [PATCH] ARM: Samsung: Add platform support code for OneNAND
	controller
In-Reply-To: <1274338745-1745-1-git-send-email-m.szyprowski@samsung.com>
References: <1274338745-1745-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100520084848.GO4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 08:59:05AM +0200, Marek Szyprowski wrote:
> This patch adds setup code for Samsung OneNAND controller driver. The
> driver needs to be aware on which SoC it is running, so the actual
> device id is being changed in cpu init code. S3C64xx SoCs have 2 OneNAND
> controllers while S5PC100 and S5PC110 has only one.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Ok, in future please try and keep a core and then have the architecture
additions seperate, it makes it very difficult to deal with any problems
whilst merging and means there is a higher possibility of a problem during
this.
 
> ---
> 
> The patch has been prepared in assumtion that the plat-s5pc1xx cleanup
> patches has been applied as well as "Add support for Samsung Aquila
> board (S5PC110 based)" patch series.
> 
> The driver itself has been merged by mtd maintainers, but without the
> platform setup code it is useless.
> 
> Changes sinve v2:
> * rebased onto git://git.fluff.org/bjdooks/linux for-linus/samsung4
> 
> Changes since v1:
> * addressed all coding style issues reported by Ben
> * moved all resource definitions to platform device resources
> * moved all resource definitions for different SoCs from regs-onenand.h to
>   arch/arm/mach-{s3c64xx,s5pc100,s5pv210}/include/mach/map.h
> * moved all #ifdef conditional code to separate functions
> 
> Changes since first submission attempt (long time ago):
> * all cpu conditional code in the driver has been redesigned from cpu_is_xxx()
> macros to actual device ids.
> 
> The Samsung OneNAND driver itself has been posted also to the Linux MTD
> mailing list (linux-mtd at lists.infradead.org).
> 
> ---
>  arch/arm/mach-s3c64xx/Kconfig                     |    5 ++
>  arch/arm/mach-s3c64xx/Makefile                    |    1 +
>  arch/arm/mach-s3c64xx/dev-onenand1.c              |   55 ++++++++++++++++++
>  arch/arm/mach-s3c64xx/include/mach/irqs.h         |    4 +
>  arch/arm/mach-s3c64xx/include/mach/map.h          |   13 ++++
>  arch/arm/mach-s3c64xx/s3c6400.c                   |    4 +
>  arch/arm/mach-s3c64xx/s3c6410.c                   |    3 +
>  arch/arm/mach-s5pc100/cpu.c                       |    3 +
>  arch/arm/mach-s5pc100/include/mach/map.h          |    7 ++
>  arch/arm/mach-s5pv210/Kconfig                     |    5 ++
>  arch/arm/mach-s5pv210/Makefile                    |    2 +
>  arch/arm/mach-s5pv210/dev-onenand.c               |   50 ++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/map.h          |    3 +
>  arch/arm/plat-samsung/Kconfig                     |    5 ++
>  arch/arm/plat-samsung/Makefile                    |    1 +
>  arch/arm/plat-samsung/dev-onenand.c               |   55 ++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/devs.h         |    3 +
>  arch/arm/plat-samsung/include/plat/onenand-core.h |   37 ++++++++++++
>  arch/arm/plat-samsung/include/plat/regs-onenand.h |   63 +++++++++++++++++++++
>  19 files changed, 319 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/dev-onenand1.c
>  create mode 100644 arch/arm/mach-s5pv210/dev-onenand.c
>  create mode 100644 arch/arm/plat-samsung/dev-onenand.c
>  create mode 100644 arch/arm/plat-samsung/include/plat/onenand-core.h
>  create mode 100644 arch/arm/plat-samsung/include/plat/regs-onenand.h
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 69e9fbf..805da81 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -35,6 +35,11 @@ config S3C64XX_SETUP_SDHCI
>  	  Internal configuration for default SDHCI setup for S3C6400 and
>  	  S3C6410 SoCs.
>  
> +config S3C64XX_DEV_ONENAND1
> +	bool
> +	help
> +	  Compile in platform device definition for OneNAND1 controller
> +
>  # platform specific device setup
>  
>  config S3C64XX_SETUP_I2C0
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
> index a10f1fc..1788318 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -59,3 +59,4 @@ obj-y				+= dev-uart.o
>  obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
>  obj-$(CONFIG_S3C64XX_DEV_TS)	+= dev-ts.o
> +obj-$(CONFIG_S3C64XX_DEV_ONENAND1)	+= dev-onenand1.o
> diff --git a/arch/arm/mach-s3c64xx/dev-onenand1.c b/arch/arm/mach-s3c64xx/dev-onenand1.c
> new file mode 100644
> index 0000000..92ffd5b
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/dev-onenand1.c
> @@ -0,0 +1,55 @@
> +/*
> + * linux/arch/arm/mach-s3c64xx/dev-onenand1.c
> + *
> + *  Copyright (c) 2008-2010 Samsung Electronics
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * S3C64XX series device definition for OneNAND devices
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/onenand.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +static struct resource s3c64xx_onenand1_resources[] = {
> +	[0] = {
> +		.start	= S3C64XX_PA_ONENAND1,
> +		.end	= S3C64XX_PA_ONENAND1 + 0x400 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= S3C64XX_PA_ONENAND1_BUF,
> +		.end	= S3C64XX_PA_ONENAND1_BUF + S3C64XX_SZ_ONENAND1_BUF - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[2] = {
> +		.start	= IRQ_ONENAND1,
> +		.end	= IRQ_ONENAND1,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s3c64xx_device_onenand1 = {
> +	.name		= "samsung-onenand",
> +	.id		= 1,
> +	.num_resources	= ARRAY_SIZE(s3c64xx_onenand1_resources),
> +	.resource	= s3c64xx_onenand1_resources,
> +};
> +
> +void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
> +{
> +	struct onenand_platform_data *pd;
> +
> +	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
> +	if (!pd)
> +		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> +	s3c64xx_device_onenand1.dev.platform_data = pd;
> +}
> diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
> index e9ab4ac..8e2df26 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
> @@ -212,5 +212,9 @@
>  
>  #define NR_IRQS	(IRQ_BOARD_END + 1)
>  
> +/* Compatibility */
> +
> +#define IRQ_ONENAND	IRQ_ONENAND0
> +
>  #endif /* __ASM_MACH_S3C64XX_IRQS_H */
>  
> diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
> index 9fdd50c..b6fb892 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/map.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/map.h
> @@ -52,6 +52,16 @@
>  
>  #define S3C64XX_PA_SROM		(0x70000000)
>  
> +#define S3C64XX_PA_ONENAND0	(0x70100000)
> +#define S3C64XX_PA_ONENAND0_BUF	(0x20000000)
> +#define S3C64XX_SZ_ONENAND0_BUF (SZ_64M)
> +
> +/* NAND and OneNAND1 controllers occupy the same register region
> +   (depending on SoC POP version) */
> +#define S3C64XX_PA_ONENAND1	(0x70200000)
> +#define S3C64XX_PA_ONENAND1_BUF	(0x28000000)
> +#define S3C64XX_SZ_ONENAND1_BUF	(SZ_64M)
> +
>  #define S3C64XX_PA_NAND		(0x70200000)
>  #define S3C64XX_PA_FB		(0x77100000)
>  #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
> @@ -99,6 +109,9 @@
>  #define S3C_PA_IIC		S3C64XX_PA_IIC0
>  #define S3C_PA_IIC1		S3C64XX_PA_IIC1
>  #define S3C_PA_NAND		S3C64XX_PA_NAND
> +#define S3C_PA_ONENAND		S3C64XX_PA_ONENAND0
> +#define S3C_PA_ONENAND_BUF	S3C64XX_PA_ONENAND0_BUF
> +#define S3C_SZ_ONENAND_BUF	S3C64XX_SZ_ONENAND0_BUF
>  #define S3C_PA_FB		S3C64XX_PA_FB
>  #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
>  #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
> diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
> index 707e34e..5e93fe3 100644
> --- a/arch/arm/mach-s3c64xx/s3c6400.c
> +++ b/arch/arm/mach-s3c64xx/s3c6400.c
> @@ -37,6 +37,7 @@
>  #include <plat/clock.h>
>  #include <plat/sdhci.h>
>  #include <plat/iic-core.h>
> +#include <plat/onenand-core.h>
>  #include <mach/s3c6400.h>
>  
>  void __init s3c6400_map_io(void)
> @@ -51,6 +52,9 @@ void __init s3c6400_map_io(void)
>  	s3c_i2c0_setname("s3c2440-i2c");
>  
>  	s3c_device_nand.name = "s3c6400-nand";
> +
> +	s3c_onenand_setname("s3c6400-onenand");
> +	s3c64xx_onenand1_setname("s3c6400-onenand");
>  }
>  
>  void __init s3c6400_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
> index 3ab695c..014401c 100644
> --- a/arch/arm/mach-s3c64xx/s3c6410.c
> +++ b/arch/arm/mach-s3c64xx/s3c6410.c
> @@ -39,6 +39,7 @@
>  #include <plat/sdhci.h>
>  #include <plat/iic-core.h>
>  #include <plat/adc.h>
> +#include <plat/onenand-core.h>
>  #include <mach/s3c6400.h>
>  #include <mach/s3c6410.h>
>  
> @@ -55,6 +56,8 @@ void __init s3c6410_map_io(void)
>  
>  	s3c_device_adc.name	= "s3c64xx-adc";
>  	s3c_device_nand.name = "s3c6400-nand";
> +	s3c_onenand_setname("s3c6410-onenand");
> +	s3c64xx_onenand1_setname("s3c6410-onenand");
>  }
>  
>  void __init s3c6410_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
> index d424a9f..cc47c3a 100644
> --- a/arch/arm/mach-s5pc100/cpu.c
> +++ b/arch/arm/mach-s5pc100/cpu.c
> @@ -39,6 +39,7 @@
>  #include <plat/devs.h>
>  #include <plat/clock.h>
>  #include <plat/iic-core.h>
> +#include <plat/onenand-core.h>
>  #include <plat/sdhci.h>
>  #include <plat/s5pc100.h>
>  
> @@ -88,6 +89,8 @@ void __init s5pc100_map_io(void)
>  	/* the i2c devices are directly compatible with s3c2440 */
>  	s3c_i2c0_setname("s3c2440-i2c");
>  	s3c_i2c1_setname("s3c2440-i2c");
> +
> +	s3c_onenand_setname("s5pc100-onenand");
>  }
>  
>  void __init s5pc100_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
> index fbaec9f..918e4e3 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -50,6 +50,10 @@
>  #define S5P_PA_UART3		(S5PC100_PA_UART + 0xC00)
>  #define S5P_SZ_UART		SZ_256
>  
> +#define S5PC100_PA_ONENAND	(0xE7100000)
> +#define S5PC100_PA_ONENAND_BUF	(0xB0000000)
> +#define S5PC100_SZ_ONENAND_BUF	(SZ_256M - SZ_32M)
> +
>  #define S5PC100_PA_IIC0		(0xEC100000)
>  #define S5PC100_PA_IIC1		(0xEC200000)
>  
> @@ -64,6 +68,9 @@
>  #define S3C_PA_UART		S5PC100_PA_UART
>  #define S3C_PA_IIC		S5PC100_PA_IIC0
>  #define S3C_PA_IIC1		S5PC100_PA_IIC1
> +#define S3C_PA_ONENAND		S5PC100_PA_ONENAND
> +#define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
> +#define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
>  #define S3C_PA_FB		S5PC100_PA_FB
>  #define S3C_PA_HSMMC0		S5PC100_PA_HSMMC(0)
>  #define S3C_PA_HSMMC1		S5PC100_PA_HSMMC(1)
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index bccd3f5..735e8f8 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -43,6 +43,11 @@ config S5PV210_SETUP_SDHCI_GPIO
>  	help
>  	  Common setup code for SDHCI gpio.
>  
> +config S5PC110_DEV_ONENAND
> +	bool
> +	help
> +	  Compile in platform device definition for OneNAND1 controller
> +
>  config MACH_SMDKV210
>  	bool "SMDKV210"
>  	select CPU_S5PV210
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index 0b389bb..06dbd14 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -29,3 +29,5 @@ obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
>  obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
>  obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
>  obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> +
> +obj-$(CONFIG_S5PC110_DEV_ONENAND)	+= dev-onenand.o
> diff --git a/arch/arm/mach-s5pv210/dev-onenand.c b/arch/arm/mach-s5pv210/dev-onenand.c
> new file mode 100644
> index 0000000..34997b7
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/dev-onenand.c
> @@ -0,0 +1,50 @@
> +/*
> + * linux/arch/arm/mach-s5pv210/dev-onenand.c
> + *
> + *  Copyright (c) 2008-2010 Samsung Electronics
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * S5PC110 series device definition for OneNAND devices
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/onenand.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +static struct resource s5pc110_onenand_resources[] = {
> +	[0] = {
> +		.start	= S5PC110_PA_ONENAND,
> +		.end	= S5PC110_PA_ONENAND + SZ_128K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= S5PC110_PA_ONENAND_DMA,
> +		.end	= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +struct platform_device s5pc110_device_onenand = {
> +	.name		= "s5pc110-onenand",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(s5pc110_onenand_resources),
> +	.resource	= s5pc110_onenand_resources,
> +};
> +
> +void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
> +{
> +	struct onenand_platform_data *pd;
> +
> +	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
> +	if (!pd)
> +		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> +	s5pc110_device_onenand.dev.platform_data = pd;
> +}
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
> index e9f022c..c1a6f64 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -49,6 +49,9 @@
>  #define S5PV210_PA_PDMA0	0xE0900000
>  #define S5PV210_PA_PDMA1	0xE0A00000
>  
> +#define S5PC110_PA_ONENAND	(0xB0000000)
> +#define S5PC110_PA_ONENAND_DMA	(0xB0600000)
> +
>  #define S5PV210_PA_FB		(0xF8000000)
>  
>  #define S5PV210_PA_HSMMC(x)	(0xEB000000 + ((x) * 0x100000))
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index b787d57..014599d 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -195,6 +195,11 @@ config S3C_DEV_NAND
>  	help
>  	  Compile in platform device definition for NAND controller
>  
> +config S3C_DEV_ONENAND
> +	bool
> +	help
> +	  Compile in platform device definition for OneNAND controller
> +
>  config S3C_DEV_RTC
>  	bool
>  	help
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index 606ec84..8f6410a 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -42,6 +42,7 @@ obj-y				+= dev-uart.o
>  obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
>  obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
>  obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
> +obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
>  obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
>  
>  obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
> diff --git a/arch/arm/plat-samsung/dev-onenand.c b/arch/arm/plat-samsung/dev-onenand.c
> new file mode 100644
> index 0000000..45ec732
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-onenand.c
> @@ -0,0 +1,55 @@
> +/*
> + * linux/arch/arm/plat-samsung/dev-onenand.c
> + *
> + *  Copyright (c) 2008-2010 Samsung Electronics
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * S3C64XX/S5PC100 series device definition for OneNAND devices
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/onenand.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +static struct resource s3c_onenand_resources[] = {
> +	[0] = {
> +		.start	= S3C_PA_ONENAND,
> +		.end	= S3C_PA_ONENAND + 0x400 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= S3C_PA_ONENAND_BUF,
> +		.end	= S3C_PA_ONENAND_BUF + S3C_SZ_ONENAND_BUF - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[2] = {
> +		.start	= IRQ_ONENAND,
> +		.end	= IRQ_ONENAND,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s3c_device_onenand = {
> +	.name		= "samsung-onenand",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(s3c_onenand_resources),
> +	.resource	= s3c_onenand_resources,
> +};
> +
> +void s3c_onenand_set_platdata(struct onenand_platform_data *pdata)
> +{
> +	struct onenand_platform_data *pd;
> +
> +	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
> +	if (!pd)
> +		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> +	s3c_device_onenand.dev.platform_data = pd;
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
> index 78d2420..d786b0f 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -61,6 +61,9 @@ extern struct platform_device s3c_device_spi1;
>  extern struct platform_device s3c_device_hwmon;
>  
>  extern struct platform_device s3c_device_nand;
> +extern struct platform_device s3c_device_onenand;
> +extern struct platform_device s3c64xx_device_onenand1;
> +extern struct platform_device s5pc110_device_onenand;
>  
>  extern struct platform_device s3c_device_usbgadget;
>  extern struct platform_device s3c_device_usb_hsotg;
> diff --git a/arch/arm/plat-samsung/include/plat/onenand-core.h b/arch/arm/plat-samsung/include/plat/onenand-core.h
> new file mode 100644
> index 0000000..7701cb7
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/onenand-core.h
> @@ -0,0 +1,37 @@
> +/*
> + * linux/arch/arm/plat-samsung/onenand-core.h
> + *
> + *  Copyright (c) 2010 Samsung Electronics
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *  Marek Szyprowski <m.szyprowski@samsung.com>
> + *
> + * Samsung OneNAD Controller core functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_ONENAND_CORE_H
> +#define __ASM_ARCH_ONENAND_CORE_H __FILE__
> +
> +/* These functions are only for use with the core support code, such as
> + * the cpu specific initialisation code
> + */
> +
> +/* re-define device name depending on support. */
> +static inline void s3c_onenand_setname(char *name)
> +{
> +#ifdef CONFIG_S3C_DEV_ONENAND
> +	s3c_device_onenand.name = name;
> +#endif
> +}
> +
> +static inline void s3c64xx_onenand1_setname(char *name)
> +{
> +#ifdef CONFIG_S3C64XX_DEV_ONENAND1
> +	s3c64xx_device_onenand1.name = name;
> +#endif
> +}
> +
> +#endif /* __ASM_ARCH_ONENAND_CORE_H */
> diff --git a/arch/arm/plat-samsung/include/plat/regs-onenand.h b/arch/arm/plat-samsung/include/plat/regs-onenand.h
> new file mode 100644
> index 0000000..930ea8b
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/regs-onenand.h
> @@ -0,0 +1,63 @@
> +/*
> + * linux/arch/arm/plat-s3c/include/plat/regs-onenand.h
> + *
> + *  Copyright (C) 2008-2010 Samsung Electronics
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __SAMSUNG_ONENAND_H__
> +#define __SAMSUNG_ONENAND_H__
> +
> +#include <mach/hardware.h>
> +
> +/*
> + * OneNAND Controller
> + */
> +#define MEM_CFG_OFFSET		0x0000
> +#define BURST_LEN_OFFSET	0x0010
> +#define MEM_RESET_OFFSET	0x0020
> +#define INT_ERR_STAT_OFFSET	0x0030
> +#define INT_ERR_MASK_OFFSET	0x0040
> +#define INT_ERR_ACK_OFFSET	0x0050
> +#define ECC_ERR_STAT_OFFSET	0x0060
> +#define MANUFACT_ID_OFFSET	0x0070
> +#define DEVICE_ID_OFFSET	0x0080
> +#define DATA_BUF_SIZE_OFFSET	0x0090
> +#define BOOT_BUF_SIZE_OFFSET	0x00A0
> +#define BUF_AMOUNT_OFFSET	0x00B0
> +#define TECH_OFFSET		0x00C0
> +#define FBA_WIDTH_OFFSET	0x00D0
> +#define FPA_WIDTH_OFFSET	0x00E0
> +#define FSA_WIDTH_OFFSET	0x00F0
> +#define TRANS_SPARE_OFFSET	0x0140
> +#define DBS_DFS_WIDTH_OFFSET	0x0160
> +#define INT_PIN_ENABLE_OFFSET	0x01A0
> +#define ACC_CLOCK_OFFSET	0x01C0
> +#define FLASH_VER_ID_OFFSET	0x01F0
> +#define FLASH_AUX_CNTRL_OFFSET	0x0300		/* s3c64xx only */
> +
> +#define ONENAND_MEM_RESET_HOT	0x3
> +#define ONENAND_MEM_RESET_COLD	0x2
> +#define ONENAND_MEM_RESET_WARM	0x1
> +
> +#define CACHE_OP_ERR		(1 << 13)
> +#define RST_CMP			(1 << 12)
> +#define RDY_ACT			(1 << 11)
> +#define INT_ACT			(1 << 10)
> +#define UNSUP_CMD		(1 << 9)
> +#define LOCKED_BLK		(1 << 8)
> +#define BLK_RW_CMP		(1 << 7)
> +#define ERS_CMP			(1 << 6)
> +#define PGM_CMP			(1 << 5)
> +#define LOAD_CMP		(1 << 4)
> +#define ERS_FAIL		(1 << 3)
> +#define PGM_FAIL		(1 << 2)
> +#define INT_TO			(1 << 1)
> +#define LD_FAIL_ECC_ERR		(1 << 0)
> +
> +#define TSRF			(1 << 0)
> +
> +#endif
> -- 
> 1.6.4
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
