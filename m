From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 Jan 2014 22:29:35 +0800
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6sl
In-Reply-To: <1389117017-29509-1-git-send-email-b20788@freescale.com>
References: <1389117017-29509-1-git-send-email-b20788@freescale.com>
Message-ID: <20140108142933.GC10725@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 12:50:17PM -0500, Anson Huang wrote:
> Add cpuidle support for i.MX6SL, currently only support
> two level cpuidle(ARM wfi and WAIT mode), as there is no
> hardware fix for WAIT mode issue, so we need to ensure
> ARM:IPG clock ratio is maintained within 12:5 before
> entering WAIT mode.

We already have a formal erratum published in i.MX6SL Chip Errata for
this issue.

ERR005311 CCM: After exit from WAIT mode, unwanted interrupt(s) taken
during WAIT mode entry process could cause cache memory corruption

We should probably refer to it in both commit log and code comment.

> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/Makefile         |    1 +
>  arch/arm/mach-imx/clk-imx6sl.c     |   21 ++++++++++++++
>  arch/arm/mach-imx/common.h         |    1 +
>  arch/arm/mach-imx/cpuidle-imx6sl.c |   53 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/cpuidle.h        |    5 ++++
>  arch/arm/mach-imx/mach-imx6sl.c    |    7 +++++
>  6 files changed, 88 insertions(+)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx6sl.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index d8205fb..1fcd273 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
>  ifeq ($(CONFIG_CPU_IDLE),y)
>  obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
>  obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
> +obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
>  endif
>  
>  ifdef CONFIG_SND_IMX_SOC
> diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
> index e6900e9..cb6cbce 100644
> --- a/arch/arm/mach-imx/clk-imx6sl.c
> +++ b/arch/arm/mach-imx/clk-imx6sl.c
> @@ -66,6 +66,27 @@ static struct clk_div_table video_div_table[] = {
>  static struct clk *clks[IMX6SL_CLK_END];
>  static struct clk_onecell_data clk_data;
>  
> +/*
> + * On i.MX6SL, need to ensure that the ARM:IPG clock ratio is maintained
> + * within 12:5 when the clocks to ARM are gated when the SOC enters
> + * WAIT mode. This is necessary to avoid WAIT mode issue (an early
> + * interrupt waking up the ARM).
> + * This function will set the ARM clk to max value within the 12:5 limit.
> + */
> +void imx6sl_set_wait_clk(bool enter)
> +{
> +	static u32 saved_arm_rate;
> +
> +	if (enter) {
> +		u32 ipg_rate = clk_get_rate(clks[IMX6SL_CLK_IPG]);

It's more appropriate to use 'unsigned long' than 'u32' for a rate,
since that's the type clk_get_rate() returns.  Same for saved_arm_rate.

Shawn

> +		u32 max_arm_wait_rate = (12 * ipg_rate) / 5;
> +		saved_arm_rate = clk_get_rate(clks[IMX6SL_CLK_ARM]);
> +		clk_set_rate(clks[IMX6SL_CLK_ARM], max_arm_wait_rate);
> +	} else {
> +		clk_set_rate(clks[IMX6SL_CLK_ARM], saved_arm_rate);
> +	}
> +}
> +
>  static void __init imx6sl_clocks_init(struct device_node *ccm_node)
>  {
>  	struct device_node *np;
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 2b0151f..524c4cb 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -140,6 +140,7 @@ void imx_anatop_pre_suspend(void);
>  void imx_anatop_post_resume(void);
>  int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
>  void imx6q_set_chicken_bit(void);
> +void imx6sl_set_wait_clk(bool enter);
>  
>  void imx_cpu_die(unsigned int cpu);
>  int imx_cpu_kill(unsigned int cpu);
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
> new file mode 100644
> index 0000000..676831a
> --- /dev/null
> +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (C) 2014 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +
> +#include "common.h"
> +#include "cpuidle.h"
> +
> +static int imx6sl_enter_wait(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv, int index)
> +{
> +	imx6q_set_lpm(WAIT_UNCLOCKED);
> +	imx6sl_set_wait_clk(true);
> +	cpu_do_idle();
> +	imx6sl_set_wait_clk(false);
> +	imx6q_set_lpm(WAIT_CLOCKED);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver imx6sl_cpuidle_driver = {
> +	.name = "imx6sl_cpuidle",
> +	.owner = THIS_MODULE,
> +	.states = {
> +		/* WFI */
> +		ARM_CPUIDLE_WFI_STATE,
> +		/* WAIT */
> +		{
> +			.exit_latency = 50,
> +			.target_residency = 75,
> +			.flags = CPUIDLE_FLAG_TIME_VALID |
> +				CPUIDLE_FLAG_TIMER_STOP,
> +			.enter = imx6sl_enter_wait,
> +			.name = "WAIT",
> +			.desc = "Clock off",
> +		},
> +	},
> +	.state_count = 2,
> +	.safe_state_index = 0,
> +};
> +
> +int __init imx6sl_cpuidle_init(void)
> +{
> +	return cpuidle_register(&imx6sl_cpuidle_driver, NULL);
> +}
> diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
> index 786f98e..24e3367 100644
> --- a/arch/arm/mach-imx/cpuidle.h
> +++ b/arch/arm/mach-imx/cpuidle.h
> @@ -13,6 +13,7 @@
>  #ifdef CONFIG_CPU_IDLE
>  extern int imx5_cpuidle_init(void);
>  extern int imx6q_cpuidle_init(void);
> +extern int imx6sl_cpuidle_init(void);
>  #else
>  static inline int imx5_cpuidle_init(void)
>  {
> @@ -22,4 +23,8 @@ static inline int imx6q_cpuidle_init(void)
>  {
>  	return 0;
>  }
> +static inline int imx6sl_cpuidle_init(void)
> +{
> +	return 0;
> +}
>  #endif
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 7fdd4e8..1cb6f6e 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -17,6 +17,7 @@
>  #include <asm/mach/map.h>
>  
>  #include "common.h"
> +#include "cpuidle.h"
>  
>  static void __init imx6sl_fec_init(void)
>  {
> @@ -52,6 +53,11 @@ static void __init imx6sl_init_machine(void)
>  	imx6q_pm_init();
>  }
>  
> +static void __init imx6sl_init_late(void)
> +{
> +	imx6sl_cpuidle_init();
> +}
> +
>  static void __init imx6sl_map_io(void)
>  {
>  	debug_ll_io_init();
> @@ -78,4 +84,5 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
>  	.init_machine	= imx6sl_init_machine,
>  	.dt_compat	= imx6sl_dt_compat,
>  	.restart	= mxc_restart,
> +	.init_late      = imx6sl_init_late,
>  MACHINE_END
> -- 
> 1.7.9.5
> 
> 
