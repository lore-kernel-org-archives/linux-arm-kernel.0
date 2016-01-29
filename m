From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 29 Jan 2016 09:29:32 +0100
Subject: [PATCH v2 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
References: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
Message-ID: <7944f006c35daeae9eb94fadb5c2bac1540ae050.1454054112.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.1 increases the PMU event number space. Detect the
presence of this PMUv3 type and extend the event mask.

The event mask is moved to struct arm_pmu so different event masks
can exist, depending on the PMU type.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm/kernel/perf_event_v6.c     |  6 ++++--
 arch/arm/kernel/perf_event_v7.c     | 29 +++++++++++++++++++----------
 arch/arm/kernel/perf_event_xscale.c |  4 +++-
 arch/arm64/kernel/perf_event.c      | 33 +++++++++++++++++++--------------
 drivers/perf/arm_pmu.c              |  5 +++--
 include/linux/perf/arm_pmu.h        |  4 ++--
 6 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 09413e7..d6769f5 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -481,7 +481,7 @@ static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 static int armv6_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv6_perf_map,
-				&armv6_perf_cache_map, 0xFF);
+				&armv6_perf_cache_map);
 }
 
 static void armv6pmu_init(struct arm_pmu *cpu_pmu)
@@ -494,6 +494,7 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
 	cpu_pmu->start		= armv6pmu_start;
 	cpu_pmu->stop		= armv6pmu_stop;
+	cpu_pmu->event_mask	= 0xFF;
 	cpu_pmu->map_event	= armv6_map_event;
 	cpu_pmu->num_events	= 3;
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
@@ -531,7 +532,7 @@ static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
 static int armv6mpcore_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv6mpcore_perf_map,
-				&armv6mpcore_perf_cache_map, 0xFF);
+				&armv6mpcore_perf_cache_map);
 }
 
 static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
@@ -545,6 +546,7 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
 	cpu_pmu->start		= armv6pmu_start;
 	cpu_pmu->stop		= armv6pmu_stop;
+	cpu_pmu->event_mask	= 0xFF;
 	cpu_pmu->map_event	= armv6mpcore_map_event;
 	cpu_pmu->num_events	= 3;
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 4152158..8aab098 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1042,7 +1042,7 @@ static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	int idx;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	unsigned long evtype = hwc->config_base & ARMV7_EVTYPE_EVENT;
+	unsigned long evtype = hwc->config_base & cpu_pmu->event_mask;
 
 	/* Always place a cycle counter into the cycle counter. */
 	if (evtype == ARMV7_PERFCTR_CPU_CYCLES) {
@@ -1109,55 +1109,55 @@ static void armv7pmu_reset(void *info)
 static int armv7_a8_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a8_perf_map,
-				&armv7_a8_perf_cache_map, 0xFF);
+				&armv7_a8_perf_cache_map);
 }
 
 static int armv7_a9_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a9_perf_map,
-				&armv7_a9_perf_cache_map, 0xFF);
+				&armv7_a9_perf_cache_map);
 }
 
 static int armv7_a5_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a5_perf_map,
-				&armv7_a5_perf_cache_map, 0xFF);
+				&armv7_a5_perf_cache_map);
 }
 
 static int armv7_a15_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a15_perf_map,
-				&armv7_a15_perf_cache_map, 0xFF);
+				&armv7_a15_perf_cache_map);
 }
 
 static int armv7_a7_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a7_perf_map,
-				&armv7_a7_perf_cache_map, 0xFF);
+				&armv7_a7_perf_cache_map);
 }
 
 static int armv7_a12_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a12_perf_map,
-				&armv7_a12_perf_cache_map, 0xFF);
+				&armv7_a12_perf_cache_map);
 }
 
 static int krait_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &krait_perf_map,
-				&krait_perf_cache_map, 0xFFFFF);
+				&krait_perf_cache_map);
 }
 
 static int krait_map_event_no_branch(struct perf_event *event)
 {
 	return armpmu_map_event(event, &krait_perf_map_no_branch,
-				&krait_perf_cache_map, 0xFFFFF);
+				&krait_perf_cache_map);
 }
 
 static int scorpion_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &scorpion_perf_map,
-				&scorpion_perf_cache_map, 0xFFFFF);
+				&scorpion_perf_cache_map);
 }
 
 static void armv7pmu_init(struct arm_pmu *cpu_pmu)
@@ -1196,6 +1196,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a8";
+	cpu_pmu->event_mask	= ARMV7_EVTYPE_EVENT;
 	cpu_pmu->map_event	= armv7_a8_map_event;
 	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
@@ -1205,6 +1206,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a9";
+	cpu_pmu->event_mask	= ARMV7_EVTYPE_EVENT;
 	cpu_pmu->map_event	= armv7_a9_map_event;
 	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
@@ -1214,6 +1216,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a5";
+	cpu_pmu->event_mask	= ARMV7_EVTYPE_EVENT;
 	cpu_pmu->map_event	= armv7_a5_map_event;
 	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
@@ -1223,6 +1226,7 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a15";
+	cpu_pmu->event_mask	= ARMV7_EVTYPE_EVENT;
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
 	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
@@ -1233,6 +1237,7 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a7";
+	cpu_pmu->event_mask	= ARMV7_EVTYPE_EVENT;
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
 	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
@@ -1243,6 +1248,7 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a12";
+	cpu_pmu->event_mask	= ARMV7_EVTYPE_EVENT;
 	cpu_pmu->map_event	= armv7_a12_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
 	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
@@ -1628,6 +1634,7 @@ static int krait_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_krait";
+	cpu_pmu->event_mask	= 0xFFFFF;
 	/* Some early versions of Krait don't support PC write events */
 	if (of_property_read_bool(cpu_pmu->plat_device->dev.of_node,
 				  "qcom,no-pc-write"))
@@ -1957,6 +1964,7 @@ static int scorpion_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_scorpion";
+	cpu_pmu->event_mask	= 0xFFFFF;
 	cpu_pmu->map_event	= scorpion_map_event;
 	cpu_pmu->reset		= scorpion_pmu_reset;
 	cpu_pmu->enable		= scorpion_pmu_enable_event;
@@ -1970,6 +1978,7 @@ static int scorpion_mp_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_scorpion_mp";
+	cpu_pmu->event_mask	= 0xFFFFF;
 	cpu_pmu->map_event	= scorpion_map_event;
 	cpu_pmu->reset		= scorpion_pmu_reset;
 	cpu_pmu->enable		= scorpion_pmu_enable_event;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index aa0499e..8708691 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -358,7 +358,7 @@ static inline void xscale1pmu_write_counter(struct perf_event *event, u32 val)
 static int xscale_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &xscale_perf_map,
-				&xscale_perf_cache_map, 0xFF);
+				&xscale_perf_cache_map);
 }
 
 static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
@@ -372,6 +372,7 @@ static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	= xscale1pmu_get_event_idx;
 	cpu_pmu->start		= xscale1pmu_start;
 	cpu_pmu->stop		= xscale1pmu_stop;
+	cpu_pmu->event_mask	= 0xFF;
 	cpu_pmu->map_event	= xscale_map_event;
 	cpu_pmu->num_events	= 3;
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
@@ -742,6 +743,7 @@ static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	= xscale2pmu_get_event_idx;
 	cpu_pmu->start		= xscale2pmu_start;
 	cpu_pmu->stop		= xscale2pmu_stop;
+	cpu_pmu->event_mask	= 0xFF;
 	cpu_pmu->map_event	= xscale_map_event;
 	cpu_pmu->num_events	= 5;
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
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
