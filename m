From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:09 -0600
Subject: [RFC PATCH 6/8] ARM: shmobile: Replace init with new common ARM
 cpuidle init code
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-7-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated cpuidle init functionality with common ARM cpuidle
init implementation.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 1b23342..0314fa2 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <asm/system.h>
 #include <asm/io.h>
+#include <asm/cpuidle.h>
 
 static void shmobile_enter_wfi(void)
 {
@@ -29,25 +30,11 @@ static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
 				  struct cpuidle_driver *drv,
 				  int index)
 {
-	ktime_t before, after;
-
-	before = ktime_get();
-
-	local_irq_disable();
-	local_fiq_disable();
-
 	shmobile_cpuidle_modes[index]();
 
-	local_irq_enable();
-	local_fiq_enable();
-
-	after = ktime_get();
-	dev->last_residency = ktime_to_ns(ktime_sub(after, before)) >> 10;
-
 	return index;
 }
 
-static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_driver = {
 	.name =		"shmobile_cpuidle",
 	.owner =	THIS_MODULE,
@@ -66,21 +53,15 @@ void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
 static int shmobile_cpuidle_init(void)
 {
-	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
-	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
-	int i;
-
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
-		drv->states[i].enter = shmobile_cpuidle_enter;
+	int ret;
 
 	if (shmobile_cpuidle_setup)
-		shmobile_cpuidle_setup(drv);
-
-	cpuidle_register_driver(drv);
+		shmobile_cpuidle_setup(&shmobile_cpuidle_driver);
 
-	dev->state_count = drv->state_count;
-	cpuidle_register_device(dev);
+	ret = arm_cpuidle_init(&shmobile_cpuidle_driver,
+					shmobile_cpuidle_enter,
+					NULL);
 
-	return 0;
+	return ret;
 }
 late_initcall(shmobile_cpuidle_init);
-- 
1.7.1
