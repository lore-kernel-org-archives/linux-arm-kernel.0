From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 May 2011 11:20:11 +0100
Subject: [RFC PATCH 14/15] ARM: perf: remove cpu-related misnomers
Message-ID: <mailman.84.1313415787.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently struct cpu_hw_events stores data on events running on a
PMU associated with a CPU. As this data is general enough to be used
for system PMUs, this name is a misnomer, and may cause confusion when
it is used for system PMUs.

Additionally, 'armpmu' is commonly used as a parameter name for an
instance of struct arm_pmu. The name is also used for a global instance
which represents the CPU's PMU.

As cpu_hw_events is now not tied to CPU PMUs, it is renamed to
pmu_hw_events, with instances of it renamed similarly. As the global
'armpmu' is CPU-specfic, it is renamed to cpu_pmu. This should make it
clearer which code is generic, and which is coupled with the CPU.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c        |   84 +++++++++++++++++-----------------
 arch/arm/kernel/perf_event_v6.c     |   18 ++++----
 arch/arm/kernel/perf_event_v7.c     |   22 +++++-----
 arch/arm/kernel/perf_event_xscale.c |   32 +++++++-------
 4 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index e1db555..8315133 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -37,10 +37,10 @@
  */
 #define ARMPMU_MAX_HWEVENTS		32
 
