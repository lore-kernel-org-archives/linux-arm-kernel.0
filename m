From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:33:41 +0100
Subject: [PATCH 4/7] ARM: perf: check ARMv7 counter validity on a per-pmu basis
In-Reply-To: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
References: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488024-3224-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>

Multi-cluster ARMv7 systems may have CPU PMUs with different number of
counters.

This patch updates armv7_pmnc_counter_valid so that it takes a pmu
argument and checks the counter validity against that. We also remove a
number of redundant counter checks whether the current PMU is not easily
retrievable.

Signed-off-by: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   94 ++++++++++++--------------------------
 1 files changed, 30 insertions(+), 64 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 1183c81..7d0cce8 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -736,7 +736,8 @@ static const unsigned armv7_a7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
  */
 #define	ARMV7_IDX_CYCLE_COUNTER	0
 #define	ARMV7_IDX_COUNTER0	1
-#define	ARMV7_IDX_COUNTER_LAST	(ARMV7_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
+#define	ARMV7_IDX_COUNTER_LAST(cpu_pmu) \
+	(ARMV7_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
 
 #define	ARMV7_MAX_COUNTERS	32
 #define	ARMV7_COUNTER_MASK	(ARMV7_MAX_COUNTERS - 1)
@@ -802,38 +803,20 @@ static inline int armv7_pmnc_has_overflowed(u32 pmnc)
 	return pmnc & ARMV7_OVERFLOWED_MASK;
 }
 
-static inline int armv7_pmnc_counter_valid(int idx)
+static inline int armv7_pmnc_counter_valid(struct arm_pmu *cpu_pmu, int idx)
 {
-	return idx >= ARMV7_IDX_CYCLE_COUNTER && idx <= ARMV7_IDX_COUNTER_LAST;
+	return idx >= ARMV7_IDX_CYCLE_COUNTER &&
+		idx <= ARMV7_IDX_COUNTER_LAST(cpu_pmu);
 }
 
 static inline int armv7_pmnc_counter_has_overflowed(u32 pmnc, int idx)
 {
-	int ret = 0;
-	u32 counter;
-
-	if (!armv7_pmnc_counter_valid(idx)) {
-		pr_err("CPU%u checking wrong counter %d overflow status\n",
-			smp_processor_id(), idx);
-	} else {
-		counter = ARMV7_IDX_TO_COUNTER(idx);
-		ret = pmnc & BIT(counter);
-	}
-
-	return ret;
+	return pmnc & BIT(ARMV7_IDX_TO_COUNTER(idx));
 }
 
 static inline int armv7_pmnc_select_counter(int idx)
 {
-	u32 counter;
-
-	if (!armv7_pmnc_counter_valid(idx)) {
-		pr_err("CPU%u selecting wrong PMNC counter %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV7_IDX_TO_COUNTER(idx);
+	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
 	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (counter));
 	isb();
 
@@ -842,11 +825,12 @@ static inline int armv7_pmnc_select_counter(int idx)
 
 static inline u32 armv7pmu_read_counter(struct perf_event *event)
 {
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	u32 value = 0;
 
-	if (!armv7_pmnc_counter_valid(idx))
+	if (!armv7_pmnc_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u reading wrong counter %d\n",
 			smp_processor_id(), idx);
 	else if (idx == ARMV7_IDX_CYCLE_COUNTER)
@@ -859,10 +843,11 @@ static inline u32 armv7pmu_read_counter(struct perf_event *event)
 
 static inline void armv7pmu_write_counter(struct perf_event *event, u32 value)
 {
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
-	if (!armv7_pmnc_counter_valid(idx))
+	if (!armv7_pmnc_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
 	else if (idx == ARMV7_IDX_CYCLE_COUNTER)
@@ -881,60 +866,28 @@ static inline void armv7_pmnc_write_evtsel(int idx, u32 val)
 
 static inline int armv7_pmnc_enable_counter(int idx)
 {
-	u32 counter;
-
-	if (!armv7_pmnc_counter_valid(idx)) {
-		pr_err("CPU%u enabling wrong PMNC counter %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV7_IDX_TO_COUNTER(idx);
+	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
 	asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (BIT(counter)));
 	return idx;
 }
 
 static inline int armv7_pmnc_disable_counter(int idx)
 {
-	u32 counter;
-
-	if (!armv7_pmnc_counter_valid(idx)) {
-		pr_err("CPU%u disabling wrong PMNC counter %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV7_IDX_TO_COUNTER(idx);
+	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
 	asm volatile("mcr p15, 0, %0, c9, c12, 2" : : "r" (BIT(counter)));
 	return idx;
 }
 
 static inline int armv7_pmnc_enable_intens(int idx)
 {
-	u32 counter;
-
-	if (!armv7_pmnc_counter_valid(idx)) {
-		pr_err("CPU%u enabling wrong PMNC counter IRQ enable %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV7_IDX_TO_COUNTER(idx);
+	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
 	asm volatile("mcr p15, 0, %0, c9, c14, 1" : : "r" (BIT(counter)));
 	return idx;
 }
 
 static inline int armv7_pmnc_disable_intens(int idx)
 {
-	u32 counter;
-
-	if (!armv7_pmnc_counter_valid(idx)) {
-		pr_err("CPU%u disabling wrong PMNC counter IRQ enable %d\n",
-			smp_processor_id(), idx);
-		return -EINVAL;
-	}
-
-	counter = ARMV7_IDX_TO_COUNTER(idx);
+	u32 counter = ARMV7_IDX_TO_COUNTER(idx);
 	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (BIT(counter)));
 	isb();
 	/* Clear the overflow flag in case an interrupt is pending. */
@@ -959,7 +912,7 @@ static inline u32 armv7_pmnc_getreset_flags(void)
 }
 
 #ifdef DEBUG
-static void armv7_pmnc_dump_regs(void)
+static void armv7_pmnc_dump_regs(struct arm_pmu *cpu_pmu)
 {
 	u32 val;
 	unsigned int cnt;
@@ -984,7 +937,8 @@ static void armv7_pmnc_dump_regs(void)
 	asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (val));
 	printk(KERN_INFO "CCNT  =0x%08x\n", val);
 
-	for (cnt = ARMV7_IDX_COUNTER0; cnt <= ARMV7_IDX_COUNTER_LAST; cnt++) {
+	for (cnt = ARMV7_IDX_COUNTER0;
+			cnt <= ARMV7_IDX_COUNTER_LAST(cpu_pmu); cnt++) {
 		armv7_pmnc_select_counter(cnt);
 		asm volatile("mrc p15, 0, %0, c9, c13, 2" : "=r" (val));
 		printk(KERN_INFO "CNT[%d] count =0x%08x\n",
@@ -1004,6 +958,12 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 	int idx = hwc->idx;
 
+	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
+		pr_err("CPU%u enabling wrong PMNC counter IRQ enable %d\n",
+			smp_processor_id(), idx);
+		return;
+	}
+
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
@@ -1044,6 +1004,12 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 	int idx = hwc->idx;
 
+	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
+		pr_err("CPU%u disabling wrong PMNC counter IRQ enable %d\n",
+			smp_processor_id(), idx);
+		return;
+	}
+
 	/*
 	 * Disable counter and interrupt
 	 */
-- 
1.7.4.1
