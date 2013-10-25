From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 25 Oct 2013 09:11:13 +0200
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: convert to platform driver
Message-ID: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is tied with the pm low level code making difficult to split the
driver into a more arch independent code. The platform driver allows to move
the standby callback into the platform data field and use a simple driver with
no more dependency on the low level code.

The standby callback has a portion of code to set the standby method and the
effective cpu_do_idle switching the cpu to the right mode. As this code is
redundant in the cpu suspend code, it has been factored out when implementing
the standby methdod.

By this way, the driver is ready to be moved out to the drivers/cpuidle.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   38 ++++++++++++++++----------------------
 arch/arm/mach-s3c64xx/pm.c      |   33 ++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 3c8ab07..8022f5f 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -9,33 +9,16 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/time.h>
+#include <linux/platform_device.h>
 
-#include <asm/proc-fns.h>
-
-#include <mach/map.h>
-
-#include "regs-sys.h"
-#include "regs-syscon-power.h"
+static void (*s3c64xx_standby)(void);
 
 static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
 			      int index)
 {
-	unsigned long tmp;
-
-	/* Setup PWRCFG to enter idle mode */
-	tmp = __raw_readl(S3C64XX_PWR_CFG);
-	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
-	tmp |= S3C64XX_PWRCFG_CFG_WFI_IDLE;
-	__raw_writel(tmp, S3C64XX_PWR_CFG);
-
-	cpu_do_idle();
+	s3c64xx_standby();
 
 	return index;
 }
@@ -56,8 +39,19 @@ static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 	.state_count = 1,
 };
 
-static int __init s3c64xx_init_cpuidle(void)
+static int s3c64xx_cpuidle_probe(struct platform_device *dev)
 {
+	s3c64xx_standby =  (void *)(dev->dev.platform_data);
+
 	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
 }
-device_initcall(s3c64xx_init_cpuidle);
+
+static struct platform_driver s3c64xx_driver_cpuidle = {
+	.driver = {
+		.name = "cpuidle-s3c64xx",
+		.owner = THIS_MODULE,
+	},
+	.probe = s3c64xx_cpuidle_probe,
+};
+
+module_platform_driver(s3c64xx_driver_cpuidle);
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 6a1f91f..534fb4e 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pm_domain.h>
+#include <linux/platform_device.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
@@ -259,6 +260,22 @@ void s3c_pm_save_core(void)
 	s3c_pm_do_save(core_save, ARRAY_SIZE(core_save));
 }
 
+static void s3c64xx_set_standby(void)
+{
+	unsigned long tmp;
+
+	tmp = __raw_readl(S3C64XX_PWR_CFG);
+	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
+	tmp |= S3C64XX_PWRCFG_CFG_WFI_SLEEP;
+	__raw_writel(tmp, S3C64XX_PWR_CFG);
+}
+
+static void s3c64xx_standby(void)
+{
+	s3c64xx_set_standby();
+	cpu_do_idle();
+}
+
 /* since both s3c6400 and s3c6410 share the same sleep pm calls, we
  * put the per-cpu code in here until any new cpu comes along and changes
  * this.
@@ -269,11 +286,7 @@ static int s3c64xx_cpu_suspend(unsigned long arg)
 	unsigned long tmp;
 
 	/* set our standby method to sleep */
-
-	tmp = __raw_readl(S3C64XX_PWR_CFG);
-	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
-	tmp |= S3C64XX_PWRCFG_CFG_WFI_SLEEP;
-	__raw_writel(tmp, S3C64XX_PWR_CFG);
+	s3c64xx_set_standby();
 
 	/* clear any old wakeup */
 
@@ -348,6 +361,13 @@ int __init s3c64xx_pm_init(void)
 	return 0;
 }
 
+static struct platform_device s3c64xx_cpuidle_device = {
+	.name = "cpuidle-s3c64xx",
+	.dev = {
+		.platform_data = s3c64xx_standby,
+	},
+};
+
 static __init int s3c64xx_pm_initcall(void)
 {
 	pm_cpu_prep = s3c64xx_pm_prepare;
@@ -364,8 +384,7 @@ static __init int s3c64xx_pm_initcall(void)
 	gpio_direction_output(S3C64XX_GPN(14), 0);
 	gpio_direction_output(S3C64XX_GPN(15), 0);
 #endif
-
-	return 0;
+	return platform_device_register(&s3c64xx_cpuidle_device);
 }
 arch_initcall(s3c64xx_pm_initcall);
 
-- 
1.7.9.5
