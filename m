From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Apr 2013 22:42:37 +0200
Subject: [V2 patch 07/19] ARM: ux500: cpuidle: use init/exit common routine
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1365712969-7541-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicate code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index 5657d4a..488e074 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -21,7 +21,6 @@
 
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
-static DEFINE_PER_CPU(struct cpuidle_device, ux500_cpuidle_device);
 
 static inline int ux500_enter_idle(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index)
@@ -112,40 +111,11 @@ static struct cpuidle_driver ux500_idle_driver = {
 
 int __init ux500_idle_init(void)
 {
-	int ret, cpu;
-	struct cpuidle_device *device;
-
         /* Configure wake up reasons */
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
 			     PRCMU_WAKEUP(ABB));
 
-	ret = cpuidle_register_driver(&ux500_idle_driver);
-	if (ret) {
-		printk(KERN_ERR "failed to register ux500 idle driver\n");
-		return ret;
-	}
-
-	for_each_possible(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		device->cpu = cpu;
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			printk(KERN_ERR "Failed to register cpuidle "
-			       "device for cpu%d\n", cpu);
-			goto out_unregister;
-		}
-	}
-out:
-	return ret;
-
-out_unregister:
-	for_each_possible_cpu(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		cpuidle_unregister_device(device);
-	}
-
-	cpuidle_unregister_driver(&ux500_idle_driver);
-	goto out;
+	return cpuidle_register(&ux500_idle_driver, NULL);
 }
 
 device_initcall(ux500_idle_init);
-- 
1.7.9.5
