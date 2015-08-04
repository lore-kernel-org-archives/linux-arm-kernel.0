From: b20788@freescale.com (Anson Huang)
Date: Wed, 5 Aug 2015 01:59:24 +0800
Subject: [PATCH V2] ARM: imx: add cpuidle support for i.mx6ul
Message-ID: <1438711164-9106-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces an independent cpuidle driver for
i.MX6UL, totally 3 levels of cpuidle are supported as below:

1. ARM WFI;
2. SOC in WAIT mode;
3. SOC in WAIT mode + ARM power off.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
change from V1:
	remove CPUIDLE_FLAG_TIMER_STOP flag as i.MX6UL does
NOT use local timer.
 arch/arm/mach-imx/Makefile         |   1 +
 arch/arm/mach-imx/cpuidle-imx6ul.c | 105 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h        |   5 ++
 arch/arm/mach-imx/mach-imx6ul.c    |   8 +++
 4 files changed, 119 insertions(+)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6ul.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fb689d8..1d7df9c 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6ul.o
 endif
 
 ifdef CONFIG_SND_IMX_SOC
diff --git a/arch/arm/mach-imx/cpuidle-imx6ul.c b/arch/arm/mach-imx/cpuidle-imx6ul.c
new file mode 100644
index 0000000..27ab28a
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx6ul.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/cpuidle.h>
+#include <asm/suspend.h>
+
+#include "common.h"
+#include "cpuidle.h"
+
+static int imx6ul_idle_finish(unsigned long val)
+{
+	flush_cache_all();
+	cpu_do_idle();
+
+	return 0;
+}
+
+static int imx6ul_enter_wait(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	imx6_set_lpm(WAIT_UNCLOCKED);
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
+		cpu_suspend(0, imx6ul_idle_finish);
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
+	imx6_set_lpm(WAIT_CLOCKED);
+
+	return index;
+}
+
+static struct cpuidle_driver imx6ul_cpuidle_driver = {
+	.name = "imx6ul_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency = 50,
+			.target_residency = 75,
+			.enter = imx6ul_enter_wait,
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
+			.enter = imx6ul_enter_wait,
+			.name = "LOW-POWER-IDLE",
+			.desc = "ARM power off",
+		},
+	},
+	.state_count = 3,
+	.safe_state_index = 0,
+};
+
+int __init imx6ul_cpuidle_init(void)
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
+	return cpuidle_register(&imx6ul_cpuidle_driver, NULL);
+}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index f914012..4dcf71d 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -15,6 +15,7 @@ extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 extern int imx6sl_cpuidle_init(void);
 extern int imx6sx_cpuidle_init(void);
+extern int imx6ul_cpuidle_init(void);
 #else
 static inline int imx5_cpuidle_init(void)
 {
@@ -32,4 +33,8 @@ static inline int imx6sx_cpuidle_init(void)
 {
 	return 0;
 }
+static inline int imx6ul_cpuidle_init(void)
+{
+	return 0;
+}
 #endif
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index f206506..0f4b95c 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -11,6 +11,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
+#include "cpuidle.h"
 
 static void __init imx6ul_init_machine(void)
 {
@@ -29,6 +30,12 @@ static void __init imx6ul_init_irq(void)
 	imx_init_revision_from_anatop();
 	imx_src_init();
 	irqchip_init();
+	imx6_pm_ccm_init("fsl,imx6ul-ccm");
+}
+
+static void __init imx6ul_init_late(void)
+{
+	imx6ul_cpuidle_init();
 }
 
 static const char *imx6ul_dt_compat[] __initconst = {
@@ -40,4 +47,5 @@ DT_MACHINE_START(IMX6UL, "Freescale i.MX6 Ultralite (Device Tree)")
 	.init_irq	= imx6ul_init_irq,
 	.init_machine	= imx6ul_init_machine,
 	.dt_compat	= imx6ul_dt_compat,
+	.init_late	= imx6ul_init_late,
 MACHINE_END
-- 
1.9.1
