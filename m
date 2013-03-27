From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 14:01:34 +0100
Subject: [PATCH v2 5/5] ARM: imx: Remove cpufreq driver
In-Reply-To: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1364389294-1997-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old cpufreq driver is not necessary anymore with DT and
cpufreq-cpu0.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/Kconfig                      |   7 --
 arch/arm/mach-imx/Makefile            |   1 -
 arch/arm/mach-imx/cpu_op-mx51.c       |  31 -----
 arch/arm/mach-imx/cpu_op-mx51.h       |  14 ---
 arch/arm/mach-imx/cpufreq.c           | 206 ----------------------------------
 arch/arm/mach-imx/mach-cpuimx51sd.c   |   5 -
 arch/arm/mach-imx/mach-mx51_babbage.c |   4 -
 7 files changed, 268 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cpu_op-mx51.c
 delete mode 100644 arch/arm/mach-imx/cpu_op-mx51.h
 delete mode 100644 arch/arm/mach-imx/cpufreq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13b7394..c5ed84c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2153,13 +2153,6 @@ if ARCH_HAS_CPUFREQ
 
 source "drivers/cpufreq/Kconfig"
 
-config CPU_FREQ_IMX
-	tristate "CPUfreq driver for i.MX CPUs"
-	depends on ARCH_MXC && CPU_FREQ
-	select CPU_FREQ_TABLE
-	help
-	  This enables the CPUfreq driver for i.MX CPUs.
-
 config CPU_FREQ_SA1100
 	bool
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..e313433 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_IRAM_ALLOC) += iram_alloc.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
-obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-y += cpuidle.o
diff --git a/arch/arm/mach-imx/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
deleted file mode 100644
index b9ef692..0000000
--- a/arch/arm/mach-imx/cpu_op-mx51.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/bug.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-
-#include "hardware.h"
-
-static struct cpu_op mx51_cpu_op[] = {
-	{
-	.cpu_rate = 160000000,},
-	{
-	.cpu_rate = 800000000,},
-};
-
-struct cpu_op *mx51_get_cpu_op(int *op)
-{
-	*op = ARRAY_SIZE(mx51_cpu_op);
-	return mx51_cpu_op;
-}
diff --git a/arch/arm/mach-imx/cpu_op-mx51.h b/arch/arm/mach-imx/cpu_op-mx51.h
deleted file mode 100644
index 97477fe..0000000
--- a/arch/arm/mach-imx/cpu_op-mx51.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-extern struct cpu_op *mx51_get_cpu_op(int *op);
diff --git a/arch/arm/mach-imx/cpufreq.c b/arch/arm/mach-imx/cpufreq.c
deleted file mode 100644
index d8c75c3..0000000
--- a/arch/arm/mach-imx/cpufreq.c
+++ /dev/null
@@ -1,206 +0,0 @@
-/*
- * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/*
- * A driver for the Freescale Semiconductor i.MXC CPUfreq module.
- * The CPUFREQ driver is for controlling CPU frequency. It allows you to change
- * the CPU clock speed on the fly.
- */
-
-#include <linux/module.h>
-#include <linux/cpufreq.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-
-#include "hardware.h"
-
-#define CLK32_FREQ	32768
-#define NANOSECOND	(1000 * 1000 * 1000)
-
-struct cpu_op *(*get_cpu_op)(int *op);
-
-static int cpu_freq_khz_min;
-static int cpu_freq_khz_max;
-
-static struct clk *cpu_clk;
-static struct cpufreq_frequency_table *imx_freq_table;
-
-static int cpu_op_nr;
-static struct cpu_op *cpu_op_tbl;
-
-static int set_cpu_freq(int freq)
-{
-	int ret = 0;
-	int org_cpu_rate;
-
-	org_cpu_rate = clk_get_rate(cpu_clk);
-	if (org_cpu_rate == freq)
-		return ret;
-
-	ret = clk_set_rate(cpu_clk, freq);
-	if (ret != 0) {
-		printk(KERN_DEBUG "cannot set CPU clock rate\n");
-		return ret;
-	}
-
-	return ret;
-}
-
-static int mxc_verify_speed(struct cpufreq_policy *policy)
-{
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	return cpufreq_frequency_table_verify(policy, imx_freq_table);
-}
-
-static unsigned int mxc_get_speed(unsigned int cpu)
-{
-	if (cpu)
-		return 0;
-
-	return clk_get_rate(cpu_clk) / 1000;
-}
-
-static int mxc_set_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq, unsigned int relation)
-{
-	struct cpufreq_freqs freqs;
-	int freq_Hz;
-	int ret = 0;
-	unsigned int index;
-
-	cpufreq_frequency_table_target(policy, imx_freq_table,
-			target_freq, relation, &index);
-	freq_Hz = imx_freq_table[index].frequency * 1000;
-
-	freqs.old = clk_get_rate(cpu_clk) / 1000;
-	freqs.new = freq_Hz / 1000;
-	freqs.cpu = 0;
-	freqs.flags = 0;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-
-	ret = set_cpu_freq(freq_Hz);
-
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-
-	return ret;
-}
-
-static int mxc_cpufreq_init(struct cpufreq_policy *policy)
-{
-	int ret;
-	int i;
-
-	printk(KERN_INFO "i.MXC CPU frequency driver\n");
-
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	if (!get_cpu_op)
-		return -EINVAL;
-
-	cpu_clk = clk_get(NULL, "cpu_clk");
-	if (IS_ERR(cpu_clk)) {
-		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
-		return PTR_ERR(cpu_clk);
-	}
-
-	cpu_op_tbl = get_cpu_op(&cpu_op_nr);
-
-	cpu_freq_khz_min = cpu_op_tbl[0].cpu_rate / 1000;
-	cpu_freq_khz_max = cpu_op_tbl[0].cpu_rate / 1000;
-
-	imx_freq_table = kmalloc(
-		sizeof(struct cpufreq_frequency_table) * (cpu_op_nr + 1),
-			GFP_KERNEL);
-	if (!imx_freq_table) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	for (i = 0; i < cpu_op_nr; i++) {
-		imx_freq_table[i].index = i;
-		imx_freq_table[i].frequency = cpu_op_tbl[i].cpu_rate / 1000;
-
-		if ((cpu_op_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
-			cpu_freq_khz_min = cpu_op_tbl[i].cpu_rate / 1000;
-
-		if ((cpu_op_tbl[i].cpu_rate / 1000) > cpu_freq_khz_max)
-			cpu_freq_khz_max = cpu_op_tbl[i].cpu_rate / 1000;
-	}
-
-	imx_freq_table[i].index = i;
-	imx_freq_table[i].frequency = CPUFREQ_TABLE_END;
-
-	policy->cur = clk_get_rate(cpu_clk) / 1000;
-	policy->min = policy->cpuinfo.min_freq = cpu_freq_khz_min;
-	policy->max = policy->cpuinfo.max_freq = cpu_freq_khz_max;
-
-	/* Manual states, that PLL stabilizes in two CLK32 periods */
-	policy->cpuinfo.transition_latency = 2 * NANOSECOND / CLK32_FREQ;
-
-	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
-
-	if (ret < 0) {
-		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
-		       __func__, ret);
-		goto err;
-	}
-
-	cpufreq_frequency_table_get_attr(imx_freq_table, policy->cpu);
-	return 0;
-err:
-	kfree(imx_freq_table);
-err1:
-	clk_put(cpu_clk);
-	return ret;
-}
-
-static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-
-	set_cpu_freq(cpu_freq_khz_max * 1000);
-	clk_put(cpu_clk);
-	kfree(imx_freq_table);
-	return 0;
-}
-
-static struct cpufreq_driver mxc_driver = {
-	.flags = CPUFREQ_STICKY,
-	.verify = mxc_verify_speed,
-	.target = mxc_set_target,
-	.get = mxc_get_speed,
-	.init = mxc_cpufreq_init,
-	.exit = mxc_cpufreq_exit,
-	.name = "imx",
-};
-
-static int mxc_cpufreq_driver_init(void)
-{
-	return cpufreq_register_driver(&mxc_driver);
-}
-
-static void mxc_cpufreq_driver_exit(void)
-{
-	cpufreq_unregister_driver(&mxc_driver);
-}
-
-module_init(mxc_cpufreq_driver_init);
-module_exit(mxc_cpufreq_driver_exit);
-
-MODULE_AUTHOR("Freescale Semiconductor Inc. Yong Shen <yong.shen@linaro.org>");
-MODULE_DESCRIPTION("CPUfreq driver for i.MX");
-MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 9b73932..9b5ddf5 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -33,7 +33,6 @@
 
 #include "common.h"
 #include "devices-imx51.h"
