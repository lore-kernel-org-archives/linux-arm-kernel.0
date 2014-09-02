From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  2 Sep 2014 16:26:11 +0100
Subject: [PATCH] bus: arm-ccn: Move event cleanup routine
Message-ID: <1409671571-4606-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pawel Moll <mail@pawelmoll.com>

The function cleaning up an initialized event
was called from the "event_del" handler, instead
of being used as the "destroy" callback. In case of
events group allocation this caused NULL pointer
dereference (as events are added and deleted
multiple times then). Fixed now.

Signed-off-by: Pawel Moll <mail@pawelmoll.com>
---
 drivers/bus/arm-ccn.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 6f550d9..a60f264 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -586,6 +586,30 @@ static int arm_ccn_pmu_type_eq(u32 a, u32 b)
 	return 0;
 }
 
+static void arm_ccn_pmu_event_destroy(struct perf_event *event)
+{
+	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+
+	if (hw->idx == CCN_IDX_PMU_CYCLE_COUNTER) {
+		clear_bit(CCN_IDX_PMU_CYCLE_COUNTER, ccn->dt.pmu_counters_mask);
+	} else {
+		struct arm_ccn_component *source =
+				ccn->dt.pmu_counters[hw->idx].source;
+
+		if (CCN_CONFIG_TYPE(event->attr.config) == CCN_TYPE_XP &&
+				CCN_CONFIG_EVENT(event->attr.config) ==
+				CCN_EVENT_WATCHPOINT)
+			clear_bit(hw->config_base, source->xp.dt_cmp_mask);
+		else
+			clear_bit(hw->config_base, source->pmu_events_mask);
+		clear_bit(hw->idx, ccn->dt.pmu_counters_mask);
+	}
+
+	ccn->dt.pmu_counters[hw->idx].source = NULL;
+	ccn->dt.pmu_counters[hw->idx].event = NULL;
+}
+
 static int arm_ccn_pmu_event_init(struct perf_event *event)
 {
 	struct arm_ccn *ccn;
@@ -599,6 +623,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	ccn = pmu_to_arm_ccn(event->pmu);
+	event->destroy = arm_ccn_pmu_event_destroy;
 
 	if (hw->sample_period) {
 		dev_warn(ccn->dev, "Sampling not supported!\n");
@@ -731,30 +756,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	return 0;
 }
 
-static void arm_ccn_pmu_event_free(struct perf_event *event)
-{
-	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
-	struct hw_perf_event *hw = &event->hw;
-
-	if (hw->idx == CCN_IDX_PMU_CYCLE_COUNTER) {
-		clear_bit(CCN_IDX_PMU_CYCLE_COUNTER, ccn->dt.pmu_counters_mask);
-	} else {
-		struct arm_ccn_component *source =
-				ccn->dt.pmu_counters[hw->idx].source;
-
-		if (CCN_CONFIG_TYPE(event->attr.config) == CCN_TYPE_XP &&
-				CCN_CONFIG_EVENT(event->attr.config) ==
-				CCN_EVENT_WATCHPOINT)
-			clear_bit(hw->config_base, source->xp.dt_cmp_mask);
-		else
-			clear_bit(hw->config_base, source->pmu_events_mask);
-		clear_bit(hw->idx, ccn->dt.pmu_counters_mask);
-	}
-
-	ccn->dt.pmu_counters[hw->idx].source = NULL;
-	ccn->dt.pmu_counters[hw->idx].event = NULL;
-}
-
 static u64 arm_ccn_pmu_read_counter(struct arm_ccn *ccn, int idx)
 {
 	u64 res;
@@ -1027,8 +1028,6 @@ static int arm_ccn_pmu_event_add(struct perf_event *event, int flags)
 static void arm_ccn_pmu_event_del(struct perf_event *event, int flags)
 {
 	arm_ccn_pmu_event_stop(event, PERF_EF_UPDATE);
-
-	arm_ccn_pmu_event_free(event);
 }
 
 static void arm_ccn_pmu_event_read(struct perf_event *event)
-- 
1.9.1
