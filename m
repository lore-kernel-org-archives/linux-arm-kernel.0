From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Oct 2010 14:58:18 +0200
Subject: [PATCH 2/2] ARM: S5PV310: Add support Power Domain
In-Reply-To: <1286970422-15993-3-git-send-email-kgene.kim@samsung.com>
References: <1286970422-15993-1-git-send-email-kgene.kim@samsung.com>
	<1286970422-15993-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <00e201cb6ad6$51037dc0$f30a7940$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, October 13, 2010 1:47 PM Kukjin Kim wrote:

> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> This patch adds support Power Domain for S5PV310 and S5PC210.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Kconfig                 |    7 +
>  arch/arm/mach-s5pv310/Makefile                |    2 +
>  arch/arm/mach-s5pv310/cpu.c                   |    5 +
>  arch/arm/mach-s5pv310/dev-pd.c                |  249 +++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/include/mach/map.h      |    2 +
>  arch/arm/mach-s5pv310/include/mach/regs-pmu.h |   40 ++++
>  arch/arm/mach-s5pv310/mach-smdkc210.c         |    9 +
>  arch/arm/mach-s5pv310/mach-smdkv310.c         |    9 +
>  arch/arm/plat-s5p/include/plat/map-s5p.h      |    1 +
>  arch/arm/plat-samsung/include/plat/devs.h     |    2 +
>  10 files changed, 326 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/dev-pd.c
>  create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-pmu.h
> 
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index 1150b36..3bf72a6 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -14,6 +14,11 @@ config CPU_S5PV310
>  	help
>  	  Enable S5PV310 CPU support
> 
> +config S5PV310_DEV_PD
> +	bool
> +	help
> +	  Compile in platform device definitions for Power Domain
> +
>  config S5PV310_SETUP_I2C1
>  	bool
>  	help
> @@ -73,6 +78,7 @@ config MACH_SMDKC210
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_HSMMC2
>  	select S3C_DEV_HSMMC3
> +	select S5PV310_DEV_PD
>  	select S5PV310_SETUP_SDHCI
>  	help
>  	  Machine support for Samsung SMDKC210
> @@ -101,6 +107,7 @@ config MACH_SMDKV310
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_HSMMC2
>  	select S3C_DEV_HSMMC3
> +	select S5PV310_DEV_PD
>  	select S5PV310_SETUP_SDHCI
>  	help
>  	  Machine support for Samsung SMDKV310
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index 97aba6d..74beb47 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -28,6 +28,8 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
> 
>  # device support
> 
> +obj-$(CONFIG_S5PV310_DEV_PD)		+= dev-pd.o
> +
>  obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
>  obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
>  obj-$(CONFIG_S5PV310_SETUP_I2C3)	+= setup-i2c3.o
> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
> index ffed262..44ddad6 100644
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -42,6 +42,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
>  		.length		= SZ_128K,
>  		.type		= MT_DEVICE,
>  	}, {
> +		.virtual	= (unsigned long)S5P_VA_PMU,
> +		.pfn		= __phys_to_pfn(S5PV310_PA_PMU),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE,
> +	}, {
>  		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
>  		.pfn		= __phys_to_pfn(S5PV310_PA_COMBINER),
>  		.length		= SZ_4K,
> diff --git a/arch/arm/mach-s5pv310/dev-pd.c b/arch/arm/mach-s5pv310/dev-pd.c
> new file mode 100644
> index 0000000..ac5a1f8
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/dev-pd.c
> @@ -0,0 +1,249 @@
> +/* linux/arch/arm/mach-s5pv310/dev-pd.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * S5PV310 - Power Domain support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +
> +#include <mach/regs-pmu.h>
> +
> +#include <plat/pd.h>
> +
> +static int s5pv310_pd_enable(enum s5pv310_pd_block pd)
> +{
> +	void __iomem *status;
> +	u32 timeout;
> +
> +	switch (pd) {
> +	case PD_MFC:
> +		__raw_writel(S5P_INT_LOCAL_PWR_EN, S5P_MFC_CONFIGURATION);
> +		status = S5P_MFC_STATUS;
> +		break;
> +	case PD_G3D:
> +		__raw_writel(S5P_INT_LOCAL_PWR_EN, S5P_G3D_CONFIGURATION);
> +		status = S5P_G3D_STATUS;
> +		break;
> +	case PD_LCD0:
> +		__raw_writel(S5P_INT_LOCAL_PWR_EN, S5P_LCD0_CONFIGURATION);
> +		status = S5P_LCD0_STATUS;
> +		break;
> +	case PD_LCD1:
> +		__raw_writel(S5P_INT_LOCAL_PWR_EN, S5P_LCD1_CONFIGURATION);
> +		status = S5P_LCD1_STATUS;
> +		break;
> +	case PD_CAM:
> +		__raw_writel(S5P_INT_LOCAL_PWR_EN, S5P_CAM_CONFIGURATION);
> +		status = S5P_CAM_STATUS;
> +		break;
> +	case PD_TV:
> +		__raw_writel(S5P_INT_LOCAL_PWR_EN, S5P_TV_CONFIGURATION);
> +		status = S5P_TV_STATUS;
> +		break;
> +	default:
> +		printk(KERN_WARNING "Wrong PD enable request %d\n", pd);
> +		return -EINVAL;
> +	}
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while ((__raw_readl(status) & S5P_INT_LOCAL_PWR_EN)
> +		!= S5P_INT_LOCAL_PWR_EN) {
> +		if (timeout == 0) {
> +			printk(KERN_ERR "Power domain %d enable failed.\n", pd);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		udelay(100);
> +	}
> +
> +	return 0;
> +}
> +
> +static int s5pv310_pd_disable(enum s5pv310_pd_block pd)
> +{
> +	void __iomem *status;
> +	u32 timeout;
> +
> +	switch (pd) {
> +	case PD_MFC:
> +		__raw_writel(0, S5P_MFC_CONFIGURATION);
> +		status = S5P_MFC_STATUS;
> +		break;
> +	case PD_G3D:
> +		__raw_writel(0, S5P_G3D_CONFIGURATION);
> +		status = S5P_G3D_STATUS;
> +		break;
> +	case PD_LCD0:
> +		__raw_writel(0, S5P_LCD0_CONFIGURATION);
> +		status = S5P_LCD0_STATUS;
> +		break;
> +	case PD_LCD1:
> +		__raw_writel(0, S5P_LCD1_CONFIGURATION);
> +		status = S5P_LCD1_STATUS;
> +		break;
> +	case PD_CAM:
> +		__raw_writel(0, S5P_CAM_CONFIGURATION);
> +		status = S5P_CAM_STATUS;
> +		break;
> +	case PD_TV:
> +		__raw_writel(0, S5P_TV_CONFIGURATION);
> +		status = S5P_TV_STATUS;
> +		break;
> +	default:
> +		printk(KERN_WARNING "Wrong PD disable request %d\n", pd);
> +		return -EINVAL;
> +	}
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while (__raw_readl(status) & S5P_INT_LOCAL_PWR_EN) {
> +		if (timeout == 0) {
> +			printk(KERN_ERR "PD %d disable failed.\n", pd);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		udelay(100);
> +	}
> +
> +	return 0;
> +}
> +
> +static int s5pv310_pd_mfc_enable(void)
> +{
> +	return s5pv310_pd_enable(PD_MFC);
> +}
> +
> +static int s5pv310_pd_mfc_disable(void)
> +{
> +	return s5pv310_pd_disable(PD_MFC);
> +}
> +
> +static int s5pv310_pd_g3d_enable(void)
> +{
> +	return s5pv310_pd_enable(PD_G3D);
> +}
> +
> +static int s5pv310_pd_g3d_disable(void)
> +{
> +	return s5pv310_pd_disable(PD_G3D);
> +}
> +
> +static int s5pv310_pd_lcd0_enable(void)
> +{
> +	return s5pv310_pd_enable(PD_LCD0);
> +}
> +
> +static int s5pv310_pd_lcd0_disable(void)
> +{
> +	return s5pv310_pd_disable(PD_LCD0);
> +}
> +
> +static int s5pv310_pd_lcd1_enable(void)
> +{
> +	return s5pv310_pd_enable(PD_LCD1);
> +}
> +
> +static int s5pv310_pd_lcd1_disable(void)
> +{
> +	return s5pv310_pd_disable(PD_LCD1);
> +}
> +
> +static int s5pv310_pd_cam_enable(void)
> +{
> +	return s5pv310_pd_enable(PD_CAM);
> +}
> +
> +static int s5pv310_pd_cam_disable(void)
> +{
> +	return s5pv310_pd_disable(PD_CAM);
> +}
> +
> +static int s5pv310_pd_tv_enable(void)
> +{
> +	return s5pv310_pd_enable(PD_TV);
> +}
> +
> +static int s5pv310_pd_tv_disable(void)
> +{
> +	return s5pv310_pd_disable(PD_TV);
> +}
> +
> +static struct samsung_pd_info s5pv310_pd_mfc_pdata = {
> +	.enable		= s5pv310_pd_mfc_enable,
> +	.disable	= s5pv310_pd_mfc_disable,
> +};
> +
> +static struct samsung_pd_info s5pv310_pd_g3d_pdata = {
> +	.enable		= s5pv310_pd_g3d_enable,
> +	.disable	= s5pv310_pd_g3d_disable,
> +};
> +
> +static struct samsung_pd_info s5pv310_pd_lcd0_pdata = {
> +	.enable		= s5pv310_pd_lcd0_enable,
> +	.disable	= s5pv310_pd_lcd0_disable,
> +};
> +
> +static struct samsung_pd_info s5pv310_pd_lcd1_pdata = {
> +	.enable		= s5pv310_pd_lcd1_enable,
> +	.disable	= s5pv310_pd_lcd1_disable,
> +};
> +
> +static struct samsung_pd_info s5pv310_pd_tv_pdata = {
> +	.enable		= s5pv310_pd_tv_enable,
> +	.disable	= s5pv310_pd_tv_disable,
> +};
> +
> +static struct samsung_pd_info s5pv310_pd_cam_pdata = {
> +	.enable		= s5pv310_pd_cam_enable,
> +	.disable	= s5pv310_pd_cam_disable,
> +};

You can probably get rid of all the above by adding a few more entries to 
struct samsung_pd_info. Just think of adding a u32 reg, status, on_value,
off_value and maybe a mask. In such case all power domain devices can be
handled by the same function which will read all needed data from device's
platform_data.


> +struct platform_device s5pv310_device_pd[] = {
> +	{
> +		.name		= "samsung-pd",
> +		.id		= 0,
> +		.dev = {
> +			.platform_data = &s5pv310_pd_mfc_pdata,
> +		},


You can use embedded structure definition to make the code a bit easier
to read (I've also added the entries from the previous comment):

.dev = {
	.platform_data = &(struct samsung_pd_info) {
		.enable	= s5pv310_pd_enable,
		.disable	= s5pv310_pd_disable,
		.reg		= S5P_MFC_CONFIGURATION,
		.status	= S5P_MFC_STATUS,
		.on_value	= S5P_INT_LOCAL_PWR_EN,
		.mask		= 0x7,
	},
},

> +	}, {
> +		.name		= "samsung-pd",
> +		.id		= 1,
> +		.dev = {
> +			.platform_data = &s5pv310_pd_g3d_pdata,
> +		},
> +	}, {
> +		.name		= "samsung-pd",
> +		.id		= 2,
> +		.dev = {
> +			.platform_data = &s5pv310_pd_lcd0_pdata,
> +		},
> +	}, {
> +		.name		= "samsung-pd",
> +		.id		= 3,
> +		.dev = {
> +			.platform_data = &s5pv310_pd_lcd1_pdata,
> +		},
> +	}, {
> +		.name		= "samsung-pd",
> +		.id		= 4,
> +		.dev = {
> +			.platform_data = &s5pv310_pd_tv_pdata,
> +		},
> +	}, {
> +		.name		= "samsung-pd",
> +		.id		= 5,
> +		.dev = {
> +			.platform_data = &s5pv310_pd_cam_pdata,
> +		},
> +	},
> +};
> diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
> index 1429510..9decf02 100644
> --- a/arch/arm/mach-s5pv310/include/mach/map.h
> +++ b/arch/arm/mach-s5pv310/include/mach/map.h
> @@ -37,6 +37,8 @@
>  #define S5PV310_PA_SYSCON		(0x10010000)
>  #define S5P_PA_SYSCON			S5PV310_PA_SYSCON
> 
> +#define S5PV310_PA_PMU			(0x10020000)
> +
>  #define S5PV310_PA_CMU			(0x10030000)
> 
>  #define S5PV310_PA_WATCHDOG		(0x10060000)
> diff --git a/arch/arm/mach-s5pv310/include/mach/regs-pmu.h b/arch/arm/mach-s5pv310/include/mach/regs-
> pmu.h
> new file mode 100644
> index 0000000..f4b2229
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
> @@ -0,0 +1,40 @@
> +/* linux/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * S5PV310 - Power management unit definition
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_PMU_H
> +#define __ASM_ARCH_REGS_PMU_H __FILE__
> +
> +#include <mach/map.h>
> +
> +#define S5P_PMUREG(x)				(S5P_VA_PMU + (x))
> +
> +#define S5P_CAM_CONFIGURATION			S5P_PMUREG(0x3C00)
> +#define S5P_CAM_STATUS				S5P_PMUREG(0x3C04)
> +
> +#define S5P_TV_CONFIGURATION			S5P_PMUREG(0x3C20)
> +#define S5P_TV_STATUS				S5P_PMUREG(0x3C24)
> +
> +#define S5P_MFC_CONFIGURATION			S5P_PMUREG(0x3C40)
> +#define S5P_MFC_STATUS				S5P_PMUREG(0x3C44)
> +
> +#define S5P_G3D_CONFIGURATION			S5P_PMUREG(0x3C60)
> +#define S5P_G3D_STATUS				S5P_PMUREG(0x3C64)
> +
> +#define S5P_LCD0_CONFIGURATION			S5P_PMUREG(0x3C80)
> +#define S5P_LCD0_STATUS				S5P_PMUREG(0x3C84)
> +
> +#define S5P_LCD1_CONFIGURATION			S5P_PMUREG(0x3CA0)
> +#define S5P_LCD1_STATUS				S5P_PMUREG(0x3CA4)
> +
> +#define S5P_INT_LOCAL_PWR_EN			0x7
> +
> +#endif /* __ASM_ARCH_REGS_PMU_H */
> diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
> index d2cf694..390befd 100644
> --- a/arch/arm/mach-s5pv310/mach-smdkc210.c
> +++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
> @@ -22,6 +22,7 @@
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/sdhci.h>
> +#include <plat/pd.h>
> 
>  #include <mach/map.h>
> 
> @@ -113,6 +114,12 @@ static struct platform_device *smdkc210_devices[] __initdata = {
>  	&s3c_device_hsmmc3,
>  	&s3c_device_rtc,
>  	&s3c_device_wdt,
> +	&s5pv310_device_pd[PD_MFC],
> +	&s5pv310_device_pd[PD_G3D],
> +	&s5pv310_device_pd[PD_LCD0],
> +	&s5pv310_device_pd[PD_LCD1],
> +	&s5pv310_device_pd[PD_CAM],
> +	&s5pv310_device_pd[PD_TV],
>  };
> 
>  static void __init smdkc210_map_io(void)
> @@ -124,6 +131,8 @@ static void __init smdkc210_map_io(void)
> 
>  static void __init smdkc210_machine_init(void)
>  {
> +	samsung_pd_init();
> +
>  	s3c_sdhci0_set_platdata(&smdkc210_hsmmc0_pdata);
>  	s3c_sdhci1_set_platdata(&smdkc210_hsmmc1_pdata);
>  	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
> diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
> index 10f8056..c6690cf 100644
> --- a/arch/arm/mach-s5pv310/mach-smdkv310.c
> +++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
> @@ -22,6 +22,7 @@
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/sdhci.h>
> +#include <plat/pd.h>
> 
>  #include <mach/map.h>
> 
> @@ -113,6 +114,12 @@ static struct platform_device *smdkv310_devices[] __initdata = {
>  	&s3c_device_hsmmc3,
>  	&s3c_device_rtc,
>  	&s3c_device_wdt,
> +	&s5pv310_device_pd[PD_MFC],
> +	&s5pv310_device_pd[PD_G3D],
> +	&s5pv310_device_pd[PD_LCD0],
> +	&s5pv310_device_pd[PD_LCD1],
> +	&s5pv310_device_pd[PD_CAM],
> +	&s5pv310_device_pd[PD_TV],
>  };
> 
>  static void __init smdkv310_map_io(void)
> @@ -124,6 +131,8 @@ static void __init smdkv310_map_io(void)
> 
>  static void __init smdkv310_machine_init(void)
>  {
> +	samsung_pd_init();
> +
>  	s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
>  	s3c_sdhci1_set_platdata(&smdkv310_hsmmc1_pdata);
>  	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
> diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
> index fef353d..d973d39 100644
> --- a/arch/arm/plat-s5p/include/plat/map-s5p.h
> +++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
> @@ -15,6 +15,7 @@
> 
>  #define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
>  #define S5P_VA_CMU		S3C_ADDR(0x02100000)
> +#define S5P_VA_PMU		S3C_ADDR(0x02180000)
>  #define S5P_VA_GPIO		S3C_ADDR(0x02200000)
>  #define S5P_VA_GPIO1		S5P_VA_GPIO
>  #define S5P_VA_GPIO2		S3C_ADDR(0x02240000)
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
> index 71bcc0f..c483480 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -118,6 +118,8 @@ extern struct platform_device s5p_device_fimc0;
>  extern struct platform_device s5p_device_fimc1;
>  extern struct platform_device s5p_device_fimc2;
> 
> +extern struct platform_device s5pv310_device_pd[];
> +
>  /* s3c2440 specific devices */
> 
>  #ifdef CONFIG_CPU_S3C2440
> --
> 1.6.2.5


Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
