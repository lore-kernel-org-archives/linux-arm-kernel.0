From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 23 Apr 2013 10:54:39 +0200
Subject: [V4 patch 09/15] ARM: OMAP4: cpuidle: use init/exit common routine
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1366707285-12179-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index d1bfb21..5a286b5 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -15,6 +15,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
 
+#include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
 #include "common.h"
@@ -159,8 +160,6 @@ fail:
 	return index;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, omap_idle_dev);
-
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
@@ -209,9 +208,6 @@ static struct cpuidle_driver omap4_idle_driver = {
  */
 int __init omap4_idle_init(void)
 {
-	struct cpuidle_device *dev;
-	unsigned int cpu_id = 0;
-
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
 	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
@@ -223,23 +219,5 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	if (cpuidle_register_driver(&omap4_idle_driver)) {
-		pr_err("%s: CPUidle driver register failed\n", __func__);
-		return -EIO;
-	}
-
-	for_each_cpu(cpu_id, cpu_online_mask) {
-		dev = &per_cpu(omap_idle_dev, cpu_id);
-		dev->cpu = cpu_id;
-#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-		dev->coupled_cpus = *cpu_online_mask;
-#endif
-		if (cpuidle_register_device(dev)) {
-			pr_err("%s: CPUidle register failed\n", __func__);
-			cpuidle_unregister_driver(&omap4_idle_driver);
-			return -EIO;
-		}
-	}
-
-	return 0;
+	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
 }
-- 
1.7.9.5
