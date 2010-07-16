From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 19:07:32 +0900
Subject: [PATCH 02/10 v2] ARM: Samsung: Add FIMC resource definition and
	FIMC driver platform helpers
In-Reply-To: <1279185041-6004-3-git-send-email-s.nawrocki@samsung.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
	<1279185041-6004-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <012301cb24ce$cc67aac0$65370040$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Add camera interface SoC resource definitions and setup code
> for FIMC/FB fifo links.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig                  |   15 ++++++
>  arch/arm/mach-s5pc100/Makefile                 |    3 +
>  arch/arm/mach-s5pc100/include/mach/map.h       |    8 +++
>  arch/arm/mach-s5pc100/setup-fimc0.c            |   14 ++++++
>  arch/arm/mach-s5pc100/setup-fimc1.c            |   14 ++++++
>  arch/arm/mach-s5pc100/setup-fimc2.c            |   14 ++++++
>  arch/arm/mach-s5pv210/Kconfig                  |   15 ++++++
>  arch/arm/mach-s5pv210/Makefile                 |    3 +
>  arch/arm/mach-s5pv210/cpu.c                    |    5 ++
>  arch/arm/mach-s5pv210/include/mach/map.h       |    8 +++
>  arch/arm/mach-s5pv210/setup-fimc0.c            |   14 ++++++
>  arch/arm/mach-s5pv210/setup-fimc1.c            |   14 ++++++
>  arch/arm/mach-s5pv210/setup-fimc2.c            |   14 ++++++
>  arch/arm/plat-s5p/Kconfig                      |   16 +++++++
>  arch/arm/plat-s5p/Makefile                     |    3 +
>  arch/arm/plat-s5p/dev-fimc0.c                  |   56
> ++++++++++++++++++++++++
>  arch/arm/plat-s5p/dev-fimc1.c                  |   55
> +++++++++++++++++++++++
>  arch/arm/plat-s5p/dev-fimc2.c                  |   55
> +++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/fimc-core.h |   45 +++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/fimc.h      |   12 +++++
>  20 files changed, 383 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pc100/setup-fimc0.c
>  create mode 100644 arch/arm/mach-s5pc100/setup-fimc1.c
>  create mode 100644 arch/arm/mach-s5pc100/setup-fimc2.c
>  create mode 100644 arch/arm/mach-s5pv210/setup-fimc0.c
>  create mode 100644 arch/arm/mach-s5pv210/setup-fimc1.c
>  create mode 100644 arch/arm/mach-s5pv210/setup-fimc2.c
>  create mode 100644 arch/arm/plat-s5p/dev-fimc0.c
>  create mode 100644 arch/arm/plat-s5p/dev-fimc1.c
>  create mode 100644 arch/arm/plat-s5p/dev-fimc2.c
>  create mode 100644 arch/arm/plat-samsung/include/plat/fimc-core.h
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index d421f80..791270d 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -36,6 +36,21 @@ config S5PC100_SETUP_SDHCI_GPIO
>  	help
>  	  Common setup code for SDHCI gpio.
> 
> +config S5PC100_SETUP_FIMC0
> +	bool
> +	help
> +	  Setup code for FIMC controller 0
> +
> +config S5PC100_SETUP_FIMC1
> +	bool
> +	help
> +	  Setup code for FIMC controller 1
> +
> +config S5PC100_SETUP_FIMC2
> +	bool
> +	help
> +	  Setup code for FIMC controller 2
> +
>  config MACH_SMDKC100
>  	bool "SMDKC100"
>  	select CPU_S5PC100
> diff --git a/arch/arm/mach-s5pc100/Makefile
b/arch/arm/mach-s5pc100/Makefile
> index f2073bc..7b43337 100644
> --- a/arch/arm/mach-s5pc100/Makefile
> +++ b/arch/arm/mach-s5pc100/Makefile
> @@ -25,6 +25,9 @@ obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-
> sdhci-gpio.o
>  # device support
>  obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> +obj-$(CONFIG_S5PC100_SETUP_FIMC0)	+= setup-fimc0.o
> +obj-$(CONFIG_S5PC100_SETUP_FIMC1)	+= setup-fimc1.o
> +obj-$(CONFIG_S5PC100_SETUP_FIMC2)	+= setup-fimc2.o
> 
>  # machine support
> 
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-
> s5pc100/include/mach/map.h
> index c025064..a1c6f22 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -112,6 +112,11 @@
>  #define S5PC100_PA_SDRAM	(0x30000000)
>  #define S5P_PA_SDRAM		S5PC100_PA_SDRAM
> 
> +/* FIMC */
> +#define S5PC100_PA_FIMC0	(0xEE200000)
> +#define S5PC100_PA_FIMC1	(0xEE300000)
> +#define S5PC100_PA_FIMC2	(0xEE400000)
> +
>  /* compatibiltiy defines. */
>  #define S3C_PA_UART		S5PC100_PA_UART
>  #define S3C_PA_IIC		S5PC100_PA_IIC0
> @@ -134,5 +139,8 @@
>  #define S3C_PA_ONENAND		S5PC100_PA_ONENAND
>  #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
>  #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
> +#define S5P_PA_FIMC0		S5PC100_PA_FIMC0
> +#define S5P_PA_FIMC1		S5PC100_PA_FIMC1
> +#define S5P_PA_FIMC2		S5PC100_PA_FIMC2
> 
>  #endif /* __ASM_ARCH_C100_MAP_H */
> diff --git a/arch/arm/mach-s5pc100/setup-fimc0.c
b/arch/arm/mach-s5pc100/setup-
> fimc0.c
> new file mode 100644
> index 0000000..dea33c2
> --- /dev/null
> +++ b/arch/arm/mach-s5pc100/setup-fimc0.c
> @@ -0,0 +1,14 @@
> +/* linux/arch/arm/mach-s5pc100/setup-fimc0.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * S5PC100 - setup for S5P FIMC device 0
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/fimc.h>
> +
> +struct samsung_plat_fimc s5p_fimc0_default_data __initdata = {};
> diff --git a/arch/arm/mach-s5pc100/setup-fimc1.c
b/arch/arm/mach-s5pc100/setup-
> fimc1.c
> new file mode 100644
> index 0000000..1833377
> --- /dev/null
> +++ b/arch/arm/mach-s5pc100/setup-fimc1.c
> @@ -0,0 +1,14 @@
> +/* linux/arch/arm/mach-s5pc100/setup-fimc1.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * S5PC100 - setup for S5P FIMC device 1
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/fimc.h>
> +
> +struct samsung_plat_fimc s5p_fimc1_default_data __initdata = {};
> diff --git a/arch/arm/mach-s5pc100/setup-fimc2.c
b/arch/arm/mach-s5pc100/setup-
> fimc2.c
> new file mode 100644
> index 0000000..746e0f0
> --- /dev/null
> +++ b/arch/arm/mach-s5pc100/setup-fimc2.c
> @@ -0,0 +1,14 @@
> +/* linux/arch/arm/mach-s5pc100/setup-fimc2.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * S5PC100 - setup for S5P FIMC device 2
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/fimc.h>
> +
> +struct samsung_plat_fimc s5p_fimc2_default_data __initdata = {};
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index d876ff0..4bb5a85 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -32,6 +32,21 @@ config S5PV210_SETUP_FB_24BPP
>  	help
>            Common setup code for S5PV210 with an 24bpp RGB display helper.
> 
> +config S5PV210_SETUP_FIMC0
> +	bool
> +	help
> +	  Setup code for FIMC controller 0
> +
> +config S5PV210_SETUP_FIMC1
> +	bool
> +	help
> +	  Setup code for FIMC controller 1
> +
> +config S5PV210_SETUP_FIMC2
> +	bool
> +	help
> +	  Setup code for FIMC controller 2
> +
>  config S5PV210_SETUP_SDHCI
>          bool
>          select S5PV210_SETUP_SDHCI_GPIO
> diff --git a/arch/arm/mach-s5pv210/Makefile
b/arch/arm/mach-s5pv210/Makefile
> index 7b3a984..6eceeb8 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -35,3 +35,6 @@ obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
>  obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
>  obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
>  obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> +obj-$(CONFIG_S5PV210_SETUP_FIMC0)	+= setup-fimc0.o
> +obj-$(CONFIG_S5PV210_SETUP_FIMC1)	+= setup-fimc1.o
> +obj-$(CONFIG_S5PV210_SETUP_FIMC2)	+= setup-fimc2.o
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index fc3801b..4133cae 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -35,6 +35,7 @@
>  #include <plat/iic-core.h>
>  #include <plat/sdhci.h>
>  #include <plat/fb-core.h>
> +#include <plat/fimc-core.h>
> 
>  /* Initial IO mappings */
> 
> @@ -95,6 +96,10 @@ void __init s5pv210_map_io(void)
>  	s3c_i2c2_setname("s3c2440-i2c");
> 
>  	s3c_fb_setname("s5pv210-fb");
> +
> +	s3c_fimc_setname(0, "s5pv210-fimc");
> +	s3c_fimc_setname(1, "s5pv210-fimc");
> +	s3c_fimc_setname(2, "s5pv210-fimc");
>  }
> 
>  void __init s5pv210_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index e78bd47..9b8cf69 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -96,6 +96,11 @@
> 
>  #define S5PV210_PA_ADC		(0xE1700000)
> 
> +/* FIMC */
> +#define S5PV210_PA_FIMC0	(0xFB200000)
> +#define S5PV210_PA_FIMC1	(0xFB300000)
> +#define S5PV210_PA_FIMC2	(0xFB400000)
> +
>  /* compatibiltiy defines. */
>  #define S3C_PA_UART		S5PV210_PA_UART
>  #define S3C_PA_HSMMC0		S5PV210_PA_HSMMC(0)
> @@ -111,5 +116,8 @@
>  #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
>  #define S3C_PA_USB_HSOTG	S5PV210_PA_USB_HSOTG
>  #define S3C_PA_USB_HSPHY	S5PV210_PA_USB_HSPHY
> +#define S5P_PA_FIMC0		S5PV210_PA_FIMC0
> +#define S5P_PA_FIMC1		S5PV210_PA_FIMC1
> +#define S5P_PA_FIMC2		S5PV210_PA_FIMC2
> 
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/mach-s5pv210/setup-fimc0.c
b/arch/arm/mach-s5pv210/setup-
> fimc0.c
> new file mode 100644
> index 0000000..0e5ef0a
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/setup-fimc0.c
> @@ -0,0 +1,14 @@
> +/* linux/arch/arm/mach-s5pv210/setup-fimc0.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * S5PV210 - setup for S5P FIMC device 0
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/fimc.h>
> +
> +struct samsung_plat_fimc s5p_fimc0_default_data __initdata = {};
> diff --git a/arch/arm/mach-s5pv210/setup-fimc1.c
b/arch/arm/mach-s5pv210/setup-
> fimc1.c
> new file mode 100644
> index 0000000..80da0e7
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/setup-fimc1.c
> @@ -0,0 +1,14 @@
> +/* linux/arch/arm/mach-s5pv210/setup-fimc1.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * S5PV210 - setup for S5P FIMC device 1
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/fimc.h>
> +
> +struct samsung_plat_fimc s5p_fimc1_default_data __initdata = {};
> diff --git a/arch/arm/mach-s5pv210/setup-fimc2.c
b/arch/arm/mach-s5pv210/setup-
> fimc2.c
> new file mode 100644
> index 0000000..bc6a27b
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/setup-fimc2.c
> @@ -0,0 +1,14 @@
> +/* linux/arch/arm/mach-s5pv210/setup-fimc2.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * S5PV210 - setup for S5P FIMC device 2
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <plat/fimc.h>
> +
> +struct samsung_plat_fimc s5p_fimc2_default_data __initdata = {};
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 11d6a1b..38b60c7 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -5,6 +5,22 @@
>  #
>  # Licensed under GPLv2
> 
> +config S5P_DEV_FIMC0
> +	bool
> +	help
> +	  Compile in platform device definitions for FIMC controller 0
> +
> +config S5P_DEV_FIMC1
> +	bool
> +	help
> +	  Compile in platform device definitions for FIMC controller 1
> +
> +config S5P_DEV_FIMC2
> +	bool
> +	help
> +	  Compile in platform device definitions for FIMC controller 2
> +
> +

2 empty lines...

>  config PLAT_S5P
>  	bool
>  	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 ||
> ARCH_S5PV210)
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index b56b4d3..a7d3c35 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -18,3 +18,6 @@ obj-y				+= clock.o
>  obj-y				+= irq.o irq-gpioint.o
>  obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
> 
> +obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
> +obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
> +obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
> diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
> new file mode 100644
> index 0000000..cfa10f0
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-fimc0.c
> @@ -0,0 +1,56 @@
> +/* linux/arch/arm/plat-s5p/dev-fimc0.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * Base S5P FIMC0 resource and device definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/platform_device.h>
> +#include <mach/map.h>
> +#include <mach/irqs.h>
> +#include <plat/fimc.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +
> +

Same...2 empty lines...

> +static struct resource s5p_fimc_resource[] = {
> +	[0] = {
> +		.start	= S5P_PA_FIMC0,
> +		.end	= S5P_PA_FIMC0 + SZ_1M - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_FIMC0,
> +		.end	= IRQ_FIMC0,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s5p_device_fimc0 = {
> +	.name		= "s5p-fimc",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
> +	.resource	= s5p_fimc_resource,
> +};
> +
> +

2 empty lines...

> +void __init s5p_fimc0_set_platdata(struct samsung_plat_fimc *pd)

Actually, we can use Ben's 's3c_set_platdata' which can replace a number of
sites...

Please refer to below URL.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/016650.html

I think this method is better to us.

> +{
> +	struct samsung_plat_fimc *npd;
> +
> +	if (!pd)
> +		pd = &s5p_fimc0_default_data;
> +
> +	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
> +	if (!npd)
> +		printk(KERN_ERR "%s: out of memory\n", __func__);
> +
> +	s5p_device_fimc0.dev.platform_data = npd;
> +}
> +

No need last empty line

> diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
> new file mode 100644
> index 0000000..7178477
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-fimc1.c
> @@ -0,0 +1,55 @@
> +/* linux/arch/arm/plat-s5p/dev-fimc1.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * Base S5P FIMC1 resource and device definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/platform_device.h>
> +#include <mach/map.h>
> +#include <mach/irqs.h>
> +#include <plat/fimc.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +
> +
2 empty lines..

> +static struct resource s5p_fimc_resource[] = {
> +	[0] = {
> +		.start	= S5P_PA_FIMC1,
> +		.end	= S5P_PA_FIMC1 + SZ_1M - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_FIMC1,
> +		.end	= IRQ_FIMC1,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s5p_device_fimc1 = {
> +	.name		= "s5p-fimc",
> +	.id		= 1,
> +	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
> +	.resource	= s5p_fimc_resource,
> +};
> +
> +void __init s5p_fimc1_set_platdata(struct samsung_plat_fimc *pd)
> +{
> +	struct samsung_plat_fimc *npd;
> +
> +	if (!pd)
> +		pd = &s5p_fimc1_default_data;
> +
> +	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
> +	if (!npd)
> +		printk(KERN_ERR "%s: out of memory\n", __func__);
> +
> +	s5p_device_fimc1.dev.platform_data = npd;
> +}
> +

No need last empty line...

> diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
> new file mode 100644
> index 0000000..fe1a6c0
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-fimc2.c
> @@ -0,0 +1,55 @@
> +/* linux/arch/arm/plat-s5p/dev-fimc2.c
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + * Base S5P FIMC2 resource and device definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/platform_device.h>
> +#include <mach/map.h>
> +#include <mach/irqs.h>
> +#include <plat/fimc.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +
> +

Same...

> +static struct resource s5p_fimc_resource[] = {
> +	[0] = {
> +		.start	= S5P_PA_FIMC2,
> +		.end	= S5P_PA_FIMC2 + SZ_1M - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_FIMC2,
> +		.end	= IRQ_FIMC2,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s5p_device_fimc2 = {
> +	.name		= "s5p-fimc",
> +	.id		= 2,
> +	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
> +	.resource	= s5p_fimc_resource,
> +};
> +
> +void __init s5p_fimc2_set_platdata(struct samsung_plat_fimc *pd)
> +{
> +	struct samsung_plat_fimc *npd;
> +
> +	if (!pd)
> +		pd = &s5p_fimc2_default_data;
> +
> +	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
> +	if (!npd)
> +		printk(KERN_ERR "%s: out of memory\n", __func__);
> +
> +	s5p_device_fimc2.dev.platform_data = npd;
> +}
> +

Same..

> diff --git a/arch/arm/plat-samsung/include/plat/fimc-core.h
b/arch/arm/plat-
> samsung/include/plat/fimc-core.h
> new file mode 100644
> index 0000000..a126bbd
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/fimc-core.h
> @@ -0,0 +1,45 @@
> +/*
> + * arch/arm/plat-samsung/include/plat/fimc-core.h
> + *
> + * Copyright 2010 Samsung Electronics Co., Ltd.
> + *	Sylwester Nawrocki <s.nawrocki@samsung.com>
> + *
> + * Samsung camera interface driver core functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_PLAT_FIMC_CORE_H
> +#define __ASM_PLAT_FIMC_CORE_H __FILE__
> +
> +/*
> + * These functions are only for use with the core support code, such as
> + * the CPU-specific initialization code.
> + */
> +
> +#include <plat/fimc.h>
> +
> +/* Re-define device name to differentiate the subsystem in various SoCs.
*/
> +static inline void s3c_fimc_setname(int id, char *name)
> +{
> +	switch(id) {
> +#ifdef CONFIG_S5P_DEV_FIMC0
> +	case 0:
> +		s5p_device_fimc0.name = name;
> +		break;
> +#endif
> +#ifdef CONFIG_S5P_DEV_FIMC1
> +	case 1:
> +		s5p_device_fimc1.name = name;
> +		break;
> +#endif
> +#ifdef CONFIG_S5P_DEV_FIMC2
> +	case 2:
> +		s5p_device_fimc2.name = name;
> +		break;
> +#endif
> +	}
> +}
> +
> +#endif /* __ASM_PLAT_FIMC_CORE_H */
> diff --git a/arch/arm/plat-samsung/include/plat/fimc.h b/arch/arm/plat-
> samsung/include/plat/fimc.h
> index be1e853..cf7d2fb 100644
> --- a/arch/arm/plat-samsung/include/plat/fimc.h
> +++ b/arch/arm/plat-samsung/include/plat/fimc.h
> @@ -27,5 +27,17 @@ struct samsung_plat_fimc {
>  	struct s3c_fifo_link	*fifo_targets[FIMC_MAX_FIFO_TARGETS];
>  };
> 
> +extern struct platform_device s5p_device_fimc0;
> +extern struct platform_device s5p_device_fimc1;
> +extern struct platform_device s5p_device_fimc2;
> +
> +extern struct samsung_plat_fimc s5p_fimc0_default_data;
> +extern struct samsung_plat_fimc s5p_fimc1_default_data;
> +extern struct samsung_plat_fimc s5p_fimc2_default_data;
> +
> +extern void s5p_fimc0_set_platdata(struct samsung_plat_fimc *fimc);
> +extern void s5p_fimc1_set_platdata(struct samsung_plat_fimc *fimc);
> +extern void s5p_fimc2_set_platdata(struct samsung_plat_fimc *fimc);
> +
>  #endif /* FIMC_H_ */
> 
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
