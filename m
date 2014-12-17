From: b20788@freescale.com (Anson Huang)
Date: Wed, 17 Dec 2014 12:24:12 +0800
Subject: [PATCH V2] ARM: imx: support arm power off in cpuidle for i.mx6sx
Message-ID: <1418790252-12947-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces an independent cpuidle driver for
i.MX6SX, and supports arm power off in idle, totally
3 levels of cpuidle are supported as below:

1. ARM WFI;
2. SOC in WAIT mode;
3. SOC in WAIT mode + ARM power off.

ARM power off can save at least 5mW power.

This patch also replaces imx6q_enable_rbc with imx6_enable_rbc.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
changes since V1:
	replace imx6q_enable_rbc with imx6_enable_rbc.
 arch/arm/mach-imx/Makefile         |   3 +-
 arch/arm/mach-imx/common.h         |   4 ++
 arch/arm/mach-imx/cpuidle-imx6sx.c | 107 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h        |   5 ++
 arch/arm/mach-imx/gpc.c            |  25 ++++++++-
 arch/arm/mach-imx/mach-imx6sx.c    |   2 +-
 arch/arm/mach-imx/pm-imx6.c        |   6 +--
 7 files changed, 144 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6sx.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index f5ac685..8d1b101 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -32,8 +32,7 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
-# i.MX6SX reuses i.MX6Q cpuidle driver
-obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6q.o
+obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 endif
 
 ifdef CONFIG_SND_IMX_SOC
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 59ce8f3..ea82dc1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -70,6 +70,10 @@ void imx_set_soc_revision(unsigned int rev);
 unsigned int imx_get_soc_revision(void);
 void imx_init_revision_from_anatop(void);
 struct device *imx_soc_device_init(void);
+void imx6_enable_rbc(bool enable);
+void imx_gpc_set_arm_power_in_lpm(bool power_off);
+void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
+void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
new file mode 100644
index 0000000..d8a9f21
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+
+#include "common.h"
+#include "cpuidle.h"
+
+static int imx6sx_idle_finish(unsigned long val)
+{
+	cpu_do_idle();
+
+	return 0;
+}
+
+static int imx6sx_enter_wait(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	imx6q_set_lpm(WAIT_UNCLOCKED);
+
+	switch (index) {
+	case 1:
+		cpu_do_idle();
+		break;
+	case 2:
+		imx6_enable_rbc(true);
+		imx_gpc_set_arm_power_in_lpm(true);
+		imx_set_cpu_jump(0, v7_cpu_resume);
+		/* Need to notify there is a cpu pm operation. */
+		cpu_pm_enter();
+		cpu_cluster_pm_enter();
+
+		cpu_suspend(0, imx6sx_idle_finish);
+
+		cpu_cluster_pm_exit();
+		cpu_pm_exit();
+		imx_gpc_set_arm_power_in_lpm(false);
+		imx6_enable_rbc(false);
+		break;
+	default:
+		break;
+	}
+
+	imx6q_set_lpm(WAIT_CLOCKED);
+
+	return index;
+}
+
+static struct cpuidle_driver imx6sx_cpuidle_driver = {
+	.name = "imx6sx_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency = 50,
+			.target_residency = 75,
+			.flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_TIMER_STOP,
+			.enter = imx6sx_enter_wait,
+			.name = "WAIT",
+			.desc = "Clock off",
+		},
+		/* WAIT + ARM power off  */
+		{
+			/*
+			 * ARM gating 31us * 5 + RBC clear 65us
+			 * and some margin for SW execution, here set it
+			 * to 300us.
+			 */
+			.exit_latency = 300,
+			.target_residency = 500,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = imx6sx_enter_wait,
+			.name = "LOW-POWER-IDLE",
+			.desc = "ARM power off",
+		},
+	},
+	.state_count = 3,
+	.safe_state_index = 0,
+};
+
+int __init imx6sx_cpuidle_init(void)
+{
+	imx6_enable_rbc(false);
+	/*
+	 * set ARM power up/down timing to the fastest,
+	 * sw2iso and sw can be set to one 32K cycle = 31us
+	 * except for power up sw2iso which need to be
+	 * larger than LDO ramp up time.
+	 */
+	imx_gpc_set_arm_power_up_timing(2, 1);
+	imx_gpc_set_arm_power_down_timing(1, 1);
+
+	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);
+}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index 24e3367..f914012 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -14,6 +14,7 @@
 extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 extern int imx6sl_cpuidle_init(void);
