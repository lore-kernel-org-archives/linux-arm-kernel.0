From: rob.lee@linaro.org (Robert Lee)
Date: Tue,  6 Mar 2012 21:42:18 -0600
Subject: [RFC PATCH] cpuidle: avoid unnecessary expensive governor processing
Message-ID: <1331091738-26322-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There a few cases when a platform's cpuidle_device will only have one
cpuidle state.  e.g., when a single idle state system uses cpuidle
to provide sysfs staticstics for profiling (powertop, etc).  This can
also be the case for coupled smp system implementations that keep
all but one cpuidle_device at a state_count of 1, but they still want
to export idle statistics for these states using cpuidle.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 drivers/cpuidle/governors/ladder.c |    7 +++++--
 drivers/cpuidle/governors/menu.c   |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index b6a09ea..13abdba 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -71,8 +71,11 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 	int last_residency, last_idx = ldev->last_state_idx;
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 
-	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0)) {
+	/*
+	 * Special case when user has set very strict latency requirement or
+	 * there is currently only one state for this device.
+	 */
+	if ((latency_req == 0) || (dev->state_count == 1)) {
 		ladder_do_selection(ldev, last_idx, 0);
 		return 0;
 	}
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index ad09526..80eb606 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -249,8 +249,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	data->last_state_idx = 0;
 	data->exit_us = 0;
 
-	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0))
+	/*
+	 * Special case when user has set very strict latency requirement or
+	 * there is currently only one state for this device.
+	 */
+	if ((latency_req == 0) || (dev->state_count == 1))
 		return 0;
 
 	/* determine the expected residency time, round up */
-- 
1.7.1
