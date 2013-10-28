From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 28 Oct 2013 09:49:32 -0700
Subject: [RFC PATCH 2/3] ARM: imx: cpuidle: Convert imx6q driver to
 platform_driver
In-Reply-To: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1382978973-4034-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm code and the cpuidle driver are tied together. The platform
driver approach allows to split this code and move the pm low level
code from the driver to the pm block.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c |   31 ++++++++++++++++++-------------
 arch/arm/mach-imx/cpuidle.h       |   20 --------------------
 arch/arm/mach-imx/mach-imx6q.c    |    8 --------
 arch/arm/mach-imx/pm-imx6q.c      |   30 ++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cpuidle.h

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 23ddfb6..9761278 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -7,16 +7,15 @@
  */
 
 #include <linux/cpuidle.h>
-#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
-#include "common.h"
-#include "cpuidle.h"
-
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
 
+static void (*imx6q_idle)(void);
+
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
@@ -27,9 +26,9 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
 		 */
 		if (!spin_trylock(&master_lock))
 			goto idle;
-		imx6q_set_lpm(WAIT_UNCLOCKED);
-		cpu_do_idle();
-		imx6q_set_lpm(WAIT_CLOCKED);
+
+		imx6q_idle();
+		
 		spin_unlock(&master_lock);
 		goto done;
 	}
@@ -63,13 +62,19 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.safe_state_index = 0,
 };
 
-int __init imx6q_cpuidle_init(void)
+static int imx6q_cpuidle_probe(struct platform_device *dev)
 {
-	/* Need to enable SCU standby for entering WAIT modes */
-	imx_scu_standby_enable();
-
-	/* Set chicken bit to get a reliable WAIT mode support */
-	imx6q_set_chicken_bit();
+	imx6q_idle = dev->dev.platform_data;
 
 	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
 }
+
+static struct platform_driver imx6q_driver_cpuidle = {
+	.driver = {
+		.name = "cpuidle-imx6q",
+		.owner = THIS_MODULE,
+	},
+	.probe = imx6q_cpuidle_probe,
+};
+
+module_platform_driver(imx6q_driver_cpuidle);
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
deleted file mode 100644
index 9e93ea0..0000000
--- a/arch/arm/mach-imx/cpuidle.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#ifdef CONFIG_CPU_IDLE
-extern int imx6q_cpuidle_init(void);
-#else
-static inline int imx6q_cpuidle_init(void)
-{
-	return 0;
-}
-#endif
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 90372a2..9ca5b40 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -37,7 +37,6 @@
 #include <asm/system_misc.h>
 
 #include "common.h"
-#include "cpuidle.h"
 #include "hardware.h"
 
 static u32 chip_revision;
@@ -265,13 +264,6 @@ static struct platform_device imx6q_cpufreq_pdev = {
 
 static void __init imx6q_init_late(void)
 {
-	/*
-	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
-	 * to run cpuidle on them.
-	 */
-	if (imx6q_revision() > IMX_CHIP_REVISION_1_1)
-		imx6q_cpuidle_init();
-
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
 		imx6q_opp_init();
 		platform_device_register(&imx6q_cpufreq_pdev);
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 2049427..bbb6d1c 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/suspend.h>
+#include <linux/platform_device.h>
 #include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
@@ -50,12 +51,41 @@ static int imx6q_pm_enter(suspend_state_t state)
 	return 0;
 }
 
+static void imx6q_pm_idle(void)
+{
+	imx6q_set_lpm(WAIT_UNCLOCKED);
+	cpu_do_idle();
+	imx6q_set_lpm(WAIT_CLOCKED);
+}
+
 static const struct platform_suspend_ops imx6q_pm_ops = {
 	.enter = imx6q_pm_enter,
 	.valid = suspend_valid_only_mem,
 };
 
+static struct platform_device imx6q_cpuidle_device = {
+	.name = "cpuidle-imx6q",
+	.dev = {
+		.platform_data = imx6q_pm_idle,
+	},
+};
+
 void __init imx6q_pm_init(void)
 {
+	/*
+	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
+	 * to run cpuidle on them.
+	 */
+	if (imx6q_revision() > IMX_CHIP_REVISION_1_1) {
+
+		/* Need to enable SCU standby for entering WAIT modes */
+		imx_scu_standby_enable();
+
+		/* Set chicken bit to get a reliable WAIT mode support */
+		imx6q_set_chicken_bit();
+
+		platform_device_register(&imx6q_cpuidle_device);
+	}
+
 	suspend_set_ops(&imx6q_pm_ops);
 }
-- 
1.7.9.5
