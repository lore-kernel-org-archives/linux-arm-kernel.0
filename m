From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:33:40 +0100
Subject: [PATCH 3/7] ARM: perf: consistently use struct perf_event in arm_pmu
 functions
In-Reply-To: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
References: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488024-3224-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>

The arm_pmu functions have wildly varied parameters which can often be
derived from struct perf_event.

This patch changes the arm_pmu function prototypes so that struct
perf_event pointers are passed in preference to fields that can be
derived from the event.

Signed-off-by: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h          |   26 +++++------
 arch/arm/kernel/perf_event.c        |   44 ++++++++----------
 arch/arm/kernel/perf_event_cpu.c    |    8 ++--
 arch/arm/kernel/perf_event_v6.c     |   54 ++++++++++++----------
 arch/arm/kernel/perf_event_v7.c     |   46 +++++++++++++------
 arch/arm/kernel/perf_event_xscale.c |   85 ++++++++++++++++++++---------------
 6 files changed, 142 insertions(+), 121 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index a26170d..a209a38 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -67,19 +67,19 @@ struct arm_pmu {
 	cpumask_t	active_irqs;
 	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
-	void		(*enable)(struct hw_perf_event *evt, int idx);
-	void		(*disable)(struct hw_perf_event *evt, int idx);
+	void		(*enable)(struct perf_event *event);
+	void		(*disable)(struct perf_event *event);
 	int		(*get_event_idx)(struct pmu_hw_events *hw_events,
-					 struct hw_perf_event *hwc);
+					 struct perf_event *event);
 	int		(*set_event_filter)(struct hw_perf_event *evt,
 					    struct perf_event_attr *attr);
-	u32		(*read_counter)(int idx);
-	void		(*write_counter)(int idx, u32 val);
-	void		(*start)(void);
-	void		(*stop)(void);
+	u32		(*read_counter)(struct perf_event *event);
+	void		(*write_counter)(struct perf_event *event, u32 val);
+	void		(*start)(struct arm_pmu *);
+	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
-	int		(*request_irq)(irq_handler_t handler);
-	void		(*free_irq)(void);
+	int		(*request_irq)(struct arm_pmu *, irq_handler_t handler);
+	void		(*free_irq)(struct arm_pmu *);
 	int		(*map_event)(struct perf_event *event);
 	int		num_events;
 	atomic_t	active_events;
@@ -95,13 +95,9 @@ extern const struct dev_pm_ops armpmu_dev_pm_ops;
 
 int armpmu_register(struct arm_pmu *armpmu, char *name, int type);
 
-u64 armpmu_event_update(struct perf_event *event,
-			struct hw_perf_event *hwc,
-			int idx);
+u64 armpmu_event_update(struct perf_event *event);
 
-int armpmu_event_set_period(struct perf_event *event,
-			    struct hw_perf_event *hwc,
-			    int idx);
+int armpmu_event_set_period(struct perf_event *event);
 
 int armpmu_map_event(struct perf_event *event,
 		     const unsigned (*event_map)[PERF_COUNT_HW_MAX],
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 27413aa..710c65c 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -86,12 +86,10 @@ armpmu_map_event(struct perf_event *event,
 	return -ENOENT;
 }
 
-int
-armpmu_event_set_period(struct perf_event *event,
-			struct hw_perf_event *hwc,
-			int idx)
+int armpmu_event_set_period(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	s64 left = local64_read(&hwc->period_left);
 	s64 period = hwc->sample_period;
 	int ret = 0;
@@ -115,24 +113,22 @@ armpmu_event_set_period(struct perf_event *event,
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	armpmu->write_counter(idx, (u64)(-left) & 0xffffffff);
+	armpmu->write_counter(event, (u64)(-left) & 0xffffffff);
 
 	perf_event_update_userpage(event);
 
 	return ret;
 }
 
-u64
-armpmu_event_update(struct perf_event *event,
-		    struct hw_perf_event *hwc,
-		    int idx)
+u64 armpmu_event_update(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	u64 delta, prev_raw_count, new_raw_count;
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	new_raw_count = armpmu->read_counter(idx);
+	new_raw_count = armpmu->read_counter(event);
 
 	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
 			     new_raw_count) != prev_raw_count)
@@ -155,7 +151,7 @@ armpmu_read(struct perf_event *event)
 	if (hwc->idx < 0)
 		return;
 
-	armpmu_event_update(event, hwc, hwc->idx);
+	armpmu_event_update(event);
 }
 
 static void
