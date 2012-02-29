From: rob.lee@linaro.org (Robert Lee)
Date: Tue, 28 Feb 2012 21:11:48 -0600
Subject: [PATCH v6 8/9] ARM: shmobile: Consolidate time keeping and irq enable
In-Reply-To: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330485109-7327-9-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 1b23342..47b56a9 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <asm/system.h>
+#include <asm/cpuidle.h>
 #include <asm/io.h>
 
 static void shmobile_enter_wfi(void)
@@ -29,21 +30,8 @@ static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
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
 
@@ -51,13 +39,8 @@ static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_driver = {
 	.name =		"shmobile_cpuidle",
 	.owner =	THIS_MODULE,
-	.states[0] = {
-		.name = "C1",
-		.desc = "WFI",
-		.exit_latency = 1,
-		.target_residency = 1 * 2,
-		.flags = CPUIDLE_FLAG_TIME_VALID,
-	},
+	.en_core_tk_irqen = 1,
+	.states[0] = CPUIDLE_ARM_WFI_STATE,
 	.safe_state_index = 0, /* C1 */
 	.state_count = 1,
 };
-- 
1.7.1
