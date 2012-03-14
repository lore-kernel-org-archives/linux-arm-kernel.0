From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 10:31:42 -0700
Subject: [PATCH v2 RE-SEND] [CPUFREQ] EXYNOS5250: Add support cpufreq
 for EXYNOS5250
In-Reply-To: <1331377202-25173-1-git-send-email-kgene.kim@samsung.com>
References: <1331377202-25173-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F60D5FE.7080400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> From: Jaecheol Lee<jc.lee@samsung.com>
> 
> This patch adds support cpufreq for EXYNOS5250 SoC. Basically,
> the exynos-cpufreq.c is used commonly and exynos5250-cpufreq.c
> is used for EXYNOS5250(two Cortex-A15 cores) SoC.
> 
> Signed-off-by: Jaecheol Lee<jc.lee@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>

Hi again Dave :)

Please pick up this patch for v3.4.
If any problems, please kindly let us know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>   arch/arm/mach-exynos/include/mach/cpufreq.h |    1 +
>   drivers/cpufreq/Kconfig.arm                 |    7 +
>   drivers/cpufreq/Makefile                    |    1 +
>   drivers/cpufreq/exynos-cpufreq.c            |    2 +
>   drivers/cpufreq/exynos5250-cpufreq.c        |  347 +++++++++++++++++++++++++++
>   5 files changed, 358 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
> 
> diff --git a/arch/arm/mach-exynos/include/mach/cpufreq.h b/arch/arm/mach-exynos/include/mach/cpufreq.h
> index 96ac0cb..7517c3f 100644
> --- a/arch/arm/mach-exynos/include/mach/cpufreq.h
> +++ b/arch/arm/mach-exynos/include/mach/cpufreq.h
> @@ -33,3 +33,4 @@ struct exynos_dvfs_info {
> 
>   extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
>   extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
> +extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 9b99a96..2e33515 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -48,6 +48,7 @@ config ARM_EXYNOS_CPUFREQ
>   	depends on ARCH_EXYNOS
>   	select ARM_EXYNOS4210_CPUFREQ if CPU_EXYNOS4210
>   	select ARM_EXYNOS4X12_CPUFREQ if (SOC_EXYNOS4212 || SOC_EXYNOS4412)
> +	select ARM_EXYNOS5250_CPUFREQ if SOC_EXYNOS5250
>   	default y
>   	help
>   	  This adds the CPUFreq driver common part for Samsung
> @@ -67,3 +68,9 @@ config ARM_EXYNOS4X12_CPUFREQ
>   	help
>   	  This adds the CPUFreq driver for Samsung EXYNOS4X12
>   	  SoC (EXYNOS4212 or EXYNOS4412).
> +
> +config ARM_EXYNOS5250_CPUFREQ
> +	bool "Samsung EXYNOS5250"
> +	help
> +	  This adds the CPUFreq driver for Samsung EXYNOS5250
> +	  SoC.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index f37bbcc..3cbbcd0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
>   obj-$(CONFIG_ARCH_OMAP2PLUS)            += omap-cpufreq.o
> 
>   ##################################################################################
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 2c63b68..b243a7e 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -256,6 +256,8 @@ static int __init exynos_cpufreq_init(void)
>   		ret = exynos4210_cpufreq_init(exynos_info);
>   	else if (soc_is_exynos4212() || soc_is_exynos4412())
>   		ret = exynos4x12_cpufreq_init(exynos_info);
> +	else if (soc_is_exynos5250())
> +		ret = exynos5250_cpufreq_init(exynos_info);
>   	else
>   		pr_err("%s: CPU type not found\n", __func__);
> 
> diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
> new file mode 100644
> index 0000000..a883316
> --- /dev/null
> +++ b/drivers/cpufreq/exynos5250-cpufreq.c
> @@ -0,0 +1,347 @@
> +/*
> + * Copyright (c) 2010-20122Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * EXYNOS5250 - CPU frequency scaling support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include<linux/module.h>
> +#include<linux/kernel.h>
> +#include<linux/err.h>
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +#include<linux/slab.h>
> +#include<linux/cpufreq.h>
> +
> +#include<mach/map.h>
> +#include<mach/regs-clock.h>
> +#include<mach/cpufreq.h>
> +
> +#define CPUFREQ_LEVEL_END	(L15 + 1)
> +
> +static int max_support_idx;
> +static int min_support_idx = (CPUFREQ_LEVEL_END - 1);
> +static struct clk *cpu_clk;
> +static struct clk *moutcore;
> +static struct clk *mout_mpll;
> +static struct clk *mout_apll;
> +
> +struct cpufreq_clkdiv {
> +	unsigned int	index;
> +	unsigned int	clkdiv;
> +	unsigned int	clkdiv1;
> +};
> +
> +static unsigned int exynos5250_volt_table[CPUFREQ_LEVEL_END];
> +
> +static struct cpufreq_frequency_table exynos5250_freq_table[] = {
> +	{L0, 1700 * 1000},
> +	{L1, 1600 * 1000},
> +	{L2, 1500 * 1000},
> +	{L3, 1400 * 1000},
> +	{L4, 1300 * 1000},
> +	{L5, 1200 * 1000},
> +	{L6, 1100 * 1000},
> +	{L7, 1000 * 1000},
> +	{L8, 900 * 1000},
> +	{L9, 800 * 1000},
> +	{L10, 700 * 1000},
> +	{L11, 600 * 1000},
> +	{L12, 500 * 1000},
> +	{L13, 400 * 1000},
> +	{L14, 300 * 1000},
> +	{L15, 200 * 1000},
> +	{0, CPUFREQ_TABLE_END},
> +};
> +
> +static struct cpufreq_clkdiv exynos5250_clkdiv_table[CPUFREQ_LEVEL_END];
> +
> +static unsigned int clkdiv_cpu0_5250[CPUFREQ_LEVEL_END][8] = {
> +	/*
> +	 * Clock divider value for following
> +	 * { ARM, CPUD, ACP, PERIPH, ATB, PCLK_DBG, APLL, ARM2 }
> +	 */
> +	{ 0, 3, 7, 7, 6, 1, 3, 0 },	/* 1700 MHz - N/A */
> +	{ 0, 3, 7, 7, 6, 1, 3, 0 },	/* 1600 MHz - N/A */
> +	{ 0, 3, 7, 7, 5, 1, 3, 0 },	/* 1500 MHz - N/A */
> +	{ 0, 3, 7, 7, 6, 1, 3, 0 },	/* 1400 MHz */
> +	{ 0, 3, 7, 7, 6, 1, 3, 0 },	/* 1300 MHz */
> +	{ 0, 3, 7, 7, 5, 1, 3, 0 },	/* 1200 MHz */
> +	{ 0, 2, 7, 7, 5, 1, 2, 0 },	/* 1100 MHz */
> +	{ 0, 2, 7, 7, 4, 1, 2, 0 },	/* 1000 MHz */
> +	{ 0, 2, 7, 7, 4, 1, 2, 0 },	/* 900 MHz */
> +	{ 0, 2, 7, 7, 3, 1, 1, 0 },	/* 800 MHz */
> +	{ 0, 1, 7, 7, 3, 1, 1, 0 },	/* 700 MHz */
> +	{ 0, 1, 7, 7, 2, 1, 1, 0 },	/* 600 MHz */
> +	{ 0, 1, 7, 7, 2, 1, 1, 0 },	/* 500 MHz */
> +	{ 0, 1, 7, 7, 1, 1, 1, 0 },	/* 400 MHz */
> +	{ 0, 1, 7, 7, 1, 1, 1, 0 },	/* 300 MHz */
> +	{ 0, 1, 7, 7, 1, 1, 1, 0 },	/* 200 MHz */
> +};
> +
> +static unsigned int clkdiv_cpu1_5250[CPUFREQ_LEVEL_END][2] = {
> +	/* Clock divider value for following
> +	 * { COPY, HPM }
> +	 */
> +	{ 0, 2 },	/* 1700 MHz - N/A */
> +	{ 0, 2 },	/* 1600 MHz - N/A */
> +	{ 0, 2 },	/* 1500 MHz - N/A */
> +	{ 0, 2 },	/* 1400 MHz */
> +	{ 0, 2 },	/* 1300 MHz */
> +	{ 0, 2 },	/* 1200 MHz */
> +	{ 0, 2 },	/* 1100 MHz */
> +	{ 0, 2 },	/* 1000 MHz */
> +	{ 0, 2 },	/* 900 MHz */
> +	{ 0, 2 },	/* 800 MHz */
> +	{ 0, 2 },	/* 700 MHz */
> +	{ 0, 2 },	/* 600 MHz */
> +	{ 0, 2 },	/* 500 MHz */
> +	{ 0, 2 },	/* 400 MHz */
> +	{ 0, 2 },	/* 300 MHz */
> +	{ 0, 2 },	/* 200 MHz */
> +};
> +
> +static unsigned int exynos5_apll_pms_table[CPUFREQ_LEVEL_END] = {
> +	(0),				/* 1700 MHz - N/A */
> +	(0),				/* 1600 MHz - N/A */
> +	(0),				/* 1500 MHz - N/A */
> +	(0),				/* 1400 MHz */
> +	((325<<  16) | (6<<  8) | 0),	/* 1300 MHz */
> +	((200<<  16) | (4<<  8) | 0),	/* 1200 MHz */
> +	((275<<  16) | (6<<  8) | 0),	/* 1100 MHz */
> +	((125<<  16) | (3<<  8) | 0),	/* 1000 MHz */
> +	((150<<  16) | (4<<  8) | 0),	/* 900 MHz */
> +	((100<<  16) | (3<<  8) | 0),	/* 800 MHz */
> +	((175<<  16) | (3<<  8) | 1),	/* 700 MHz */
> +	((200<<  16) | (4<<  8) | 1),	/* 600 MHz */
> +	((125<<  16) | (3<<  8) | 1),	/* 500 MHz */
> +	((100<<  16) | (3<<  8) | 1),	/* 400 MHz */
> +	((200<<  16) | (4<<  8) | 2),	/* 300 MHz */
> +	((100<<  16) | (3<<  8) | 2),	/* 200 MHz */
> +};
> +
> +/* ASV group voltage table */
> +static const unsigned int asv_voltage_5250[CPUFREQ_LEVEL_END] = {
> +	0, 0, 0, 0, 0, 0, 0,	/* 1700 MHz ~ 1100 MHz Not supported */
> +	1175000, 1125000, 1075000, 1050000, 1000000,
> +	950000, 925000, 925000, 900000
> +};
> +
> +static void set_clkdiv(unsigned int div_index)
> +{
> +	unsigned int tmp;
> +
> +	/* Change Divider - CPU0 */
> +
> +	tmp = exynos5250_clkdiv_table[div_index].clkdiv;
> +
> +	__raw_writel(tmp, EXYNOS5_CLKDIV_CPU0);
> +
> +	while (__raw_readl(EXYNOS5_CLKDIV_STATCPU0)&  0x11111111)
> +		cpu_relax();
> +
> +	/* Change Divider - CPU1 */
> +	tmp = exynos5250_clkdiv_table[div_index].clkdiv1;
> +
> +	__raw_writel(tmp, EXYNOS5_CLKDIV_CPU1);
> +
> +	while (__raw_readl(EXYNOS5_CLKDIV_STATCPU1)&  0x11)
> +		cpu_relax();
> +}
> +
> +static void set_apll(unsigned int new_index,
> +			     unsigned int old_index)
> +{
> +	unsigned int tmp, pdiv;
> +
> +	/* 1. MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> +	clk_set_parent(moutcore, mout_mpll);
> +
> +	do {
> +		cpu_relax();
> +		tmp = (__raw_readl(EXYNOS5_CLKMUX_STATCPU)>>  16);
> +		tmp&= 0x7;
> +	} while (tmp != 0x2);
> +
> +	/* 2. Set APLL Lock time */
> +	pdiv = ((exynos5_apll_pms_table[new_index]>>  8)&  0x3f);
> +
> +	__raw_writel((pdiv * 250), EXYNOS5_APLL_LOCK);
> +
> +	/* 3. Change PLL PMS values */
> +	tmp = __raw_readl(EXYNOS5_APLL_CON0);
> +	tmp&= ~((0x3ff<<  16) | (0x3f<<  8) | (0x7<<  0));
> +	tmp |= exynos5_apll_pms_table[new_index];
> +	__raw_writel(tmp, EXYNOS5_APLL_CON0);
> +
> +	/* 4. wait_lock_time */
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS5_APLL_CON0);
> +	} while (!(tmp&  (0x1<<  29)));
> +
> +	/* 5. MUX_CORE_SEL = APLL */
> +	clk_set_parent(moutcore, mout_apll);
> +
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS5_CLKMUX_STATCPU);
> +		tmp&= (0x7<<  16);
> +	} while (tmp != (0x1<<  16));
> +
> +}
> +
> +bool exynos5250_pms_change(unsigned int old_index, unsigned int new_index)
> +{
> +	unsigned int old_pm = (exynos5_apll_pms_table[old_index]>>  8);
> +	unsigned int new_pm = (exynos5_apll_pms_table[new_index]>>  8);
> +
> +	return (old_pm == new_pm) ? 0 : 1;
> +}
> +
> +static void exynos5250_set_frequency(unsigned int old_index,
> +				  unsigned int new_index)
> +{
> +	unsigned int tmp;
> +
> +	if (old_index>  new_index) {
> +		if (!exynos5250_pms_change(old_index, new_index)) {
> +			/* 1. Change the system clock divider values */
> +			set_clkdiv(new_index);
> +			/* 2. Change just s value in apll m,p,s value */
> +			tmp = __raw_readl(EXYNOS5_APLL_CON0);
> +			tmp&= ~(0x7<<  0);
> +			tmp |= (exynos5_apll_pms_table[new_index]&  0x7);
> +			__raw_writel(tmp, EXYNOS5_APLL_CON0);
> +
> +		} else {
> +			/* Clock Configuration Procedure */
> +			/* 1. Change the system clock divider values */
> +			set_clkdiv(new_index);
> +			/* 2. Change the apll m,p,s value */
> +			set_apll(new_index, old_index);
> +		}
> +	} else if (old_index<  new_index) {
> +		if (!exynos5250_pms_change(old_index, new_index)) {
> +			/* 1. Change just s value in apll m,p,s value */
> +			tmp = __raw_readl(EXYNOS5_APLL_CON0);
> +			tmp&= ~(0x7<<  0);
> +			tmp |= (exynos5_apll_pms_table[new_index]&  0x7);
> +			__raw_writel(tmp, EXYNOS5_APLL_CON0);
> +			/* 2. Change the system clock divider values */
> +			set_clkdiv(new_index);
> +		} else {
> +			/* Clock Configuration Procedure */
> +			/* 1. Change the apll m,p,s value */
> +			set_apll(new_index, old_index);
> +			/* 2. Change the system clock divider values */
> +			set_clkdiv(new_index);
> +		}
> +	}
> +}
> +
> +static void __init set_volt_table(void)
> +{
> +	unsigned int i;
> +
> +	exynos5250_freq_table[L0].frequency = CPUFREQ_ENTRY_INVALID;
> +	exynos5250_freq_table[L1].frequency = CPUFREQ_ENTRY_INVALID;
> +	exynos5250_freq_table[L2].frequency = CPUFREQ_ENTRY_INVALID;
> +	exynos5250_freq_table[L3].frequency = CPUFREQ_ENTRY_INVALID;
> +	exynos5250_freq_table[L4].frequency = CPUFREQ_ENTRY_INVALID;
> +	exynos5250_freq_table[L5].frequency = CPUFREQ_ENTRY_INVALID;
> +	exynos5250_freq_table[L6].frequency = CPUFREQ_ENTRY_INVALID;
> +
> +	max_support_idx = L7;
> +
> +	for (i = 0 ; i<  CPUFREQ_LEVEL_END ; i++)
> +		exynos5250_volt_table[i] = asv_voltage_5250[i];
> +}
> +
> +int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
> +{
> +	int i;
> +	unsigned int tmp;
> +	unsigned long rate;
> +
> +	set_volt_table();
> +
> +	cpu_clk = clk_get(NULL, "armclk");
> +	if (IS_ERR(cpu_clk))
> +		return PTR_ERR(cpu_clk);
> +
> +	moutcore = clk_get(NULL, "mout_cpu");
> +	if (IS_ERR(moutcore))
> +		goto err_moutcore;
> +
> +	mout_mpll = clk_get(NULL, "mout_mpll");
> +	if (IS_ERR(mout_mpll))
> +		goto err_mout_mpll;
> +
> +	rate = clk_get_rate(mout_mpll) / 1000;
> +
> +	mout_apll = clk_get(NULL, "mout_apll");
> +	if (IS_ERR(mout_apll))
> +		goto err_mout_apll;
> +
> +	for (i = L0; i<  CPUFREQ_LEVEL_END; i++) {
> +
> +		exynos5250_clkdiv_table[i].index = i;
> +
> +		tmp = __raw_readl(EXYNOS5_CLKDIV_CPU0);
> +
> +		tmp&= ~((0x7<<  0) | (0x7<<  4) | (0x7<<  8) |
> +			(0x7<<  12) | (0x7<<  16) | (0x7<<  20) |
> +			(0x7<<  24) | (0x7<<  28));
> +
> +		tmp |= ((clkdiv_cpu0_5250[i][0]<<  0) |
> +			(clkdiv_cpu0_5250[i][1]<<  4) |
> +			(clkdiv_cpu0_5250[i][2]<<  8) |
> +			(clkdiv_cpu0_5250[i][3]<<  12) |
> +			(clkdiv_cpu0_5250[i][4]<<  16) |
> +			(clkdiv_cpu0_5250[i][5]<<  20) |
> +			(clkdiv_cpu0_5250[i][6]<<  24) |
> +			(clkdiv_cpu0_5250[i][7]<<  28));
> +
> +		exynos5250_clkdiv_table[i].clkdiv = tmp;
> +
> +		tmp = __raw_readl(EXYNOS5_CLKDIV_CPU1);
> +
> +		tmp&= ~((0x7<<  0) | (0x7<<  4));
> +
> +		tmp |= ((clkdiv_cpu1_5250[i][0]<<  0) |
> +			(clkdiv_cpu1_5250[i][1]<<  4));
> +
> +		exynos5250_clkdiv_table[i].clkdiv1 = tmp;
> +	}
> +
> +	info->mpll_freq_khz = rate;
> +	/* 1000Mhz */
> +	info->pm_lock_idx = L7;
> +	/* 800Mhz */
> +	info->pll_safe_idx = L9;
> +	info->max_support_idx = max_support_idx;
> +	info->min_support_idx = min_support_idx;
> +	info->cpu_clk = cpu_clk;
> +	info->volt_table = exynos5250_volt_table;
> +	info->freq_table = exynos5250_freq_table;
> +	info->set_freq = exynos5250_set_frequency;
> +	info->need_apll_change = exynos5250_pms_change;
> +
> +	return 0;
> +
> +err_mout_apll:
> +	clk_put(mout_mpll);
> +err_mout_mpll:
> +	clk_put(moutcore);
> +err_moutcore:
> +	clk_put(cpu_clk);
> +
> +	pr_err("%s: failed initialization\n", __func__);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(exynos5250_cpufreq_init);
