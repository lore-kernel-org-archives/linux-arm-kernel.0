From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 18:55:33 +0100
Subject: [PATCH 08/15] ARM: ux500: cpuidle: use init/exit common routine
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364234140-514-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the duplicate code and use the arm cpuidle driver's common code
for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index 1b16d9e..ee81d22 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -21,7 +21,6 @@
 
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
-static DEFINE_PER_CPU(struct cpuidle_device, ux500_cpuidle_device);
 
 static inline int ux500_enter_idle(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index)
@@ -113,40 +112,11 @@ static struct cpuidle_driver ux500_idle_driver = {
 
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
-	for_each_online_cpu(cpu) {
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
-	for_each_online_cpu(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		cpuidle_unregister_device(device);
-	}
-
-	cpuidle_unregister_driver(&ux500_idle_driver);
-	goto out;
+	return arm_cpuidle_init(&ux500_idle_driver);
 }
 
 device_initcall(ux500_idle_init);
-- 
1.7.9.5
