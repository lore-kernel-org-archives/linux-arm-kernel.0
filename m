From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 09 Dec 2013 09:23:24 +0100
Subject: [PATCH 3/3] cpufreq: exynos: Add exynos5420 cpufreq driver
In-Reply-To: <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
 <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
Message-ID: <20131209092324.1f8b6502@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

> From: "Arjun.K.V" <arjun.kv@samsung.com>
> 
> The patch adds cpufreq driver for exynos5420.
> 
> Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   11 ++
>  drivers/cpufreq/Makefile             |    1 +
>  drivers/cpufreq/exynos-cpufreq.c     |    2 +
>  drivers/cpufreq/exynos-cpufreq.h     |    8 +
>  drivers/cpufreq/exynos5420-cpufreq.c |  346
> ++++++++++++++++++++++++++++++++++ 5 files changed, 368 insertions(+)
>  create mode 100644 drivers/cpufreq/exynos5420-cpufreq.c

I think that we shall cleanup "a bit" the cpufreq code for exynos.
Now we have [*]:
- exynos4x12-cpufreq.c 
- exynos4210-cpufreq.c
- exynos5250-cpufreq.c

and you want to add exynos5420-cpufreq.c

Those files are pretty similar, so are a very good candidates for
cleanup.

All supported processors (up to exynos5250) allows for frequency
setting on all cores in the SoC.

Those files [*] can be easily replaced by cpu0-cpufreq.c generic code.
Also we can provide frequency, voltage table and ASV if needed via
device tree.

I did some preliminary work on this for Exynos4412. My plan is to
continue when things with BOOST "calm down" :-).

> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index ce52ed9..96769fe 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -51,6 +51,17 @@ config ARM_EXYNOS5250_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config ARM_EXYNOS5420_CPUFREQ
> +	bool "SAMSUNG EXYNOS5420"
> +	depends on SOC_EXYNOS5420
> +	default y
> +	select ARM_EXYNOS_CPUFREQ
> +	help
> +	  This adds the CPUFreq driver for Samsung EXYNOS5420
> +	  SoC.
> +
> +	  If in doubt, say N.
> +
>  config ARM_EXYNOS5440_CPUFREQ
>  	bool "SAMSUNG EXYNOS5440"
>  	depends on SOC_EXYNOS5440
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 7494565..802c251 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+=
> exynos-cpufreq.o obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+=
> exynos4210-cpufreq.o obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+=
> exynos4x12-cpufreq.o obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+=
> exynos5250-cpufreq.o +obj-$(CONFIG_ARM_EXYNOS5420_CPUFREQ)	+=
> exynos5420-cpufreq.o obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+=
> exynos5440-cpufreq.o obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=
> highbank-cpufreq.o obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=
> imx6q-cpufreq.o diff --git a/drivers/cpufreq/exynos-cpufreq.c
> b/drivers/cpufreq/exynos-cpufreq.c index f3c2287..ac556eb 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -246,6 +246,8 @@ static int __init exynos_cpufreq_init(void)
>  		ret = exynos4x12_cpufreq_init(exynos_info);
>  	else if (soc_is_exynos5250())
>  		ret = exynos5250_cpufreq_init(exynos_info);
> +	else if (soc_is_exynos5420())
> +		ret = exynos5420_cpufreq_init(exynos_info);
>  	else
>  		return 0;
>  
> diff --git a/drivers/cpufreq/exynos-cpufreq.h
> b/drivers/cpufreq/exynos-cpufreq.h index 7f25cee..d2f3d1e 100644
> --- a/drivers/cpufreq/exynos-cpufreq.h
> +++ b/drivers/cpufreq/exynos-cpufreq.h
> @@ -67,3 +67,11 @@ static inline int exynos5250_cpufreq_init(struct
> exynos_dvfs_info *info) return -EOPNOTSUPP;
>  }
>  #endif
> +#ifdef CONFIG_ARM_EXYNOS5420_CPUFREQ
> +extern int exynos5420_cpufreq_init(struct exynos_dvfs_info *);
> +#else
> +static inline int exynos5420_cpufreq_init(struct exynos_dvfs_info
> *info) +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> diff --git a/drivers/cpufreq/exynos5420-cpufreq.c
> b/drivers/cpufreq/exynos5420-cpufreq.c new file mode 100644
> index 0000000..728ce71
> --- /dev/null
> +++ b/drivers/cpufreq/exynos5420-cpufreq.c
> @@ -0,0 +1,346 @@
> +/*
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * EXYNOS5420 - CPU frequency scaling support
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/cpufreq.h>
> +
> +#include <mach/map.h>
> +#include <mach/regs-clock.h>
> +
> +#include "exynos-cpufreq.h"
> +
> +#define CPUFREQ_NUM_LEVELS	(L18 + 1)
> +#define EXYNOS5_CLKDIV_STATCPU0_MASK	0x11111111
> +#define EXYNOS5_CLKDIV_STATCPU1_MASK	0x111
> +
> +static struct clk *mout_cpu;
> +static struct clk *mout_mspll_cpu;
> +static struct clk *mout_apll;
> +static struct clk *fout_apll;
> +static struct clk *fout_spll;
> +
> +struct cpufreq_clkdiv {
> +	unsigned int	index;
> +	unsigned int	clkdiv;
> +	unsigned int	clkdiv1;
> +};
> +
> +static unsigned int exynos5420_volt_table[CPUFREQ_NUM_LEVELS];
> +static struct cpufreq_frequency_table exynos5420_freq_table[] = {
> +	{L0,  2000 * 1000},
> +	{L1,  1900 * 1000},
> +	{L2,  1800 * 1000},
> +	{L3,  1700 * 1000},
> +	{L4,  1600 * 1000},
> +	{L5,  1500 * 1000},
> +	{L6,  1400 * 1000},
> +	{L7,  1300 * 1000},
> +	{L8,  1200 * 1000},
> +	{L9,  1100 * 1000},
> +	{L10, 1000 * 1000},
> +	{L11,  900 * 1000},
> +	{L12,  800 * 1000},
> +	{L13,  700 * 1000},
> +	{L14,  600 * 1000},
> +	{L15,  500 * 1000},
> +	{L16,  400 * 1000},
> +	{L17,  300 * 1000},
> +	{L18,  200 * 1000},
> +	{0, CPUFREQ_TABLE_END},
> +};

This shall be provided via device tree.

> +
> +static struct cpufreq_clkdiv
> exynos5420_clkdiv_table[CPUFREQ_NUM_LEVELS]; +
> +static unsigned int clkdiv_cpu0_5420[CPUFREQ_NUM_LEVELS][7] = {
> +	/*
> +	 *  Clock divider values for {CPUD, ATB, PCLK_DBG, APLL,
> ARM2}
> +	 */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L0: 2.0GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L1: 1.9GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L2: 1.8GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L3: 1.7GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L4: 1.6GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L5: 1.5GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L6: 1.4GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L7: 1.3GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L8: 1.2GHz */
> +	{ 2, 7, 7, 3, 0 }, /* ARM L9: 1.1GHz */
> +	{ 2, 6, 6, 3, 0 }, /* ARM L10: 1GHz */
> +	{ 2, 6, 6, 3, 0 }, /* ARM L11: 900MHz */
> +	{ 2, 5, 5, 3, 0 }, /* ARM L12: 800MHz */
> +	{ 2, 5, 5, 3, 0 }, /* ARM L13: 700MHz */
> +	{ 2, 4, 4, 3, 0 }, /* ARM L14: 600MHz */
> +	{ 2, 3, 3, 3, 0 }, /* ARM L15: 500MHz */
> +	{ 2, 3, 3, 3, 0 }, /* ARM L16: 400MHz */
> +	{ 2, 3, 3, 3, 0 }, /* ARM L17: 300MHz */
> +	{ 2, 3, 3, 3, 0 }, /* ARM L18: 200MHz */
> +};

This table is not needed (as similar ones in this patch), since the
Common Clock Framework (and more specific the PLL code for Exynos)
shall handle this. 

