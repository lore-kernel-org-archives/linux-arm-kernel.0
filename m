From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Tue,  5 Oct 2010 19:58:24 +0800
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <1286279904-4378-1-git-send-email-yong.shen@linaro.org>
References: <1286279904-4378-1-git-send-email-yong.shen@linaro.org>
Message-ID: <1286279904-4378-2-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@linaro.org>

it is tested on babbage 3.0

Signed-off-by: Yong Shen <yong.shen@linaro.org>
---
 arch/arm/Kconfig                       |    6 +
 arch/arm/mach-mx5/Kconfig              |    1 +
 arch/arm/mach-mx5/Makefile             |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c |    7 +-
 arch/arm/mach-mx5/clock-mx51.c         |   53 +++++++
 arch/arm/mach-mx5/cpu_wp-mx51.c        |   43 ++++++
 arch/arm/plat-mxc/Makefile             |    2 +
 arch/arm/plat-mxc/cpufreq.c            |  254 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mxc.h   |   22 +++-
 9 files changed, 387 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpu_wp-mx51.c
 create mode 100644 arch/arm/plat-mxc/cpufreq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4db064e..64ebbc0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1517,6 +1517,12 @@ if ARCH_HAS_CPUFREQ
 
 source "drivers/cpufreq/Kconfig"
 
+config CPU_FREQ_IMX
+	tristate "CPUfreq driver for i.MX CPUs"
+	depends on ARCH_MXC && CPU_FREQ
+	help
+	This enables the CPUfreq driver for i.MX CPUs.
+
 config CPU_FREQ_SA1100
 	bool
 
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 1576d51..5956fee 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -5,6 +5,7 @@ config ARCH_MX51
 	default y
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
+	select ARCH_HAS_CPUFREQ
 
 comment "MX5 platforms:"
 
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index bf23f86..aaa13f8 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Object file lists.
-obj-y   := cpu.o mm.o clock-mx51.o devices.o
+obj-y   := cpu.o mm.o clock-mx51.o devices.o cpu_wp-mx51.o
 
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ed885f9..038760c 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
  *
  * The code contained herein is licensed under the GNU General Public
@@ -43,6 +43,10 @@
 #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
 #define	MX51_USB_PLL_DIV_24_MHZ	0x02
 
+
+extern struct cpu_wp *mx51_get_cpu_wp(int *wp);
+struct cpu_wp *(*get_cpu_wp)(int *wp);
+
 static struct platform_device *devices[] __initdata = {
 	&mxc_fec_device,
 };
@@ -246,6 +250,7 @@ static void __init mxc_board_init(void)
 
 static void __init mx51_babbage_timer_init(void)
 {
+	get_cpu_wp = mx51_get_cpu_wp;
 	mx51_clocks_init(32768, 24000000, 22579200, 0);
 }
 
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index d9f612d..f2488e6 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/time.h>
 
 #include <asm/clkdev.h>
 #include <asm/div64.h>
@@ -28,6 +29,11 @@
 static unsigned long external_high_reference, external_low_reference;
 static unsigned long oscillator_reference, ckih2_reference;
 
+extern struct cpu_wp *(*get_cpu_wp)(int *wp);
+static int cpu_wp_nr;
+static int cpu_curr_wp;
+static struct cpu_wp *cpu_wp_tbl;
+
 static struct clk osc_clk;
 static struct clk pll1_main_clk;
 static struct clk pll1_sw_clk;
@@ -38,7 +44,9 @@ static struct clk periph_apm_clk;
 static struct clk ahb_clk;
 static struct clk ipg_clk;
 static struct clk usboh3_clk;
+static void __iomem *pll1_base;
 
+#define SPIN_DELAY	1000000 /* in nanoseconds */
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
 static int _clk_ccgr_enable(struct clk *clk)