-/* The events for a given CPU. */
-struct cpu_hw_events {
+/* The events for a given PMU register set. */
+struct pmu_hw_events {
 	/*
-	 * The events that are active on the CPU for the given index.
+	 * The events that are active on the PMU for the given index.
 	 */
 	struct perf_event	**events;
 
@@ -59,7 +59,7 @@ struct cpu_hw_events {
 
 static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
 static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
-static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
 
 struct arm_pmu {
 	struct pmu	pmu;
@@ -70,7 +70,7 @@ struct arm_pmu {
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct hw_perf_event *evt, int idx);
 	void		(*disable)(struct hw_perf_event *evt, int idx);
-	int		(*get_event_idx)(struct cpu_hw_events *cpuc,
+	int		(*get_event_idx)(struct pmu_hw_events *hw_events,
 					 struct hw_perf_event *hwc);
 	int		(*set_event_filter)(struct hw_perf_event *evt,
 					    struct perf_event_attr *attr);
@@ -85,21 +85,21 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	struct platform_device	*plat_device;
-	struct cpu_hw_events	*(*get_hw_events)(void);
+	struct pmu_hw_events	*(*get_hw_events)(void);
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
 /* Set at runtime when we know what CPU type we are. */
-static struct arm_pmu *armpmu;
+static struct arm_pmu *cpu_pmu;
 
 enum arm_perf_pmu_ids
 armpmu_get_pmu_id(void)
 {
 	int id = -ENODEV;
 
-	if (armpmu != NULL)
-		id = armpmu->id;
+	if (cpu_pmu != NULL)
+		id = cpu_pmu->id;
 
 	return id;
 }
@@ -110,8 +110,8 @@ armpmu_get_max_events(void)
 {
 	int max_events = 0;
 
-	if (armpmu != NULL)
-		max_events = armpmu->num_events;
+	if (cpu_pmu != NULL)
+		max_events = cpu_pmu->num_events;
 
 	return max_events;
 }
@@ -319,15 +319,15 @@ static void
 armpmu_del(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
 	WARN_ON(idx < 0);
 
 	armpmu_stop(event, PERF_EF_UPDATE);
-	cpuc->events[idx] = NULL;
-	clear_bit(idx, cpuc->used_mask);
+	hw_events->events[idx] = NULL;
+	clear_bit(idx, hw_events->used_mask);
 
 	perf_event_update_userpage(event);
 }
@@ -336,7 +336,7 @@ static int
 armpmu_add(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 	int err = 0;
@@ -344,7 +344,7 @@ armpmu_add(struct perf_event *event, int flags)
 	perf_pmu_disable(event->pmu);
 
 	/* If we don't have a space for the counter then finish early. */
-	idx = armpmu->get_event_idx(cpuc, hwc);
+	idx = armpmu->get_event_idx(hw_events, hwc);
 	if (idx < 0) {
 		err = idx;
 		goto out;
@@ -356,7 +356,7 @@ armpmu_add(struct perf_event *event, int flags)
 	 */
 	event->hw.idx = idx;
 	armpmu->disable(hwc, idx);
-	cpuc->events[idx] = event;
+	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	if (flags & PERF_EF_START)
@@ -371,7 +371,7 @@ out:
 }
 
 static int
-validate_event(struct cpu_hw_events *cpuc,
+validate_event(struct pmu_hw_events *hw_events,
 	       struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
@@ -381,14 +381,14 @@ validate_event(struct cpu_hw_events *cpuc,
 	if (event->pmu != leader_pmu || event->state <= PERF_EVENT_STATE_OFF)
 		return 1;
 
-	return armpmu->get_event_idx(cpuc, &fake_event) >= 0;
+	return armpmu->get_event_idx(hw_events, &fake_event) >= 0;
 }
 
 static int
 validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
-	struct cpu_hw_events fake_pmu;
+	struct pmu_hw_events fake_pmu;
 
 	memset(&fake_pmu, 0, sizeof(fake_pmu));
 
@@ -604,13 +604,13 @@ static int armpmu_event_init(struct perf_event *event)
 
 static void armpmu_enable(struct pmu *pmu)
 {
-	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	/* Enable all of the perf events on hardware. */
+	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	int idx, enabled = 0;
-	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
+	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
 
 	for (idx = 0; idx < armpmu->num_events; ++idx) {
-		struct perf_event *event = cpuc->events[idx];
+		struct perf_event *event = hw_events->events[idx];
 
 		if (!event)
 			continue;
@@ -662,13 +662,13 @@ static int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type)
  * This requires SMP to be available, so exists as a separate initcall.
  */
 static int __init
-armpmu_reset(void)
+cpu_pmu_reset(void)
 {
-	if (armpmu && armpmu->reset)
-		return on_each_cpu(armpmu->reset, NULL, 1);
+	if (cpu_pmu && cpu_pmu->reset)
+		return on_each_cpu(cpu_pmu->reset, NULL, 1);
 	return 0;
 }
-arch_initcall(armpmu_reset);
+arch_initcall(cpu_pmu_reset);
 
 /*
  * PMU platform driver and devicetree bindings.
@@ -688,7 +688,7 @@ static struct platform_device_id armpmu_plat_device_ids[] = {
 
 static int __devinit armpmu_device_probe(struct platform_device *pdev)
 {
-	armpmu->plat_device = pdev;
+	cpu_pmu->plat_device = pdev;
 	return 0;
 }
 
@@ -707,7 +707,7 @@ static int __init register_pmu_driver(void)
 }
 device_initcall(register_pmu_driver);
 
-static struct cpu_hw_events *armpmu_get_cpu_events(void)
+static struct pmu_hw_events *armpmu_get_cpu_events(void)
 {
 	return &__get_cpu_var(cpu_hw_events);
 }
@@ -716,7 +716,7 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 {
 	int cpu;
 	for_each_possible_cpu(cpu) {
-		struct cpu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
+		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
 		events->events = per_cpu(hw_events, cpu);
 		events->used_mask = per_cpu(used_mask, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
@@ -741,22 +741,22 @@ init_hw_perf_events(void)
 		case 0xB360:	/* ARM1136 */
 		case 0xB560:	/* ARM1156 */
 		case 0xB760:	/* ARM1176 */
-			armpmu = armv6pmu_init();
+			cpu_pmu = armv6pmu_init();
 			break;
 		case 0xB020:	/* ARM11mpcore */
-			armpmu = armv6mpcore_pmu_init();
+			cpu_pmu = armv6mpcore_pmu_init();
 			break;
 		case 0xC080:	/* Cortex-A8 */
-			armpmu = armv7_a8_pmu_init();
+			cpu_pmu = armv7_a8_pmu_init();
 			break;
 		case 0xC090:	/* Cortex-A9 */
-			armpmu = armv7_a9_pmu_init();
+			cpu_pmu = armv7_a9_pmu_init();
 			break;
 		case 0xC050:	/* Cortex-A5 */
-			armpmu = armv7_a5_pmu_init();
+			cpu_pmu = armv7_a5_pmu_init();
 			break;
 		case 0xC0F0:	/* Cortex-A15 */
-			armpmu = armv7_a15_pmu_init();
+			cpu_pmu = armv7_a15_pmu_init();
 			break;
 		}
 	/* Intel CPUs [xscale]. */
@@ -764,19 +764,19 @@ init_hw_perf_events(void)
 		part_number = (cpuid >> 13) & 0x7;
 		switch (part_number) {
 		case 1:
-			armpmu = xscale1pmu_init();
+			cpu_pmu = xscale1pmu_init();
 			break;
 		case 2:
-			armpmu = xscale2pmu_init();
+			cpu_pmu = xscale2pmu_init();
 			break;
 		}
 	}
 
-	if (armpmu) {
+	if (cpu_pmu) {
 		pr_info("enabled with %s PMU driver, %d counters available\n",
-			armpmu->name, armpmu->num_events);
-		cpu_pmu_init(armpmu);
-		armpmu_register(armpmu, "cpu", PERF_TYPE_RAW);
+			cpu_pmu->name, cpu_pmu->num_events);
+		cpu_pmu_init(cpu_pmu);
+		armpmu_register(cpu_pmu, "cpu", PERF_TYPE_RAW);
 	} else {
 		pr_info("no hardware support available\n");
 	}
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index a4c5aa9..e63d811 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -433,7 +433,7 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
 		      int idx)
 {
 	unsigned long val, mask, evt, flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= 0;
@@ -486,7 +486,7 @@ armv6pmu_handle_irq(int irq_num,
 {
 	unsigned long pmcr = armv6_pmcr_read();
 	struct perf_sample_data data;
-	struct cpu_hw_events *cpuc;
+	struct pmu_hw_events *cpuc;
 	struct pt_regs *regs;
 	int idx;
 
@@ -505,7 +505,7 @@ armv6pmu_handle_irq(int irq_num,
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx < armpmu->num_events; ++idx) {
+	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -526,7 +526,7 @@ armv6pmu_handle_irq(int irq_num,
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			armpmu->disable(hwc, idx);
+			cpu_pmu->disable(hwc, idx);
 	}
 
 	/*
@@ -545,7 +545,7 @@ static void
 armv6pmu_start(void)
 {
 	unsigned long flags, val;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
@@ -558,7 +558,7 @@ static void
 armv6pmu_stop(void)
 {
 	unsigned long flags, val;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
@@ -568,7 +568,7 @@ armv6pmu_stop(void)
 }
 
 static int
-armv6pmu_get_event_idx(struct cpu_hw_events *cpuc,
+armv6pmu_get_event_idx(struct pmu_hw_events *cpuc,
 		       struct hw_perf_event *event)
 {
 	/* Always place a cycle counter into the cycle counter. */
@@ -598,7 +598,7 @@ armv6pmu_disable_event(struct hw_perf_event *hwc,
 		       int idx)
 {
 	unsigned long val, mask, evt, flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= ARMV6_PMCR_CCOUNT_IEN;
@@ -632,7 +632,7 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 			      int idx)
 {
 	unsigned long val, mask, flags, evt = 0;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= ARMV6_PMCR_CCOUNT_IEN;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index be7b58a..98b7573 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -683,7 +683,7 @@ static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
  */
 #define	ARMV7_IDX_CYCLE_COUNTER	0
 #define	ARMV7_IDX_COUNTER0	1
-#define	ARMV7_IDX_COUNTER_LAST	(ARMV7_IDX_CYCLE_COUNTER + armpmu->num_events - 1)
+#define	ARMV7_IDX_COUNTER_LAST	(ARMV7_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
 
 #define	ARMV7_MAX_COUNTERS	32
 #define	ARMV7_COUNTER_MASK	(ARMV7_MAX_COUNTERS - 1)
@@ -936,7 +936,7 @@ static void armv7_pmnc_dump_regs(void)
 static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
@@ -973,7 +973,7 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	/*
 	 * Disable counter and interrupt
@@ -997,7 +997,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 {
 	u32 pmnc;
 	struct perf_sample_data data;
-	struct cpu_hw_events *cpuc;
+	struct pmu_hw_events *cpuc;
 	struct pt_regs *regs;
 	int idx;
 
@@ -1020,7 +1020,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx < armpmu->num_events; ++idx) {
+	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -1038,7 +1038,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			armpmu->disable(hwc, idx);
+			cpu_pmu->disable(hwc, idx);
 	}
 
 	/*
@@ -1056,7 +1056,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 static void armv7pmu_start(void)
 {
 	unsigned long flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
@@ -1067,7 +1067,7 @@ static void armv7pmu_start(void)
 static void armv7pmu_stop(void)
 {
 	unsigned long flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
@@ -1075,7 +1075,7 @@ static void armv7pmu_stop(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
+static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				  struct hw_perf_event *event)
 {
 	int idx;
@@ -1093,7 +1093,7 @@ static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
 	 * For anything other than a cycle counter, try and use
 	 * the events counters
 	 */
-	for (idx = ARMV7_IDX_COUNTER0; idx < armpmu->num_events; ++idx) {
+	for (idx = ARMV7_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -1130,7 +1130,7 @@ static int armv7pmu_set_event_filter(struct hw_perf_event *event,
 
 static void armv7pmu_reset(void *info)
 {
-	u32 idx, nb_cnt = armpmu->num_events;
+	u32 idx, nb_cnt = cpu_pmu->num_events;
 
 	/* The counter and interrupt enable registers are unknown at reset. */
 	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx)
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index d4c7610..e0cca10 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -222,7 +222,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 {
 	unsigned long pmnc;
 	struct perf_sample_data data;
-	struct cpu_hw_events *cpuc;
+	struct pmu_hw_events *cpuc;
 	struct pt_regs *regs;
 	int idx;
 
@@ -249,7 +249,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx < armpmu->num_events; ++idx) {
+	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -263,7 +263,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			armpmu->disable(hwc, idx);
+			cpu_pmu->disable(hwc, idx);
 	}
 
 	irq_work_run();
@@ -281,7 +281,7 @@ static void
 xscale1pmu_enable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long val, mask, evt, flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
@@ -315,7 +315,7 @@ static void
 xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long val, mask, evt, flags;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
@@ -344,7 +344,7 @@ xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
 }
 
 static int
-xscale1pmu_get_event_idx(struct cpu_hw_events *cpuc,
+xscale1pmu_get_event_idx(struct pmu_hw_events *cpuc,
 			struct hw_perf_event *event)
 {
 	if (XSCALE_PERFCTR_CCNT == event->config_base) {
@@ -367,7 +367,7 @@ static void
 xscale1pmu_start(void)
 {
 	unsigned long flags, val;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
@@ -380,7 +380,7 @@ static void
 xscale1pmu_stop(void)
 {
 	unsigned long flags, val;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
@@ -565,7 +565,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 {
 	unsigned long pmnc, of_flags;
 	struct perf_sample_data data;
-	struct cpu_hw_events *cpuc;
+	struct pmu_hw_events *cpuc;
 	struct pt_regs *regs;
 	int idx;
 
@@ -586,7 +586,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx < armpmu->num_events; ++idx) {
+	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -600,7 +600,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			armpmu->disable(hwc, idx);
+			cpu_pmu->disable(hwc, idx);
 	}
 
 	irq_work_run();
@@ -618,7 +618,7 @@ static void
 xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags, ien, evtsel;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	ien = xscale2pmu_read_int_enable();
 	evtsel = xscale2pmu_read_event_select();
@@ -662,7 +662,7 @@ static void
 xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags, ien, evtsel;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	ien = xscale2pmu_read_int_enable();
 	evtsel = xscale2pmu_read_event_select();
@@ -703,7 +703,7 @@ xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 }
 
 static int
-xscale2pmu_get_event_idx(struct cpu_hw_events *cpuc,
+xscale2pmu_get_event_idx(struct pmu_hw_events *cpuc,
 			struct hw_perf_event *event)
 {
 	int idx = xscale1pmu_get_event_idx(cpuc, event);
@@ -722,7 +722,7 @@ static void
 xscale2pmu_start(void)
 {
 	unsigned long flags, val;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
@@ -735,7 +735,7 @@ static void
 xscale2pmu_stop(void)
 {
 	unsigned long flags, val;
-	struct cpu_hw_events *events = armpmu->get_hw_events();
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
-- 
1.7.0.4