+extern int imx6sx_cpuidle_init(void);
 #else
 static inline int imx5_cpuidle_init(void)
 {
@@ -27,4 +28,8 @@ static inline int imx6sl_cpuidle_init(void)
 {
 	return 0;
 }
+static inline int imx6sx_cpuidle_init(void)
+{
+	return 0;
+}
 #endif
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 82ea74e..5fa43d2 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -20,6 +20,10 @@
 
 #define GPC_IMR1		0x008
 #define GPC_PGC_CPU_PDN		0x2a0
+#define GPC_PGC_CPU_PUPSCR	0x2a4
+#define GPC_PGC_CPU_PDNSCR	0x2a8
+#define GPC_PGC_SW2ISO_SHIFT	0x8
+#define GPC_PGC_SW_SHIFT	0x0
 
 #define IMR_NUM			4
 
@@ -27,6 +31,23 @@ static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
 
+void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw)
+{
+	writel_relaxed((sw2iso << GPC_PGC_SW2ISO_SHIFT) |
+		(sw << GPC_PGC_SW_SHIFT), gpc_base + GPC_PGC_CPU_PUPSCR);
+}
+
+void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw)
+{
+	writel_relaxed((sw2iso << GPC_PGC_SW2ISO_SHIFT) |
+		(sw << GPC_PGC_SW_SHIFT), gpc_base + GPC_PGC_CPU_PDNSCR);
+}
+
+void imx_gpc_set_arm_power_in_lpm(bool power_off)
+{
+	writel_relaxed(power_off, gpc_base + GPC_PGC_CPU_PDN);
+}
+
 void imx_gpc_pre_suspend(bool arm_power_off)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
@@ -34,7 +55,7 @@ void imx_gpc_pre_suspend(bool arm_power_off)
 
 	/* Tell GPC to power off ARM core when suspend */
 	if (arm_power_off)
-		writel_relaxed(0x1, gpc_base + GPC_PGC_CPU_PDN);
+		imx_gpc_set_arm_power_in_lpm(arm_power_off);
 
 	for (i = 0; i < IMR_NUM; i++) {
 		gpc_saved_imrs[i] = readl_relaxed(reg_imr1 + i * 4);
@@ -48,7 +69,7 @@ void imx_gpc_post_resume(void)
 	int i;
 
 	/* Keep ARM core powered on for other low-power modes */
-	writel_relaxed(0x0, gpc_base + GPC_PGC_CPU_PDN);
+	imx_gpc_set_arm_power_in_lpm(false);
 
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 7a96c65..66988eb 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -90,7 +90,7 @@ static void __init imx6sx_init_irq(void)
 
 static void __init imx6sx_init_late(void)
 {
-	imx6q_cpuidle_init();
+	imx6sx_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 671e2a9..8a1421e 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -205,7 +205,7 @@ void imx6q_set_int_mem_clk_lpm(bool enable)
 	writel_relaxed(val, ccm_base + CGPR);
 }
 
-static void imx6q_enable_rbc(bool enable)
+void imx6_enable_rbc(bool enable)
 {
 	u32 val;
 
@@ -360,7 +360,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		 * RBC setting, so we do NOT need to do that here.
 		 */
 		if (!imx6_suspend_in_ocram_fn)
-			imx6q_enable_rbc(true);
+			imx6_enable_rbc(true);
 		imx_gpc_pre_suspend(true);
 		imx_anatop_pre_suspend();
 		/* Zzz ... */
@@ -369,7 +369,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 			imx_smp_prepare();
 		imx_anatop_post_resume();
 		imx_gpc_post_resume();
-		imx6q_enable_rbc(false);
+		imx6_enable_rbc(false);
 		imx6q_enable_wb(false);
 		imx6q_set_int_mem_clk_lpm(true);
 		imx6q_set_lpm(WAIT_CLOCKED);
-- 
1.9.1
