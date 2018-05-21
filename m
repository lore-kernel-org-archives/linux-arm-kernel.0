From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 21 May 2018 12:17:09 +0100
Subject: [PATCH] perf/arm-cci: Remove unnecessary period adjustment
Message-ID: <9e5b7638ff44111334aff53b76bdcd1f26f08179.1526901337.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since sampling events are rejected up-front by cci_pmu_event_init(), it
doesn't make much sense to go fiddling with the sampling period later.
This would seem to be just another leftover artefact of the arm_pmu
framwork, and as such can go.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 09938dd8eb6f..e6fadc8e1178 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1297,15 +1297,6 @@ static int __hw_perf_event_init(struct perf_event *event)
 	 */
 	hwc->config_base	    |= (unsigned long)mapping;
 
-	/*
-	 * Limit the sample_period to half of the counter width. That way, the
-	 * new counter value is far less likely to overtake the previous one
-	 * unless you have some serious IRQ latency issues.
-	 */
-	hwc->sample_period  = CCI_PMU_CNTR_MASK >> 1;
-	hwc->last_period    = hwc->sample_period;
-	local64_set(&hwc->period_left, hwc->sample_period);
-
 	if (event->group_leader != event) {
 		if (validate_group(event) != 0)
 			return -EINVAL;
-- 
2.17.0.dirty
