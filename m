From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 Nov 2011 05:54:42 +0100
Subject: [alsa-devel] [PATCH v5 1/3] ARM: mxs: add saif clkmux functions
In-Reply-To: <1321003855-13430-2-git-send-email-b29396@freescale.com>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
 <1321003855-13430-2-git-send-email-b29396@freescale.com>
Message-ID: <201111180554.42242.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> 
> ---
> changes since v4:
>  * remove get_master_id function.
>    Instead, we use master_mode and master_id in platform_data to tell
>    saif driver the correct master id for each saifs.
> changes since v3:
>  * remove the unneeded locking according to Sascha
> changes since v2:
>  * This patch is separated from the following patch based on
>    suggestions from Uwe.
>    [PATCH 2/3] ARM: mx28evk: add platform data for saif
> ---
>  arch/arm/mach-mxs/clock-mx28.c          |   29
> +++++++++++++++++++++++++++++ arch/arm/mach-mxs/include/mach/common.h |   
> 1 +
>  arch/arm/mach-mxs/include/mach/digctl.h |   21 +++++++++++++++++++++
>  3 files changed, 51 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c
> b/arch/arm/mach-mxs/clock-mx28.c index 7954013..c51fe85 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -22,6 +22,7 @@
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
>  #include <linux/clkdev.h>
> +#include <linux/spinlock.h>
> 
>  #include <asm/clkdev.h>
>  #include <asm/div64.h>
> @@ -29,6 +30,7 @@
>  #include <mach/mx28.h>
>  #include <mach/common.h>
>  #include <mach/clock.h>
> +#include <mach/digctl.h>
> 
>  #include "regs-clkctrl-mx28.h"
> 
> @@ -43,6 +45,33 @@ static struct clk emi_clk;
>  static struct clk saif0_clk;
>  static struct clk saif1_clk;
>  static struct clk clk32k_clk;
> +static DEFINE_SPINLOCK(clkmux_lock);
> +
> +/*
> + * HW_SAIF_CLKMUX_SEL:
> + *  DIRECT(0x0): SAIF0 clock pins selected for SAIF0 input clocks, and
> SAIF1 + *		clock pins selected for SAIF1 input clocks.
> + *  CROSSINPUT(0x1): SAIF1 clock inputs selected for SAIF0 input clocks,
> and + *		SAIF0 clock inputs selected for SAIF1 input clocks.
> + *  EXTMSTR0(0x2): SAIF0 clock pin selected for both SAIF0 and SAIF1 input
> + *		clocks.
> + *  EXTMSTR1(0x3): SAIF1 clock pin selected for both SAIF0 and SAIF1 input
> + *		clocks.
> + */
> +int mxs_saif_clkmux_select(unsigned int clkmux)
> +{
> +	if (clkmux > 0x3)
> +		return -EINVAL;
> +
> +	spin_lock(&clkmux_lock);
> +	__raw_writel(BM_DIGCTL_CTRL_SAIF_CLKMUX,
> +			DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL + MXS_CLR_ADDR);
> +	__raw_writel(clkmux << BP_DIGCTL_CTRL_SAIF_CLKMUX,
> +			DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL + MXS_SET_ADDR);
> +	spin_unlock(&clkmux_lock);
> +
> +	return 0;
> +}
> 
>  static int _raw_clk_enable(struct clk *clk)
>  {
> diff --git a/arch/arm/mach-mxs/include/mach/common.h
> b/arch/arm/mach-mxs/include/mach/common.h index 635bb5d..3bbb94f 100644
> --- a/arch/arm/mach-mxs/include/mach/common.h
> +++ b/arch/arm/mach-mxs/include/mach/common.h
> @@ -16,6 +16,7 @@ struct clk;
>  extern const u32 *mxs_get_ocotp(void);
>  extern int mxs_reset_block(void __iomem *);
>  extern void mxs_timer_init(struct clk *, int);
> +extern int mxs_saif_clkmux_select(unsigned int clkmux);
> 
>  extern int mx23_register_gpios(void);
>  extern int mx23_clocks_init(void);
> diff --git a/arch/arm/mach-mxs/include/mach/digctl.h
> b/arch/arm/mach-mxs/include/mach/digctl.h new file mode 100644
> index 0000000..9bd0496
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/digctl.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MACH_DIGCTL_H__
> +#define __MACH_DIGCTL_H__
> +
> +/* MXS DIGCTL SAIF CLKMUX */
> +#define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
> +#define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
> +#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
> +#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
> +
> +#define HW_DIGCTL_CTRL			0x0
> +#define  BP_DIGCTL_CTRL_SAIF_CLKMUX	(10)

Do you need the parenthesis above ?

> +#define  BM_DIGCTL_CTRL_SAIF_CLKMUX	(0x3 << 10)
> +#endif

Please add my

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