> +
> +unsigned int clkdiv_cpu1_5420[CPUFREQ_NUM_LEVELS][2] = {
> +	/* Clock divider values for { copy, HPM } */
> +	{ 7, 7 }, /* ARM L0: 2.0GHz */
> +	{ 7, 7 }, /* ARM L1: 1.9GHz */
> +	{ 7, 7 }, /* ARM L2: 1.8GHz */
> +	{ 7, 7 }, /* ARM L3: 1.7GHz */
> +	{ 7, 7 }, /* ARM L4: 1.6GHz */
> +	{ 7, 7 }, /* ARM L5: 1.5GHz */
> +	{ 7, 7 }, /* ARM L6: 1.4GHz */
> +	{ 7, 7 }, /* ARM L7: 1.3GHz */
> +	{ 7, 7 }, /* ARM L8: 1.2GHz */
> +	{ 7, 7 }, /* ARM L9: 1.1GHz */
> +	{ 7, 7 }, /* ARM L10: 1GHz */
> +	{ 7, 7 }, /* ARM L11: 900MHz */
> +	{ 7, 7 }, /* ARM L12: 800MHz */
> +	{ 7, 7 }, /* ARM L13: 700MHz */
> +	{ 7, 7 }, /* ARM L14: 600MHz */
> +	{ 7, 7 }, /* ARM L15: 500MHz */
> +	{ 7, 7 }, /* ARM L16: 400MHz */
> +	{ 7, 7 }, /* ARM L17: 300MHz */
> +	{ 7, 7 }, /* ARM L18: 200MHz */
> +};
> +
> +/*
> + * Default ASV table
> + */
> +static const unsigned int asv_voltage_5420[CPUFREQ_NUM_LEVELS] = {
> +	1300000,	/* L0  2000 */
> +	1300000,	/* L1  1900 */
> +	1200000,	/* L2  1800 */
> +	1200000,	/* L3  1700 */
> +	1200000,	/* L4  1600 */
> +	1175000,	/* L5  1500 */
> +	1150000,	/* L6  1400 */
> +	1125000,	/* L7  1300 */
> +	1100000,	/* L8  1200 */
> +	1075000,	/* L9  1100 */
> +	1050000,	/* L10 1000 */
> +	1000000,	/* L11  900 */
> +	 950000,	/* L12  800 */
> +	 925000,	/* L13  700 */
> +	 900000,	/* L14  600 */
> +	 900000,	/* L15  500 */
> +	 900000,	/* L16  400 */
> +	 900000,	/* L17  300 */
> +	 900000,	/* L18  200 */
> +};
> +

If I remember correctly, some code for ASV generic framework has
been posted recently (by Sachin):

http://article.gmane.org/gmane.linux.power-management.general/40453/match=asv+framework

> +static void exynos5420_set_clkdiv(unsigned int div_index)
> +{
> +	unsigned int tmp;
> +
> +	/* Change Divider - CPU0 for CMU_CPU */
> +	tmp = exynos5420_clkdiv_table[div_index].clkdiv;
> +	__raw_writel(tmp, EXYNOS5_CLKDIV_CPU0);
> +
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS5_CLKDIV_STATCPU0);
> +	} while (tmp & EXYNOS5_CLKDIV_STATCPU0_MASK);
> +	pr_debug("DIV_CPU0[0x%x]\n",
> __raw_readl(EXYNOS5_CLKDIV_CPU0)); +
> +	/* Change Divider - CPU1 for CMU_CPU */
> +	tmp = exynos5420_clkdiv_table[div_index].clkdiv1;
> +	__raw_writel(tmp, EXYNOS5_CLKDIV_CPU1);
> +
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS5_CLKDIV_STATCPU1);
> +	} while (tmp & EXYNOS5_CLKDIV_STATCPU1_MASK);
> +	pr_debug("DIV_CPU1[0x%x]\n",
> __raw_readl(EXYNOS5_CLKDIV_CPU1)); +}
> +

Operations on raw registers - behind the Common Clock Framework is
asking for a trouble. I had a similar issues. Please refer to
appropriate Exynos4412/4210 patches.

http://article.gmane.org/gmane.linux.kernel/1575500/match=cpufreq

