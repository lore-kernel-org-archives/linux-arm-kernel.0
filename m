From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Jan 2013 17:15:52 +0530
Subject: [PATCH v4 6/9] ARM: davinci: Remoteproc platform device creation
 data/code
In-Reply-To: <1355967254-16726-7-git-send-email-rtivy@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
 <1355967254-16726-7-git-send-email-rtivy@ti.com>
Message-ID: <50E6C0F0.70408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 7:04 AM, Robert Tivy wrote:
> Contains CMA-based reservation of physical memory block.  A new kernel
> command-line parameter has been added to allow boot-time specification of
> physical memory block.
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>

The driver patch should precede platform data creation in the patch
series since it is more logical to review that way.

> ---
>  Documentation/kernel-parameters.txt            |    7 ++
>  arch/arm/mach-davinci/devices-da8xx.c          |   87 +++++++++++++++++++++++-
>  arch/arm/mach-davinci/include/mach/da8xx.h     |    6 ++
>  include/linux/platform_data/da8xx-remoteproc.h |   33 +++++++++
>  4 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/platform_data/da8xx-remoteproc.h
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 9776f06..87efcc6 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -44,6 +44,7 @@ parameter is applicable:
>  	AVR32	AVR32 architecture is enabled.
>  	AX25	Appropriate AX.25 support is enabled.
>  	BLACKFIN Blackfin architecture is enabled.
> +	CMA	Contiguous Memory Area support is enabled.
>  	DRM	Direct Rendering Management support is enabled.
>  	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
>  	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
> @@ -2579,6 +2580,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
>  
> +	rproc_mem=nn[KMG][@address]
> +			[KNL,ARM,CMA] Remoteproc physical memory block.
> +			Memory area to be used by remote processor image,
> +			managed by CMA.  Suitable defaults exist if not
> +			specified.
> +
>  	rw		[KNL] Mount root device read-write on boot
>  
>  	S		[KNL] Run init in single mode
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 466b70c..aa151df 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -12,10 +12,13 @@
>   */
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/dma-mapping.h>
> +#ifdef CONFIG_CMA
> +#include <linux/dma-contiguous.h>
> +#endif

Ifdefs around includes are typically not required. Do you hit any issue
if you don't have them?

