From: ta.omasab@gmail.com (Thomas Abraham)
Date: Thu,  9 Jan 2014 21:29:23 +0530
Subject: [PATCH 4/6] cpufreq: exynos: remove Exynos4210 specific cpufreq
 driver support
In-Reply-To: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1389283165-17708-5-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos4210 specific cpufreq driver performs read/write operations
of clock controller registers bypassing the Exynos common clock
framework driver. This could lead to potential issues if CCF and
cpufreq driver modify the clock registers independently of each other.
In addition to this, the generic cpufreq-cpu0 driver is sufficient
for Exynos4210 based platforms since this SoC uses a single clock
and voltage line for both the ARM cores. So remove the support for
Exynos4210 specific cpufreq driver and use cpufreq-cpu0 driver
for Exynos4210 platforms

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/cpufreq/Kconfig.arm          |   11 ---
 drivers/cpufreq/Makefile             |    1 -
 drivers/cpufreq/exynos-cpufreq.c     |    4 +-
 drivers/cpufreq/exynos-cpufreq.h     |    8 --
 drivers/cpufreq/exynos4210-cpufreq.c |  157 ----------------------------------
 5 files changed, 1 insertions(+), 180 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0468ad1..0a2a589 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -19,17 +19,6 @@ config ARM_DT_BL_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	bool
 
-config ARM_EXYNOS4210_CPUFREQ
-	bool "SAMSUNG EXYNOS4210"
-	depends on CPU_EXYNOS4210
-	default y
-	select ARM_EXYNOS_CPUFREQ
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS4210
-	  SoC (S5PV310 or S5PC210).
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 7494565..ce2abf9 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -50,7 +50,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 4ee3804..eacc7eb 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -237,9 +237,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	if (!exynos_info)
 		return -ENOMEM;
 
-	if (soc_is_exynos4210())
-		ret = exynos4210_cpufreq_init(exynos_info);
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
+	if (soc_is_exynos4212() || soc_is_exynos4412())
 		ret = exynos4x12_cpufreq_init(exynos_info);
 	else if (soc_is_exynos5250())
 		ret = exynos5250_cpufreq_init(exynos_info);
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 3ddade8..1e0afbe 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -43,14 +43,6 @@ struct exynos_dvfs_info {
 	bool (*need_apll_change)(unsigned int, unsigned int);
 };
 
-#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
-extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
-#else
-static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
-{
-	return -EOPNOTSUPP;
-}
-#endif
 #ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
 extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
 #else
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
deleted file mode 100644
index 40d84c4..0000000
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4210 - CPU frequency scaling support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/cpufreq.h>
-
-#include "exynos-cpufreq.h"
-
-static struct clk *cpu_clk;
-static struct clk *moutcore;
-static struct clk *mout_mpll;
-static struct clk *mout_apll;
-
-static unsigned int exynos4210_volt_table[] = {
-	1250000, 1150000, 1050000, 975000, 950000,
-};
-
-static struct cpufreq_frequency_table exynos4210_freq_table[] = {
-	{L0, 1200 * 1000},
-	{L1, 1000 * 1000},
-	{L2,  800 * 1000},
-	{L3,  500 * 1000},
-	{L4,  200 * 1000},
-	{0, CPUFREQ_TABLE_END},
-};
-
-static struct apll_freq apll_freq_4210[] = {
-	/*
-	 * values:
-	 * freq
-	 * clock divider for CORE, COREM0, COREM1, PERIPH, ATB, PCLK_DBG, APLL, RESERVED
-	 * clock divider for COPY, HPM, RESERVED
-	 * PLL M, P, S
-	 */
-	APLL_FREQ(1200, 0, 3, 7, 3, 4, 1, 7, 0, 5, 0, 0, 150, 3, 1),
-	APLL_FREQ(1000, 0, 3, 7, 3, 4, 1, 7, 0, 4, 0, 0, 250, 6, 1),
-	APLL_FREQ(800,  0, 3, 7, 3, 3, 1, 7, 0, 3, 0, 0, 200, 6, 1),
-	APLL_FREQ(500,  0, 3, 7, 3, 3, 1, 7, 0, 3, 0, 0, 250, 6, 2),
-	APLL_FREQ(200,  0, 1, 3, 1, 3, 1, 0, 0, 3, 0, 0, 200, 6, 3),
-};
-
-static void exynos4210_set_clkdiv(unsigned int div_index)
-{
-	unsigned int tmp;
-
-	/* Change Divider - CPU0 */
-
-	tmp = apll_freq_4210[div_index].clk_div_cpu0;
-
-	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
-
-	do {
-		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU);
-	} while (tmp & 0x1111111);
-
-	/* Change Divider - CPU1 */
-
-	tmp = apll_freq_4210[div_index].clk_div_cpu1;
-
-	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
-
-	do {
-		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU1);
-	} while (tmp & 0x11);
-}
-
-static void exynos4210_set_apll(unsigned int index)
-{
-	unsigned int tmp, freq = apll_freq_4210[index].freq;
-
-	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
-	clk_set_parent(moutcore, mout_mpll);
-
-	do {
-		tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
-			>> EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
-		tmp &= 0x7;
-	} while (tmp != 0x2);
-
-	clk_set_rate(mout_apll, freq * 1000);
-
-	/* MUX_CORE_SEL = APLL */
-	clk_set_parent(moutcore, mout_apll);
-
-	do {
-		tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
-		tmp &= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
-	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
-}
-
-static void exynos4210_set_frequency(unsigned int old_index,
-				     unsigned int new_index)
-{
-	if (old_index > new_index) {
-		exynos4210_set_clkdiv(new_index);
-		exynos4210_set_apll(new_index);
-	} else if (old_index < new_index) {
-		exynos4210_set_apll(new_index);
-		exynos4210_set_clkdiv(new_index);
-	}
-}
-
-int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
-{
-	unsigned long rate;
-
-	cpu_clk = clk_get(NULL, "armclk");
-	if (IS_ERR(cpu_clk))
-		return PTR_ERR(cpu_clk);
-
-	moutcore = clk_get(NULL, "moutcore");
-	if (IS_ERR(moutcore))
-		goto err_moutcore;
-
-	mout_mpll = clk_get(NULL, "mout_mpll");
-	if (IS_ERR(mout_mpll))
-		goto err_mout_mpll;
-
-	rate = clk_get_rate(mout_mpll) / 1000;
-
-	mout_apll = clk_get(NULL, "mout_apll");
-	if (IS_ERR(mout_apll))
-		goto err_mout_apll;
-
-	info->mpll_freq_khz = rate;
-	/* 800Mhz */
-	info->pll_safe_idx = L2;
-	info->cpu_clk = cpu_clk;
-	info->volt_table = exynos4210_volt_table;
-	info->freq_table = exynos4210_freq_table;
-	info->set_freq = exynos4210_set_frequency;
-
-	return 0;
-
-err_mout_apll:
-	clk_put(mout_mpll);
-err_mout_mpll:
-	clk_put(moutcore);
-err_moutcore:
-	clk_put(cpu_clk);
-
-	pr_debug("%s: failed initialization\n", __func__);
-	return -EINVAL;
-}
-- 
1.6.6.rc2
