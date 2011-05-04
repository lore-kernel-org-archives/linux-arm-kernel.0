From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 May 2011 09:23:51 +0100
Subject: [RFC PATCH 07/15] ARM: perf: indirect access to cpu_hw_events
Message-ID: <mailman.77.1313415783.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, cpu_hw_events is a global per-CPU variable. To enable
support for multiple PMUs, there needs to be a mapping from an instance
of arm_pmu to its cpu_hw_events. Additionally, as system PMUs are not
CPU-affine, they should not have this stored per-CPU.

This patch moves access to the hardware events data behind an accessor
function (arm_pmu::get_hw_events). This allows each instance to have
its own hardware event data, which can be stored per-CPU or globally as
required.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 1d648d1..9d6ac99 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -84,6 +84,7 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	struct platform_device	*plat_device;
+	struct cpu_hw_events	*(*get_hw_events)(void);
 };
 
 /* Set at runtime when we know what CPU type we are. */
@@ -284,7 +285,7 @@ armpmu_start(struct perf_event *event, int flags)
 static void
 armpmu_del(struct perf_event *event, int flags)
 {
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -300,7 +301,7 @@ armpmu_del(struct perf_event *event, int flags)
 static int
 armpmu_add(struct perf_event *event, int flags)
 {
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 	int err = 0;
@@ -585,7 +586,7 @@ static void armpmu_enable(struct pmu *pmu)
 {
 	/* Enable all of the perf events on hardware. */
 	int idx, enabled = 0;
-	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
 
 	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
@@ -678,6 +679,16 @@ static int __init register_pmu_driver(void)
 }
 device_initcall(register_pmu_driver);
 
+static struct cpu_hw_events *armpmu_get_cpu_events(void)
+{
+	return &__get_cpu_var(cpu_hw_events);
+}
+
+static void __init cpu_pmu_init(struct arm_pmu *armpmu)
+{
+	armpmu->get_hw_events = armpmu_get_cpu_events;
+}
+
 /*
  * CPU PMU identification and registration.
  */
@@ -728,6 +739,7 @@ init_hw_perf_events(void)
 	if (armpmu) {
 		pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
+		cpu_pmu_init(armpmu);
 		armpmu_init(armpmu);
 		perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 	} else {
-- 
1.7.0.4
