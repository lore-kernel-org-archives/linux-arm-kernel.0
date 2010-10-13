From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Oct 2010 19:54:24 +0200
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <1286525307-1934-2-git-send-email-yong.shen@linaro.org>
References: <1286525307-1934-1-git-send-email-yong.shen@linaro.org>
	<1286525307-1934-2-git-send-email-yong.shen@linaro.org>
Message-ID: <20101013175424.GU28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 08, 2010 at 04:08:27PM +0800, yong.shen at linaro.org wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> it is tested on babbage 3.0
> 
> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> ---
>  arch/arm/Kconfig                       |    6 +
>  arch/arm/mach-mx5/Kconfig              |    1 +
>  arch/arm/mach-mx5/Makefile             |    1 +
>  arch/arm/mach-mx5/board-mx51_babbage.c |   12 ++-
>  arch/arm/mach-mx5/clock-mx51.c         |   24 ++++
>  arch/arm/mach-mx5/cpu.c                |    2 +
>  arch/arm/mach-mx5/cpu_wp-mx51.c        |   42 ++++++
>  arch/arm/mach-mx5/cpu_wp-mx51.h        |   14 ++
>  arch/arm/plat-mxc/Makefile             |    2 +
>  arch/arm/plat-mxc/cpufreq.c            |  236 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mxc.h   |   20 +++-
>  11 files changed, 358 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/cpu_wp-mx51.c
>  create mode 100644 arch/arm/mach-mx5/cpu_wp-mx51.h
>  create mode 100644 arch/arm/plat-mxc/cpufreq.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d203b84..71a572a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1690,6 +1690,12 @@ if ARCH_HAS_CPUFREQ
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
> index 0848db5..7a621b4 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -5,6 +5,7 @@ config ARCH_MX51
>  	default y
>  	select MXC_TZIC
>  	select ARCH_MXC_IOMUX_V3
> +	select ARCH_HAS_CPUFREQ
>  
>  comment "MX5 platforms:"
>  
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 86c66e7..e2af3fb 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -5,6 +5,7 @@
>  # Object file lists.
>  obj-y   := cpu.o mm.o clock-mx51.o devices.o
>  
> +obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_wp-mx51.o
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
>  obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 6e384d9..2d2a052 100644
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
>  #include <asm/mach/time.h>
>  
>  #include "devices.h"
> +#include "cpu_wp-mx51.h"
>  
>  #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
>  #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
> @@ -279,8 +280,17 @@ static struct sys_timer mxc_timer = {
>  	.init	= mx51_babbage_timer_init,
>  };
>  
> +static void __init fixup_mxc_board(struct machine_desc *desc, struct tag *tags,
> +				   char **cmdline, struct meminfo *mi)
> +{
> +#if defined(CONFIG_CPU_FREQ_IMX)
> +	get_cpu_wp = mx51_get_cpu_wp;
> +#endif
> +}
> +
>  MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
>  	/* Maintainer: Amit Kucheria <amit.kucheria@canonical.com> */
> +	.fixup = fixup_mxc_board,
>  	.phys_io = MX51_AIPS1_BASE_ADDR,
>  	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
>  	.boot_params = PHYS_OFFSET + 0x100,
> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
> index 6af69de..f23cfab 100644
> --- a/arch/arm/mach-mx5/clock-mx51.c
> +++ b/arch/arm/mach-mx5/clock-mx51.c
> @@ -39,6 +39,8 @@ static struct clk ahb_clk;
>  static struct clk ipg_clk;
>  static struct clk usboh3_clk;
>  
> +DEFINE_SPINLOCK(clk_lock);

static, if needed at all.

> +
>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>  
>  static int _clk_ccgr_enable(struct clk *clk)
> @@ -342,6 +344,26 @@ static unsigned long clk_arm_get_rate(struct clk *clk)
>  	return parent_rate / div;
>  }
>  
> +static int _clk_cpu_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	u32 reg, cpu_podf;
> +	unsigned long flags, parent_rate;
> +
> +	parent_rate = clk_get_rate(clk->parent);
> +	cpu_podf = parent_rate / rate - 1;
> +	/* use post divider to change freq */
> +	spin_lock_irqsave(&clk_lock, flags);
> +
> +	reg = __raw_readl(MXC_CCM_CACRR);
> +	reg &= ~MXC_CCM_CACRR_ARM_PODF_MASK;
> +	reg |= cpu_podf << MXC_CCM_CACRR_ARM_PODF_OFFSET;
> +	__raw_writel(reg, MXC_CCM_CACRR);
> +
> +	spin_unlock_irqrestore(&clk_lock, flags);

Why this spinlock? The whole clock code is protected by a mutex already.

