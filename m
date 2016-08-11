From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 10:50:42 +0100
Subject: [PATCH 2/3] arm-ccn: fix hrtimer registration
In-Reply-To: <1470909043-7663-1-git-send-email-mark.rutland@arm.com>
References: <1470909043-7663-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1470909043-7663-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCN PMU driver has a single hrtimer, used to simulate a periodic
interrupt on systems where the overflow interrupt is not possible to
use. The hrtimer is started when any event is started, and cancelled when
any event is stopped. Thus, stopping a single event is sufficient to
disable to hrtimer, and overflows (of other events) may be lost.

To avoid this, this patch reworks the hrtimer start/cancel to only occur
when the first event is added to a PMU, and the last event removed,
making use of the existing bitmap counting active events.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 28b1d66..e07cd51b 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -921,15 +921,6 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
 			arm_ccn_pmu_read_counter(ccn, hw->idx));
 	hw->state = 0;
 
-	/*
-	 * Pin the timer, so that the overflows are handled by the chosen
-	 * event->cpu (this is the same one as presented in "cpumask"
-	 * attribute).
-	 */
-	if (!ccn->irq)
-		hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
-				HRTIMER_MODE_REL_PINNED);
-
 	/* Set the DT bus input, engaging the counter */
 	arm_ccn_pmu_xp_dt_config(event, 1);
 }
@@ -943,9 +934,6 @@ static void arm_ccn_pmu_event_stop(struct perf_event *event, int flags)
 	/* Disable counting, setting the DT bus to pass-through mode */
 	arm_ccn_pmu_xp_dt_config(event, 0);
 
-	if (!ccn->irq)
-		hrtimer_cancel(&ccn->dt.hrtimer);
-
 	/* Let the DT bus drain */
 	timeout = arm_ccn_pmu_read_counter(ccn, CCN_IDX_PMU_CYCLE_COUNTER) +
 			ccn->num_xps;
@@ -1103,15 +1091,31 @@ static void arm_ccn_pmu_event_config(struct perf_event *event)
 	spin_unlock(&ccn->dt.config_lock);
 }
 
+static int arm_ccn_pmu_active_counters(struct arm_ccn *ccn)
+{
+	return bitmap_weight(ccn->dt.pmu_counters_mask,
+			     CCN_NUM_PMU_EVENT_COUNTERS + 1);
+}
+
 static int arm_ccn_pmu_event_add(struct perf_event *event, int flags)
 {
 	int err;
 	struct hw_perf_event *hw = &event->hw;
+	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
 
 	err = arm_ccn_pmu_event_alloc(event);
 	if (err)
 		return err;
 
+	/*
+	 * Pin the timer, so that the overflows are handled by the chosen
+	 * event->cpu (this is the same one as presented in "cpumask"
+	 * attribute).
+	 */
+	if (!ccn->irq && arm_ccn_pmu_active_counters(ccn) == 1)
+		hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
+			      HRTIMER_MODE_REL_PINNED);
+
 	arm_ccn_pmu_event_config(event);
 
 	hw->state = PERF_HES_STOPPED;
@@ -1124,9 +1128,14 @@ static int arm_ccn_pmu_event_add(struct perf_event *event, int flags)
 
 static void arm_ccn_pmu_event_del(struct perf_event *event, int flags)
 {
+	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
+
 	arm_ccn_pmu_event_stop(event, PERF_EF_UPDATE);
 
 	arm_ccn_pmu_event_release(event);
+
+	if (!ccn->irq && arm_ccn_pmu_active_counters(ccn) == 0)
+		hrtimer_cancel(&ccn->dt.hrtimer);
 }
 
 static void arm_ccn_pmu_event_read(struct perf_event *event)
-- 
1.9.1