@@ -169,14 +165,13 @@ armpmu_stop(struct perf_event *event, int flags)
 	 * PERF_EF_UPDATE, see comments in armpmu_start().
 	 */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
-		armpmu->disable(hwc, hwc->idx);
-		armpmu_event_update(event, hwc, hwc->idx);
+		armpmu->disable(event);
+		armpmu_event_update(event);
 		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	}
 }
 
-static void
-armpmu_start(struct perf_event *event, int flags)
+static void armpmu_start(struct perf_event *event, int flags)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -196,8 +191,8 @@ armpmu_start(struct perf_event *event, int flags)
 	 * get an interrupt too soon or *way* too late if the overflow has
 	 * happened since disabling.
 	 */
-	armpmu_event_set_period(event, hwc, hwc->idx);
-	armpmu->enable(hwc, hwc->idx);
+	armpmu_event_set_period(event);
+	armpmu->enable(event);
 }
 
 static void
@@ -229,7 +224,7 @@ armpmu_add(struct perf_event *event, int flags)
 	perf_pmu_disable(event->pmu);
 
 	/* If we don't have a space for the counter then finish early. */
-	idx = armpmu->get_event_idx(hw_events, hwc);
+	idx = armpmu->get_event_idx(hw_events, event);
 	if (idx < 0) {
 		err = idx;
 		goto out;
@@ -240,7 +235,7 @@ armpmu_add(struct perf_event *event, int flags)
 	 * sure it is disabled.
 	 */
 	event->hw.idx = idx;
-	armpmu->disable(hwc, idx);
+	armpmu->disable(event);
 	hw_events->events[idx] = event;
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
@@ -260,13 +255,12 @@ validate_event(struct pmu_hw_events *hw_events,
 	       struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event fake_event = event->hw;
 	struct pmu *leader_pmu = event->group_leader->pmu;
 
 	if (event->pmu != leader_pmu || event->state <= PERF_EVENT_STATE_OFF)
 		return 1;
 
-	return armpmu->get_event_idx(hw_events, &fake_event) >= 0;
+	return armpmu->get_event_idx(hw_events, event) >= 0;
 }
 
 static int
@@ -312,7 +306,7 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 static void
 armpmu_release_hardware(struct arm_pmu *armpmu)
 {
-	armpmu->free_irq();
+	armpmu->free_irq(armpmu);
 	pm_runtime_put_sync(&armpmu->plat_device->dev);
 }
 
@@ -326,7 +320,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		return -ENODEV;
 
 	pm_runtime_get_sync(&pmu_device->dev);
-	err = armpmu->request_irq(armpmu_dispatch_irq);
+	err = armpmu->request_irq(armpmu, armpmu_dispatch_irq);
 	if (err) {
 		armpmu_release_hardware(armpmu);
 		return err;
@@ -461,13 +455,13 @@ static void armpmu_enable(struct pmu *pmu)
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
 
 	if (enabled)
-		armpmu->start();
+		armpmu->start(armpmu);
 }
 
 static void armpmu_disable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
-	armpmu->stop();
+	armpmu->stop(armpmu);
 }
 
 #ifdef CONFIG_PM_RUNTIME
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 3863fd4..02244fa 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -71,7 +71,7 @@ static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
 	return &__get_cpu_var(cpu_hw_events);
 }
 
-static void cpu_pmu_free_irq(void)
+static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = cpu_pmu->plat_device;
@@ -87,7 +87,7 @@ static void cpu_pmu_free_irq(void)
 	}
 }
 
