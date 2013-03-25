From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 18:55:35 +0100
Subject: [PATCH 10/15] ARM: OMAP3: cpuidle: use init/exit common routine
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364234140-514-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicate code and use the arm cpuidle driver's common code
for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 80392fc..b5a0ba1 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -26,6 +26,7 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/cpu_pm.h>
+#include <asm/cpuidle.h>
 
 #include "powerdomain.h"
 #include "clockdomain.h"
@@ -271,8 +272,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	return ret;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
-
 static struct cpuidle_driver omap3_idle_driver = {
 	.name =		"omap3_idle",
 	.owner =	THIS_MODULE,
@@ -348,8 +347,6 @@ static struct cpuidle_driver omap3_idle_driver = {
  */
 int __init omap3_idle_init(void)
 {
-	struct cpuidle_device *dev;
-
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
 	per_pd = pwrdm_lookup("per_pwrdm");
@@ -358,16 +355,5 @@ int __init omap3_idle_init(void)
 	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
 		return -ENODEV;
 
-	cpuidle_register_driver(&omap3_idle_driver);
-
-	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
-	dev->cpu = 0;
-
-	if (cpuidle_register_device(dev)) {
-		printk(KERN_ERR "%s: CPUidle register device failed\n",
-		       __func__);
-		return -EIO;
-	}
-
-	return 0;
+	return arm_cpuidle_init(&omap3_idle_driver);
 }
-- 
1.7.9.5