> +static void exynos5420_set_apll(unsigned int new_index,
> +				unsigned int old_index)
> +{
> +	unsigned int tmp;
> +	unsigned long rate;
> +
> +	clk_prepare_enable(fout_spll);
> +	/* 1. MUX_CORE_SEL = MOUT_MSPLL; ARMCLK uses MOUT_MSPLL for
> lock time */
> +	if (clk_set_parent(mout_cpu, mout_mspll_cpu))
> +		pr_err(KERN_ERR "Unable to set parent of clock
> mout_cpu\n"); +
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS5_CLKMUX_STATCPU);
> +		tmp &= EXYNOS5_CLKMUX_STATCPU_MUXCORE_MASK;
> +	} while (tmp != (0x2 << EXYNOS5_CLKSRC_CPU_MUXCORE_SHIFT));
> +
> +	/* 2. Set APLL rate */
> +	rate = exynos5420_freq_table[new_index].frequency * 1000;
> +	if (clk_set_rate(fout_apll, rate))
> +		pr_err("Unable to change apll rate to %lu\n", rate);
> +
> +	/* 3. MUX_CORE_SEL = APLL */
> +	if (clk_set_parent(mout_cpu, mout_apll))
> +		pr_err("Unable to set parent of clock mout_cpu\n");
> +
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS5_CLKMUX_STATCPU);
> +		tmp &= EXYNOS5_CLKMUX_STATCPU_MUXCORE_MASK;
> +	} while (tmp != (0x1 << EXYNOS5_CLKSRC_CPU_MUXCORE_SHIFT));
> +
> +	clk_disable_unprepare(fout_spll);
> +}
> +
> +static bool exynos5420_pms_change(unsigned int old_index,
> +				  unsigned int new_index)
> +{
> +	/*
> +	 * The Exynos cpufreq driver uses this to determine if it can
> +	 * avoid changing the CPU voltage and re-parenting the CPU
> clock
> +	 * while chaning the PLL rate.  Because we're using CCF to
> change
> +	 * the PLL rate, we no longer have access to the PLL divider
> table,
> +	 * so we can't tell whether or not we can take the fast path
> from
> +	 * here and must always take the slow path.  Since this only
> affects
> +	 * a few transitions, there should hopefully be no impact on
> +	 * performance.
> +	 */
> +	return (old_index != new_index);
> +}

This code shall be handled at PLL driver.

> +static void exynos5420_set_frequency(unsigned int old_index,
> +				     unsigned int new_index)
> +{
> +	if (old_index > new_index) {
> +		/* 1. Change the system clock divider values */
> +		exynos5420_set_clkdiv(new_index);
> +		/* 2. Change the apll rate */
> +		exynos5420_set_apll(new_index, old_index);
> +	} else if (old_index < new_index) {
> +		/* 1. Change the apll rate */
> +		exynos5420_set_apll(new_index, old_index);
> +		/* 2. Change the system clock divider values */
> +		exynos5420_set_clkdiv(new_index);
> +	}
> +}

Please refer to Exynos4412 cpufreq code.

> +
> +static void __init set_volt_table(void)
> +{
> +	unsigned int i;
> +	unsigned int asv_volt = 0;
> +
> +	for (i = 0; i < CPUFREQ_NUM_LEVELS; i++) {
> +#ifdef CONFIG_ARM_EXYNOS5420_ASV
> +		asv_volt = get_match_volt
> +			(ID_ARM, exynos5420_freq_table[i].frequency);
> +#endif
> +		if (!asv_volt)
> +			exynos5420_volt_table[i] =
> asv_voltage_5420[i];
> +		else
> +			exynos5420_volt_table[i] = asv_volt;
> +		pr_debug("CPUFREQ of CA15 L%d : %d uV\n", i,
> +				exynos5420_volt_table[i]);
> +	}
> +	for (i = L0; i < L2; i++)
> +		exynos5420_freq_table[i].frequency =
> CPUFREQ_ENTRY_INVALID;
> +	for (i = L14; i <= L18; i++)
> +		exynos5420_freq_table[i].frequency =
> CPUFREQ_ENTRY_INVALID; +}
> +

This shall be parsed from device tree or the ASV generic framework
shall be used.