-static int cpu_pmu_request_irq(irq_handler_t handler)
+static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 {
 	int i, err, irq, irqs;
 	struct platform_device *pmu_device = cpu_pmu->plat_device;
@@ -148,7 +148,7 @@ static void __devinit cpu_pmu_init(struct arm_pmu *cpu_pmu)
 
 	/* Ensure the PMU has sane values out of reset. */
 	if (cpu_pmu && cpu_pmu->reset)
-		on_each_cpu(cpu_pmu->reset, NULL, 1);
+		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
 }
 
 /*
@@ -164,7 +164,7 @@ static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
 		return NOTIFY_DONE;
 
 	if (cpu_pmu && cpu_pmu->reset)
-		cpu_pmu->reset(NULL);
+		cpu_pmu->reset(cpu_pmu);
 
 	return NOTIFY_OK;
 }
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 3908cb4..f3e22ff 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -401,9 +401,10 @@ armv6_pmcr_counter_has_overflowed(unsigned long pmcr,
 	return ret;
 }
 
-static inline u32
-armv6pmu_read_counter(int counter)
+static inline u32 armv6pmu_read_counter(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 	unsigned long value = 0;
 
 	if (ARMV6_CYCLE_COUNTER == counter)
@@ -418,10 +419,11 @@ armv6pmu_read_counter(int counter)
 	return value;
 }
 
-static inline void
-armv6pmu_write_counter(int counter,
-		       u32 value)
+static inline void armv6pmu_write_counter(struct perf_event *event, u32 value)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
 	if (ARMV6_CYCLE_COUNTER == counter)
 		asm volatile("mcr   p15, 0, %0, c15, c12, 1" : : "r"(value));
 	else if (ARMV6_COUNTER0 == counter)
@@ -432,12 +434,13 @@ armv6pmu_write_counter(int counter,
 		WARN_ONCE(1, "invalid counter number (%d)\n", counter);
 }
 
-static void
-armv6pmu_enable_event(struct hw_perf_event *hwc,
-		      int idx)
+static void armv6pmu_enable_event(struct perf_event *event)
 {
 	unsigned long val, mask, evt, flags;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= 0;
@@ -473,7 +476,8 @@ armv6pmu_handle_irq(int irq_num,
 {
 	unsigned long pmcr = armv6_pmcr_read();
 	struct perf_sample_data data;
-	struct pmu_hw_events *cpuc;
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
 	struct pt_regs *regs;
 	int idx;
 
@@ -489,7 +493,6 @@ armv6pmu_handle_irq(int irq_num,
 	 */
 	armv6_pmcr_write(pmcr);
 
-	cpuc = &__get_cpu_var(cpu_hw_events);
 	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
@@ -506,13 +509,13 @@ armv6pmu_handle_irq(int irq_num,
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (!armpmu_event_set_period(event, hwc, idx))
+		if (!armpmu_event_set_period(event))
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(hwc, idx);
+			cpu_pmu->disable(event);
 	}
 
 	/*
@@ -527,8 +530,7 @@ armv6pmu_handle_irq(int irq_num,
 	return IRQ_HANDLED;
 }
 
-static void
-armv6pmu_start(void)
+static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -540,8 +542,7 @@ armv6pmu_start(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void
-armv6pmu_stop(void)
+static void armv6pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -555,10 +556,11 @@ armv6pmu_stop(void)
 
 static int
 armv6pmu_get_event_idx(struct pmu_hw_events *cpuc,
-		       struct hw_perf_event *event)
+				struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	/* Always place a cycle counter into the cycle counter. */
-	if (ARMV6_PERFCTR_CPU_CYCLES == event->config_base) {
+	if (ARMV6_PERFCTR_CPU_CYCLES == hwc->config_base) {
 		if (test_and_set_bit(ARMV6_CYCLE_COUNTER, cpuc->used_mask))
 			return -EAGAIN;
 
@@ -579,12 +581,13 @@ armv6pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	}
 }
 
