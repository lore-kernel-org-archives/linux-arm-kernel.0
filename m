From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:07:18 +0800
Subject: [PATCH] cpuidle: arm: make enter idle operation a bit more efficient
Message-ID: <1458796038-6062-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, entering idle need to check the idx every time to choose the
real entering idle routine. But this check could be avoided by pointing
the idle enter function pointer of each idle states to the routines
suitable for each states directly.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/cpuidle/cpuidle-arm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..48a620f 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -23,6 +23,13 @@
 
 #include "dt_idle_states.h"
 
+static int arm_enter_wfi_state(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int idx)
+{
+	cpu_do_idle();
+	return 0;
+}
+
 /*
  * arm_enter_idle_state - Programs CPU to enter the specified state
  *
@@ -38,11 +45,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 {
 	int ret;
 
-	if (!idx) {
-		cpu_do_idle();
-		return idx;
-	}
-
 	ret = cpu_pm_enter();
 	if (!ret) {
 		/*
@@ -69,7 +71,7 @@ static struct cpuidle_driver arm_idle_driver = {
 	 * handler for idle state index 0.
 	 */
 	.states[0] = {
-		.enter                  = arm_enter_idle_state,
+		.enter                  = arm_enter_wfi_state,
 		.exit_latency           = 1,
 		.target_residency       = 1,
 		.power_usage		= UINT_MAX,
-- 
2.8.0.rc3
