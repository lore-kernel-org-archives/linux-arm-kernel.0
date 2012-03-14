From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 10:29:57 -0700
Subject: [PATCH v2 RE-SEND] [CPUFREQ] EXYNOS4X12: Add support cpufreq
 for EXYNOS4X12
In-Reply-To: <1331377162-25134-1-git-send-email-kgene.kim@samsung.com>
References: <1331377162-25134-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F60D595.5090208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> From: Jaecheol Lee<jc.lee@samsung.com>
> 
> This patch adds support cpufreq for EXYNOS4X12 SoCs. Basically,
> the exynos-cpufreq.c is used commonly and exynos4x12-cpufreq.c
> is used for EXYNOS4212(two Cortex-A9 cores) and EXYNOS4412(four
> Cortex-A9 cores) SoCs.
> 
> Signed-off-by: Jaecheol Lee<jc.lee@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>


Hi Dave,

If you're ok on this, please pick up for upcoming merge window.
If any problems, please kindly let us know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> ---
> Changes since v1:
> Address comments from Sylwester
> 
>   arch/arm/mach-exynos/include/mach/cpufreq.h |    1 +
>   drivers/cpufreq/Kconfig.arm                 |    7 +
>   drivers/cpufreq/Makefile                    |    1 +
>   drivers/cpufreq/exynos-cpufreq.c            |    2 +
>   drivers/cpufreq/exynos4x12-cpufreq.c        |  536 +++++++++++++++++++++++++++
>   5 files changed, 547 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
> 
> diff --git a/arch/arm/mach-exynos/include/mach/cpufreq.h b/arch/arm/mach-exynos/include/mach/cpufreq.h
> index 3df27f2..96ac0cb 100644
> --- a/arch/arm/mach-exynos/include/mach/cpufreq.h
> +++ b/arch/arm/mach-exynos/include/mach/cpufreq.h
> @@ -32,3 +32,4 @@ struct exynos_dvfs_info {
>   };
> 
>   extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
> +extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index dc59abf..9b99a96 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -47,6 +47,7 @@ config ARM_EXYNOS_CPUFREQ
>   	bool "SAMSUNG EXYNOS SoCs"
>   	depends on ARCH_EXYNOS
>   	select ARM_EXYNOS4210_CPUFREQ if CPU_EXYNOS4210
> +	select ARM_EXYNOS4X12_CPUFREQ if (SOC_EXYNOS4212 || SOC_EXYNOS4412)
>   	default y
>   	help
>   	  This adds the CPUFreq driver common part for Samsung
> @@ -60,3 +61,9 @@ config ARM_EXYNOS4210_CPUFREQ
>   	help
>   	  This adds the CPUFreq driver for Samsung EXYNOS4210
>   	  SoC (S5PV310 or S5PC210).
> +
> +config ARM_EXYNOS4X12_CPUFREQ
> +	bool "Samsung EXYNOS4X12"
> +	help
> +	  This adds the CPUFreq driver for Samsung EXYNOS4X12
> +	  SoC (EXYNOS4212 or EXYNOS4412).
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 042fbae..f37bbcc 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
>   obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
>   obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
>   obj-$(CONFIG_ARCH_OMAP2PLUS)            += omap-cpufreq.o
> 
>   ##################################################################################
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 7cfb516..2c63b68 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -254,6 +254,8 @@ static int __init exynos_cpufreq_init(void)
> 
>   	if (soc_is_exynos4210())
>   		ret = exynos4210_cpufreq_init(exynos_info);
> +	else if (soc_is_exynos4212() || soc_is_exynos4412())
> +		ret = exynos4x12_cpufreq_init(exynos_info);
>   	else
>   		pr_err("%s: CPU type not found\n", __func__);
> 
> diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
> new file mode 100644
> index 0000000..8c5a7af
> --- /dev/null
> +++ b/drivers/cpufreq/exynos4x12-cpufreq.c
> @@ -0,0 +1,536 @@
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * EXYNOS4X12 - CPU frequency scaling support
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
> +#include<mach/regs-clock.h>
> +#include<mach/cpufreq.h>
> +
> +#define CPUFREQ_LEVEL_END	(L13 + 1)
> +
> +static int max_support_idx;
> +static int min_support_idx = (CPUFREQ_LEVEL_END - 1);
> +
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
> +static unsigned int exynos4x12_volt_table[CPUFREQ_LEVEL_END];
> +
> +static struct cpufreq_frequency_table exynos4x12_freq_table[] = {
> +	{L0, 1500 * 1000},
> +	{L1, 1400 * 1000},
> +	{L2, 1300 * 1000},
> +	{L3, 1200 * 1000},
> +	{L4, 1100 * 1000},
> +	{L5, 1000 * 1000},
> +	{L6,  900 * 1000},
> +	{L7,  800 * 1000},
> +	{L8,  700 * 1000},
> +	{L9,  600 * 1000},
> +	{L10, 500 * 1000},
> +	{L11, 400 * 1000},
> +	{L12, 300 * 1000},
> +	{L13, 200 * 1000},
> +	{0, CPUFREQ_TABLE_END},
> +};
> +
> +static struct cpufreq_clkdiv exynos4x12_clkdiv_table[CPUFREQ_LEVEL_END];
> +
> +static unsigned int clkdiv_cpu0_4212[CPUFREQ_LEVEL_END][8] = {
> +	/*
> +	 * Clock divider value for following
> +	 * { DIVCORE, DIVCOREM0, DIVCOREM1, DIVPERIPH,
> +	 *		DIVATB, DIVPCLK_DBG, DIVAPLL, DIVCORE2 }
> +	 */
> +	/* ARM L0: 1500 MHz */
> +	{ 0, 3, 7, 0, 6, 1, 2, 0 },
> +
> +	/* ARM L1: 1400 MHz */
> +	{ 0, 3, 7, 0, 6, 1, 2, 0 },
> +
> +	/* ARM L2: 1300 MHz */
> +	{ 0, 3, 7, 0, 5, 1, 2, 0 },
> +
> +	/* ARM L3: 1200 MHz */
> +	{ 0, 3, 7, 0, 5, 1, 2, 0 },
> +
> +	/* ARM L4: 1100 MHz */
> +	{ 0, 3, 6, 0, 4, 1, 2, 0 },
> +
> +	/* ARM L5: 1000 MHz */
> +	{ 0, 2, 5, 0, 4, 1, 1, 0 },
> +
> +	/* ARM L6: 900 MHz */
> +	{ 0, 2, 5, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L7: 800 MHz */
> +	{ 0, 2, 5, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L8: 700 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L9: 600 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L10: 500 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L11: 400 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L12: 300 MHz */
> +	{ 0, 2, 4, 0, 2, 1, 1, 0 },
> +
> +	/* ARM L13: 200 MHz */
> +	{ 0, 1, 3, 0, 1, 1, 1, 0 },
> +};
> +
> +static unsigned int clkdiv_cpu0_4412[CPUFREQ_LEVEL_END][8] = {
> +	/*
> +	 * Clock divider value for following
> +	 * { DIVCORE, DIVCOREM0, DIVCOREM1, DIVPERIPH,
> +	 *		DIVATB, DIVPCLK_DBG, DIVAPLL, DIVCORE2 }
> +	 */
> +	/* ARM L0: 1500 MHz */
> +	{ 0, 3, 7, 0, 6, 1, 2, 0 },
> +
> +	/* ARM L1: 1400 MHz */
> +	{ 0, 3, 7, 0, 6, 1, 2, 0 },
> +
> +	/* ARM L2: 1300 MHz */
> +	{ 0, 3, 7, 0, 5, 1, 2, 0 },
> +
> +	/* ARM L3: 1200 MHz */
> +	{ 0, 3, 7, 0, 5, 1, 2, 0 },
> +
> +	/* ARM L4: 1100 MHz */
> +	{ 0, 3, 6, 0, 4, 1, 2, 0 },
> +
> +	/* ARM L5: 1000 MHz */
> +	{ 0, 2, 5, 0, 4, 1, 1, 0 },
> +
> +	/* ARM L6: 900 MHz */
> +	{ 0, 2, 5, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L7: 800 MHz */
> +	{ 0, 2, 5, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L8: 700 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L9: 600 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L10: 500 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L11: 400 MHz */
> +	{ 0, 2, 4, 0, 3, 1, 1, 0 },
> +
> +	/* ARM L12: 300 MHz */
> +	{ 0, 2, 4, 0, 2, 1, 1, 0 },
> +
> +	/* ARM L13: 200 MHz */
> +	{ 0, 1, 3, 0, 1, 1, 1, 0 },
> +};
> +
> +static unsigned int clkdiv_cpu1_4212[CPUFREQ_LEVEL_END][2] = {
> +	/* Clock divider value for following
> +	 * { DIVCOPY, DIVHPM }
> +	 */
> +	/* ARM L0: 1500 MHz */
> +	{ 6, 0 },
> +
> +	/* ARM L1: 1400 MHz */
> +	{ 6, 0 },
> +
> +	/* ARM L2: 1300 MHz */
> +	{ 5, 0 },
> +
> +	/* ARM L3: 1200 MHz */
> +	{ 5, 0 },
> +
> +	/* ARM L4: 1100 MHz */
> +	{ 4, 0 },
> +
> +	/* ARM L5: 1000 MHz */
> +	{ 4, 0 },
> +
> +	/* ARM L6: 900 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L7: 800 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L8: 700 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L9: 600 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L10: 500 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L11: 400 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L12: 300 MHz */
> +	{ 3, 0 },
> +
> +	/* ARM L13: 200 MHz */
> +	{ 3, 0 },
> +};
> +
> +static unsigned int clkdiv_cpu1_4412[CPUFREQ_LEVEL_END][3] = {
> +	/* Clock divider value for following
> +	 * { DIVCOPY, DIVHPM, DIVCORES }
> +	 */
> +	/* ARM L0: 1500 MHz */
> +	{ 6, 0, 7 },
> +
> +	/* ARM L1: 1400 MHz */
> +	{ 6, 0, 6 },
> +
> +	/* ARM L2: 1300 MHz */
> +	{ 5, 0, 6 },
> +
> +	/* ARM L3: 1200 MHz */
> +	{ 5, 0, 5 },
> +
> +	/* ARM L4: 1100 MHz */
> +	{ 4, 0, 5 },
> +
> +	/* ARM L5: 1000 MHz */
> +	{ 4, 0, 4 },
> +
> +	/* ARM L6: 900 MHz */
> +	{ 3, 0, 4 },
> +
> +	/* ARM L7: 800 MHz */
> +	{ 3, 0, 3 },
> +
> +	/* ARM L8: 700 MHz */
> +	{ 3, 0, 3 },
> +
> +	/* ARM L9: 600 MHz */
> +	{ 3, 0, 2 },
> +
> +	/* ARM L10: 500 MHz */
> +	{ 3, 0, 2 },
> +
> +	/* ARM L11: 400 MHz */
> +	{ 3, 0, 1 },
> +
> +	/* ARM L12: 300 MHz */
> +	{ 3, 0, 1 },
> +
> +	/* ARM L13: 200 MHz */
> +	{ 3, 0, 0 },
> +};
> +
> +static unsigned int exynos4x12_apll_pms_table[CPUFREQ_LEVEL_END] = {
> +	/* APLL FOUT L0: 1500 MHz */
> +	((250<<  16) | (4<<  8) | (0x0)),
> +
> +	/* APLL FOUT L1: 1400 MHz */
> +	((175<<  16) | (3<<  8) | (0x0)),
> +
> +	/* APLL FOUT L2: 1300 MHz */
> +	((325<<  16) | (6<<  8) | (0x0)),
> +
> +	/* APLL FOUT L3: 1200 MHz */
> +	((200<<  16) | (4<<  8) | (0x0)),
> +
> +	/* APLL FOUT L4: 1100 MHz */
> +	((275<<  16) | (6<<  8) | (0x0)),
> +
> +	/* APLL FOUT L5: 1000 MHz */
> +	((125<<  16) | (3<<  8) | (0x0)),
> +
> +	/* APLL FOUT L6: 900 MHz */
> +	((150<<  16) | (4<<  8) | (0x0)),
> +
> +	/* APLL FOUT L7: 800 MHz */
> +	((100<<  16) | (3<<  8) | (0x0)),
> +
> +	/* APLL FOUT L8: 700 MHz */
> +	((175<<  16) | (3<<  8) | (0x1)),
> +
> +	/* APLL FOUT L9: 600 MHz */
> +	((200<<  16) | (4<<  8) | (0x1)),
> +
> +	/* APLL FOUT L10: 500 MHz */
> +	((125<<  16) | (3<<  8) | (0x1)),
> +
> +	/* APLL FOUT L11 400 MHz */
> +	((100<<  16) | (3<<  8) | (0x1)),
> +
> +	/* APLL FOUT L12: 300 MHz */
> +	((200<<  16) | (4<<  8) | (0x2)),
> +
> +	/* APLL FOUT L13: 200 MHz */
> +	((100<<  16) | (3<<  8) | (0x2)),
> +};
> +
> +static const unsigned int asv_voltage_4x12[CPUFREQ_LEVEL_END] = {
> +	1350000, 1287500, 1250000, 1187500, 1137500, 1087500, 1037500,
> +	1000000,  987500,  975000,  950000,  925000,  900000,  900000
> +};
> +
> +static void exynos4x12_set_clkdiv(unsigned int div_index)
> +{
> +	unsigned int tmp;
> +	unsigned int stat_cpu1;
> +
> +	/* Change Divider - CPU0 */
> +
> +	tmp = exynos4x12_clkdiv_table[div_index].clkdiv;
> +
> +	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
> +
> +	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU)&  0x11111111)
> +		cpu_relax();
> +
> +	/* Change Divider - CPU1 */
> +	tmp = exynos4x12_clkdiv_table[div_index].clkdiv1;
> +
> +	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
> +	if (soc_is_exynos4212())
> +		stat_cpu1 = 0x11;
> +	else
> +		stat_cpu1 = 0x111;
> +
> +	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU1)&  stat_cpu1)
> +		cpu_relax();
> +}
> +
> +static void exynos4x12_set_apll(unsigned int index)
> +{
> +	unsigned int tmp, pdiv;
> +
> +	/* 1. MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> +	clk_set_parent(moutcore, mout_mpll);
> +
> +	do {
> +		cpu_relax();
> +		tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
> +			>>  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
> +		tmp&= 0x7;
> +	} while (tmp != 0x2);
> +
> +	/* 2. Set APLL Lock time */
> +	pdiv = ((exynos4x12_apll_pms_table[index]>>  8)&  0x3f);
> +
> +	__raw_writel((pdiv * 250), EXYNOS4_APLL_LOCK);
> +
> +	/* 3. Change PLL PMS values */
> +	tmp = __raw_readl(EXYNOS4_APLL_CON0);
> +	tmp&= ~((0x3ff<<  16) | (0x3f<<  8) | (0x7<<  0));
> +	tmp |= exynos4x12_apll_pms_table[index];
> +	__raw_writel(tmp, EXYNOS4_APLL_CON0);
> +
> +	/* 4. wait_lock_time */
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS4_APLL_CON0);
> +	} while (!(tmp&  (0x1<<  EXYNOS4_APLLCON0_LOCKED_SHIFT)));
> +
> +	/* 5. MUX_CORE_SEL = APLL */
> +	clk_set_parent(moutcore, mout_apll);
> +
> +	do {
> +		cpu_relax();
> +		tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
> +		tmp&= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
> +	} while (tmp != (0x1<<  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
> +}
> +
> +bool exynos4x12_pms_change(unsigned int old_index, unsigned int new_index)
> +{
> +	unsigned int old_pm = exynos4x12_apll_pms_table[old_index]>>  8;
> +	unsigned int new_pm = exynos4x12_apll_pms_table[new_index]>>  8;
> +
> +	return (old_pm == new_pm) ? 0 : 1;
> +}
> +
> +static void exynos4x12_set_frequency(unsigned int old_index,
> +				  unsigned int new_index)
> +{
> +	unsigned int tmp;
> +
> +	if (old_index>  new_index) {
> +		if (!exynos4x12_pms_change(old_index, new_index)) {
> +			/* 1. Change the system clock divider values */
> +			exynos4x12_set_clkdiv(new_index);
> +			/* 2. Change just s value in apll m,p,s value */
> +			tmp = __raw_readl(EXYNOS4_APLL_CON0);
> +			tmp&= ~(0x7<<  0);
> +			tmp |= (exynos4x12_apll_pms_table[new_index]&  0x7);
> +			__raw_writel(tmp, EXYNOS4_APLL_CON0);
> +
> +		} else {
> +			/* Clock Configuration Procedure */
> +			/* 1. Change the system clock divider values */
> +			exynos4x12_set_clkdiv(new_index);
> +			/* 2. Change the apll m,p,s value */
> +			exynos4x12_set_apll(new_index);
> +		}
> +	} else if (old_index<  new_index) {
> +		if (!exynos4x12_pms_change(old_index, new_index)) {
> +			/* 1. Change just s value in apll m,p,s value */
> +			tmp = __raw_readl(EXYNOS4_APLL_CON0);
> +			tmp&= ~(0x7<<  0);
> +			tmp |= (exynos4x12_apll_pms_table[new_index]&  0x7);
> +			__raw_writel(tmp, EXYNOS4_APLL_CON0);
> +			/* 2. Change the system clock divider values */
> +			exynos4x12_set_clkdiv(new_index);
> +		} else {
> +			/* Clock Configuration Procedure */
> +			/* 1. Change the apll m,p,s value */
> +			exynos4x12_set_apll(new_index);
> +			/* 2. Change the system clock divider values */
> +			exynos4x12_set_clkdiv(new_index);
> +		}
> +	}
> +}
> +
> +static void __init set_volt_table(void)
> +{
> +	unsigned int i;
> +
> +	max_support_idx = L1;
> +
> +	/* Not supported */
> +	exynos4x12_freq_table[L0].frequency = CPUFREQ_ENTRY_INVALID;
> +
> +	for (i = 0 ; i<  CPUFREQ_LEVEL_END ; i++)
> +		exynos4x12_volt_table[i] = asv_voltage_4x12[i];
> +}
> +
> +int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
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
> +	moutcore = clk_get(NULL, "moutcore");
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
> +	for (i = L0; i<   CPUFREQ_LEVEL_END; i++) {
> +
> +		exynos4x12_clkdiv_table[i].index = i;
> +
> +		tmp = __raw_readl(EXYNOS4_CLKDIV_CPU);
> +
> +		tmp&= ~(EXYNOS4_CLKDIV_CPU0_CORE_MASK |
> +			EXYNOS4_CLKDIV_CPU0_COREM0_MASK |
> +			EXYNOS4_CLKDIV_CPU0_COREM1_MASK |
> +			EXYNOS4_CLKDIV_CPU0_PERIPH_MASK |
> +			EXYNOS4_CLKDIV_CPU0_ATB_MASK |
> +			EXYNOS4_CLKDIV_CPU0_PCLKDBG_MASK |
> +			EXYNOS4_CLKDIV_CPU0_APLL_MASK);
> +
> +		if (soc_is_exynos4212()) {
> +			tmp |= ((clkdiv_cpu0_4212[i][0]<<  EXYNOS4_CLKDIV_CPU0_CORE_SHIFT) |
> +				(clkdiv_cpu0_4212[i][1]<<  EXYNOS4_CLKDIV_CPU0_COREM0_SHIFT) |
> +				(clkdiv_cpu0_4212[i][2]<<  EXYNOS4_CLKDIV_CPU0_COREM1_SHIFT) |
> +				(clkdiv_cpu0_4212[i][3]<<  EXYNOS4_CLKDIV_CPU0_PERIPH_SHIFT) |
> +				(clkdiv_cpu0_4212[i][4]<<  EXYNOS4_CLKDIV_CPU0_ATB_SHIFT) |
> +				(clkdiv_cpu0_4212[i][5]<<  EXYNOS4_CLKDIV_CPU0_PCLKDBG_SHIFT) |
> +				(clkdiv_cpu0_4212[i][6]<<  EXYNOS4_CLKDIV_CPU0_APLL_SHIFT));
> +		} else {
> +			tmp&= ~EXYNOS4_CLKDIV_CPU0_CORE2_MASK;
> +
> +			tmp |= ((clkdiv_cpu0_4412[i][0]<<  EXYNOS4_CLKDIV_CPU0_CORE_SHIFT) |
> +				(clkdiv_cpu0_4412[i][1]<<  EXYNOS4_CLKDIV_CPU0_COREM0_SHIFT) |
> +				(clkdiv_cpu0_4412[i][2]<<  EXYNOS4_CLKDIV_CPU0_COREM1_SHIFT) |
> +				(clkdiv_cpu0_4412[i][3]<<  EXYNOS4_CLKDIV_CPU0_PERIPH_SHIFT) |
> +				(clkdiv_cpu0_4412[i][4]<<  EXYNOS4_CLKDIV_CPU0_ATB_SHIFT) |
> +				(clkdiv_cpu0_4412[i][5]<<  EXYNOS4_CLKDIV_CPU0_PCLKDBG_SHIFT) |
> +				(clkdiv_cpu0_4412[i][6]<<  EXYNOS4_CLKDIV_CPU0_APLL_SHIFT) |
> +				(clkdiv_cpu0_4412[i][7]<<  EXYNOS4_CLKDIV_CPU0_CORE2_SHIFT));
> +		}
> +
> +		exynos4x12_clkdiv_table[i].clkdiv = tmp;
> +
> +		tmp = __raw_readl(EXYNOS4_CLKDIV_CPU1);
> +
> +		if (soc_is_exynos4212()) {
> +			tmp&= ~(EXYNOS4_CLKDIV_CPU1_COPY_MASK |
> +				EXYNOS4_CLKDIV_CPU1_HPM_MASK);
> +			tmp |= ((clkdiv_cpu1_4212[i][0]<<  EXYNOS4_CLKDIV_CPU1_COPY_SHIFT) |
> +				(clkdiv_cpu1_4212[i][1]<<  EXYNOS4_CLKDIV_CPU1_HPM_SHIFT));
> +		} else {
> +			tmp&= ~(EXYNOS4_CLKDIV_CPU1_COPY_MASK |
> +				EXYNOS4_CLKDIV_CPU1_HPM_MASK |
> +				EXYNOS4_CLKDIV_CPU1_CORES_MASK);
> +			tmp |= ((clkdiv_cpu1_4412[i][0]<<  EXYNOS4_CLKDIV_CPU1_COPY_SHIFT) |
> +				(clkdiv_cpu1_4412[i][1]<<  EXYNOS4_CLKDIV_CPU1_HPM_SHIFT) |
> +				(clkdiv_cpu1_4412[i][2]<<  EXYNOS4_CLKDIV_CPU1_CORES_SHIFT));
> +		}
> +		exynos4x12_clkdiv_table[i].clkdiv1 = tmp;
> +	}
> +
> +	info->mpll_freq_khz = rate;
> +	info->pm_lock_idx = L5;
> +	info->pll_safe_idx = L7;
> +	info->max_support_idx = max_support_idx;
> +	info->min_support_idx = min_support_idx;
> +	info->cpu_clk = cpu_clk;
> +	info->volt_table = exynos4x12_volt_table;
> +	info->freq_table = exynos4x12_freq_table;
> +	info->set_freq = exynos4x12_set_frequency;
> +	info->need_apll_change = exynos4x12_pms_change;
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
> +	pr_debug("%s: failed initialization\n", __func__);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(exynos4x12_cpufreq_init);
