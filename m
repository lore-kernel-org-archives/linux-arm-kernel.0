From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 14:31:23 +0900
Subject: [PATCH v3 7/7] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <1279517483-22751-7-git-send-email-myungjoo.ham@samsung.com>
References: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-2-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-3-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-4-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-5-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-6-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-7-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279517483-22751-8-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210 CPUFREQ Support.

This CPUFREQ may work without PMIC's DVS support. However, it is not
as effective without DVS support as supposed. AVS is not supported in
this version.

Note that CLK_SRC of some clocks including ARMCLK, G3D, G2D, MFC,
and ONEDRAM are modified directly without updating clksrc_src
representations of the clocks.  Because CPUFREQ reverts the CLK_SRC
to the supposed values, this does not affect the consistency as long as
there are no other modules that modifies clock sources of ARMCLK, G3D,
G2D, MFC, and ONEDRAM (and only CPUFREQ should have the control). As
soon as clock framework is settled, we may update source clocks
(.parent field) of those clocks accordingly later.


Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
v2:
	- Ramp-up delay is removed. (let regulator framework do the job)
	- Provide proper max values for regulator_set_voltage
	- Removed unneccesary #ifdef's.
	- Removed unnecessary initialiser for CLK_OUT
v3:
	- Style corrections (pr_info/pr_err, ...)
	- Revised dvs_conf struct

