From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jun 2011 11:30:59 +0100
Subject: [RFC PATCH 13/15] ARM: perf: remove event limit from pmu_hw_events
Message-ID: <mailman.83.1313415786.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the event accounting data in pmu_hw_events is stored in
fixed-sized arrays within the structure.

This patch refactors the accounting data to allow any number of events
to be managed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 7f31eff..e1db555 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -42,13 +42,13 @@ struct cpu_hw_events {
 	/*
 	 * The events that are active on the CPU for the given index.
 	 */
-	struct perf_event	*events[ARMPMU_MAX_HWEVENTS];
+	struct perf_event	**events;
 
 	/*
 	 * A 1 bit for an index indicates that the counter is being used for
 	 * an event. A 0 means that the counter can be used.
 	 */
-	unsigned long		used_mask[BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)];
+	unsigned long           *used_mask;
 
 	/*
 	 * Hardware lock to serialize accesses to PMU registers. Needed for the
@@ -56,6 +56,9 @@ struct cpu_hw_events {
 	 */
 	raw_spinlock_t		pmu_lock;
 };
+
+static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
+static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 struct arm_pmu {
@@ -714,6 +717,8 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 	int cpu;
 	for_each_possible_cpu(cpu) {
 		struct cpu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
+		events->events = per_cpu(hw_events, cpu);
+		events->used_mask = per_cpu(used_mask, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
 	}
 	armpmu->get_hw_events = armpmu_get_cpu_events;
-- 
1.7.0.4