-#include "cpu_op-mx51.h"
 #include "eukrea-baseboards.h"
 #include "hardware.h"
 #include "iomux-mx51.h"
@@ -285,10 +284,6 @@ static void __init eukrea_cpuimx51sd_init(void)
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51sd_pads,
 					ARRAY_SIZE(eukrea_cpuimx51sd_pads));
 
-#if defined(CONFIG_CPU_FREQ_IMX)
-	get_cpu_op = mx51_get_cpu_op;
-#endif
-
 	imx51_add_imx_uart(0, &uart_pdata);
 	imx51_add_mxc_nand(&eukrea_cpuimx51sd_nand_board_info);
 	imx51_add_imx2_wdt(0);
diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index 6c4d7fe..f3d264a 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -27,7 +27,6 @@
 
 #include "common.h"
 #include "devices-imx51.h"
-#include "cpu_op-mx51.h"
 #include "hardware.h"
 #include "iomux-mx51.h"
 
@@ -371,9 +370,6 @@ static void __init mx51_babbage_init(void)
 
 	imx51_soc_init();
 
-#if defined(CONFIG_CPU_FREQ_IMX)
-	get_cpu_op = mx51_get_cpu_op;
-#endif
 	imx51_babbage_common_init();
 
 	imx51_add_imx_uart(0, &uart_pdata);
-- 
1.8.1.5