> +
> +	return 0;
> +}
> +
>  static int _clk_periph_apm_set_parent(struct clk *clk, struct clk *parent)
>  {
>  	u32 reg, mux;
> @@ -694,6 +716,7 @@ static struct clk periph_apm_clk = {
>  static struct clk cpu_clk = {
>  	.parent = &pll1_sw_clk,
>  	.get_rate = clk_arm_get_rate,
> +	.set_rate = _clk_cpu_set_rate,

The names should be consistent. Either clk_arm_[sg]et_rate or clk_cpu.
ALso, please remove those leading underscores.

>  };
>  
>  static struct clk ahb_clk = {
> @@ -837,6 +860,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
>  	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
> +	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
>  };
>  
>  static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> index 2d37785..83add9c 100644
> --- a/arch/arm/mach-mx5/cpu.c
> +++ b/arch/arm/mach-mx5/cpu.c
> @@ -22,6 +22,8 @@ static int cpu_silicon_rev = -1;
>  
>  #define SI_REV 0x48
>  
> +struct cpu_wp *(*get_cpu_wp)(int *wp);
> +

This is not needed.


>  static void query_silicon_parameter(void)
>  {
>  	void __iomem *rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
> diff --git a/arch/arm/mach-mx5/cpu_wp-mx51.c b/arch/arm/mach-mx5/cpu_wp-mx51.c
> new file mode 100644
> index 0000000..51bde45
> --- /dev/null
> +++ b/arch/arm/mach-mx5/cpu_wp-mx51.c
> @@ -0,0 +1,42 @@
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
> +
> +static struct cpu_wp cpu_wp_auto[] = {
> +	{
> +	.pll_rate = 800000000,
> +	.cpu_rate = 160000000,
> +	.pdf = 4,
> +	.mfi = 8,
> +	.mfd = 2,
> +	.mfn = 1,
> +	.cpu_podf = 4,
> +	.cpu_voltage = 850000,},
> +	{
> +	.pll_rate = 800000000,
> +	.cpu_rate = 800000000,
> +	.pdf = 0,
> +	.mfi = 8,
> +	.mfd = 2,
> +	.mfn = 1,
> +	.cpu_podf = 0,
> +	.cpu_voltage = 1100000,},
> +};
> +
> +struct cpu_wp *mx51_get_cpu_wp(int *wp)
> +{
> +	*wp = sizeof(cpu_wp_auto) / sizeof(struct cpu_wp);

use ARRAY_SIZE here.

> +	return cpu_wp_auto;
> +}
> diff --git a/arch/arm/mach-mx5/cpu_wp-mx51.h b/arch/arm/mach-mx5/cpu_wp-mx51.h
> new file mode 100644
> index 0000000..8038b62
> --- /dev/null
> +++ b/arch/arm/mach-mx5/cpu_wp-mx51.h
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
> +extern struct cpu_wp *mx51_get_cpu_wp(int *wp);
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 78d405e..0b8464f 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -16,6 +16,8 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> +# CPU FREQ support
> +obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o

I think most people digging in kernel code get that without the comment.

>  ifdef CONFIG_SND_IMX_SOC
>  obj-y += ssi-fiq.o
>  obj-y += ssi-fiq-ksym.o
> diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
> new file mode 100644
> index 0000000..9990ea8
> --- /dev/null
> +++ b/arch/arm/plat-mxc/cpufreq.c
> @@ -0,0 +1,236 @@
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
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/proc_fs.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <mach/hardware.h>
> +#include <asm/setup.h>
> +#include <mach/clock.h>
> +#include <asm/cacheflush.h>
> +#include <linux/hrtimer.h>

Please clean up the includes. At least linux/proc_fs.h, linux/regulator/consumer.h,
asm/cacheflush.h and linux/hrtimer.h are unused.

> +
> +static int cpu_freq_khz_min;
> +static int cpu_freq_khz_max;
> +static int arm_lpm_clk;
> +static int arm_normal_clk;
> +static int cpufreq_suspended;
> +
> +static struct clk *cpu_clk;
> +static struct cpufreq_frequency_table *imx_freq_table;
> +
> +static int cpu_wp_nr;
> +static struct cpu_wp *cpu_wp_tbl;
> +
> +static int set_cpu_freq(int freq)
> +{
> +	int ret = 0;
> +	int org_cpu_rate;
> +	int gp_volt = 0;
> +	int i;
> +
> +	org_cpu_rate = clk_get_rate(cpu_clk);
> +	if (org_cpu_rate == freq)
> +		return ret;
> +
> +	for (i = 0; i < cpu_wp_nr; i++) {
> +		if (freq == cpu_wp_tbl[i].cpu_rate)
> +			gp_volt = cpu_wp_tbl[i].cpu_voltage;
> +	}
> +
> +	if (gp_volt == 0)
> +		return ret;

I can't see why we need this check here. This can only happen when the
table is not correctly initialized. Furthermore, cpu voltages are not
handled yet. I'm sure we'll find a better place for this check once we
start supporting voltage changes, so I think you can remove it here.

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
> +	if (cpufreq_suspended) {

cpufreq_suspended is never set in this code, so please remove this until
we get a user for this.

> +		target_freq = clk_get_rate(cpu_clk) / 1000;
> +		cpufreq_frequency_table_target(policy, imx_freq_table,
> +				target_freq, relation, &index);
> +		freq_Hz = imx_freq_table[index].frequency * 1000;
> +
> +		if (freq_Hz == arm_lpm_clk)
> +			freqs.old = cpu_wp_tbl[cpu_wp_nr - 2].cpu_rate / 1000;
> +		else
> +			freqs.old = arm_lpm_clk / 1000;
> +
> +		freqs.new = freq_Hz / 1000;
> +		freqs.cpu = 0;
> +		freqs.flags = 0;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +		return ret;
> +	}
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
> +	if (freqs.old != freqs.new)
> +		ret = set_cpu_freq(freq_Hz);
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
> +	cpu_clk = clk_get(NULL, "cpu_clk");
> +	if (IS_ERR(cpu_clk)) {
> +		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
> +		return PTR_ERR(cpu_clk);
> +	}
> +
> +	/* Set the current working point. */
> +	cpu_wp_tbl = get_cpu_wp(&cpu_wp_nr);

The comment seems to have nothing to do with what the code does. You
don't set a workpoint here but get the table of available workpoints.

> +
> +	cpu_freq_khz_min = cpu_wp_tbl[0].cpu_rate / 1000;
> +	cpu_freq_khz_max = cpu_wp_tbl[0].cpu_rate / 1000;
> +
> +	imx_freq_table = kmalloc(
> +		sizeof(struct cpufreq_frequency_table) * (cpu_wp_nr + 1),
> +			GFP_KERNEL);

kmalloc can fail.

> +
> +	for (i = 0; i < cpu_wp_nr; i++) {
> +		imx_freq_table[i].index = i;
> +		imx_freq_table[i].frequency =
> +		    cpu_wp_tbl[i].cpu_rate / 1000;
> +
> +		if ((cpu_wp_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
> +			cpu_freq_khz_min = cpu_wp_tbl[i].cpu_rate / 1000;
> +
> +		if ((cpu_wp_tbl[i].cpu_rate / 1000) > cpu_freq_khz_max)
> +			cpu_freq_khz_max = cpu_wp_tbl[i].cpu_rate / 1000;
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
> +	arm_lpm_clk = cpu_freq_khz_min * 1000;
> +	arm_normal_clk = cpu_freq_khz_max * 1000;
> +
> +	/* Manual states, that PLL stabilizes in two CLK32 periods */
> +	policy->cpuinfo.transition_latency = 10;

transition_latency is in nano seconds, the correct value here is
2/32768*1000*1000*1000 = 61035.

> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
> +
> +	if (ret < 0) {
> +		clk_put(cpu_clk);
> +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq\n",
> +		       __func__);

It's always good to print the error code with such messages.

> +		return ret;
> +	}
> +
> +	cpufreq_frequency_table_get_attr(imx_freq_table, policy->cpu);
> +	return 0;
> +}
> +
> +static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	cpufreq_frequency_table_put_attr(policy->cpu);
> +
> +	/* Reset CPU to 665MHz */
> +	set_cpu_freq(arm_normal_clk);

arm_normal_clk is initialized to cpu_freq_khz_max * 1000 and never touched
again. It would be clearer here to remove arm_normal_clk and write
cpu_freq_khz_max * 1000 directly here. Then you can also remove the
comment which is wrong for most i.MXs, even for the i.MX51.

Also, you forget to kfree the resources alloced above.

> +	clk_put(cpu_clk);
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
> index a790bf2..31df991 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -133,6 +133,24 @@ extern unsigned int __mxc_cpu_type;
>  # define cpu_is_mxc91231()	(0)
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +
> +struct cpu_wp {
> +	u32 pll_reg;
> +	u32 pll_rate;
> +	u32 cpu_rate;
> +	u32 pdr0_reg;
> +	u32 pdf;
> +	u32 mfi;
> +	u32 mfd;
> +	u32 mfn;
> +	u32 cpu_voltage;
> +	u32 cpu_podf;
> +};
> +
> +extern struct cpu_wp *(*get_cpu_wp)(int *wp);
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
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