-static void
-armv6pmu_disable_event(struct hw_perf_event *hwc,
-		       int idx)
+static void armv6pmu_disable_event(struct perf_event *event)
 {
 	unsigned long val, mask, evt, flags;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= ARMV6_PMCR_CCOUNT_IEN;
@@ -613,12 +616,13 @@ armv6pmu_disable_event(struct hw_perf_event *hwc,
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void
-armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
-			      int idx)
+static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 {
 	unsigned long val, mask, flags, evt = 0;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= ARMV6_PMCR_CCOUNT_IEN;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index b189403..1183c81 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -840,8 +840,10 @@ static inline int armv7_pmnc_select_counter(int idx)
 	return idx;
 }
 
-static inline u32 armv7pmu_read_counter(int idx)
+static inline u32 armv7pmu_read_counter(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
 	u32 value = 0;
 
 	if (!armv7_pmnc_counter_valid(idx))
@@ -855,8 +857,11 @@ static inline u32 armv7pmu_read_counter(int idx)
 	return value;
 }
 
-static inline void armv7pmu_write_counter(int idx, u32 value)
+static inline void armv7pmu_write_counter(struct perf_event *event, u32 value)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
 	if (!armv7_pmnc_counter_valid(idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
@@ -991,10 +996,13 @@ static void armv7_pmnc_dump_regs(void)
 }
 #endif
 
-static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
+static void armv7pmu_enable_event(struct perf_event *event)
 {
 	unsigned long flags;
+	struct hw_perf_event *hwc = &event->hw;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
@@ -1028,10 +1036,13 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
+static void armv7pmu_disable_event(struct perf_event *event)
 {
 	unsigned long flags;
+	struct hw_perf_event *hwc = &event->hw;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	/*
 	 * Disable counter and interrupt
@@ -1055,7 +1066,8 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 {
 	u32 pmnc;
 	struct perf_sample_data data;
-	struct pmu_hw_events *cpuc;
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
 	struct pt_regs *regs;
 	int idx;
 
@@ -1075,7 +1087,6 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	 */
 	regs = get_irq_regs();
 
-	cpuc = &__get_cpu_var(cpu_hw_events);
 	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
@@ -1092,13 +1103,13 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (!armpmu_event_set_period(event, hwc, idx))
+		if (!armpmu_event_set_period(event))
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(hwc, idx);
+			cpu_pmu->disable(event);
 	}
 
 	/*
@@ -1113,7 +1124,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void armv7pmu_start(void)
+static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -1124,7 +1135,7 @@ static void armv7pmu_start(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void armv7pmu_stop(void)
+static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -1136,10 +1147,12 @@ static void armv7pmu_stop(void)
 }
 
 static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				  struct hw_perf_event *event)
+				  struct perf_event *event)
 {
 	int idx;
-	unsigned long evtype = event->config_base & ARMV7_EVTYPE_EVENT;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long evtype = hwc->config_base & ARMV7_EVTYPE_EVENT;
 
 	/* Always place a cycle counter into the cycle counter. */
 	if (evtype == ARMV7_PERFCTR_CPU_CYCLES) {
@@ -1190,11 +1203,14 @@ static int armv7pmu_set_event_filter(struct hw_perf_event *event,
 
 static void armv7pmu_reset(void *info)
 {
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
 	u32 idx, nb_cnt = cpu_pmu->num_events;
 
 	/* The counter and interrupt enable registers are unknown at reset. */
-	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx)
-		armv7pmu_disable_event(NULL, idx);
+	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
+		armv7_pmnc_disable_counter(idx);
+		armv7_pmnc_disable_intens(idx);
+	}
 
 	/* Initialize & Reset PMNC: C and P bits */
 	armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 131ede6..0c8265e 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -224,7 +224,8 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 {
 	unsigned long pmnc;
 	struct perf_sample_data data;
-	struct pmu_hw_events *cpuc;
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
 	struct pt_regs *regs;
 	int idx;
 
@@ -248,7 +249,6 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 
 	regs = get_irq_regs();
 
-	cpuc = &__get_cpu_var(cpu_hw_events);
 	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
@@ -260,13 +260,13 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (!armpmu_event_set_period(event, hwc, idx))
+		if (!armpmu_event_set_period(event))
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(hwc, idx);
+			cpu_pmu->disable(event);
 	}
 
 	irq_work_run();
@@ -280,11 +280,13 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void
-xscale1pmu_enable_event(struct hw_perf_event *hwc, int idx)
+static void xscale1pmu_enable_event(struct perf_event *event)
 {
 	unsigned long val, mask, evt, flags;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
@@ -314,11 +316,13 @@ xscale1pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void
-xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
+static void xscale1pmu_disable_event(struct perf_event *event)
 {
 	unsigned long val, mask, evt, flags;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
@@ -348,9 +352,10 @@ xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
 
 static int
 xscale1pmu_get_event_idx(struct pmu_hw_events *cpuc,
-			struct hw_perf_event *event)
+				struct perf_event *event)
 {
-	if (XSCALE_PERFCTR_CCNT == event->config_base) {
+	struct hw_perf_event *hwc = &event->hw;
+	if (XSCALE_PERFCTR_CCNT == hwc->config_base) {
 		if (test_and_set_bit(XSCALE_CYCLE_COUNTER, cpuc->used_mask))
 			return -EAGAIN;
 
@@ -366,8 +371,7 @@ xscale1pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	}
 }
 
-static void
-xscale1pmu_start(void)
+static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -379,8 +383,7 @@ xscale1pmu_start(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void
-xscale1pmu_stop(void)
+static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -392,9 +395,10 @@ xscale1pmu_stop(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static inline u32
-xscale1pmu_read_counter(int counter)
+static inline u32 xscale1pmu_read_counter(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 	u32 val = 0;
 
 	switch (counter) {
@@ -412,9 +416,11 @@ xscale1pmu_read_counter(int counter)
 	return val;
 }
 
-static inline void
-xscale1pmu_write_counter(int counter, u32 val)
+static inline void xscale1pmu_write_counter(struct perf_event *event, u32 val)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
 	switch (counter) {
 	case XSCALE_CYCLE_COUNTER:
 		asm volatile("mcr p14, 0, %0, c1, c0, 0" : : "r" (val));
@@ -565,7 +571,8 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 {
 	unsigned long pmnc, of_flags;
 	struct perf_sample_data data;
-	struct pmu_hw_events *cpuc;
+	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
 	struct pt_regs *regs;
 	int idx;
 
@@ -583,7 +590,6 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 
 	regs = get_irq_regs();
 
-	cpuc = &__get_cpu_var(cpu_hw_events);
 	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
@@ -595,13 +601,13 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (!armpmu_event_set_period(event, hwc, idx))
+		if (!armpmu_event_set_period(event))
 			continue;
 
 		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(hwc, idx);
+			cpu_pmu->disable(event);
 	}
 
 	irq_work_run();
@@ -615,11 +621,13 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void
-xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
+static void xscale2pmu_enable_event(struct perf_event *event)
 {
 	unsigned long flags, ien, evtsel;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
 	evtsel = xscale2pmu_read_event_select();
@@ -659,11 +667,13 @@ xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void
-xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
+static void xscale2pmu_disable_event(struct perf_event *event)
 {
 	unsigned long flags, ien, evtsel, of_flags;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
 
 	ien = xscale2pmu_read_int_enable();
 	evtsel = xscale2pmu_read_event_select();
@@ -711,7 +721,7 @@ xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 
 static int
 xscale2pmu_get_event_idx(struct pmu_hw_events *cpuc,
-			struct hw_perf_event *event)
+				struct perf_event *event)
 {
 	int idx = xscale1pmu_get_event_idx(cpuc, event);
 	if (idx >= 0)
@@ -725,8 +735,7 @@ out:
 	return idx;
 }
 
-static void
-xscale2pmu_start(void)
+static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -738,8 +747,7 @@ xscale2pmu_start(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static void
-xscale2pmu_stop(void)
+static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
@@ -751,9 +759,10 @@ xscale2pmu_stop(void)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static inline u32
-xscale2pmu_read_counter(int counter)
+static inline u32 xscale2pmu_read_counter(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 	u32 val = 0;
 
 	switch (counter) {
@@ -777,9 +786,11 @@ xscale2pmu_read_counter(int counter)
 	return val;
 }
 
-static inline void
-xscale2pmu_write_counter(int counter, u32 val)
+static inline void xscale2pmu_write_counter(struct perf_event *event, u32 val)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
 	switch (counter) {
 	case XSCALE_CYCLE_COUNTER:
 		asm volatile("mcr p14, 0, %0, c1, c1, 0" : : "r" (val));
-- 
1.7.4.1
