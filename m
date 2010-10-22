From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 22 Oct 2010 11:31:37 +0300
Subject: [PATCHv5] cpufreq for freescale mx51
In-Reply-To: <1287667139-1534-1-git-send-email-yong.shen@linaro.org>
References: <1287667139-1534-1-git-send-email-yong.shen@linaro.org>
Message-ID: <20101022083137.GE17631@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 21, Yong Shen wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> Currently, only two operating points: 160Mhz and 800Mhz.
> the operating points are tested on babbage 3.0
> 
> Signed-off-by: Yong Shen <yong.shen@linaro.org>

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm/Kconfig                       |    6 +
>  arch/arm/mach-mx5/Kconfig              |    1 +
>  arch/arm/mach-mx5/Makefile             |    1 +
>  arch/arm/mach-mx5/board-mx51_babbage.c |    6 +-
>  arch/arm/mach-mx5/clock-mx51.c         |   22 +++-
>  arch/arm/mach-mx5/cpu_op-mx51.c        |   29 +++++
>  arch/arm/mach-mx5/cpu_op-mx51.h        |   14 ++
>  arch/arm/plat-mxc/Makefile             |    1 +
>  arch/arm/plat-mxc/cpufreq.c            |  206 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mxc.h   |   13 ++-
>  10 files changed, 295 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/cpu_op-mx51.c
>  create mode 100644 arch/arm/mach-mx5/cpu_op-mx51.h
>  create mode 100644 arch/arm/plat-mxc/cpufreq.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 553b7cf..12115ff 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1584,6 +1584,12 @@ if ARCH_HAS_CPUFREQ
>  
>  source "drivers/cpufreq/Kconfig"
>  
> +config CPU_FREQ_IMX
> +	tristate "CPUfreq driver for i.MX CPUs"
> +	depends on ARCH_MXC && CPU_FREQ
> +	help
> +	  This enables the CPUfreq driver for i.MX CPUs.
> +
>  config CPU_FREQ_SA1100
>  	bool
>  
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index a2df9ac..427a66c 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -6,6 +6,7 @@ config ARCH_MX51
>  	select MXC_TZIC
>  	select ARCH_MXC_IOMUX_V3
>  	select ARCH_MXC_AUDMUX_V2
> +	select ARCH_HAS_CPUFREQ
>  
>  comment "MX5 platforms:"
>  
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 1769c16..462f177 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -5,6 +5,7 @@
>  # Object file lists.
>  obj-y   := cpu.o mm.o clock-mx51.o devices.o
>  
> +obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
>  obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 23ee4a4..26b8e14 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
>   *
>   * The code contained herein is licensed under the GNU General Public
> @@ -32,6 +32,7 @@
>  
>  #include "devices-imx51.h"
>  #include "devices.h"
> +#include "cpu_op-mx51.h"
>  
>  #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
>  #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
> @@ -282,6 +283,9 @@ static void __init mxc_board_init(void)
>  {
>  	struct pad_desc usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
>  
> +#if defined(CONFIG_CPU_FREQ_IMX)
> +	get_cpu_op = mx51_get_cpu_op;
> +#endif
>  	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
>  					ARRAY_SIZE(mx51babbage_pads));
>  	mxc_init_imx_uart();
> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
> index f2aae92..8ac36d8 100644
> --- a/arch/arm/mach-mx5/clock-mx51.c
> +++ b/arch/arm/mach-mx5/clock-mx51.c
> @@ -362,7 +362,7 @@ static int _clk_lp_apm_set_parent(struct clk *clk, struct clk *parent)
>  	return 0;
>  }
>  
> -static unsigned long clk_arm_get_rate(struct clk *clk)
> +static unsigned long clk_cpu_get_rate(struct clk *clk)
>  {
>  	u32 cacrr, div;
>  	unsigned long parent_rate;
> @@ -374,6 +374,22 @@ static unsigned long clk_arm_get_rate(struct clk *clk)
>  	return parent_rate / div;
>  }
>  
> +static int clk_cpu_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	u32 reg, cpu_podf;
> +	unsigned long parent_rate;
> +
> +	parent_rate = clk_get_rate(clk->parent);
> +	cpu_podf = parent_rate / rate - 1;
> +	/* use post divider to change freq */
> +	reg = __raw_readl(MXC_CCM_CACRR);
> +	reg &= ~MXC_CCM_CACRR_ARM_PODF_MASK;
> +	reg |= cpu_podf << MXC_CCM_CACRR_ARM_PODF_OFFSET;
> +	__raw_writel(reg, MXC_CCM_CACRR);
> +
> +	return 0;
> +}
> +
>  static int _clk_periph_apm_set_parent(struct clk *clk, struct clk *parent)
>  {
>  	u32 reg, mux;
> @@ -736,7 +752,8 @@ static struct clk periph_apm_clk = {
>  
>  static struct clk cpu_clk = {
>  	.parent = &pll1_sw_clk,
> -	.get_rate = clk_arm_get_rate,
> +	.get_rate = clk_cpu_get_rate,
> +	.set_rate = clk_cpu_set_rate,
>  };
>  
>  static struct clk ahb_clk = {
> @@ -1064,6 +1081,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> +	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
>  };
>  
>  static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/cpu_op-mx51.c b/arch/arm/mach-mx5/cpu_op-mx51.c
> new file mode 100644
> index 0000000..9d34c3d
> --- /dev/null
> +++ b/arch/arm/mach-mx5/cpu_op-mx51.c
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/types.h>
> +#include <mach/hardware.h>
> +#include <linux/kernel.h>
> +
> +static struct cpu_op mx51_cpu_op[] = {
> +	{
> +	.cpu_rate = 160000000,},
> +	{
> +	.cpu_rate = 800000000,},
> +};
> +
> +struct cpu_op *mx51_get_cpu_op(int *op)
> +{
> +	*op = ARRAY_SIZE(mx51_cpu_op);
> +	return mx51_cpu_op;
> +}
> diff --git a/arch/arm/mach-mx5/cpu_op-mx51.h b/arch/arm/mach-mx5/cpu_op-mx51.h
> new file mode 100644
> index 0000000..97477fe
> --- /dev/null
> +++ b/arch/arm/mach-mx5/cpu_op-mx51.h
> @@ -0,0 +1,14 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +extern struct cpu_op *mx51_get_cpu_op(int *op);
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 06875b4..3726709 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_MXC_USE_EPIT) += epit.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> +obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
>  ifdef CONFIG_SND_IMX_SOC
>  obj-y += ssi-fiq.o
>  obj-y += ssi-fiq-ksym.o
> diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
> new file mode 100644
> index 0000000..039538e
> --- /dev/null
> +++ b/arch/arm/plat-mxc/cpufreq.c
> @@ -0,0 +1,206 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/*
> + * A driver for the Freescale Semiconductor i.MXC CPUfreq module.
> + * The CPUFREQ driver is for controling CPU frequency. It allows you to change
> + * the CPU clock speed on the fly.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <mach/hardware.h>
> +#include <mach/clock.h>
> +
> +#define CLK32_FREQ	32768
> +#define NANOSECOND	(1000 * 1000 * 1000)
> +
> +struct cpu_op *(*get_cpu_op)(int *op);
> +
> +static int cpu_freq_khz_min;
> +static int cpu_freq_khz_max;
> +
> +static struct clk *cpu_clk;
> +static struct cpufreq_frequency_table *imx_freq_table;
> +
> +static int cpu_op_nr;
> +static struct cpu_op *cpu_op_tbl;
> +
> +static int set_cpu_freq(int freq)
> +{
> +	int ret = 0;
> +	int org_cpu_rate;
> +
> +	org_cpu_rate = clk_get_rate(cpu_clk);
> +	if (org_cpu_rate == freq)
> +		return ret;
> +
> +	ret = clk_set_rate(cpu_clk, freq);
> +	if (ret != 0) {
> +		printk(KERN_DEBUG "cannot set CPU clock rate\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mxc_verify_speed(struct cpufreq_policy *policy)
> +{
> +	if (policy->cpu != 0)
> +		return -EINVAL;
> +
> +	return cpufreq_frequency_table_verify(policy, imx_freq_table);
> +}
> +
> +static unsigned int mxc_get_speed(unsigned int cpu)
> +{
> +	if (cpu)
> +		return 0;
> +
> +	return clk_get_rate(cpu_clk) / 1000;
> +}
> +
> +static int mxc_set_target(struct cpufreq_policy *policy,
> +			  unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	int freq_Hz;
> +	int ret = 0;
> +	unsigned int index;
> +
> +	cpufreq_frequency_table_target(policy, imx_freq_table,
> +			target_freq, relation, &index);
> +	freq_Hz = imx_freq_table[index].frequency * 1000;
> +
> +	freqs.old = clk_get_rate(cpu_clk) / 1000;
> +	freqs.new = freq_Hz / 1000;
> +	freqs.cpu = 0;
> +	freqs.flags = 0;
> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +	ret = set_cpu_freq(freq_Hz);
> +
> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +
> +	return ret;
> +}
> +
> +static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +	int i;
> +
> +	printk(KERN_INFO "i.MXC CPU frequency driver\n");
> +
> +	if (policy->cpu != 0)
> +		return -EINVAL;
> +
> +	if (!get_cpu_op)
> +		return -EINVAL;
> +
> +	cpu_clk = clk_get(NULL, "cpu_clk");
> +	if (IS_ERR(cpu_clk)) {
> +		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
> +		return PTR_ERR(cpu_clk);
> +	}
> +
> +	cpu_op_tbl = get_cpu_op(&cpu_op_nr);
> +
> +	cpu_freq_khz_min = cpu_op_tbl[0].cpu_rate / 1000;
> +	cpu_freq_khz_max = cpu_op_tbl[0].cpu_rate / 1000;
> +
> +	imx_freq_table = kmalloc(
> +		sizeof(struct cpufreq_frequency_table) * (cpu_op_nr + 1),
> +			GFP_KERNEL);
> +	if (!imx_freq_table) {
> +		ret = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	for (i = 0; i < cpu_op_nr; i++) {
> +		imx_freq_table[i].index = i;
> +		imx_freq_table[i].frequency = cpu_op_tbl[i].cpu_rate / 1000;
> +
> +		if ((cpu_op_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
> +			cpu_freq_khz_min = cpu_op_tbl[i].cpu_rate / 1000;
> +
> +		if ((cpu_op_tbl[i].cpu_rate / 1000) > cpu_freq_khz_max)
> +			cpu_freq_khz_max = cpu_op_tbl[i].cpu_rate / 1000;
> +	}
> +
> +	imx_freq_table[i].index = i;
> +	imx_freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	policy->cur = clk_get_rate(cpu_clk) / 1000;
> +	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
> +	policy->min = policy->cpuinfo.min_freq = cpu_freq_khz_min;
> +	policy->max = policy->cpuinfo.max_freq = cpu_freq_khz_max;
> +
> +	/* Manual states, that PLL stabilizes in two CLK32 periods */
> +	policy->cpuinfo.transition_latency = 2 * NANOSECOND / CLK32_FREQ;
> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
> +
> +	if (ret < 0) {
> +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq \
> +				with error code %d\n", __func__, ret);
> +		goto err;
> +	}
> +
> +	cpufreq_frequency_table_get_attr(imx_freq_table, policy->cpu);
> +	return 0;
> +err:
> +	kfree(imx_freq_table);
> +err1:
> +	clk_put(cpu_clk);
> +	return ret;
> +}
> +
> +static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_frequency_table_put_attr(policy->cpu);
> +
> +	set_cpu_freq(cpu_freq_khz_max * 1000);
> +	clk_put(cpu_clk);
> +	kfree(imx_freq_table);
> +	return 0;
> +}
> +
> +static struct cpufreq_driver mxc_driver = {
> +	.flags = CPUFREQ_STICKY,
> +	.verify = mxc_verify_speed,
> +	.target = mxc_set_target,
> +	.get = mxc_get_speed,
> +	.init = mxc_cpufreq_init,
> +	.exit = mxc_cpufreq_exit,
> +	.name = "imx",
> +};
> +
> +static int __devinit mxc_cpufreq_driver_init(void)
> +{
> +	return cpufreq_register_driver(&mxc_driver);
> +}
> +
> +static void mxc_cpufreq_driver_exit(void)
> +{
> +	cpufreq_unregister_driver(&mxc_driver);
> +}
> +
> +module_init(mxc_cpufreq_driver_init);
> +module_exit(mxc_cpufreq_driver_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor Inc. Yong Shen <yong.shen@linaro.org>");
> +MODULE_DESCRIPTION("CPUfreq driver for i.MX");
> +MODULE_LICENSE("GPL");
> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index a790bf2..a42c720 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2004-2007, 2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -20,6 +20,8 @@
>  #ifndef __ASM_ARCH_MXC_H__
>  #define __ASM_ARCH_MXC_H__
>  
> +#include <linux/types.h>
> +
>  #ifndef __ASM_ARCH_MXC_HARDWARE_H__
>  #error "Do not include directly."
>  #endif
> @@ -133,6 +135,15 @@ extern unsigned int __mxc_cpu_type;
>  # define cpu_is_mxc91231()	(0)
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +
> +struct cpu_op {
> +	u32 cpu_rate;
> +};
> +
> +extern struct cpu_op *(*get_cpu_op)(int *op);
> +#endif
> +
>  #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
>  /* These are deprecated, use mx[23][157]_setup_weimcs instead. */
>  #define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
