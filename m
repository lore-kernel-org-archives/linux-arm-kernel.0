From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Aug 2010 20:44:19 +0900
Subject: [PATCH v6 7/7] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <1280829866-26001-8-git-send-email-myungjoo.ham@samsung.com>
References: <1280829866-26001-1-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-2-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-3-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-4-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-5-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-6-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-7-git-send-email-myungjoo.ham@samsung.com>
	<1280829866-26001-8-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <001d01cb33ca$62cd4060$2867c120$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> S5PV210 CPUFREQ Support.
> 
> This CPUFREQ may work without PMIC's DVS support. However, it is not
> as effective without DVS support as supposed. AVS is not supported in
> this version.
> 
> Note that CLK_SRC of some clocks including ARMCLK, G3D, G2D, MFC,
> and ONEDRAM are modified directly without updating clksrc_src
> representations of the clocks.  Because CPUFREQ reverts the CLK_SRC
> to the supposed values, this does not affect the consistency as long as
> there are no other modules that modifies clock sources of ARMCLK, G3D,
> G2D, MFC, and ONEDRAM (and only CPUFREQ should have the control). As
> soon as clock framework is settled, we may update source clocks
> (.parent field) of those clocks accordingly later.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> --
> v2:
> 	- Ramp-up delay is removed. (let regulator framework do the job)
> 	- Provide proper max values for regulator_set_voltage
> 	- Removed unneccesary #ifdef's.
> 	- Removed unnecessary initialiser for CLK_OUT
> v3:
> 	- Style corrections (pr_info/pr_err, ...)
> 	- Revised dvs_conf struct
> v4:
> 	- Renamed cpufreq-s5pv210.c -> cpufreq.c
> 	- Style corrections (less #ifdef's, comments)
> 	- Removed unncessary codes
> 	- Remove #ifdef for WORKAROUND, use s5pv210_workaround()
> 	- Renamed some static variables (get rid of s5pv210 prefix)
> 	- Added machine dependency to Kconfig/Makefile
> 	- DMC0, DMC1 refresh counter is not updated by a hardcoded value,
but
> 	with the value given as the default and relative clock speeds.
Besides,
> 	the algorithm to update DMC0/1 refresh counter is reformed.
> v5:
> 	- Remove unnecessary USE_FREQ_TABLE
> 	- Renamed functions
> 	- s5pv210_cpufreq_target's initialization revised. (first_run)
> 	- "workaround" --> "revision"
> 	- CLK_*_STAT register entries use macros: they are used mutiple
> 	  times.
> v6:
> 	- Restyled evt0-related codes.
> 
> ---
>  arch/arm/Kconfig                              |    1 +
>  arch/arm/mach-s5pv210/Kconfig                 |    5 +
>  arch/arm/mach-s5pv210/Makefile                |    2 +
>  arch/arm/mach-s5pv210/cpufreq.c               |  802
> +++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/cpu-freq.h |   38 ++
>  5 files changed, 848 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/cpufreq.c
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 98922f7..d5a5916 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -701,6 +701,7 @@ config ARCH_S5PV210
>  	select HAVE_CLK
>  	select ARM_L1_CACHE_SHIFT_6
>  	select ARCH_USES_GETTIMEOFFSET
> +	select ARCH_HAS_CPUFREQ
>  	help
>  	  Samsung S5PV210/S5PC110 series based systems
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 631019a..1c6d3bc 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -14,6 +14,7 @@ config CPU_S5PV210
>  	select PLAT_S5P
>  	select S3C_PL330_DMA
>  	select S5P_EXT_INT
> +	select S5PV210_CPU_FREQ if CPU_FREQ

Maybe as you know, can't use this with DDR2...
So right now, the selection should being in each machine config.

>  	help
>  	  Enable S5PV210 CPU support
> 
> @@ -101,4 +102,8 @@ config MACH_SMDKC110
>  	  Machine support for Samsung SMDKC110
>  	  S5PC110(MCP) is one of package option of S5PV210
> 
> +config S5PV210_CPU_FREQ
> +	bool "S5PV210 CPU-FREQ Support"
> +	depends on CPU_S5PV210 && CPU_FREQ
> +
>  endif
> diff --git a/arch/arm/mach-s5pv210/Makefile
b/arch/arm/mach-s5pv210/Makefile
> index aae592a..72ca5ec 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -34,3 +34,5 @@ obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
>  obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
>  obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
>  obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> +
> +obj-$(CONFIG_S5PV210_CPU_FREQ)		+= cpufreq.o
> diff --git a/arch/arm/mach-s5pv210/cpufreq.c
b/arch/arm/mach-s5pv210/cpufreq.c
> new file mode 100644
> index 0000000..f394007
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/cpufreq.c
> @@ -0,0 +1,802 @@
> +/*  linux/arch/arm/mach-s5pv210/cpufreq.c
> + *
> + *  Copyright (C) 2010 Samsung Electronics Co., Ltd.
> + *
> + *  CPU frequency scaling for S5PV210/S5PC110
> + *  Based on cpu-sa1110.c and s5pc11x-cpufreq.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio.h>
> +#include <asm/system.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +#include <mach/regs-clock.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/cpu-freq.h>
> +
> +#include <plat/cpu-freq.h>
> +#include <plat/pll.h>
> +#include <plat/clock.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/regs-fb.h>
> +#ifdef CONFIG_PM
> +#include <plat/pm.h>
> +#endif
> +
> +static struct clk *mpu_clk;
> +static struct regulator *arm_regulator;
> +static struct regulator *internal_regulator;
> +
> +struct s3c_cpufreq_freqs s3c_freqs;
> +
> +static unsigned long previous_arm_volt;
> +
> +static unsigned int backup_dmc0_reg;
> +static unsigned int backup_dmc1_reg;
> +static unsigned int backup_freq_level;
> +static unsigned int mpll_freq; /* in MHz */
> +static unsigned int apll_freq_max; /* in MHz */
> +
> +/* frequency */
> +static struct cpufreq_frequency_table freq_table[] = {
> +	{L0, 1000*1000},
> +	{L1, 800*1000},
> +	{L2, 400*1000},
> +	{L3, 200*1000},
> +	{L4, 100*1000},
> +	{0, CPUFREQ_TABLE_END},
> +};
> +
> +struct s5pv210_dvs_conf {
> +	unsigned long       arm_volt;   /* uV */
> +	unsigned long       int_volt;   /* uV */
> +};
> +
> +const unsigned long arm_volt_max = 1350000;
> +const unsigned long int_volt_max = 1250000;
> +
> +static struct s5pv210_dvs_conf dvs_conf_evt0[] = {
> +	[L0] = {
> +		.arm_volt   = 1300000,
> +		.int_volt   = 1200000,
> +	},
> +	[L1] = {
> +		.arm_volt   = 1250000,
> +		.int_volt   = 1200000,
> +
> +	},
> +	[L2] = {
> +		.arm_volt   = 1250000,
> +		.int_volt   = 1200000,
> +
> +	},
> +	[L3] = {
> +		.arm_volt   = 1250000,
> +		.int_volt   = 1200000,
> +	},
> +	[L4] = {
> +		.arm_volt   = 1250000,
> +		.int_volt   = 1200000,
> +	},
> +};
> +static struct s5pv210_dvs_conf dvs_conf_default[] = {
> +	[L0] = {
> +		.arm_volt   = 1250000,
> +		.int_volt   = 1100000,
> +	},
> +	[L1] = {
> +		.arm_volt   = 1200000,
> +		.int_volt   = 1100000,
> +	},
> +	[L2] = {
> +		.arm_volt   = 1050000,
> +		.int_volt   = 1100000,
> +	},
> +	[L3] = {
> +		.arm_volt   = 950000,
> +		.int_volt   = 1100000,
> +	},
> +	[L4] = {
> +		.arm_volt   = 950000,
> +		.int_volt   = 1000000,
> +	},
> +};
> +static struct s5pv210_dvs_conf *dvs_conf = dvs_conf_default;
> +
> +static u32 clkdiv_val[5][11] = {
> +	/*{ APLL, A2M, HCLK_MSYS, PCLK_MSYS,
> +	 * HCLK_DSYS, PCLK_DSYS, HCLK_PSYS, PCLK_PSYS, ONEDRAM,
> +	 * MFC, G3D }
> +	 */
> +	/* L0 : [1000/200/200/100][166/83][133/66][200/200] */
> +	{0, 4, 4, 1, 3, 1, 4, 1, 3, 0, 0},
> +	/* L1 : [800/200/200/100][166/83][133/66][200/200] */
> +	{0, 3, 3, 1, 3, 1, 4, 1, 3, 0, 0},
> +	/* L2 : [400/200/200/100][166/83][133/66][200/200] */
> +	{1, 3, 1, 1, 3, 1, 4, 1, 3, 0, 0},
> +	/* L3 : [200/200/200/100][166/83][133/66][200/200] */
> +	{3, 3, 0, 1, 3, 1, 4, 1, 3, 0, 0},
> +	/* L4 : [100/100/100/100][83/83][66/66][100/100] */
> +	{7, 7, 0, 0, 7, 0, 9, 0, 7, 0, 0},
> +};
> +
> +static struct s3c_freq clk_info[] = {
> +	[L0] = {	/* L0: 1GHz */
> +		.fclk       = 1000000,
> +		.armclk     = 1000000,
> +		.hclk_tns   = 0,
> +		.hclk       = 133000,
> +		.pclk       = 66000,
> +		.hclk_msys  = 200000,
> +		.pclk_msys  = 100000,
> +		.hclk_dsys  = 166750,
> +		.pclk_dsys  = 83375,
> +	},
> +	[L1] = {	/* L1: 800MHz */
> +		.fclk       = 800000,
> +		.armclk     = 800000,
> +		.hclk_tns   = 0,
> +		.hclk       = 133000,
> +		.pclk       = 66000,
> +		.hclk_msys  = 200000,
> +		.pclk_msys  = 100000,
> +		.hclk_dsys  = 166750,
> +		.pclk_dsys  = 83375,
> +	},
> +	[L2] = {	/* L2: 400MHz */
> +		.fclk       = 800000,
> +		.armclk     = 400000,
> +		.hclk_tns   = 0,
> +		.hclk       = 133000,
> +		.pclk       = 66000,
> +		.hclk_msys  = 200000,
> +		.pclk_msys  = 100000,
> +		.hclk_dsys  = 166750,
> +		.pclk_dsys  = 83375,
> +	},
> +	[L3] = {	/* L3: 200MHz */
> +		.fclk       = 800000,
> +		.armclk     = 200000,
> +		.hclk_tns   = 0,
> +		.hclk       = 133000,
> +		.pclk       = 66000,
> +		.hclk_msys  = 200000,
> +		.pclk_msys  = 100000,
> +		.hclk_dsys  = 166750,
> +		.pclk_dsys  = 83375,
> +	},
> +	[L4] = {	/* L4: 100MHz */
> +		.fclk       = 800000,
> +		.armclk     = 100000,
> +		.hclk_tns   = 0,
> +		.hclk       = 66000,
> +		.pclk       = 66000,
> +		.hclk_msys  = 100000,
> +		.pclk_msys  = 100000,
> +		.hclk_dsys  = 83375,
> +		.pclk_dsys  = 83375,
> +	},
> +};
> +
> +static int s5pv210_cpufreq_verify_speed(struct cpufreq_policy *policy)
> +{
> +	if (policy->cpu)
> +		return -EINVAL;
> +
> +	return cpufreq_frequency_table_verify(policy, freq_table);
> +}
> +
> +static unsigned int s5pv210_cpufreq_getspeed(unsigned int cpu)
> +{
> +	unsigned long rate;
> +
> +	if (cpu)
> +		return 0;
> +
> +	rate = clk_get_rate(mpu_clk) / 1000;
> +
> +	return rate;
> +}
> +
> +static void s5pv210_cpufreq_clksrcs_APLL2MPLL(unsigned int index,
> +		unsigned int bus_speed_changing)
> +{
> +	unsigned int reg;
> +
> +	/*
> +	 * 1. Temporarily change divider for MFC and G3D
> +	 * SCLKA2M(200/1=200)->(200/4=50)MHz
> +	 */
> +	reg = __raw_readl(S5P_CLK_DIV2);
> +	reg &= ~(S5P_CLKDIV2_G3D_MASK | S5P_CLKDIV2_MFC_MASK);
> +	reg |= (0x3 << S5P_CLKDIV2_G3D_SHIFT) |
> +		(0x3 << S5P_CLKDIV2_MFC_SHIFT);
> +	if (s5pv210_revision_evt0()) {
> +		/* Nothing to do for EVT0 */
> +	} else {
> +		reg &= ~S5P_CLKDIV2_G2D_MASK;
> +		reg |= (0x2 << S5P_CLKDIV2_G2D_SHIFT);
> +	}
> +
> +	__raw_writel(reg, S5P_CLK_DIV2);
> +
> +	/* Wait for MFC, G3D div changing */
> +	do {
> +		reg = __raw_readl(S5P_CLK_DIV_STAT0);
> +	} while (reg & (S5P_CLKDIV_STAT0_G3D | S5P_CLKDIV_STAT0_MFC));
> +	/* Wait for G2D div changing */
> +	if (s5pv210_revision_evt0()) {
> +		/* Nothing to do for EVT0 */
> +	} else {
> +		do {
> +			reg = __raw_readl(S5P_CLK_DIV_STAT1);
> +		} while  (reg & (S5P_CLKDIV_STAT1_G2D));

Maybe you remember Ben's comment in the SRC/DIV status check patch.
I think, in this case, some inline function can reduce duplicate do {} while
().

> +	}
> +
> +	/*
> +	 * 2. Change SCLKA2M(200MHz) to SCLKMPLL in MFC_MUX, G3D MUX
> +	 * (100/4=50)->(667/4=166)MHz
> +	 */
> +	reg = __raw_readl(S5P_CLK_SRC2);
> +	reg &= ~(S5P_CLKSRC2_G3D_MASK | S5P_CLKSRC2_MFC_MASK);
> +	reg |= (0x1 << S5P_CLKSRC2_G3D_SHIFT) |
> +		(0x1 << S5P_CLKSRC2_MFC_SHIFT);
> +	if (s5pv210_revision_evt0()) {
> +		/* Nothing to do for EVT0 */
> +	} else {
> +		reg &= ~S5P_CLKSRC2_G2D_MASK;
> +		reg |= (0x1 << S5P_CLKSRC2_G2D_SHIFT);
> +	}
> +	__raw_writel(reg, S5P_CLK_SRC2);
> +
> +	if (s5pv210_revision_evt0()) {
> +		/* Wait for MFC, G3D mux changing */
> +		do {
> +			reg = __raw_readl(S5P_CLK_MUX_STAT1);
> +		} while (reg & (S5P_CLKMUX_STAT1_G3D |
> S5P_CLKMUX_STAT1_MFC));

Here...

> +	} else {
> +		/* EVT1 or later: wait for MFC, G3D, G2D mux changing */
> +		do {
> +			reg = __raw_readl(S5P_CLK_MUX_STAT1);
> +		} while (reg & (S5P_CLKMUX_STAT1_G3D |
> S5P_CLKMUX_STAT1_MFC
> +					| S5P_CLKMUX_STAT1_G2D));

Here...

> +	}
> +
> +	/* 3. msys: SCLKAPLL -> SCLKMPLL */
> +	reg = __raw_readl(S5P_CLK_SRC0);
> +	reg &= ~(S5P_CLKSRC0_MUX200_MASK);
> +	reg |= (0x1 << S5P_CLKSRC0_MUX200_SHIFT);
> +	__raw_writel(reg, S5P_CLK_SRC0);
> +
> +	do {
> +		reg = __raw_readl(S5P_CLK_MUX_STAT0);
> +	} while (reg & S5P_CLKMUX_STAT0_MUX200);

Here...

> +}
> +
> +static void s5pv210_cpufreq_clksrcs_MPLL2APLL(unsigned int index,
> +		unsigned int bus_speed_changing)
> +{
> +	unsigned int reg;
> +
> +	/*
> +	 * 1. Set Lock time = 30us*24MHz = 02cf (EVT1)
> +	 * EVT0			: Lock time = 300us*24Mhz = 7200(0x1c20)
> +	 * EVT1 and later	: Lock time = 30us*24Mhz = 0x2cf
> +	 */
> +	if (s5pv210_revision_evt0())
> +		__raw_writel(0x1c20, S5P_APLL_LOCK);
> +	else
> +		__raw_writel(0x2cf, S5P_APLL_LOCK);
> +
> +	/*
> +	 * 2. Turn on APLL
> +	 * 2-1. Set PMS values
> +	 */
> +	if (index == L0)
> +		/* APLL FOUT becomes 1000 Mhz */
> +		__raw_writel(PLL45XX_APLL_VAL_1000, S5P_APLL_CON);
> +	else
> +		/* APLL FOUT becomes 800 Mhz */
> +		__raw_writel(PLL45XX_APLL_VAL_800, S5P_APLL_CON);
> +	/* 2-2. Wait until the PLL is locked */
> +	do {
> +		reg = __raw_readl(S5P_APLL_CON);
> +	} while (!(reg & (0x1 << 29)));
> +
> +	/*
> +	 * 3. Change source clock from SCLKMPLL(667MHz)
> +	 * to SCLKA2M(200MHz) in MFC_MUX and G3D_MUX
> +	 * (667/4=166)->(200/4=50)MHz
> +	 */
> +	reg = __raw_readl(S5P_CLK_SRC2);
> +	reg &= ~(S5P_CLKSRC2_G3D_MASK | S5P_CLKSRC2_MFC_MASK);
> +	reg |= (0 << S5P_CLKSRC2_G3D_SHIFT) | (0 <<
> S5P_CLKSRC2_MFC_SHIFT);
> +	if (s5pv210_revision_evt0()) {
> +		/* Nothing to do for EVT0 */
> +	} else {
> +		reg &= ~S5P_CLKSRC2_G2D_MASK;
> +		reg |= 0x1 << S5P_CLKSRC2_G2D_SHIFT;
> +	}
> +	__raw_writel(reg, S5P_CLK_SRC2);
> +
> +	if (s5pv210_revision_evt0()) {
> +		/* Wait for MFC, G3D mux changing */
> +		do {
> +			reg = __raw_readl(S5P_CLK_MUX_STAT1);
> +		} while (reg & (S5P_CLKMUX_STAT1_G3D |
> S5P_CLKMUX_STAT1_MFC));
> +	} else {
> +		/* EVT1 or later: wait for MFC, G3D, G2D mux changing */
> +		do {
> +			reg = __raw_readl(S5P_CLK_MUX_STAT1);
> +		} while (reg & (S5P_CLKMUX_STAT1_G3D |
> S5P_CLKMUX_STAT1_MFC
> +					| S5P_CLKMUX_STAT1_G2D));
> +	}
> +
> +	/*
> +	 * 4. Change divider for MFC and G3D
> +	 * (200/4=50)->(200/1=200)MHz
> +	 */
> +	reg = __raw_readl(S5P_CLK_DIV2);
> +	reg &= ~(S5P_CLKDIV2_G3D_MASK | S5P_CLKDIV2_MFC_MASK);
> +	reg |= (clkdiv_val[index][10] << S5P_CLKDIV2_G3D_SHIFT) |
> +		(clkdiv_val[index][9] << S5P_CLKDIV2_MFC_SHIFT);
> +	if (s5pv210_revision_evt0()) {
> +		/* Nothing to do for EVT0 */
> +	} else {
> +		reg &= ~S5P_CLKDIV2_G2D_MASK;
> +		reg |= 0x2 << S5P_CLKDIV2_G2D_SHIFT;
> +	}
> +	__raw_writel(reg, S5P_CLK_DIV2);
> +
> +	/* Wait for MFC, G3D div changing */
> +	do {
> +		reg = __raw_readl(S5P_CLK_DIV_STAT0);
> +	} while (reg & (S5P_CLKDIV_STAT0_G3D | S5P_CLKDIV_STAT0_MFC));
> +	/* Wait for G2D div changing */
> +	if (s5pv210_revision_evt0()) {
> +		/* Nothing to do for EVT0 */
> +	} else {
> +		do {
> +			reg = __raw_readl(S5P_CLK_DIV_STAT1);
> +		} while  (reg & (S5P_CLKDIV_STAT1_G2D));
> +	}
> +
> +	/* 5. Change MPLL to APLL in MSYS_MUX */
> +	reg = __raw_readl(S5P_CLK_SRC0);
> +	reg &= ~(S5P_CLKSRC0_MUX200_MASK);
> +	reg |= (0x0 << S5P_CLKSRC0_MUX200_SHIFT); /* SCLKMPLL ->
> SCLKAPLL   */
> +	__raw_writel(reg, S5P_CLK_SRC0);
> +
> +	do {
> +		reg = __raw_readl(S5P_CLK_MUX_STAT0);
> +	} while (reg & S5P_CLKMUX_STAT0_MUX200);
> +}
> +
> +#ifdef CONFIG_PM
> +static int no_cpufreq_access;
> +/*
> + * s5pv210_cpufreq_target: relation has an additional symantics other
than
> + * the standard
> + * [0x30]:
> + *	1: disable further access to target until being re-enabled.
> + *	2: re-enable access to target */
> +#endif
> +static int s5pv210_cpufreq_target(struct cpufreq_policy *policy,
> +		unsigned int target_freq,
> +		unsigned int relation)
> +{
> +	static bool first_run = true;
> +	int ret = 0;
> +	unsigned long arm_clk;
> +	unsigned int index, reg, arm_volt, int_volt;
> +	unsigned int pll_changing = 0;
> +	unsigned int bus_speed_changing = 0;
> +
> +	cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, KERN_INFO,
> +			"cpufreq: Entering for %dkHz\n", target_freq);
> +#ifdef CONFIG_PM
> +	if ((relation & ENABLE_FURTHER_CPUFREQ) &&
> +			(relation & DISABLE_FURTHER_CPUFREQ)) {
> +		/* Invalidate both if both marked */
> +		relation &= ~ENABLE_FURTHER_CPUFREQ;
> +		relation &= ~DISABLE_FURTHER_CPUFREQ;
> +		pr_err("%s:%d denied marking \"FURTHER_CPUFREQ\""
> +				" as both marked.\n",
> +				__FILE__, __LINE__);
> +	}
> +	if (relation & ENABLE_FURTHER_CPUFREQ)
> +		no_cpufreq_access = 0;
> +	if (no_cpufreq_access == 1) {
> +#ifdef CONFIG_PM_VERBOSE
> +		pr_err("%s:%d denied access to %s as it is disabled"
> +			       " temporarily\n", __FILE__, __LINE__,
__func__);
> +#endif
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (relation & DISABLE_FURTHER_CPUFREQ)
> +		no_cpufreq_access = 1;
> +	relation &= ~MASK_FURTHER_CPUFREQ;
> +#endif
> +
> +	s3c_freqs.freqs.old = s5pv210_cpufreq_getspeed(0);
> +
> +	if (cpufreq_frequency_table_target(policy, freq_table,
> +				target_freq, relation, &index)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	arm_clk = freq_table[index].frequency;
> +
> +	s3c_freqs.freqs.new = arm_clk;
> +	s3c_freqs.freqs.cpu = 0;
> +
> +	/*
> +	 * Run this function unconditionally until s3c_freqs.freqs.new
> +	 * and s3c_freqs.freqs.old are both set by this function.
> +	 */
> +	if (s3c_freqs.freqs.new == s3c_freqs.freqs.old && !first_run)
> +		return 0;
> +
> +	arm_volt = dvs_conf[index].arm_volt;
> +	int_volt = dvs_conf[index].int_volt;
> +
> +	/* New clock information update */
> +	memcpy(&s3c_freqs.new, &clk_info[index],
> +			sizeof(struct s3c_freq));
> +
> +	if (s3c_freqs.freqs.new >= s3c_freqs.freqs.old) {
> +		/* Voltage up code: increase ARM first */
> +		if (!IS_ERR_OR_NULL(arm_regulator) &&
> +				!IS_ERR_OR_NULL(internal_regulator)) {
> +			regulator_set_voltage(arm_regulator,
> +					arm_volt, arm_volt_max);
> +			regulator_set_voltage(internal_regulator,
> +					int_volt, int_volt_max);
> +		}
> +	}
> +	cpufreq_notify_transition(&s3c_freqs.freqs, CPUFREQ_PRECHANGE);
> +
> +	if (s3c_freqs.new.fclk != s3c_freqs.old.fclk || first_run)
> +		pll_changing = 1;
> +
> +	if (s3c_freqs.new.hclk_msys != s3c_freqs.old.hclk_msys || first_run)
> +		bus_speed_changing = 1;
> +
> +	/*
> +	 * If ONEDRAM(DMC0)'s clock is getting slower, DMC0's
> +	 * refresh counter should decrease before slowing down
> +	 * DMC0 clock. We assume that DMC0's source clock never
> +	 * changes. This is a temporary setting for the transition.
> +	 * Stable setting is done at the end of this function.
> +	 */
> +	reg = (__raw_readl(S5P_CLK_DIV6) & S5P_CLKDIV6_ONEDRAM_MASK)
> +		>> S5P_CLKDIV6_ONEDRAM_SHIFT;
> +	if (clkdiv_val[index][8] > reg) {
> +		reg = backup_dmc0_reg * (reg + 1) / (clkdiv_val[index][8] +
1);
> +		WARN_ON(reg > 0xFFFF);
> +		reg &= 0xFFFF;
> +		__raw_writel(reg, S5P_VA_DMC0 + 0x30);
> +	}
> +
> +	/*
> +	 * If hclk_msys (for DMC1) is getting slower, DMC1's
> +	 * refresh counter should decrease before slowing down
> +	 * hclk_msys in order to get rid of glitches in the
> +	 * transition. This is temporary setting for the transition.
> +	 * Stable setting is done at the end of this function.
> +	 *
> +	 * Besides, we need to consider the case when PLL speed changes,
> +	 * where the DMC1's source clock hclk_msys is changed from ARMCLK
> +	 * to MPLL temporarily. DMC1 needs to be ready for this
> +	 * transition as well.
> +	 */
> +	if (s3c_freqs.new.hclk_msys < s3c_freqs.old.hclk_msys || first_run)
{
> +		/*
> +		 * hclk_msys is up to 12bit. (200000)
> +		 * reg is 16bit. so no overflow, yet.
> +		 *
> +		 * May need to use div64.h later with larger hclk_msys or
> +		 * DMCx refresh counter. But, we have bugs in do_div and
> +		 * that should be fixed before.
> +		 */
> +		reg = backup_dmc1_reg * s3c_freqs.new.hclk_msys;
> +		reg /= clk_info[backup_freq_level].hclk_msys;
> +
> +		/*
> +		 * When ARM_CLK is absed on APLL->MPLL,
> +		 * hclk_msys becomes hclk_msys *= MPLL/APLL;
> +		 *
> +		 * Based on the worst case scenario, we use MPLL/APLL_MAX
> +		 * assuming that MPLL clock speed does not change.
> +		 *
> +		 * Multiplied first in order to reduce rounding error.
> +		 * because reg has 15b length, using 64b should be enough to
> +		 * prevent overflow.
> +		 */
> +		if (pll_changing) {
> +			reg *= mpll_freq;
> +			reg /= apll_freq_max;
> +		}
> +		WARN_ON(reg > 0xFFFF);
> +		__raw_writel(reg & 0xFFFF, S5P_VA_DMC1 + 0x30);
> +	}
> +
> +	/*
> +	 * APLL should be changed in this level
> +	 * APLL -> MPLL(for stable transition) -> APLL
> +	 * Some clock source's clock API  are not prepared. Do not use clock
> API
> +	 * in below code.
> +	 */
> +	if (pll_changing)
> +		s5pv210_cpufreq_clksrcs_APLL2MPLL(index,
> bus_speed_changing);
> +
> +	/* ARM MCS value changed */
> +	if (index != L4) {
> +		reg = __raw_readl(S5P_ARM_MCS_CON);
> +		reg &= ~0x3;
> +		reg |= 0x1;
> +		__raw_writel(reg, S5P_ARM_MCS_CON);
> +	}
> +
> +	reg = __raw_readl(S5P_CLK_DIV0);
> +
> +	reg &= ~(S5P_CLKDIV0_APLL_MASK | S5P_CLKDIV0_A2M_MASK
> +			| S5P_CLKDIV0_HCLK200_MASK |
> S5P_CLKDIV0_PCLK100_MASK
> +			| S5P_CLKDIV0_HCLK166_MASK |
> S5P_CLKDIV0_PCLK83_MASK
> +			| S5P_CLKDIV0_HCLK133_MASK |
> S5P_CLKDIV0_PCLK66_MASK);
> +
> +	reg |= ((clkdiv_val[index][0]<<S5P_CLKDIV0_APLL_SHIFT)
> +			| (clkdiv_val[index][1] << S5P_CLKDIV0_A2M_SHIFT)
> +			| (clkdiv_val[index][2] <<
> S5P_CLKDIV0_HCLK200_SHIFT)
> +			| (clkdiv_val[index][3] <<
> S5P_CLKDIV0_PCLK100_SHIFT)
> +			| (clkdiv_val[index][4] <<
> S5P_CLKDIV0_HCLK166_SHIFT)
> +			| (clkdiv_val[index][5] << S5P_CLKDIV0_PCLK83_SHIFT)
> +			| (clkdiv_val[index][6] <<
> S5P_CLKDIV0_HCLK133_SHIFT)
> +			| (clkdiv_val[index][7] <<
> S5P_CLKDIV0_PCLK66_SHIFT));
> +
> +	__raw_writel(reg, S5P_CLK_DIV0);
> +
> +	do {
> +		reg = __raw_readl(S5P_CLK_DIV_STAT0);
> +	} while (reg & 0xff);
> +
> +	/* ARM MCS value changed */
> +	if (index == L4) {
> +		reg = __raw_readl(S5P_ARM_MCS_CON);
> +		reg &= ~0x3;
> +		reg |= 0x3;
> +		__raw_writel(reg, S5P_ARM_MCS_CON);
> +	}
> +
> +	if (pll_changing)
> +		s5pv210_cpufreq_clksrcs_MPLL2APLL(index,
> bus_speed_changing);
> +
> +	/*
> +	 * Adjust DMC0 refresh ratio according to the rate of DMC0
> +	 * The DIV value of DMC0 clock changes and SRC value is not
controlled.
> +	 * We assume that no one changes SRC value of DMC0 clock, either.
> +	 */
> +	reg = __raw_readl(S5P_CLK_DIV6);
> +	reg &= ~S5P_CLKDIV6_ONEDRAM_MASK;
> +	reg |= (clkdiv_val[index][8] << S5P_CLKDIV6_ONEDRAM_SHIFT);
> +	/* ONEDRAM(DMC0) Clock Divider Ratio: 7+1 for L4, 3+1 for Others */
> +	__raw_writel(reg, S5P_CLK_DIV6);
> +	do {
> +		reg = __raw_readl(S5P_CLK_DIV_STAT1);
> +	} while (reg & (1 << 15));
> +
> +	/*
> +	 * If DMC0 clock gets slower (by orginal clock speed / n),
> +	 * then, the refresh rate should decrease
> +	 * (by original refresh count / n) (n: divider)
> +	 */
> +	reg = backup_dmc0_reg * (clkdiv_val[backup_freq_level][8] + 1)
> +		/ (clkdiv_val[index][8] + 1);
> +	__raw_writel(reg & 0xFFFF, S5P_VA_DMC0 + 0x30);
> +
> +	/*
> +	 * Adjust DMC1 refresh ratio according to the rate of hclk_msys
> +	 * (L0~L3: 200 <-> L4: 100)
> +	 * If DMC1 clock gets slower (by original clock speed * n),
> +	 * then, the refresh rate should decrease
> +	 * (by original refresh count * n) (n : clock rate)
> +	 */
> +	reg = backup_dmc1_reg * clk_info[index].hclk_msys;
> +	reg /= clk_info[backup_freq_level].hclk_msys;
> +	__raw_writel(reg & 0xFFFF, S5P_VA_DMC1 + 0x30);
> +
> +	if (s3c_freqs.freqs.new < s3c_freqs.freqs.old) {
> +		/* Voltage down: decrease INT first.*/
> +		if (!IS_ERR_OR_NULL(arm_regulator) &&
> +				!IS_ERR_OR_NULL(internal_regulator)) {
> +			regulator_set_voltage(internal_regulator,
> +					int_volt, int_volt_max);
> +			regulator_set_voltage(arm_regulator,
> +					arm_volt, arm_volt_max);
> +		}
> +	}
> +	cpufreq_notify_transition(&s3c_freqs.freqs, CPUFREQ_POSTCHANGE);
> +
> +	memcpy(&s3c_freqs.old, &s3c_freqs.new, sizeof(struct s3c_freq));
> +	cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, KERN_INFO,
> +			"cpufreq: Performance changed[L%d]\n", index);
> +	previous_arm_volt = dvs_conf[index].arm_volt;
> +
> +	if (first_run)
> +		first_run = false;
> +out:
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM
> +static int previous_frequency;
> +
> +static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy,
> +		pm_message_t pmsg)
> +{
> +	int ret = 0;
> +	pr_info("cpufreq: Entering suspend.\n");
> +
> +	previous_frequency = cpufreq_get(0);
> +	ret = __cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
> +			DISABLE_FURTHER_CPUFREQ);
> +	return ret;
> +}
> +
> +static int s5pv210_cpufreq_resume(struct cpufreq_policy *policy)
> +{
> +	int ret = 0;
> +	u32 rate;
> +	int level = CPUFREQ_TABLE_END;
> +	int i = 0;
> +
> +	pr_info("cpufreq: Waking up from a suspend.\n");
> +
> +	__cpufreq_driver_target(cpufreq_cpu_get(0), previous_frequency,
> +			ENABLE_FURTHER_CPUFREQ);
> +
> +	/* Clock information update with wakeup value */
> +	rate = clk_get_rate(mpu_clk);
> +
> +	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
> +		if (freq_table[i].frequency * 1000 == rate) {
> +			level = freq_table[i].index;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (level == CPUFREQ_TABLE_END) { /* Not found */
> +		pr_err("[%s:%d] clock speed does not match: "
> +				"%d. Using L1 of 800MHz.\n",
> +				__FILE__, __LINE__, rate);
> +		level = L1;
> +	}
> +
> +	memcpy(&s3c_freqs.old, &clk_info[level],
> +			sizeof(struct s3c_freq));
> +	previous_arm_volt = dvs_conf[level].arm_volt;
> +	return ret;
> +}
> +#endif
> +
> +static int __init s5pv210_cpufreq_driver_init(struct cpufreq_policy
*policy)
> +{
> +	u32 rate ;
> +	int i, level = CPUFREQ_TABLE_END;
> +	struct clk *mpll_clk;
> +
> +	pr_info("S5PV210 CPUFREQ Initialising...\n");
> +#ifdef CONFIG_PM
> +	no_cpufreq_access = 0;
> +#endif
> +	mpu_clk = clk_get(NULL, "armclk");
> +	if (IS_ERR(mpu_clk)) {
> +		pr_err("S5PV210 CPUFREQ cannot get armclk\n");
> +		return PTR_ERR(mpu_clk);
> +	}
> +
> +	if (policy->cpu != 0) {
> +		pr_err("S5PV210 CPUFREQ cannot get proper cpu(%d)\n",
> +				policy->cpu);
> +		return -EINVAL;
> +	}
> +	policy->cur = policy->min = policy->max =
s5pv210_cpufreq_getspeed(0);
> +
> +	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> +
> +	policy->cpuinfo.transition_latency = 40000;	/* 1us */
> +
> +	rate = clk_get_rate(mpu_clk);
> +	i = 0;
> +
> +	while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
> +		if (freq_table[i].frequency * 1000 == rate) {
> +			level = freq_table[i].index;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (level == CPUFREQ_TABLE_END) { /* Not found */
> +		pr_err("[%s:%d] clock speed does not match: "
> +				"%d. Using L1 of 800MHz.\n",
> +				__FILE__, __LINE__, rate);
> +		level = L1;
> +	}
> +
> +	backup_dmc0_reg = __raw_readl(S5P_VA_DMC0 + 0x30) & 0xFFFF;
> +	backup_dmc1_reg = __raw_readl(S5P_VA_DMC1 + 0x30) & 0xFFFF;
> +	backup_freq_level = level;
> +	mpll_clk = clk_get(NULL, "mout_mpll");
> +	mpll_freq = clk_get_rate(mpll_clk) / 1000 / 1000; /* in MHz */
> +	clk_put(mpll_clk);
> +	i = 0;
> +	do {
> +		int index = freq_table[i].index;
> +		if (apll_freq_max < clk_info[index].fclk)
> +			apll_freq_max = clk_info[index].fclk;
> +		i++;
> +	} while (freq_table[i].frequency != CPUFREQ_TABLE_END);
> +	apll_freq_max /= 1000; /* in MHz */
> +
> +	memcpy(&s3c_freqs.old, &clk_info[level],
> +			sizeof(struct s3c_freq));
> +	previous_arm_volt = dvs_conf[level].arm_volt;
> +
> +	return cpufreq_frequency_table_cpuinfo(policy, freq_table);
> +}
> +
> +static struct cpufreq_driver s5pv210_cpufreq_driver = {
> +	.flags		= CPUFREQ_STICKY,
> +	.verify		= s5pv210_cpufreq_verify_speed,
> +	.target		= s5pv210_cpufreq_target,
> +	.get		= s5pv210_cpufreq_getspeed,
> +	.init		= s5pv210_cpufreq_driver_init,
> +	.name		= "s5pv210",
> +#ifdef CONFIG_PM
> +	.suspend	= s5pv210_cpufreq_suspend,
> +	.resume		= s5pv210_cpufreq_resume,
> +#endif
> +};
> +
> +static int __init s5pv210_cpufreq_init(void)
> +{
> +	if (s5pv210_revision_evt0())
> +		dvs_conf = dvs_conf_evt0;
> +
> +	arm_regulator = regulator_get_exclusive(NULL, "vddarm");
> +	if (IS_ERR(arm_regulator)) {
> +		pr_err("failed to get regulater resource vddarm\n");
> +		goto error;
> +	}
> +	internal_regulator = regulator_get_exclusive(NULL, "vddint");
> +	if (IS_ERR(internal_regulator)) {
> +		pr_err("failed to get regulater resource vddint\n");
> +		goto error;
> +	}
> +	goto finish;
> +error:
> +	pr_warn("Cannot get vddarm or vddint. CPUFREQ Will not"
> +		       " change the voltage.\n");
> +finish:
> +	return cpufreq_register_driver(&s5pv210_cpufreq_driver);
> +}
> +
> +late_initcall(s5pv210_cpufreq_init);
> diff --git a/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
b/arch/arm/mach-
> s5pv210/include/mach/cpu-freq.h
> new file mode 100644
> index 0000000..76806ab
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> @@ -0,0 +1,38 @@
> +/* arch/arm/mach-s5pv210/include/mach/cpu-freq.h
> + *
> + * Copyright (c) 2010 Samsung Electronics
> + *
> + *       MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * S5PV210/S5PC110 CPU frequency scaling support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_CPU_FREQ_H
> +#define __ASM_ARCH_CPU_FREQ_H
> +
> +#include <linux/cpufreq.h>
> +
> +enum perf_level {
> +	L0 = 0,
> +	L1,
> +	L2,
> +	L3,
> +	L4,
> +};
> +
> +#ifdef CONFIG_PM
> +#define SLEEP_FREQ      (800 * 1000) /* Use 800MHz when entering sleep */
> +
> +/* additional symantics for "relation" in cpufreq with pm */
> +#define DISABLE_FURTHER_CPUFREQ         0x10
> +#define ENABLE_FURTHER_CPUFREQ          0x20
> +#define MASK_FURTHER_CPUFREQ            0x30
> +/* With 0x00(NOCHANGE), it depends on the previous "further" status */
> +
> +#endif /* CONFIG_PM */
> +
> +#endif /* __ASM_ARCH_CPU_FREQ_H */
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