> +int exynos5420_cpufreq_init(struct exynos_dvfs_info *info)
> +{
> +	int i;
> +	unsigned int tmp;
> +	unsigned long rate;
> +	struct clk *sclk_spll;
> +
> +	set_volt_table();
> +
> +	mout_cpu = clk_get(NULL, "mout_cpu");
> +	if (IS_ERR(mout_cpu))
> +		return PTR_ERR(mout_cpu);
> +
> +	mout_mspll_cpu = clk_get(NULL, "mout_mspll_cpu");
> +	if (IS_ERR(mout_mspll_cpu))
> +		goto err_mout_mspll_cpu;
> +
> +	sclk_spll = clk_get(NULL, "mout_spll");
> +	if (IS_ERR(sclk_spll))
> +		goto err_sclk_spll;
> +	clk_set_parent(mout_mspll_cpu, sclk_spll);
> +	clk_put(sclk_spll);
> +
> +	fout_spll = clk_get(NULL, "fout_spll");
> +	if (IS_ERR(fout_spll))
> +		goto err_fout_spll;
> +
> +	rate = clk_get_rate(mout_mspll_cpu) / 1000;
> +
> +	mout_apll = clk_get(NULL, "mout_apll");
> +	if (IS_ERR(mout_apll))
> +		goto err_mout_apll;
> +
> +	fout_apll = clk_get(NULL, "fout_apll");
> +	if (IS_ERR(fout_apll))
> +		goto err_fout_apll;
> +
> +	for (i = L0; i < CPUFREQ_NUM_LEVELS; i++) {
> +		exynos5420_clkdiv_table[i].index = i;
> +
> +		tmp = __raw_readl(EXYNOS5_CLKDIV_CPU0);
> +		tmp &= ~(EXYNOS5_CLKDIV_CPU0_CPUD_MASK |
> +			EXYNOS5_CLKDIV_CPU0_ATB_MASK |
> +			EXYNOS5_CLKDIV_CPU0_PCLKDBG_MASK |
> +			EXYNOS5_CLKDIV_CPU0_APLL_MASK |
> +			EXYNOS5_CLKDIV_CPU0_CORE2_MASK);
> +		tmp |= ((clkdiv_cpu0_5420[i][0] <<
> +				EXYNOS5_CLKDIV_CPU0_CPUD_SHIFT) |
> +			(clkdiv_cpu0_5420[i][1] <<
> +				EXYNOS5_CLKDIV_CPU0_ATB_SHIFT) |
> +			(clkdiv_cpu0_5420[i][2] <<
> +				EXYNOS5_CLKDIV_CPU0_PCLKDBG_SHIFT) |
> +			(clkdiv_cpu0_5420[i][3] <<
> +				EXYNOS5_CLKDIV_CPU0_APLL_SHIFT) |
> +			(clkdiv_cpu0_5420[i][4] <<
> +				EXYNOS5_CLKDIV_CPU0_CORE2_SHIFT));
> +
> +		exynos5420_clkdiv_table[i].clkdiv = tmp;
> +
> +		tmp = __raw_readl(EXYNOS5_CLKDIV_CPU1);
> +		tmp &= ~(EXYNOS5_CLKDIV_CPU1_COPY_MASK |
> +			EXYNOS5_CLKDIV_CPU1_HPM_MASK);
> +		tmp |= ((clkdiv_cpu1_5420[i][0] <<
> +				EXYNOS5_CLKDIV_CPU1_COPY_SHIFT) |
> +			(clkdiv_cpu1_5420[i][1] <<
> +				EXYNOS5_CLKDIV_CPU1_HPM_SHIFT));
> +
> +		exynos5420_clkdiv_table[i].clkdiv1 = tmp;
> +	}
> +
> +	info->mpll_freq_khz = rate;
> +	info->pll_safe_idx = L12;
> +	info->cpu_clk = fout_apll;
> +	pr_debug("fout_apll[%lu]\n", clk_get_rate(fout_apll));
> +	info->volt_table = exynos5420_volt_table;
> +	info->freq_table = exynos5420_freq_table;
> +	info->set_freq = exynos5420_set_frequency;
> +	info->need_apll_change = exynos5420_pms_change;
> +
> +	return 0;
> +
> +err_fout_apll:
> +	clk_put(fout_apll);
> +err_mout_apll:
> +	clk_put(mout_apll);
> +err_fout_spll:
> +	clk_put(fout_spll);
> +err_sclk_spll:
> +	clk_put(sclk_spll);
> +err_mout_mspll_cpu:
> +	clk_put(mout_mspll_cpu);
> +
> +	pr_err("%s: failed initialization\n", __func__);
> +	return -EINVAL;
> +}

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
