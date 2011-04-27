From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Apr 2011 10:31:51 +0100
Subject: [RFC PATCH 02/15] ARM: perf: only register a CPU PMU when present
Message-ID: <mailman.72.1313415781.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, an "empty" struct pmu is registered as the CPU PMU,
regardless of whether there is a physical PMU. This burdens the
accessor functions with checks to see whether a PMU is actually
present.

This patch changes initialisation to register a PMU only if there is a
supported PMU present, and removes the checks that this change makes
redundant.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5d60c9c..753648c 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -250,9 +250,6 @@ armpmu_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (!armpmu)
-		return;
-
 	/*
 	 * ARM pmu always has to update the counter, so ignore
 	 * PERF_EF_UPDATE, see comments in armpmu_start().
@@ -270,9 +267,6 @@ armpmu_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (!armpmu)
-		return;
-
 	/*
 	 * ARM pmu always has to reprogram the period, so ignore
 	 * PERF_EF_RELOAD, see the comment below.
@@ -567,9 +561,6 @@ static int armpmu_event_init(struct perf_event *event)
 		return -ENOENT;
 	}
 
-	if (!armpmu)
-		return -ENODEV;
-
 	event->destroy = hw_perf_event_destroy;
 
 	if (!atomic_inc_not_zero(&active_events)) {
@@ -599,9 +590,6 @@ static void armpmu_enable(struct pmu *pmu)
 	int idx, enabled = 0;
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 
-	if (!armpmu)
-		return;
-
 	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 
@@ -618,8 +606,7 @@ static void armpmu_enable(struct pmu *pmu)
 
 static void armpmu_disable(struct pmu *pmu)
 {
-	if (armpmu)
-		armpmu->stop();
+	armpmu->stop();
 }
 
 static struct pmu pmu = {
@@ -738,12 +725,11 @@ init_hw_perf_events(void)
 	if (armpmu) {
 		pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
+		perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 	} else {
 		pr_info("no hardware support available\n");
 	}
 
-	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
-
 	return 0;
 }
 early_initcall(init_hw_perf_events);
-- 
1.7.0.4
