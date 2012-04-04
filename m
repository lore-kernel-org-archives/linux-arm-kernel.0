From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:48 +0200
Subject: [PATCH 14/17][V2] ARM: OMAP3 : cpuidle - simplify next_valid_state
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1333570371-1389-15-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the indentation by removing the useless 'else' statement.
Remove the first loop for the 'idx' search as we have it already
with the 'index' passed as parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   53 +++++++++++++-----------------------
 1 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index e4738eb..35a1471 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -174,13 +174,12 @@ static inline int omap3_enter_idle(struct cpuidle_device *dev,
  * if it satisfies the enable_off_mode condition.
  */
 static int next_valid_state(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-				int index)
+			    struct cpuidle_driver *drv, int index)
 {
-	struct cpuidle_state *curr = &drv->states[index];
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
+	int idx;
 	int next_index = -1;
 
 	if (enable_off_mode) {
@@ -196,42 +195,28 @@ static int next_valid_state(struct cpuidle_device *dev,
 
 	/* Check if current state is valid */
 	if ((cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state)) {
+	    (cx->core_state >= core_deepest_state))
 		return index;
-	} else {
-		int idx = OMAP3_NUM_STATES - 1;
-
-		/* Reach the current state starting at highest C-state */
-		for (; idx >= 0; idx--) {
-			if (&drv->states[idx] == curr) {
-				next_index = idx;
-				break;
-			}
-		}
-
-		/* Should never hit this condition */
-		WARN_ON(next_index == -1);
 
-		/*
-		 * Drop to next valid state.
-		 * Start search from the next (lower) state.
-		 */
-		idx--;
-		for (; idx >= 0; idx--) {
-			cx =  &omap3_idle_data[idx];
-			if ((cx->mpu_state >= mpu_deepest_state) &&
-			    (cx->core_state >= core_deepest_state)) {
-				next_index = idx;
-				break;
-			}
+	/*
+	 * Drop to next valid state.
+	 * Start search from the next (lower) state.
+	 */
+	for (idx = index - 1; idx >= 0; idx--) {
+		cx =  &omap3_idle_data[idx];
+		if ((cx->mpu_state >= mpu_deepest_state) &&
+		    (cx->core_state >= core_deepest_state)) {
+			next_index = idx;
+			break;
 		}
-		/*
-		 * C1 is always valid.
-		 * So, no need to check for 'next_index == -1' outside
-		 * this loop.
-		 */
 	}
 
+	/*
+	 * C1 is always valid.
+	 * So, no need to check for 'next_index == -1' outside
+	 * this loop.
+	 */
+
 	return next_index;
 }
 
-- 
1.7.5.4
