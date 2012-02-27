From: rob.lee@linaro.org (Robert Lee)
Date: Sun, 26 Feb 2012 22:47:39 -0600
Subject: [PATCH v5 5/9] ARM: shmobile: Consolidate cpuidle functionality
In-Reply-To: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330318063-25460-6-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added core cpuidle functionality and remove this duplicated
code from the platform cpuidle.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 1b23342..e01a73f 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -29,21 +29,8 @@ static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
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
 
@@ -51,13 +38,8 @@ static struct cpuidle_device shmobile_cpuidle_dev;
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
