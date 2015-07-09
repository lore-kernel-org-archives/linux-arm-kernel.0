From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jul 2015 10:17:30 +0800
Subject: [PATCH 1/8] ARM: imx: add i.mx6ul msl support
In-Reply-To: <1434555569-8237-2-git-send-email-Frank.Li@freescale.com>
References: <1434555569-8237-1-git-send-email-Frank.Li@freescale.com>
 <1434555569-8237-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150709021730.GL28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:39:22PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> i.MX6UL is a new SOC, add MSL support
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig       |  8 ++++++++
>  arch/arm/mach-imx/Makefile      |  1 +
>  arch/arm/mach-imx/mach-imx6ul.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 arch/arm/mach-imx/mach-imx6ul.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 573536f..8ceda28 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -548,6 +548,14 @@ config SOC_IMX6SX
>  	help
>  	  This enables support for Freescale i.MX6 SoloX processor.
>  
> +config SOC_IMX6UL
> +	bool "i.MX6 UltraLite support"
> +	select PINCTRL_IMX6UL
> +	select SOC_IMX6
> +
> +	help
> +	  This enables support for Freescale i.MX6 UltraLite processor.
> +
>  config SOC_IMX7D
>  	bool "i.MX7 Dual support"
>  	select PINCTRL_IMX7D
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 37c502a..fb689d8 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -83,6 +83,7 @@ endif
>  obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
> +obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
>  
>  ifeq ($(CONFIG_SUSPEND),y)
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> new file mode 100644
> index 0000000..706d5f6
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/irqchip.h>
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include "common.h"
> +
> +static void __init imx6ul_init_machine(void)
> +{
> +	struct device *parent;
> +
> +	parent = imx_soc_device_init();

How does the soc_id of soc_device work?  I do not see any patch adding
imx6ul soc_id.

Shawn

> +	if (parent == NULL)
> +		pr_warn("failed to initialize soc device\n");
> +
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	imx_anatop_init();
> +}
> +
> +static void __init imx6ul_init_irq(void)
> +{
> +	imx_init_revision_from_anatop();
> +	imx_src_init();
> +	irqchip_init();
> +}
> +
> +static const char *imx6ul_dt_compat[] __initconst = {
> +	"fsl,imx6ul",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(IMX7D, "Freescale i.MX6 Ultralite (Device Tree)")
> +	.init_irq	= imx6ul_init_irq,
> +	.init_machine	= imx6ul_init_machine,
> +	.dt_compat	= imx6ul_dt_compat,
> +MACHINE_END
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
