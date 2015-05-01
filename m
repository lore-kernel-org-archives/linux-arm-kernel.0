From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  1 May 2015 18:36:30 +0100
Subject: [PATCH 5/5] bus: arm-ccn: Allocate event when it is being added,
 not initialised
In-Reply-To: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
References: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1430501790-26918-6-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make events rotation possible, they should be allocated when event
is being ->added(), not during initialisation. This patch moves the
respective code.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 114 +++++++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index fb589d4..df5f307 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -628,7 +628,65 @@ static int arm_ccn_pmu_type_eq(u32 a, u32 b)
 	return 0;
 }
 
-static void arm_ccn_pmu_event_destroy(struct perf_event *event)
+static int arm_ccn_pmu_event_alloc(struct perf_event *event)
+{
+	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	u32 node_xp, type, event_id;
+	struct arm_ccn_component *source;
+	int bit;
+
+	node_xp = CCN_CONFIG_NODE(event->attr.config);
+	type = CCN_CONFIG_TYPE(event->attr.config);
+	event_id = CCN_CONFIG_EVENT(event->attr.config);
+
+	/* Allocate the cycle counter */
+	if (type == CCN_TYPE_CYCLES) {
+		if (test_and_set_bit(CCN_IDX_PMU_CYCLE_COUNTER,
+				ccn->dt.pmu_counters_mask))
+			return -EAGAIN;
+
+		hw->idx = CCN_IDX_PMU_CYCLE_COUNTER;
+		ccn->dt.pmu_counters[CCN_IDX_PMU_CYCLE_COUNTER].event = event;
+
+		return 0;
+	}
+
+	/* Allocate an event counter */
+	hw->idx = arm_ccn_pmu_alloc_bit(ccn->dt.pmu_counters_mask,
+			CCN_NUM_PMU_EVENT_COUNTERS);
+	if (hw->idx < 0) {
+		dev_dbg(ccn->dev, "No more counters available!\n");
+		return -EAGAIN;
+	}
+
+	if (type == CCN_TYPE_XP)
+		source = &ccn->xp[node_xp];
+	else
+		source = &ccn->node[node_xp];
+	ccn->dt.pmu_counters[hw->idx].source = source;
+
+	/* Allocate an event source or a watchpoint */
+	if (type == CCN_TYPE_XP && event_id == CCN_EVENT_WATCHPOINT)
+		bit = arm_ccn_pmu_alloc_bit(source->xp.dt_cmp_mask,
+				CCN_NUM_XP_WATCHPOINTS);
+	else
+		bit = arm_ccn_pmu_alloc_bit(source->pmu_events_mask,
+				CCN_NUM_PMU_EVENTS);
+	if (bit < 0) {
+		dev_dbg(ccn->dev, "No more event sources/watchpoints on node/XP %d!\n",
+				node_xp);
+		clear_bit(hw->idx, ccn->dt.pmu_counters_mask);
+		return -EAGAIN;
+	}
+	hw->config_base = bit;
+
+	ccn->dt.pmu_counters[hw->idx].event = event;
+
+	return 0;
+}
+
+static void arm_ccn_pmu_event_release(struct perf_event *event)
 {
 	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
 	struct hw_perf_event *hw = &event->hw;
@@ -657,8 +715,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	struct arm_ccn *ccn;
 	struct hw_perf_event *hw = &event->hw;
 	u32 node_xp, type, event_id;
-	int valid, bit;
-	struct arm_ccn_component *source;
+	int valid;
 	int i;
 	struct perf_event *sibling;
 
@@ -666,7 +723,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	ccn = pmu_to_arm_ccn(event->pmu);
-	event->destroy = arm_ccn_pmu_event_destroy;
 
 	if (hw->sample_period) {
 		dev_warn(ccn->dev, "Sampling not supported!\n");
@@ -778,49 +834,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 				!is_software_event(sibling))
 			return -EINVAL;
 
-	/* Allocate the cycle counter */
-	if (type == CCN_TYPE_CYCLES) {
-		if (test_and_set_bit(CCN_IDX_PMU_CYCLE_COUNTER,
-				ccn->dt.pmu_counters_mask))
-			return -EAGAIN;
-
-		hw->idx = CCN_IDX_PMU_CYCLE_COUNTER;
-		ccn->dt.pmu_counters[CCN_IDX_PMU_CYCLE_COUNTER].event = event;
-
-		return 0;
-	}
-
-	/* Allocate an event counter */
-	hw->idx = arm_ccn_pmu_alloc_bit(ccn->dt.pmu_counters_mask,
-			CCN_NUM_PMU_EVENT_COUNTERS);
-	if (hw->idx < 0) {
-		dev_warn(ccn->dev, "No more counters available!\n");
-		return -EAGAIN;
-	}
-
-	if (type == CCN_TYPE_XP)
-		source = &ccn->xp[node_xp];
-	else
-		source = &ccn->node[node_xp];
-	ccn->dt.pmu_counters[hw->idx].source = source;
-
-	/* Allocate an event source or a watchpoint */
-	if (type == CCN_TYPE_XP && event_id == CCN_EVENT_WATCHPOINT)
-		bit = arm_ccn_pmu_alloc_bit(source->xp.dt_cmp_mask,
-				CCN_NUM_XP_WATCHPOINTS);
-	else
-		bit = arm_ccn_pmu_alloc_bit(source->pmu_events_mask,
-				CCN_NUM_PMU_EVENTS);
-	if (bit < 0) {
-		dev_warn(ccn->dev, "No more event sources/watchpoints on node/XP %d!\n",
-				node_xp);
-		clear_bit(hw->idx, ccn->dt.pmu_counters_mask);
-		return -EAGAIN;
-	}
-	hw->config_base = bit;
-
-	ccn->dt.pmu_counters[hw->idx].event = event;
-
 	return 0;
 }
 
@@ -1087,8 +1100,13 @@ static void arm_ccn_pmu_event_config(struct perf_event *event)
 
 static int arm_ccn_pmu_event_add(struct perf_event *event, int flags)
 {
+	int err;
 	struct hw_perf_event *hw = &event->hw;
 
+	err = arm_ccn_pmu_event_alloc(event);
+	if (err)
+		return err;
+
 	arm_ccn_pmu_event_config(event);
 
 	hw->state = PERF_HES_STOPPED;
@@ -1102,6 +1120,8 @@ static int arm_ccn_pmu_event_add(struct perf_event *event, int flags)
 static void arm_ccn_pmu_event_del(struct perf_event *event, int flags)
 {
 	arm_ccn_pmu_event_stop(event, PERF_EF_UPDATE);
+
+	arm_ccn_pmu_event_release(event);
 }
 
 static void arm_ccn_pmu_event_read(struct perf_event *event)
-- 
2.1.0