@@ -330,6 +338,32 @@ static int _clk_lp_apm_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
+/*!
+ * Setup cpu clock based on working point.
+ * @param	wp	cpu freq working point
+ * @return		0 on success or error code on failure.
+ */
+int cpu_clk_set_wp(int wp)
+{
+	struct cpu_wp *p;
+	u32 reg;
+
+	if (wp == cpu_curr_wp)
+		return 0;
+
+	p = &cpu_wp_tbl[wp];
+
+	/*use post divider to change freq
+	 */
+	reg = __raw_readl(MXC_CCM_CACRR);
+	reg &= ~MXC_CCM_CACRR_ARM_PODF_MASK;
+	reg |= cpu_wp_tbl[wp].cpu_podf << MXC_CCM_CACRR_ARM_PODF_OFFSET;
+	__raw_writel(reg, MXC_CCM_CACRR);
+	cpu_curr_wp = wp;
+
+	return 0;
+}
+
 static unsigned long clk_arm_get_rate(struct clk *clk)
 {
 	u32 cacrr, div;
@@ -342,6 +376,20 @@ static unsigned long clk_arm_get_rate(struct clk *clk)
 	return parent_rate / div;
 }
 
+int _clk_cpu_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 i;
+	for (i = 0; i < cpu_wp_nr; i++) {
+		if (rate == cpu_wp_tbl[i].cpu_rate)
+			break;
+	}
+	if (i >= cpu_wp_nr)
+		return -EINVAL;
+	cpu_clk_set_wp(i);
+
+	return 0;
+}
+
 static int _clk_periph_apm_set_parent(struct clk *clk, struct clk *parent)
 {
 	u32 reg, mux;
@@ -694,6 +742,7 @@ static struct clk periph_apm_clk = {
 static struct clk cpu_clk = {
 	.parent = &pll1_sw_clk,
 	.get_rate = clk_arm_get_rate,
+	.set_rate = _clk_cpu_set_rate,
 };
 
 static struct clk ahb_clk = {
@@ -821,6 +870,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
+	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
 };
 
 static void clk_tree_init(void)
@@ -848,10 +898,13 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 {
 	int i;
 
+	pll1_base = ioremap(MX51_PLL1_BASE_ADDR, SZ_4K);
+
 	external_low_reference = ckil;
 	external_high_reference = ckih1;
 	ckih2_reference = ckih2;
 	oscillator_reference = osc;
+	cpu_wp_tbl = get_cpu_wp(&cpu_wp_nr);
 
 	for (i = 0; i < ARRAY_SIZE(lookups); i++)
 		clkdev_add(&lookups[i]);
diff --git a/arch/arm/mach-mx5/cpu_wp-mx51.c b/arch/arm/mach-mx5/cpu_wp-mx51.c
new file mode 100644
index 0000000..53f3de3
--- /dev/null
+++ b/arch/arm/mach-mx5/cpu_wp-mx51.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/types.h>
+#include <mach/hardware.h>
+
+/* working point(wp): 0 - 800MHz; 1 - 166.25MHz; */
+static struct cpu_wp cpu_wp_auto[] = {
+	{
+	.pll_rate = 800000000,
+	.cpu_rate = 160000000,
+	.pdf = 4,
+	.mfi = 8,
+	.mfd = 2,
+	.mfn = 1,
+	.cpu_podf = 4,
+	.cpu_voltage = 850000,},
+	{
+	.pll_rate = 800000000,
+	.cpu_rate = 800000000,
+	.pdf = 0,
+	.mfi = 8,
+	.mfd = 2,
+	.mfn = 1,
+	.cpu_podf = 0,
+	.cpu_voltage = 1100000,},
+};
+
+struct cpu_wp *mx51_get_cpu_wp(int *wp)
+{
+	*wp = sizeof(cpu_wp_auto) / sizeof(struct cpu_wp);
+	return cpu_wp_auto;
+}
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 895bc3c..c1bb400 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
+# CPU FREQ support
+obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
new file mode 100644
index 0000000..2e67c0a
--- /dev/null
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -0,0 +1,254 @@
+/*
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/*
+ * A driver for the Freescale Semiconductor i.MXC CPUfreq module.
+ * The CPUFREQ driver is for controling CPU frequency. It allows you to change
+ * the CPU clock speed on the fly.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/regulator/consumer.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <asm/setup.h>
+#include <mach/clock.h>
+#include <asm/cacheflush.h>
+#include <linux/hrtimer.h>
+
+int cpu_freq_khz_min;
+int cpu_freq_khz_max;
+int arm_lpm_clk;
+int arm_normal_clk;
+int cpufreq_suspended;
+int cpufreq_trig_needed;
+
+static struct clk *cpu_clk;
+static struct cpufreq_frequency_table imx_freq_table[4];
+
+extern int set_low_bus_freq(void);
+extern int set_high_bus_freq(int high_bus_speed);
+extern int low_freq_bus_used(void);
+
+extern struct cpu_wp *(*get_cpu_wp)(int *wp);
+static int cpu_wp_nr;
+static struct cpu_wp *cpu_wp_tbl;
+
+int set_cpu_freq(int freq)
+{
+	int ret = 0;
+	int org_cpu_rate;
+	int gp_volt = 0;
+	int i;
+
+	org_cpu_rate = clk_get_rate(cpu_clk);
+	if (org_cpu_rate == freq)
+		return ret;
+
+	for (i = 0; i < cpu_wp_nr; i++) {
+		if (freq == cpu_wp_tbl[i].cpu_rate)
+			gp_volt = cpu_wp_tbl[i].cpu_voltage;
+	}
+
+	if (gp_volt == 0)
+		return ret;
+
+	ret = clk_set_rate(cpu_clk, freq);
+	if (ret != 0) {
+		printk(KERN_DEBUG "cannot set CPU clock rate\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int mxc_verify_speed(struct cpufreq_policy *policy)
+{
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	return cpufreq_frequency_table_verify(policy, imx_freq_table);
+}
+
+static unsigned int mxc_get_speed(unsigned int cpu)
+{
+	if (cpu)
+		return 0;
+
+	return clk_get_rate(cpu_clk) / 1000;
+}
+
+static int calc_frequency_khz(int target, unsigned int relation)
+{
+	int i;
+
+	if ((target * 1000) == clk_get_rate(cpu_clk))
+		return target;
+
+	if (relation == CPUFREQ_RELATION_H) {
+		for (i = cpu_wp_nr - 1; i >= 0; i--) {
+			if (imx_freq_table[i].frequency <= target)
+				return imx_freq_table[i].frequency;
+		}
+	} else if (relation == CPUFREQ_RELATION_L) {
+		for (i = 0; i < cpu_wp_nr; i++) {
+			if (imx_freq_table[i].frequency >= target)
+				return imx_freq_table[i].frequency;
+		}
+	}
+	printk(KERN_ERR "Error: No valid cpufreq relation\n");
+	return cpu_freq_khz_max;
+}
+
+static int mxc_set_target(struct cpufreq_policy *policy,
+			  unsigned int target_freq, unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	int freq_Hz;
+	int ret = 0;
+
+	if (cpufreq_suspended) {
+		target_freq = clk_get_rate(cpu_clk) / 1000;
+		freq_Hz = calc_frequency_khz(target_freq, relation) * 1000;
+		if (freq_Hz == arm_lpm_clk)
+			freqs.old = cpu_wp_tbl[cpu_wp_nr - 2].cpu_rate / 1000;
+		else
+			freqs.old = arm_lpm_clk / 1000;
+
+		freqs.new = freq_Hz / 1000;
+		freqs.cpu = 0;
+		freqs.flags = 0;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		return ret;
+	}
+
+	freq_Hz = calc_frequency_khz(target_freq, relation) * 1000;
+
+	freqs.old = clk_get_rate(cpu_clk) / 1000;
+	freqs.new = freq_Hz / 1000;
+	freqs.cpu = 0;
+	freqs.flags = 0;
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	if (freqs.old != freqs.new)
+		ret = set_cpu_freq(freq_Hz);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return ret;
+}
+
+static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret;
+	int i;
+
+	printk(KERN_INFO "i.MXC CPU frequency driver\n");
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	cpu_clk = clk_get(NULL, "cpu_clk");
+	if (IS_ERR(cpu_clk)) {
+		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
+		return PTR_ERR(cpu_clk);
+	}
+
+	/* Set the current working point. */
+	cpu_wp_tbl = get_cpu_wp(&cpu_wp_nr);
+
+	cpu_freq_khz_min = cpu_wp_tbl[0].cpu_rate / 1000;
+	cpu_freq_khz_max = cpu_wp_tbl[0].cpu_rate / 1000;
+
+	for (i = 0; i < cpu_wp_nr; i++) {
+		imx_freq_table[i].index = i;
+		imx_freq_table[i].frequency =
+		    cpu_wp_tbl[i].cpu_rate / 1000;
+
+		if ((cpu_wp_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
+			cpu_freq_khz_min = cpu_wp_tbl[i].cpu_rate / 1000;
+
+		if ((cpu_wp_tbl[i].cpu_rate / 1000) > cpu_freq_khz_max)
+			cpu_freq_khz_max = cpu_wp_tbl[i].cpu_rate / 1000;
+	}
+
+	imx_freq_table[i].index = i;
+	imx_freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	policy->cur = clk_get_rate(cpu_clk) / 1000;
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	policy->min = policy->cpuinfo.min_freq = cpu_freq_khz_min;
+	policy->max = policy->cpuinfo.max_freq = cpu_freq_khz_max;
+
+	arm_lpm_clk = cpu_freq_khz_min * 1000;
+	arm_normal_clk = cpu_freq_khz_max * 1000;
+
+	/* Manual states, that PLL stabilizes in two CLK32 periods */
+	policy->cpuinfo.transition_latency = 10;
+
+	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
+
+	if (ret < 0) {
+		clk_put(cpu_clk);
+		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq\n",
+		       __func__);
+		return ret;
+	}
+
+	cpufreq_frequency_table_get_attr(imx_freq_table, policy->cpu);
+	return 0;
+}
+
+static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+
+	/* Reset CPU to 665MHz */
+	set_cpu_freq(arm_normal_clk);
+	clk_put(cpu_clk);
+	return 0;
+}
+
+static struct cpufreq_driver mxc_driver = {
+	.flags = CPUFREQ_STICKY,
+	.verify = mxc_verify_speed,
+	.target = mxc_set_target,
+	.get = mxc_get_speed,
+	.init = mxc_cpufreq_init,
+	.exit = mxc_cpufreq_exit,
+	.name = "imx",
+};
+
+static int __devinit mxc_cpufreq_driver_init(void)
+{
+	return cpufreq_register_driver(&mxc_driver);
+}
+
+static void mxc_cpufreq_driver_exit(void)
+{
+	cpufreq_unregister_driver(&mxc_driver);
+}
+
+module_init(mxc_cpufreq_driver_init);
+module_exit(mxc_cpufreq_driver_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("CPUfreq driver for i.MX");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index a790bf2..868655b 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
  * This program is free software; you can redistribute it and/or
@@ -133,6 +133,26 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mxc91231()	(0)
 #endif
 
+#ifndef __ASSEMBLY__
+
+struct cpu_wp {
+	u32 pll_reg;
+	u32 pll_rate;
+	u32 cpu_rate;
+	u32 pdr0_reg;
+	u32 pdf;
+	u32 mfi;
+	u32 mfd;
+	u32 mfn;
+	u32 cpu_voltage;
+	u32 cpu_podf;
+};
+
+#ifndef CONFIG_ARCH_MX5
+struct cpu_wp *get_cpu_wp(int *wp);
+#endif
+#endif
+
 #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
 /* These are deprecated, use mx[23][157]_setup_weimcs instead. */
 #define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
-- 
1.6.3.3
