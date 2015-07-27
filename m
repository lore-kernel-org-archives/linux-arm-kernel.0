From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Jul 2015 21:28:02 +0800
Subject: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150727132802.GK12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 12:07:39PM -0500, Shenwei Wang wrote:
> IMX7D contains a new version of GPC IP block (GPCv2). It has two
> major functions: power management and wakeup source management.
> 
> GPCv2 provides low power mode control for Cortex-A7 and Cortex-M4
> domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> After configuring the GPCv2 module, the platform can enter into a
> selected mode either automatically triggered by ARM WFI instruction or
> manually by software. The system will exit the low power states
> by the predefined wakeup sources which are managed by the gpcv2
> irqchip driver.
> 
> This patch adds a new suspend driver to manage the power states on IMX7D.
> It currently supports "SUSPEND_STANDBY" and "SUSPEND_MEM" states.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig        |   1 +
>  arch/arm/mach-imx/Makefile       |   2 +
>  arch/arm/mach-imx/pm-imx7.c      | 765 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/suspend-imx7.S | 529 +++++++++++++++++++++++++++
>  4 files changed, 1297 insertions(+)
>  create mode 100644 arch/arm/mach-imx/pm-imx7.c
>  create mode 100644 arch/arm/mach-imx/suspend-imx7.S
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 5ccc9ea..4269c1e 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -552,6 +552,7 @@ config SOC_IMX7D
>  	bool "i.MX7 Dual support"
>  	select PINCTRL_IMX7D
>  	select ARM_GIC
> +	select IMX_GPCV2

Yes, the existing list is already a bit out of order, but please do not
make it worse.  Add it after HAVE_IMX_MMDC to keep them sort
alphabetically.

>  	select HAVE_IMX_ANATOP
>  	select HAVE_IMX_MMDC
>  	help
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 37c502a..b2ad476 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -87,6 +87,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
>  
>  ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> +obj-$(CONFIG_IMX_GPCV2)	+= suspend-imx7.o pm-imx7.o

Shouldn't it be controlled by CONFIG_SOC_IMX7D instead?

>  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
>  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
>  endif
> diff --git a/arch/arm/mach-imx/pm-imx7.c b/arch/arm/mach-imx/pm-imx7.c
> new file mode 100644
> index 0000000..50b9af4
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-imx7.c
> @@ -0,0 +1,765 @@
> +

Drop this new line.

> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +

Ditto

> +#include <linux/suspend.h>
> +#include <asm/suspend.h>
> +#include <asm/fncpy.h>
> +
> +#include <soc/imx/gpcv2.h>
> +
> +extern struct imx_gpcv2_irq *gpcv2_irq_instance;

Will this give a checkpatch warning?

> +static struct imx_gpcv2 *gpcv2_instance;

I stop right here, as I need to understand why we need to have header
soc/imx/gpcv2.h shared between irqchip driver and pm code.

Shawn
