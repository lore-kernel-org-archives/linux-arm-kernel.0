From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 28 Oct 2013 09:49:31 -0700
Subject: [RFC PATCH 1/3] ARM: imx: cpuidle: Convert imx5 driver to platform
 driver
Message-ID: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PM low level code is tied and called from the cpuidle driver.

The platform driver approach allows to split the pm code and the
cpuidle driver, hence keeping the code encapsulated inside the pm
code.

The idle method called through the arm_pm_idle is changed by a callback
in the cpuidle driver, assigned at init time from the platform_data
field of the platform device passed in the probe function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx5.c |   20 +++++++++++++++++---
 arch/arm/mach-imx/cpuidle.h      |    5 -----
 arch/arm/mach-imx/pm-imx5.c      |   11 +++++++++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
index 5a47e3c..2d49846 100644
--- a/arch/arm/mach-imx/cpuidle-imx5.c
+++ b/arch/arm/mach-imx/cpuidle-imx5.c
@@ -8,12 +8,14 @@
 
 #include <linux/cpuidle.h>
 #include <linux/module.h>
-#include <asm/system_misc.h>
+#include <linux/platform_device.h>
+
+static void (*imx5_idle)(void);
 
 static int imx5_cpuidle_enter(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index)
 {
-	arm_pm_idle();
+	imx5_idle();
 	return index;
 }
 
@@ -31,7 +33,19 @@ static struct cpuidle_driver imx5_cpuidle_driver = {
 	.state_count = 1,
 };
 
-int __init imx5_cpuidle_init(void)
+static int imx5_cpuidle_probe(struct platform_device *dev)
 {
+	imx5_idle = dev->dev.platform_data;
+
 	return cpuidle_register(&imx5_cpuidle_driver, NULL);
 }
+
+static struct platform_driver imx5_driver_cpuidle = {
+	.driver = {
+		.name = "cpuidle-imx5",
+		.owner = THIS_MODULE,
+	},
+	.probe = imx5_cpuidle_probe,
+};
+
+module_platform_driver(imx5_driver_cpuidle);
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index 786f98e..9e93ea0 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -11,13 +11,8 @@
  */
 
 #ifdef CONFIG_CPU_IDLE
-extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 #else
-static inline int imx5_cpuidle_init(void)
-{
-	return 0;
-}
 static inline int imx6q_cpuidle_init(void)
 {
 	return 0;
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 58aeaf5..9eeef85 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -13,12 +13,12 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/platform_device.h>
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 #include <asm/tlbflush.h>
 
 #include "common.h"
-#include "cpuidle.h"
 #include "crm-regs-imx5.h"
 #include "hardware.h"
 
@@ -149,6 +149,13 @@ static void imx5_pm_idle(void)
 	imx5_cpu_do_idle();
 }
 
+static struct platform_device imx5_cpuidle_pdev = {
+	.name = "cpuidle-imx5",
+	.dev = {
+		.platform_data = imx5_pm_idle,
+	},
+};
+
 static int __init imx5_pm_common_init(void)
 {
 	int ret;
@@ -166,7 +173,7 @@ static int __init imx5_pm_common_init(void)
 	/* Set the registers to the default cpu idle state. */
 	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
 
-	return imx5_cpuidle_init();
+	return platform_device_register(&imx5_cpuidle_pdev);
 }
 
 void __init imx5_pm_init(void)
-- 
1.7.9.5
