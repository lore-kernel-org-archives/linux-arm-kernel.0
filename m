From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 23 Jan 2012 22:37:30 -0600
Subject: [PATCH v3 3/7] ARM: shmobile: Modify to use new common cpuidle code.
In-Reply-To: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1327379854-12403-4-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make necessary changes for consolidation with new common cpuidle code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   51 ++++++-------------------------------
 1 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 1b23342..2a4eaef 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -16,71 +16,38 @@
 #include <asm/system.h>
 #include <asm/io.h>
 
-static void shmobile_enter_wfi(void)
-{
-	cpu_do_idle();
-}
-
-void (*shmobile_cpuidle_modes[CPUIDLE_STATE_MAX])(void) = {
-	shmobile_enter_wfi, /* regular sleep mode */
-};
+void (*shmobile_cpuidle_modes[CPUIDLE_STATE_MAX])(void);
 
 static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
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
-static struct cpuidle_driver shmobile_cpuidle_driver = {
+static struct cpuidle_driver shmobile_cpuidle_driver __initdata = {
 	.name =		"shmobile_cpuidle",
 	.owner =	THIS_MODULE,
-	.states[0] = {
-		.name = "C1",
-		.desc = "WFI",
-		.exit_latency = 1,
-		.target_residency = 1 * 2,
-		.flags = CPUIDLE_FLAG_TIME_VALID,
-	},
-	.safe_state_index = 0, /* C1 */
+	.states[0] = CPUIDLE_ARM_WFI_STATE,
+	.safe_state_index = 0,
 	.state_count = 1,
 };
 
 void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
-static int shmobile_cpuidle_init(void)
+static int __init shmobile_cpuidle_init(void)
 {
-	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
-	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
 	int i;
+	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
 
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
+	for (i = drv->state_count; i < CPUIDLE_STATE_MAX; i++)
 		drv->states[i].enter = shmobile_cpuidle_enter;
 
 	if (shmobile_cpuidle_setup)
-		shmobile_cpuidle_setup(drv);
-
-	cpuidle_register_driver(drv);
-
-	dev->state_count = drv->state_count;
-	cpuidle_register_device(dev);
+		shmobile_cpuidle_setup(&shmobile_cpuidle_driver);
 
-	return 0;
+	return common_cpuidle_init(&shmobile_cpuidle_driver, true, NULL);
 }
 late_initcall(shmobile_cpuidle_init);
-- 
1.7.1
