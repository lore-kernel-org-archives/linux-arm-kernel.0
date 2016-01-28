From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 28 Jan 2016 15:55:03 +0100
Subject: [PATCH v2 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <cover.1453992560.git.jglauber@cavium.com>
References: <cover.1453992560.git.jglauber@cavium.com>
Message-ID: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.1 increases the PMU event number space. Detect the
presence of this PMUv3 type and extend the event mask.

The event mask is moved to struct arm_pmu so different event masks
can exist, depending on the PMU type.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/perf_event.c | 33 +++++++++++++++++++--------------
 drivers/perf/arm_pmu.c         |  5 +++--
 include/linux/perf/arm_pmu.h   |  4 ++--
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 5e4275e..78b24cb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -419,7 +419,7 @@ static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
+#define	ARMV8_EVTYPE_FLT_MASK	0xc8000000	/* Writable filter bits */
 #define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
 
 /*
@@ -510,10 +510,8 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
-	if (armv8pmu_select_counter(idx) == idx) {
-		val &= ARMV8_EVTYPE_MASK;
+	if (armv8pmu_select_counter(idx) == idx)
 		asm volatile("msr pmxevtyper_el0, %0" :: "r" (val));
-	}
 }
 
 static inline int armv8pmu_enable_counter(int idx)
@@ -570,6 +568,7 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
+	u32 val;
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
@@ -585,7 +584,8 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	/*
 	 * Set event (if destined for PMNx counters).
 	 */
-	armv8pmu_write_evtype(idx, hwc->config_base);
+	val = hwc->config_base & (ARMV8_EVTYPE_FLT_MASK | cpu_pmu->event_mask);
+	armv8pmu_write_evtype(idx, val);
 
 	/*
 	 * Enable interrupt for this counter
@@ -716,7 +716,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	int idx;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	unsigned long evtype = hwc->config_base & ARMV8_EVTYPE_EVENT;
+	unsigned long evtype = hwc->config_base & cpu_pmu->event_mask;
 
 	/* Always place a cycle counter into the cycle counter. */
 	if (evtype == ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES) {
@@ -786,29 +786,25 @@ static void armv8pmu_reset(void *info)
 static int armv8_pmuv3_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				&armv8_pmuv3_perf_cache_map,
-				ARMV8_EVTYPE_EVENT);
+				&armv8_pmuv3_perf_cache_map);
 }
 
 static int armv8_a53_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv8_a53_perf_map,
-				&armv8_a53_perf_cache_map,
-				ARMV8_EVTYPE_EVENT);
+				&armv8_a53_perf_cache_map);
 }
 
 static int armv8_a57_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv8_a57_perf_map,
-				&armv8_a57_perf_cache_map,
-				ARMV8_EVTYPE_EVENT);
+				&armv8_a57_perf_cache_map);
 }
 
 static int armv8_thunder_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv8_thunder_perf_map,
-				&armv8_thunder_perf_cache_map,
-				ARMV8_EVTYPE_EVENT);
+				&armv8_thunder_perf_cache_map);
 }
 
 static void armv8pmu_read_num_pmnc_events(void *info)
@@ -831,6 +827,8 @@ static int armv8pmu_probe_num_events(struct arm_pmu *arm_pmu)
 
 static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
 {
+	u64 id;
+
 	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
 	cpu_pmu->enable			= armv8pmu_enable_event,
 	cpu_pmu->disable		= armv8pmu_disable_event,
@@ -842,6 +840,13 @@ static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->max_period		= (1LLU << 32) - 1,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+
+	/* detect ARMv8.1 PMUv3 with extended event mask */
+	id = read_cpuid(ID_AA64DFR0_EL1);
+	if (((id >> 8) & 0xf) == 4)
+		cpu_pmu->event_mask = 0xffff;	/* ARMv8.1 extended events */
+	else
+		cpu_pmu->event_mask = ARMV8_EVTYPE_EVENT;
 }
 
 static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 166637f..79e681f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -79,9 +79,10 @@ armpmu_map_event(struct perf_event *event,
 		 const unsigned (*cache_map)
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
-				[PERF_COUNT_HW_CACHE_RESULT_MAX],
-		 u32 raw_event_mask)
+				[PERF_COUNT_HW_CACHE_RESULT_MAX])
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	u32 raw_event_mask = armpmu->event_mask;
 	u64 config = event->attr.config;
 	int type = event->attr.type;
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 83b5e34..9a4c3a9 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -101,6 +101,7 @@ struct arm_pmu {
 	void		(*free_irq)(struct arm_pmu *);
 	int		(*map_event)(struct perf_event *event);
 	int		num_events;
+	int		event_mask;
 	atomic_t	active_events;
 	struct mutex	reserve_mutex;
 	u64		max_period;
@@ -119,8 +120,7 @@ int armpmu_map_event(struct perf_event *event,
 		     const unsigned (*event_map)[PERF_COUNT_HW_MAX],
 		     const unsigned (*cache_map)[PERF_COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_OP_MAX]
-						[PERF_COUNT_HW_CACHE_RESULT_MAX],
-		     u32 raw_event_mask);
+						[PERF_COUNT_HW_CACHE_RESULT_MAX]);
 
 struct pmu_probe_info {
 	unsigned int cpuid;
-- 
1.9.1