---
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-s5pv210/Makefile                |    3 +
 arch/arm/mach-s5pv210/cpufreq-s5pv210.c       |  766 +++++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/cpu-freq.h |   51 ++
 4 files changed, 821 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/cpufreq-s5pv210.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/cpu-freq.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..d5a5916 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -701,6 +701,7 @@ config ARCH_S5PV210
 	select HAVE_CLK
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_HAS_CPUFREQ
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index aae592a..293dbac 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -34,3 +34,6 @@ obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+
+# CPUFREQ (DVFS)
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq-s5pv210.o
diff --git a/arch/arm/mach-s5pv210/cpufreq-s5pv210.c b/arch/arm/mach-s5pv210/cpufreq-s5pv210.c
new file mode 100644
index 0000000..38de3ac
--- /dev/null
+++ b/arch/arm/mach-s5pv210/cpufreq-s5pv210.c
@@ -0,0 +1,766 @@
+/*  linux/arch/arm/plat-s5pc11x/s5pc11x-cpufreq.c
+ *
+ *  Copyright (C) 2010 Samsung Electronics Co., Ltd.
+ *
+ *  CPU frequency scaling for S5PC110
+ *  Based on cpu-sa1110.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <asm/system.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-gpio.h>
+#include <mach/cpu-freq.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/pll.h>
+#include <plat/clock.h>
+#include <plat/gpio-cfg.h>
+#include <plat/regs-fb.h>
+#ifdef CONFIG_PM
+#include <plat/pm.h>
+#endif
+
+static struct clk *mpu_clk;
+static struct regulator *arm_regulator;
+static struct regulator *internal_regulator;
+
+struct s3c_cpufreq_freqs s3c_freqs;
+
+#ifdef CONFIG_S5PC110_EVT0_WORKAROUND
+#define	CPUFREQ_DISABLE_1GHZ
+#endif
+/* #define	CPUFREQ_DISABLE_100MHZ */
+
+static unsigned long previous_arm_volt;
+
+/* frequency */
+static struct cpufreq_frequency_table s5pv210_freq_table[] = {
+	{L0, 1000*1000},
+	{L1, 800*1000},
+	{L2, 400*1000},
+	{L3, 200*1000},
+	{L4, 100*1000},
+	{0, CPUFREQ_TABLE_END},
+};
+
+struct s5pv210_dvs_conf {
+	unsigned long       arm_volt;   /* uV */
+	unsigned long       int_volt;   /* uV */
+};
+
+#ifdef CONFIG_S5PC110_EVT0_WORKAROUND
+const unsigned long arm_volt_max = 1350000;
+const unsigned long int_volt_max = 1250000;
+#else
+const unsigned long arm_volt_max = 1300000;
+const unsigned long int_volt_max = 1200000;
+#endif
+
+static struct s5pv210_dvs_conf s5pv210_dvs_conf[] = {
+#ifdef CONFIG_S5PC110_EVT0_WORKAROUND
+	[L0] = {
+		.arm_volt   = 1300000,
+		.int_volt   = 1200000,
+	},
+	[L1] = {
+		.arm_volt   = 1250000,
+		.int_volt   = 1200000,
+
+	},
+	[L2] = {
+		.arm_volt   = 1250000,
+		.int_volt   = 1200000,
+
+	},
+	[L3] = {
+		.arm_volt   = 1250000,
+		.int_volt   = 1200000,
+	},
+	[L4] = {
+		.arm_volt   = 1250000,
+		.int_volt   = 1200000,
+	},
+#else
+	[L0] = {
+		.arm_volt   = 1250000,
+		.int_volt   = 1100000,
+	},
+	[L1] = {
+		.arm_volt   = 1200000,
+		.int_volt   = 1100000,
+	},
+	[L2] = {
+		.arm_volt   = 1050000,
+		.int_volt   = 1100000,
+	},
+	[L3] = {
+		.arm_volt   = 950000,
+		.int_volt   = 1100000,
+	},
+	[L4] = {
+		.arm_volt   = 950000,
+		.int_volt   = 1000000,
+	},
+#endif
+};
+
+static u32 clkdiv_val[5][11] = {
+	/*{ APLL, A2M, HCLK_MSYS, PCLK_MSYS,
+	 * HCLK_DSYS, PCLK_DSYS, HCLK_PSYS, PCLK_PSYS, ONEDRAM,
+	 * MFC, G3D }
+	 */
+	/* L0 : [1000/200/200/100][166/83][133/66][200/200] */
+	{0, 4, 4, 1, 3, 1, 4, 1, 3, 0, 0},
+	/* L1 : [800/200/200/100][166/83][133/66][200/200] */
+	{0, 3, 3, 1, 3, 1, 4, 1, 3, 0, 0},
+	/* L2 : [400/200/200/100][166/83][133/66][200/200] */
+	{1, 3, 1, 1, 3, 1, 4, 1, 3, 0, 0},
+	/* L3 : [200/200/200/100][166/83][133/66][200/200] */
+	{3, 3, 0, 1, 3, 1, 4, 1, 3, 0, 0},
+	/* L4 : [100/100/100/100][83/83][66/66][100/100] */
+	{7, 7, 0, 0, 7, 0, 9, 0, 7, 0, 0},
+};
+
+static struct s3c_freq s5pv210_clk_info[] = {
+	[L0] = {	/* L0: 1GHz */
+		.fclk       = 1000000,
+		.armclk     = 1000000,
+		.hclk_tns   = 0,
+		.hclk       = 133000,
+		.pclk       = 66000,
+		.hclk_msys  = 200000,
+		.pclk_msys  = 100000,
+		.hclk_dsys  = 166750,
+		.pclk_dsys  = 83375,
+	},
+	[L1] = {	/* L1: 800MHz */
+		.fclk       = 800000,
+		.armclk     = 800000,
+		.hclk_tns   = 0,
+		.hclk       = 133000,
+		.pclk       = 66000,
+		.hclk_msys  = 200000,
+		.pclk_msys  = 100000,
+		.hclk_dsys  = 166750,
+		.pclk_dsys  = 83375,
+	},
+	[L2] = {	/* L2: 400MHz */
+		.fclk       = 800000,
+		.armclk     = 400000,
+		.hclk_tns   = 0,
+		.hclk       = 133000,
+		.pclk       = 66000,
+		.hclk_msys  = 200000,
+		.pclk_msys  = 100000,
+		.hclk_dsys  = 166750,
+		.pclk_dsys  = 83375,
+	},
+	[L3] = {	/* L3: 200MHz */
+		.fclk       = 800000,
+		.armclk     = 200000,
+		.hclk_tns   = 0,
+		.hclk       = 133000,
+		.pclk       = 66000,
+		.hclk_msys  = 200000,
+		.pclk_msys  = 100000,
+		.hclk_dsys  = 166750,
+		.pclk_dsys  = 83375,
+	},
+	[L4] = {	/* L4: 100MHz */
+		.fclk       = 800000,
+		.armclk     = 100000,
+		.hclk_tns   = 0,
+		.hclk       = 66000,
+		.pclk       = 66000,
+		.hclk_msys  = 100000,
+		.pclk_msys  = 100000,
+		.hclk_dsys  = 83375,
+		.pclk_dsys  = 83375,
+	},
+};
+
+int s5pv210_verify_speed(struct cpufreq_policy *policy)
+{
+
+	if (policy->cpu)
+		return -EINVAL;
+
+	return cpufreq_frequency_table_verify(policy, s5pv210_freq_table);
+}
+
+unsigned int s5pv210_getspeed(unsigned int cpu)
+{
+	unsigned long rate;
+
+	if (cpu)
+		return 0;
+
+	rate = clk_get_rate(mpu_clk) / KHZ_T;
+
+	return rate;
+}
+
+static void s5pv210_target_APLL2MPLL(unsigned int index,
+		unsigned int bus_speed_changing)
+{
+	unsigned int reg;
+
+	/* 1. Temporarily change divider for MFC and G3D
+	 * SCLKA2M(200/1=200)->(200/4=50)MHz
+	 **/
+	reg = __raw_readl(S5P_CLK_DIV2);
+	reg &= ~(S5P_CLKDIV2_G3D_MASK | S5P_CLKDIV2_MFC_MASK);
+	reg |= (0x3 << S5P_CLKDIV2_G3D_SHIFT) |
+		(0x3 << S5P_CLKDIV2_MFC_SHIFT);
+#ifndef CONFIG_S5PC110_EVT0_WORKAROUND
+	reg &= ~S5P_CLKDIV2_G2D_MASK;
+	reg |= (0x2 << S5P_CLKDIV2_G2D_SHIFT);
+#endif
+	__raw_writel(reg, S5P_CLK_DIV2);
+
+	/* For MFC, G3D dividing */
+	do {
+		reg = __raw_readl(S5P_CLK_DIV_STAT0);
+	} while (reg & ((1 << 16) | (1 << 17)));
+
+	/* 2. Change SCLKA2M(200MHz) to SCLKMPLL in MFC_MUX, G3D MUX
+	 * (100/4=50)->(667/4=166)MHz
+	 **/
+	reg = __raw_readl(S5P_CLK_SRC2);
+	reg &= ~(S5P_CLKSRC2_G3D_MASK | S5P_CLKSRC2_MFC_MASK);
+	reg |= (0x1 << S5P_CLKSRC2_G3D_SHIFT) |
+		(0x1 << S5P_CLKSRC2_MFC_SHIFT);
+#ifndef CONFIG_S5PC110_EVT0_WORKAROUND
+	reg &= ~S5P_CLKSRC2_G2D_MASK;
+	reg |= (0x1 << S5P_CLKSRC2_G2D_SHIFT);
+#endif
+	__raw_writel(reg, S5P_CLK_SRC2);
+
+	do {
+		reg = __raw_readl(S5P_CLK_MUX_STAT1);
+	} while (reg & ((1 << 7) | (1 << 3)));
+
+	/* 3. DMC1 refresh count for 133MHz if (index == L4) is true
+	 * refresh counter is already programmed in the outer/upper
+	 * code. 0x287@83MHz
+	 **/
+	if (!bus_speed_changing)
+		__raw_writel(0x40d, S5P_VA_DMC1 + 0x30);
+
+	/* 4. SCLKAPLL -> SCLKMPLL */
+	reg = __raw_readl(S5P_CLK_SRC0);
+	reg &= ~(S5P_CLKSRC0_MUX200_MASK);
+	reg |= (0x1 << S5P_CLKSRC0_MUX200_SHIFT);
+	__raw_writel(reg, S5P_CLK_SRC0);
+
+	do {
+		reg = __raw_readl(S5P_CLK_MUX_STAT0);
+	} while (reg & (0x1 << 18));
+
+#if defined(CONFIG_S5PC110_H_TYPE)
+	/* DMC0 source clock: SCLKA2M -> SCLKMPLL */
+	__raw_writel(0x50e, S5P_VA_DMC0 + 0x30);
+
+	reg = __raw_readl(S5P_CLK_DIV6);
+	reg &= ~(S5P_CLKDIV6_ONEDRAM_MASK);
+	reg |= (0x3 << S5P_CLKDIV6_ONEDRAM_SHIFT);
+	__raw_writel(reg, S5P_CLK_DIV6);
+
+	do {
+		reg = __raw_readl(S5P_CLK_DIV_STAT1);
+	} while (reg & (1 << 15));
+
+	reg = __raw_readl(S5P_CLK_SRC6);
+	reg &= ~(S5P_CLKSRC6_ONEDRAM_MASK);
+	reg |= (0x1 << S5P_CLKSRC6_ONEDRAM_SHIFT);
+	__raw_writel(reg, S5P_CLK_SRC6);
+
+	do {
+		reg = __raw_readl(S5P_CLK_MUX_STAT1);
+	} while (reg & (1 << 11));
+#endif
+}
+
+static void s5pv210_target_MPLL2APLL(unsigned int index,
+		unsigned int bus_speed_changing)
+{
+	unsigned int reg;
+
+	/* 7. Set Lock time = 30us*24MHz = 02cf (EVT1) */
+#ifdef CONFIG_S5PC110_EVT0_WORKAROUND
+	/* Lock time = 300us*24Mhz = 7200(0x1c20)*/
+	__raw_writel(0x1c20, S5P_APLL_LOCK);
+#else
+	/* Lock time = 30us*24Mhz = 0x2cf*/
+	__raw_writel(0x2cf, S5P_APLL_LOCK);
+#endif
+
+	/* 8. Turn on APLL
+	 * 8-1. Set PMS values
+	 * 8-3. Wait until the PLL is locked
+	 **/
+	if (index == L0)
+		/* APLL FOUT becomes 1000 Mhz */
+		__raw_writel(PLL45XX_APLL_VAL_1000, S5P_APLL_CON);
+	else
+		/* APLL FOUT becomes 800 Mhz */
+		__raw_writel(PLL45XX_APLL_VAL_800, S5P_APLL_CON);
+
+	do {
+		reg = __raw_readl(S5P_APLL_CON);
+	} while (!(reg & (0x1 << 29)));
+
+	/* 9. Change source clock from SCLKMPLL(667MHz)
+	 * to SCLKA2M(200MHz) in MFC_MUX and G3D_MUX
+	 * (667/4=166)->(200/4=50)MHz
+	 **/
+	reg = __raw_readl(S5P_CLK_SRC2);
+	reg &= ~(S5P_CLKSRC2_G3D_MASK | S5P_CLKSRC2_MFC_MASK);
+	reg |= (0 << S5P_CLKSRC2_G3D_SHIFT) | (0 << S5P_CLKSRC2_MFC_SHIFT);
+#ifndef CONFIG_S5PC110_EVT0_WORKAROUND
+	reg &= ~S5P_CLKSRC2_G2D_MASK;
+	reg |= 0x1 << S5P_CLKSRC2_G2D_SHIFT;
+#endif
+	__raw_writel(reg, S5P_CLK_SRC2);
+
+	do {
+		reg = __raw_readl(S5P_CLK_MUX_STAT1);
+	} while (reg & ((1 << 7) | (1 << 3)));
+
+	/* 10. Change divider for MFC and G3D
+	 * (200/4=50)->(200/1=200)MHz
+	 **/
+	reg = __raw_readl(S5P_CLK_DIV2);
+	reg &= ~(S5P_CLKDIV2_G3D_MASK | S5P_CLKDIV2_MFC_MASK);
+	reg |= (clkdiv_val[index][10] << S5P_CLKDIV2_G3D_SHIFT) |
+		(clkdiv_val[index][9] << S5P_CLKDIV2_MFC_SHIFT);
+#ifndef CONFIG_S5PC110_EVT0_WORKAROUND
+	reg &= ~S5P_CLKDIV2_G2D_MASK;
+	reg |= 0x2 << S5P_CLKDIV2_G2D_SHIFT;
+#endif
+	__raw_writel(reg, S5P_CLK_DIV2);
+
+	do {
+		reg = __raw_readl(S5P_CLK_DIV_STAT0);
+	} while (reg & ((1 << 16) | (1 << 17)));
+
+	/* 11. Change MPLL to APLL in MSYS_MUX */
+	reg = __raw_readl(S5P_CLK_SRC0);
+	reg &= ~(S5P_CLKSRC0_MUX200_MASK);
+	reg |= (0x0 << S5P_CLKSRC0_MUX200_SHIFT); /* SCLKMPLL -> SCLKAPLL   */
+	__raw_writel(reg, S5P_CLK_SRC0);
+
+	do {
+		reg = __raw_readl(S5P_CLK_MUX_STAT0);
+	} while (reg & (0x1 << 18));
+
+	/* 12. DMC1 refresh counter
+	 * L4: DMC1 = 100MHz 7.8us/(1/100) = 0x30c
+	 * Others: DMC1 = 200MHz 7.8us/(1/200) = 0x618
+	 **/
+	if (!bus_speed_changing)
+		__raw_writel(0x618, S5P_VA_DMC1 + 0x30);
+
+#if defined(CONFIG_S5PC110_H_TYPE)
+	/* DMC0 source clock: SCLKMPLL -> SCLKA2M */
+	reg = __raw_readl(S5P_CLK_SRC6);
+	reg &= ~(S5P_CLKSRC6_ONEDRAM_MASK);
+	reg |= (0x0 << S5P_CLKSRC6_ONEDRAM_SHIFT);
+	__raw_writel(reg, S5P_CLK_SRC6);
+
+	do {
+		reg = __raw_readl(S5P_CLK_MUX_STAT1);
+	} while (reg & (1 << 11));
+
+	reg = __raw_readl(S5P_CLK_DIC6);
+	reg &= ~(S5P_CLKDIV6_ONEDRAM_MASK);
+	reg |= (0x0 << S5P_CLKDIV6_ONEDRAM_SHIFT);
+	__raw_writel(reg, S5P_CLK_DIV6);
+
+	do {
+		reg = __raw_readl(S5P_CLK_DIV_STAT1);
+	} while (reg & (1 << 15));
+	__raw_writel(0x618, S5P_VA_DMC0 + 0x30);
+#endif
+}
+
+#ifdef CONFIG_PM
+static int no_cpufreq_access;
+/* s5pv210_target: relation has an additional symantics other than
+ * the standard
+ * [0x30]:
+ *	1: disable further access to target until being re-enabled.
+ *	2: re-enable access to target */
+#endif
+static int s5pv210_target(struct cpufreq_policy *policy,
+		unsigned int target_freq,
+		unsigned int relation)
+{
+	static int initialized;
+	int ret = 0;
+	unsigned long arm_clk;
+	unsigned int index, reg, arm_volt, int_volt;
+	unsigned int pll_changing = 0;
+	unsigned int bus_speed_changing = 0;
+
+	cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, KERN_INFO,
+			"cpufreq: Entering for %dkHz\n", target_freq);
+#ifdef CONFIG_PM
+	if ((relation & ENABLE_FURTHER_CPUFREQ) &&
+			(relation & DISABLE_FURTHER_CPUFREQ)) {
+		/* Invalidate both if both marked */
+		relation &= ~ENABLE_FURTHER_CPUFREQ;
+		relation &= ~DISABLE_FURTHER_CPUFREQ;
+		pr_err("%s:%d denied marking \"FURTHER_CPUFREQ\""
+				" as both marked.\n",
+				__FILE__, __LINE__);
+	}
+	if (relation & ENABLE_FURTHER_CPUFREQ)
+		no_cpufreq_access = 0;
+	if (no_cpufreq_access == 1) {
+#ifdef CONFIG_PM_VERBOSE
+		pr_err("%s:%d denied access to %s as it is disabled"
+			       " temporarily\n", __FILE__, __LINE__, __func__);
+#endif
+		ret = -EINVAL;
+		goto out;
+	}
+	if (relation & DISABLE_FURTHER_CPUFREQ)
+		no_cpufreq_access = 1;
+	relation &= ~MASK_FURTHER_CPUFREQ;
+#endif
+
+	s3c_freqs.freqs.old = s5pv210_getspeed(0);
+
+	if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
+				target_freq, relation, &index)) {
+		ret = -EINVAL;
+		goto out;
+	}
+#ifdef CPUFREQ_DISABLE_100MHZ
+	if (index == L4)
+		index = L3;
+#endif
+#ifdef CPUFREQ_DISABLE_1GHZ
+	if (index == L0)
+		index = L1;
+#endif
+
+	arm_clk = s5pv210_freq_table[index].frequency;
+
+	s3c_freqs.freqs.new = arm_clk;
+	s3c_freqs.freqs.cpu = 0;
+
+	if (s3c_freqs.freqs.new == s3c_freqs.freqs.old &&
+			initialized >= 2)
+		return 0;
+	else if (initialized < 2)
+		initialized++;
+
+	arm_volt = s5pv210_dvs_conf[index].arm_volt;
+	int_volt = s5pv210_dvs_conf[index].int_volt;
+
+	/* iNew clock information update */
+	memcpy(&s3c_freqs.new, &s5pv210_clk_info[index],
+			sizeof(struct s3c_freq));
+
+	if (s3c_freqs.freqs.new >= s3c_freqs.freqs.old) {
+		/* Voltage up code: increase ARM first */
+		if (!IS_ERR_OR_NULL(arm_regulator) &&
+				!IS_ERR_OR_NULL(internal_regulator)) {
+			regulator_set_voltage(arm_regulator,
+					arm_volt, arm_volt_max);
+			regulator_set_voltage(internal_regulator,
+					int_volt, int_volt_max);
+		}
+	}
+	cpufreq_notify_transition(&s3c_freqs.freqs, CPUFREQ_PRECHANGE);
+
+	if (s3c_freqs.new.fclk != s3c_freqs.old.fclk || initialized < 2)
+		pll_changing = 1;
+
+	if (s3c_freqs.new.hclk_msys != s3c_freqs.old.hclk_msys ||
+			initialized < 2)
+		bus_speed_changing = 1;
+
+	if (bus_speed_changing) {
+		/* Reconfigure DRAM refresh counter value for minimum
+		 * temporary clock while changing divider.
+		 * expected clock is 83MHz: 7.8usec/(1/83MHz) = 0x287
+		 **/
+		if (pll_changing)
+			__raw_writel(0x287, S5P_VA_DMC1 + 0x30);
+		else
+			__raw_writel(0x30c, S5P_VA_DMC1 + 0x30);
+
+		__raw_writel(0x287, S5P_VA_DMC0 + 0x30);
+	}
+
+	/* APLL should be changed in this level
+	 * APLL -> MPLL(for stable transition) -> APLL
+	 * Some clock source's clock API  are not prepared. Do not use clock API
+	 * in below code.
+	 */
+	if (pll_changing)
+		s5pv210_target_APLL2MPLL(index, bus_speed_changing);
+
+	/* ARM MCS value changed */
+	if (index != L4) {
+		reg = __raw_readl(S5P_ARM_MCS_CON);
+		reg &= ~0x3;
+		reg |= 0x1;
+		__raw_writel(reg, S5P_ARM_MCS_CON);
+	}
+
+	reg = __raw_readl(S5P_CLK_DIV0);
+
+	reg &= ~(S5P_CLKDIV0_APLL_MASK | S5P_CLKDIV0_A2M_MASK
+			| S5P_CLKDIV0_HCLK200_MASK | S5P_CLKDIV0_PCLK100_MASK
+			| S5P_CLKDIV0_HCLK166_MASK | S5P_CLKDIV0_PCLK83_MASK
+			| S5P_CLKDIV0_HCLK133_MASK | S5P_CLKDIV0_PCLK66_MASK);
+
+	reg |= ((clkdiv_val[index][0]<<S5P_CLKDIV0_APLL_SHIFT)
+			| (clkdiv_val[index][1] << S5P_CLKDIV0_A2M_SHIFT)
+			| (clkdiv_val[index][2] << S5P_CLKDIV0_HCLK200_SHIFT)
+			| (clkdiv_val[index][3] << S5P_CLKDIV0_PCLK100_SHIFT)
+			| (clkdiv_val[index][4] << S5P_CLKDIV0_HCLK166_SHIFT)
+			| (clkdiv_val[index][5] << S5P_CLKDIV0_PCLK83_SHIFT)
+			| (clkdiv_val[index][6] << S5P_CLKDIV0_HCLK133_SHIFT)
+			| (clkdiv_val[index][7] << S5P_CLKDIV0_PCLK66_SHIFT));
+
+	__raw_writel(reg, S5P_CLK_DIV0);
+
+	do {
+		reg = __raw_readl(S5P_CLK_DIV_STAT0);
+	} while (reg & 0xff);
+
+	/* ARM MCS value changed */
+	if (index == L4) {
+		reg = __raw_readl(S5P_ARM_MCS_CON);
+		reg &= ~0x3;
+		reg |= 0x3;
+		__raw_writel(reg, S5P_ARM_MCS_CON);
+	}
+
+	if (pll_changing)
+		s5pv210_target_MPLL2APLL(index, bus_speed_changing);
+
+	/* L4 level need to change memory bus speed,
+	 * hence onedram clock divier and
+	 * memory refresh parameter should be changed
+	 */
+	if (bus_speed_changing) {
+		reg = __raw_readl(S5P_CLK_DIV6);
+		reg &= ~S5P_CLKDIV6_ONEDRAM_MASK;
+		reg |= (clkdiv_val[index][8] << S5P_CLKDIV6_ONEDRAM_SHIFT);
+		/* ONEDRAM Clock Divider Ratio: 7 for L4, 3 for Others */
+		__raw_writel(reg, S5P_CLK_DIV6);
+
+		do {
+			reg = __raw_readl(S5P_CLK_DIV_STAT1);
+		} while (reg & (1 << 15));
+
+		/* Reconfigure DRAM refresh counter value */
+		if (index != L4) {
+			/* DMC0: 166MHz
+			 * DMC1: 200MHz
+			 **/
+			__raw_writel(0x618, S5P_VA_DMC1 + 0x30);
+#if !defined(CONFIG_S5PC110_H_TYPE)
+			__raw_writel(0x50e, S5P_VA_DMC0 + 0x30);
+#else
+			__raw_writel(0x618, S5P_VA_DMC0 + 0x30);
+#endif
+		} else {
+			/* DMC0: 83MHz
+			 * DMC1: 100MHz
+			 **/
+			__raw_writel(0x30c, S5P_VA_DMC1 + 0x30);
+			__raw_writel(0x287, S5P_VA_DMC0 + 0x30);
+		}
+	}
+
+	if (s3c_freqs.freqs.new < s3c_freqs.freqs.old) {
+		/* Voltage down: decrease INT first.*/
+		if (!IS_ERR_OR_NULL(arm_regulator) &&
+				!IS_ERR_OR_NULL(internal_regulator)) {
+			regulator_set_voltage(internal_regulator,
+					int_volt, int_volt_max);
+			regulator_set_voltage(arm_regulator,
+					arm_volt, arm_volt_max);
+		}
+	}
+	cpufreq_notify_transition(&s3c_freqs.freqs, CPUFREQ_POSTCHANGE);
+
+	memcpy(&s3c_freqs.old, &s3c_freqs.new, sizeof(struct s3c_freq));
+	cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, KERN_INFO,
+			"cpufreq: Performance changed[L%d]\n", index);
+	previous_arm_volt = s5pv210_dvs_conf[index].arm_volt;
+out:
+	return ret;
+}
+
+
+#ifdef CONFIG_PM
+static int previous_frequency;
+
+static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy,
+		pm_message_t pmsg)
+{
+	int ret = 0;
+	pr_info("cpufreq: Entering suspend.\n");
+
+	previous_frequency = cpufreq_get(0);
+	ret = __cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
+			DISABLE_FURTHER_CPUFREQ);
+	return ret;
+}
+
+static int s5pv210_cpufreq_resume(struct cpufreq_policy *policy)
+{
+	int ret = 0;
+	u32 rate;
+	int level = CPUFREQ_TABLE_END;
+	int i;
+
+	pr_info("cpufreq: Waking up from a suspend.\n");
+
+	__cpufreq_driver_target(cpufreq_cpu_get(0), previous_frequency,
+			ENABLE_FURTHER_CPUFREQ);
+
+	/* Clock information update with wakeup value */
+	rate = clk_get_rate(mpu_clk);
+
+	i = 0;
+	while (s5pv210_freq_table[i].frequency != CPUFREQ_TABLE_END) {
+		if (s5pv210_freq_table[i].frequency * 1000 == rate) {
+			level = s5pv210_freq_table[i].index;
+			break;
+		}
+		i++;
+	}
+
+	if (level == CPUFREQ_TABLE_END) { /* Not found */
+		pr_err("[%s:%d] clock speed does not match: "
+				"%d. Using L1 of 800MHz.\n",
+				__FILE__, __LINE__, rate);
+		level = L1;
+	}
+
+	memcpy(&s3c_freqs.old, &s5pv210_clk_info[level],
+			sizeof(struct s3c_freq));
+	previous_arm_volt = s5pv210_dvs_conf[level].arm_volt;
+	return ret;
+}
+#endif
+
+
+static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
+{
+	u32 rate ;
+	int i, level = CPUFREQ_TABLE_END;
+
+	pr_info("S5PV210 CPUFREQ Initialising...\n");
+#ifdef CONFIG_PM
+	no_cpufreq_access = 0;
+#endif
+#ifdef CLK_OUT_PROBING
+	reg = __raw_readl(S5P_CLK_OUT);
+	reg &= ~(0x1f << 12 | 0xf << 20); /* CLKSEL and DIVVAL*/
+	reg |= (0xf << 12 | 0x1 << 20); /* CLKSEL = ARMCLK/4, DIVVAL = 1 */
+	/* Result = ARMCLK / 4 / ( 1 + 1 ) */
+	__raw_writel(reg, S5P_CLK_OUT);
+#endif
+	mpu_clk = clk_get(NULL, MPU_CLK);
+	if (IS_ERR(mpu_clk)) {
+		pr_err("S5PV210 CPUFREQ cannot get MPU_CLK(%s)\n",
+				MPU_CLK);
+		return PTR_ERR(mpu_clk);
+	}
+
+	if (policy->cpu != 0) {
+		pr_err("S5PV210 CPUFREQ cannot get proper cpu(%d)\n",
+				policy->cpu);
+		return -EINVAL;
+	}
+	policy->cur = policy->min = policy->max = s5pv210_getspeed(0);
+
+	cpufreq_frequency_table_get_attr(s5pv210_freq_table, policy->cpu);
+
+	policy->cpuinfo.transition_latency = 40000;	/*1us*/
+
+	rate = clk_get_rate(mpu_clk);
+	i = 0;
+
+	while (s5pv210_freq_table[i].frequency != CPUFREQ_TABLE_END) {
+		if (s5pv210_freq_table[i].frequency * 1000 == rate) {
+			level = s5pv210_freq_table[i].index;
+			break;
+		}
+		i++;
+	}
+
+	if (level == CPUFREQ_TABLE_END) { /* Not found */
+		pr_err("[%s:%d] clock speed does not match: "
+				"%d. Using L1 of 800MHz.\n",
+				__FILE__, __LINE__, rate);
+		level = L1;
+	}
+
+	memcpy(&s3c_freqs.old, &s5pv210_clk_info[level],
+			sizeof(struct s3c_freq));
+	previous_arm_volt = s5pv210_dvs_conf[level].arm_volt;
+
+	return cpufreq_frequency_table_cpuinfo(policy, s5pv210_freq_table);
+}
+
+static struct cpufreq_driver s5pv210_driver = {
+	.flags		= CPUFREQ_STICKY,
+	.verify		= s5pv210_verify_speed,
+	.target		= s5pv210_target,
+	.get		= s5pv210_getspeed,
+	.init		= s5pv210_cpu_init,
+	.name		= "s5pv210",
+#ifdef CONFIG_PM
+	.suspend	= s5pv210_cpufreq_suspend,
+	.resume		= s5pv210_cpufreq_resume,
+#endif
+};
+
+static int __init s5pv210_cpufreq_init(void)
+{
+	arm_regulator = regulator_get_exclusive(NULL, "vddarm");
+	if (IS_ERR(arm_regulator)) {
+		pr_err("failed to get regulater resource vddarm\n");
+		goto error;
+	}
+	internal_regulator = regulator_get_exclusive(NULL, "vddint");
+	if (IS_ERR(internal_regulator)) {
+		pr_err("failed to get regulater resource vddint\n");
+		goto error;
+	}
+	goto finish;
+error:
+	pr_warn("Cannot get vddarm or vddint. CPUFREQ Will not"
+		       " change the voltage.\n");
+finish:
+	return cpufreq_register_driver(&s5pv210_driver);
+}
+
+late_initcall(s5pv210_cpufreq_init);
diff --git a/arch/arm/mach-s5pv210/include/mach/cpu-freq.h b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
new file mode 100644
index 0000000..f957c90
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/cpu-freq.h
@@ -0,0 +1,51 @@
+/* arch/arm/mach-s5pv210/include/mach/cpu-freq.h
+ *
+ * Copyright (c) 2010 Samsung Electronics
+ *
+ *       MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * S5PV210/S5PC110 CPU frequency scaling support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_
+#define _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_
+
+#include <linux/cpufreq.h>
+
+#ifdef CONFIG_CPU_S5PV210
+
+#define USE_FREQ_TABLE
+
+#define KHZ_T           1000
+
+#define MPU_CLK         "armclk"
+
+enum perf_level {
+	L0 = 0,
+	L1,
+	L2,
+	L3,
+	L4,
+};
+
+/* APLL,HCLK_MSYS,PCLK_MSYS mask value */
+#define CLK_DIV0_MASK   ((0x7<<0)|(0x7<<8)|(0x7<<12))
+
+#ifdef CONFIG_PM
+#define SLEEP_FREQ      (800 * 1000) /* Use 800MHz when entering sleep */
+
+/* additional symantics for "relation" in cpufreq with pm */
+#define DISABLE_FURTHER_CPUFREQ         0x10
+#define ENABLE_FURTHER_CPUFREQ          0x20
+#define MASK_FURTHER_CPUFREQ            0x30
+/* With 0x00(NOCHANGE), it depends on the previous "further" status */
+
+#endif
+
+
+#endif /* CONFIG_CPU_S5PV210 */
+#endif /* _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_ */
-- 
1.6.3.3
