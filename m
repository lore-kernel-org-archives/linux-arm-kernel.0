From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Apr 2011 11:20:11 +0100
Subject: [RFC PATCH 05/15] ARM: perf: move active_events into struct arm_pmu
Message-ID: <mailman.75.1313415782.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the active_events counter into struct arm_pmu, in
preparation for supporting multiple PMUs. This also moves
pmu_reserve_mutex, as it is used to guard accesses to active_events.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 438482f..9874395 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -82,6 +82,8 @@ struct arm_pmu {
 	const unsigned	(*event_map)[PERF_COUNT_HW_MAX];
 	u32		raw_event_mask;
 	int		num_events;
+	atomic_t	active_events;
+	struct mutex	reserve_mutex;
 	u64		max_period;
 };
 
@@ -454,15 +456,15 @@ armpmu_reserve_hardware(void)
 	return 0;
 }
 
-static atomic_t active_events = ATOMIC_INIT(0);
-static DEFINE_MUTEX(pmu_reserve_mutex);
-
 static void
 hw_perf_event_destroy(struct perf_event *event)
 {
-	if (atomic_dec_and_mutex_lock(&active_events, &pmu_reserve_mutex)) {
+	atomic_t *active_events	 = &armpmu->active_events;
+	struct mutex *pmu_reserve_mutex = &armpmu->reserve_mutex;
+
+	if (atomic_dec_and_mutex_lock(active_events, pmu_reserve_mutex)) {
 		armpmu_release_hardware();
-		mutex_unlock(&pmu_reserve_mutex);
+		mutex_unlock(pmu_reserve_mutex);
 	}
 }
 
@@ -543,6 +545,7 @@ __hw_perf_event_init(struct perf_event *event)
 static int armpmu_event_init(struct perf_event *event)
 {
 	int err = 0;
+	atomic_t *active_events = &armpmu->active_events;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_RAW:
@@ -556,15 +559,14 @@ static int armpmu_event_init(struct perf_event *event)
 
 	event->destroy = hw_perf_event_destroy;
 
-	if (!atomic_inc_not_zero(&active_events)) {
-		mutex_lock(&pmu_reserve_mutex);
-		if (atomic_read(&active_events) == 0) {
+	if (!atomic_inc_not_zero(active_events)) {
+		mutex_lock(&armpmu->reserve_mutex);
+		if (atomic_read(active_events) == 0)
 			err = armpmu_reserve_hardware();
-		}
 
 		if (!err)
-			atomic_inc(&active_events);
-		mutex_unlock(&pmu_reserve_mutex);
+			atomic_inc(active_events);
+		mutex_unlock(&armpmu->reserve_mutex);
 	}
 
 	if (err)
@@ -613,6 +615,12 @@ static struct pmu pmu = {
 	.read		= armpmu_read,
 };
 
+static void __init armpmu_init(struct arm_pmu *armpmu)
+{
+	atomic_set(&armpmu->active_events, 0);
+	mutex_init(&armpmu->reserve_mutex);
+}
+
 /* Include the PMU-specific implementations. */
 #include "perf_event_xscale.c"
 #include "perf_event_v6.c"
@@ -718,6 +726,7 @@ init_hw_perf_events(void)
 	if (armpmu) {
 		pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
+		armpmu_init(armpmu);
 		perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 	} else {
 		pr_info("no hardware support available\n");
-- 
1.7.0.4
