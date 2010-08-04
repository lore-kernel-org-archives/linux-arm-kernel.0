From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Aug 2010 19:55:13 +0900
Subject: [PATCH v5 3/8] ARM: Samsung: Add platform definitions and helpers
	for FIMC driver
In-Reply-To: <1280814085-25718-1-git-send-email-m.szyprowski@samsung.com>
References: <00e101cb329e$a50ceb60$ef26c220$%kim@samsung.com>
	<1280814085-25718-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001601cb33c3$8775ba70$96612f50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> FIMC (CAMIF) device is a camera interface embedded in S3C/S5P Samsung
> SOC series. It supports ITU-R BT.601/656 and MIPI-CSI2 standards,
> memory to memory operations, color conversion, resizing and rotation.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
> Changes since v4:
> - addressed all minor style issues reported by Kukjin Kim
> 
> Changes since v3:
> - rebased onto latest kgene/for-next tree
> - new entries in map.h files has been sorted by the physicall address
> 
> I'm sending this patch on behalf of Sylwerster who is on holidays this
> week.
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> ---
>  arch/arm/mach-s5pc100/include/mach/map.h       |    7 ++++
>  arch/arm/mach-s5pv210/cpu.c                    |    5 +++
>  arch/arm/mach-s5pv210/include/mach/map.h       |    7 ++++
>  arch/arm/plat-s5p/Kconfig                      |   15 ++++++++
>  arch/arm/plat-s5p/Makefile                     |    5 +++
>  arch/arm/plat-s5p/dev-fimc0.c                  |   36
> ++++++++++++++++++++
>  arch/arm/plat-s5p/dev-fimc1.c                  |   36
> ++++++++++++++++++++
>  arch/arm/plat-s5p/dev-fimc2.c                  |   36
> ++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/devs.h      |    4 ++
>  arch/arm/plat-samsung/include/plat/fimc-core.h |   43
> ++++++++++++++++++++++++
>  10 files changed, 194 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s5p/dev-fimc0.c
>  create mode 100644 arch/arm/plat-s5p/dev-fimc1.c
>  create mode 100644 arch/arm/plat-s5p/dev-fimc2.c
>  create mode 100644 arch/arm/plat-samsung/include/plat/fimc-core.h
> 
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-
> s5pc100/include/mach/map.h
> index c018697..3abe7f5 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -99,6 +99,10 @@
> 
>  #define S5PC100_PA_FB		(0xEE000000)
> 
> +#define S5PC100_PA_FIMC0	(0xEE200000)
> +#define S5PC100_PA_FIMC1	(0xEE300000)
> +#define S5PC100_PA_FIMC2	(0xEE400000)
> +
>  #define S5PC100_PA_I2S0		(0xF2000000)
>  #define S5PC100_PA_I2S1		(0xF2100000)
>  #define S5PC100_PA_I2S2		(0xF2200000)
> @@ -143,6 +147,9 @@
>  #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
>  #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
>  #define S3C_PA_RTC		S5PC100_PA_RTC
> +#define S5P_PA_FIMC0		S5PC100_PA_FIMC0
> +#define S5P_PA_FIMC1		S5PC100_PA_FIMC1
> +#define S5P_PA_FIMC2		S5PC100_PA_FIMC2
> 
>  #define SAMSUNG_PA_ADC		S5PC100_PA_TSADC
>  #define SAMSUNG_PA_CFCON	S5PC100_PA_CFCON
> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
> index ea09c32..a7446d4 100644
> --- a/arch/arm/mach-s5pv210/cpu.c
> +++ b/arch/arm/mach-s5pv210/cpu.c
> @@ -37,6 +37,7 @@
>  #include <plat/iic-core.h>
>  #include <plat/keypad-core.h>
>  #include <plat/sdhci.h>
> +#include <plat/fimc-core.h>
>  #include <plat/reset.h>
> 
>  /* Initial IO mappings */
> @@ -104,6 +105,10 @@ void __init s5pv210_map_io(void)
> 
>  	/* Use s5pv210-keypad instead of samsung-keypad */
>  	samsung_keypad_setname("s5pv210-keypad");
> +
> +	s3c_fimc_setname(0, "s5pv210-fimc");
> +	s3c_fimc_setname(1, "s5pv210-fimc");
> +	s3c_fimc_setname(2, "s5pv210-fimc");
>  }
> 
>  void __init s5pv210_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index 986b285..dd4fb6b 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -65,6 +65,10 @@
> 
>  #define S5PV210_PA_FB		(0xF8000000)
> 
> +#define S5PV210_PA_FIMC0	(0xFB200000)
> +#define S5PV210_PA_FIMC1	(0xFB300000)
> +#define S5PV210_PA_FIMC2	(0xFB400000)
> +
>  #define S5PV210_PA_HSMMC(x)	(0xEB000000 + ((x) * 0x100000))
> 
>  #define S5PV210_PA_VIC0		(0xF2000000)
> @@ -109,6 +113,9 @@
>  #define S3C_PA_FB		S5PV210_PA_FB
>  #define S3C_PA_RTC		S5PV210_PA_RTC
>  #define S3C_PA_WDT		S5PV210_PA_WATCHDOG
> +#define S5P_PA_FIMC0		S5PV210_PA_FIMC0
> +#define S5P_PA_FIMC1		S5PV210_PA_FIMC1
> +#define S5P_PA_FIMC2		S5PV210_PA_FIMC2
> 
>  #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
>  #define SAMSUNG_PA_CFCON	S5PV210_PA_CFCON
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 907ac63..66e40c8 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -5,6 +5,21 @@
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
>  config PLAT_S5P
>  	bool
>  	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 ||
> ARCH_S5PV210 || ARCH_S5PV310)
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index 7e34194..b2e0296 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -19,3 +19,8 @@ obj-y				+= clock.o
>  obj-y				+= irq.o
>  obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
> 
> +# devices
> +
> +obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
> +obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
> +obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
> diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
> new file mode 100644
> index 0000000..d3f1a9b
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-fimc0.c
> @@ -0,0 +1,36 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <mach/map.h>
> +
> +static struct resource s5p_fimc0_resource[] = {
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
> +	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
> +	.resource	= s5p_fimc0_resource,
> +};
> diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
> new file mode 100644
> index 0000000..41bd698
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-fimc1.c
> @@ -0,0 +1,36 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <mach/map.h>
> +
> +static struct resource s5p_fimc1_resource[] = {
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
> +	.num_resources	= ARRAY_SIZE(s5p_fimc1_resource),
> +	.resource	= s5p_fimc1_resource,
> +};
> diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
> new file mode 100644
> index 0000000..dfddeda
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-fimc2.c
> @@ -0,0 +1,36 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <mach/map.h>
> +
> +static struct resource s5p_fimc2_resource[] = {
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
> +	.num_resources	= ARRAY_SIZE(s5p_fimc2_resource),
> +	.resource	= s5p_fimc2_resource,
> +};
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index 4c31d32..85f6f23 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -104,6 +104,10 @@ extern struct platform_device s5pc100_device_iis2;
> 
>  extern struct platform_device samsung_device_keypad;
> 
> +extern struct platform_device s5p_device_fimc0;
> +extern struct platform_device s5p_device_fimc1;
> +extern struct platform_device s5p_device_fimc2;
> +
>  /* s3c2440 specific devices */
> 
>  #ifdef CONFIG_CPU_S3C2440
> diff --git a/arch/arm/plat-samsung/include/plat/fimc-core.h
b/arch/arm/plat-
> samsung/include/plat/fimc-core.h
> new file mode 100644
> index 0000000..c2ddd83
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/fimc-core.h
> @@ -0,0 +1,43 @@
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
> +/* Re-define device name to differentiate the subsystem in various SoCs.
*/
> +static inline void s3c_fimc_setname(int id, char *name)
> +{
> +	switch (id) {
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
> --
Looks ok..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
