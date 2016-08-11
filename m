From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 10:50:43 +0100
Subject: [PATCH 3/3] arm-ccn: make event groups reliable
In-Reply-To: <1470909043-7663-1-git-send-email-mark.rutland@arm.com>
References: <1470909043-7663-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1470909043-7663-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCN PMU driver leaves the counting logic always enabled, and thus
events are enabled while groups are manipulated. As each event is
stopped and read individually, this leads to arbitrary skew across event
groups, which can be seen if counting several identical events.

To avoid this, implement pmu_{enable,disable} callbacks to stop and
start all counters atomically around event manipulation. As the counters
are now stopped, we cannot poll the cycle counter to wait for events to
drain from the bus. However, as the counters are stopped and the events
will not be read regardless, we can simply allow the bus to drain
naturally.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index e07cd51b..4b4757f 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -927,20 +927,11 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
 
 static void arm_ccn_pmu_event_stop(struct perf_event *event, int flags)
 {
-	struct arm_ccn *ccn = pmu_to_arm_ccn(event->pmu);
 	struct hw_perf_event *hw = &event->hw;
-	u64 timeout;
 
 	/* Disable counting, setting the DT bus to pass-through mode */
 	arm_ccn_pmu_xp_dt_config(event, 0);
 
-	/* Let the DT bus drain */
-	timeout = arm_ccn_pmu_read_counter(ccn, CCN_IDX_PMU_CYCLE_COUNTER) +
-			ccn->num_xps;
-	while (arm_ccn_pmu_read_counter(ccn, CCN_IDX_PMU_CYCLE_COUNTER) <
-			timeout)
-		cpu_relax();
-
 	if (flags & PERF_EF_UPDATE)
 		arm_ccn_pmu_event_update(event);
 
@@ -1143,6 +1134,24 @@ static void arm_ccn_pmu_event_read(struct perf_event *event)
 	arm_ccn_pmu_event_update(event);
 }
 
+static void arm_ccn_pmu_enable(struct pmu *pmu)
+{
+	struct arm_ccn *ccn = pmu_to_arm_ccn(pmu);
+
+	u32 val = readl(ccn->dt.base + CCN_DT_PMCR);
+	val |= CCN_DT_PMCR__PMU_EN;
+	writel(val, ccn->dt.base + CCN_DT_PMCR);
+}
+
+static void arm_ccn_pmu_disable(struct pmu *pmu)
+{
+	struct arm_ccn *ccn = pmu_to_arm_ccn(pmu);
+
+	u32 val = readl(ccn->dt.base + CCN_DT_PMCR);
+	val &= ~CCN_DT_PMCR__PMU_EN;
+	writel(val, ccn->dt.base + CCN_DT_PMCR);
+}
+
 static irqreturn_t arm_ccn_pmu_overflow_handler(struct arm_ccn_dt *dt)
 {
 	u32 pmovsr = readl(dt->base + CCN_DT_PMOVSR);
@@ -1265,6 +1274,8 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 		.start = arm_ccn_pmu_event_start,
 		.stop = arm_ccn_pmu_event_stop,
 		.read = arm_ccn_pmu_event_read,
+		.pmu_enable = arm_ccn_pmu_enable,
+		.pmu_disable = arm_ccn_pmu_disable,
 	};
 
 	/* No overflow interrupt? Have to use a timer instead. */
-- 
1.9.1