>  #include <linux/serial_8250.h>
>  #include <linux/ahci_platform.h>
>  #include <linux/clk.h>
> +#include <linux/platform_data/da8xx-remoteproc.h>
>  
>  #include <mach/cputype.h>
>  #include <mach/common.h>
> @@ -655,6 +658,88 @@ int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
>  }
>  #endif
>  
> +static struct resource da8xx_rproc_resources[] = {
> +	{ /* DSP boot address */
> +		.start		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG,
> +		.end		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG,

DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG + 3?

> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{ /* dsp irq */
> +		.start		= IRQ_DA8XX_CHIPINT0,
> +		.end		= IRQ_DA8XX_CHIPINT0,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct da8xx_rproc_pdata rproc_pdata = {
> +	.name		= "dsp",
> +	.firmware	= "da8xx-dsp.xe674",

I thought we agreed not have firmware name in platform data.

> +};
> +
> +static struct platform_device da8xx_dsp = {
> +	.name	= "davinci-rproc",
> +	.id	= 0,
> +	.dev	= {
> +		.platform_data		= &rproc_pdata,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +	.num_resources	= ARRAY_SIZE(da8xx_rproc_resources),
> +	.resource	= da8xx_rproc_resources,
> +};
> +
> +#ifdef CONFIG_CMA

#if IS_ENABLED(DAVINCI_PROC) (or the appropriate config symbol) is more
correct here. CMA could be enabled for other reasons.

> +
> +#define DAVINCI_DSP_RPROC_CMA_BASE 0xc3000000
> +#define DAVINCI_DSP_RPROC_CMA_SIZE 0x01000000
> +
> +static phys_addr_t rproc_base __initdata = DAVINCI_DSP_RPROC_CMA_BASE;
> +static unsigned long rproc_size __initdata = DAVINCI_DSP_RPROC_CMA_SIZE;

Please get rid of these hardcoded defines. Dont want to have them even
as back-up if kernel parameters are not passed. There is absolutely no
way this will work for all users.

> +
> +static int __init early_rproc_mem(char *p)
> +{
> +	char *endp;
> +
> +	if (p == NULL)
> +		return 0;
> +
> +	rproc_size = memparse(p, &endp);
> +	if (*endp == '@')
> +		rproc_base = memparse(endp + 1, NULL);
> +
> +	return 0;
> +}
> +early_param("rproc_mem", early_rproc_mem);
> +
> +void __init da8xx_rproc_reserve_cma(void)
> +{
> +	int ret;
> +
> +	pr_info("%s: reserving 0x%lx @ 0x%lx...\n",
> +		__func__, rproc_size, (unsigned long)rproc_base);
> +
> +	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
> +	if (ret)
> +		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
> +}
> +
> +#endif
> +
> +int __init da8xx_register_rproc(void)
> +{
> +	int ret;
> +
> +	ret = platform_device_register(&da8xx_dsp);
> +	if (ret) {
> +		pr_err("%s: platform_device_register: %d\n", __func__, ret);
> +
> +		return ret;
> +	}
> +
> +	dev_set_name(&da8xx_dsp.dev, "%s.%d", da8xx_dsp.name, da8xx_dsp.id);

Why is this needed? This should have already been done by
platform_device_register() call above.

> +
> +	return 0;
> +};
> +
>  static struct resource da8xx_rtc_resources[] = {
>  	{
>  		.start		= DA8XX_RTC_BASE,
> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index aaccdc4..331fc28 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> @@ -53,6 +53,7 @@ extern unsigned int da850_max_speed;
>  #define DA8XX_SYSCFG0_BASE	(IO_PHYS + 0x14000)
>  #define DA8XX_SYSCFG0_VIRT(x)	(da8xx_syscfg0_base + (x))
>  #define DA8XX_JTAG_ID_REG	0x18
> +#define DA8XX_HOST1CFG_REG	0x44
>  #define DA8XX_CFGCHIP0_REG	0x17c
>  #define DA8XX_CFGCHIP2_REG	0x184
>  #define DA8XX_CFGCHIP3_REG	0x188
> @@ -102,6 +103,11 @@ int __init da850_register_vpif_display
>  int __init da850_register_vpif_capture
>  			(struct vpif_capture_config *capture_config);
>  void da8xx_restart(char mode, const char *cmd);
> +#ifdef CONFIG_CMA
> +void __init da8xx_rproc_reserve_cma(void);
> +#endif

You dont typically use ifdefs around function declaration. You can
define this to be a function with empty implementation if remote proc is
not used.

> +int da8xx_register_rproc(void);
> +
>  
>  extern struct platform_device da8xx_serial_device;
>  extern struct emac_platform_data da8xx_emac_pdata;
> diff --git a/include/linux/platform_data/da8xx-remoteproc.h b/include/linux/platform_data/da8xx-remoteproc.h
> new file mode 100644
> index 0000000..50e8c55
> --- /dev/null
> +++ b/include/linux/platform_data/da8xx-remoteproc.h
> @@ -0,0 +1,33 @@
> +/*
> + * Remote Processor
> + *
> + * Copyright (C) 2011-2012 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DA8XX_REMOTEPROC_H__
> +#define __DA8XX_REMOTEPROC_H__
> +
> +#include <linux/remoteproc.h>
> +
> +/**
> + * struct da8xx_rproc_pdata - da8xx remoteproc's platform data
> + * @name: the remoteproc's name
> + * @firmware: name of firmware file to load
> + * @ops: start/stop rproc handlers
> + */
> +struct da8xx_rproc_pdata {
> +	const char *name;
> +	const char *firmware;
> +	const struct rproc_ops *ops;
> +};

This file should be added a part of driver patch.

Thanks,
Sekhar
