From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:07 +0100
Subject: [PATCH 06/10] ARM: perf: index ARMv7 event counters starting from zero
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current ARMv7 PMU backend indexes event counters from two, with
index zero being reserved and index one being used to represent the
cycle counter.

This patch tidies up the code by indexing from one instead (with zero
for the cycle counter). This allows us to remove many of the accessor
macros along with the counter enumeration and makes the code much more
readable.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |  239 ++++++++++++++------------------------
 1 files changed, 88 insertions(+), 151 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index e39bc89..0934c82 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -676,23 +676,24 @@ static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 };
 
 /*
- * Perf Events counters
+ * Perf Events' indices
  */
-enum armv7_counters {
-	ARMV7_CYCLE_COUNTER		= 1,	/* Cycle counter */
-	ARMV7_COUNTER0			= 2,	/* First event counter */
-};
+#define	ARMV7_IDX_CYCLE_COUNTER	0
+#define	ARMV7_IDX_COUNTER0	1
+#define	ARMV7_IDX_COUNTER_LAST	(ARMV7_IDX_CYCLE_COUNTER + armpmu->num_events - 1)
+
+#define	ARMV7_MAX_COUNTERS	32
+#define	ARMV7_COUNTER_MASK	(ARMV7_MAX_COUNTERS - 1)
 
 /*
- * The cycle counter is ARMV7_CYCLE_COUNTER.
- * The first event counter is ARMV7_COUNTER0.
- * The last event counter is (ARMV7_COUNTER0 + armpmu->num_events - 1).
+ * ARMv7 low level PMNC access
  */
-#define	ARMV7_COUNTER_LAST	(ARMV7_COUNTER0 + armpmu->num_events - 1)
 
 /*
- * ARMv7 low level PMNC access
+ * Perf Event to low level counters mapping
  */
+#define	ARMV7_IDX_TO_COUNTER(x)	\
+	(((x) - ARMV7_IDX_COUNTER0) & ARMV7_COUNTER_MASK)
 
 /*
  * Per-CPU PMNC: config reg
@@ -708,53 +709,13 @@ enum armv7_counters {
 #define	ARMV7_PMNC_MASK		0x3f	 /* Mask for writable bits */
 
 /*
- * Available counters
- */
-#define ARMV7_CNT0		0	/* First event counter */
-#define ARMV7_CCNT		31	/* Cycle counter */
-
-/* Perf Event to low level counters mapping */
-#define ARMV7_EVENT_CNT_TO_CNTx	(ARMV7_COUNTER0 - ARMV7_CNT0)
-
-/*
- * CNTENS: counters enable reg
- */
-#define ARMV7_CNTENS_P(idx)	(1 << (idx - ARMV7_EVENT_CNT_TO_CNTx))
-#define ARMV7_CNTENS_C		(1 << ARMV7_CCNT)
-
-/*
- * CNTENC: counters disable reg
- */
-#define ARMV7_CNTENC_P(idx)	(1 << (idx - ARMV7_EVENT_CNT_TO_CNTx))
-#define ARMV7_CNTENC_C		(1 << ARMV7_CCNT)
-
-/*
- * INTENS: counters overflow interrupt enable reg
- */
-#define ARMV7_INTENS_P(idx)	(1 << (idx - ARMV7_EVENT_CNT_TO_CNTx))
-#define ARMV7_INTENS_C		(1 << ARMV7_CCNT)
-
-/*
- * INTENC: counters overflow interrupt disable reg
- */
-#define ARMV7_INTENC_P(idx)	(1 << (idx - ARMV7_EVENT_CNT_TO_CNTx))
-#define ARMV7_INTENC_C		(1 << ARMV7_CCNT)
-
-/*
  * EVTSEL: Event selection reg
  */
 #define	ARMV7_EVTSEL_MASK	0xff		/* Mask for writable bits */
 
 /*
- * SELECT: Counter selection reg
- */
-#define	ARMV7_SELECT_MASK	0x1f		/* Mask for writable bits */
-
-/*
  * FLAG: counters overflow flag status reg
  */
-#define ARMV7_FLAG_P(idx)	(1 << (idx - ARMV7_EVENT_CNT_TO_CNTx))
-#define ARMV7_FLAG_C		(1 << ARMV7_CCNT)
 #define	ARMV7_FLAG_MASK		0xffffffff	/* Mask for writable bits */
 #define	ARMV7_OVERFLOWED_MASK	ARMV7_FLAG_MASK
 
@@ -777,34 +738,39 @@ static inline int armv7_pmnc_has_overflowed(u32 pmnc)
 	return pmnc & ARMV7_OVERFLOWED_MASK;
 }
 
-static inline int armv7_pmnc_counter_has_overflowed(u32 pmnc,
-					enum armv7_counters counter)
+static inline int armv7_pmnc_counter_valid(int idx)
+{
+	return idx >= ARMV7_IDX_CYCLE_COUNTER && idx <= ARMV7_IDX_COUNTER_LAST;
+}
+
+static inline int armv7_pmnc_counter_has_overflowed(u32 pmnc, int idx)
 {
 	int ret = 0;
+	u32 counter;
 
-	if (counter == ARMV7_CYCLE_COUNTER)
-		ret = pmnc & ARMV7_FLAG_C;
-	else if ((counter >= ARMV7_COUNTER0) && (counter <= ARMV7_COUNTER_LAST))
-		ret = pmnc & ARMV7_FLAG_P(counter);
-	else
+	if (!armv7_pmnc_counter_valid(idx)) {
 		pr_err("CPU%u checking wrong counter %d overflow status\n",
-			smp_processor_id(), counter);
+			smp_processor_id(), idx);
+	} else {
+		counter = ARMV7_IDX_TO_COUNTER(idx);
+		ret = pmnc & BIT(counter);
+	}
 
 	return ret;
 }
 
 static inline int armv7_pmnc_select_counter(int idx)
 {
-	u32 val;
+	u32 counter;
 
-	if ((idx < ARMV7_COUNTER0) || (idx > ARMV7_COUNTER_LAST)) {
-		pr_err("CPU%u selecting wrong PMNC counter"
-			" %d\n", smp_processor_id(), idx);
-		return -1;
+	if (!armv7_pmnc_counter_valid(idx)) {
+		pr_err("CPU%u selecting wrong PMNC counter %d\n",
+			smp_processor_id(), idx);
+		return -EINVAL;
 	}
 
-	val = (idx - ARMV7_EVENT_CNT_TO_CNTx) & ARMV7_SELECT_MASK;
-	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (val));
+	counter = ARMV7_IDX_TO_COUNTER(idx);
+	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (counter));
 	isb();
 
 	return idx;
@@ -814,30 +780,26 @@ static inline u32 armv7pmu_read_counter(int idx)
 {
 	u32 value = 0;
 
-	if (idx == ARMV7_CYCLE_COUNTER)
-		asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (value));
-	else if ((idx >= ARMV7_COUNTER0) && (idx <= ARMV7_COUNTER_LAST)) {
-		if (armv7_pmnc_select_counter(idx) == idx)
-			asm volatile("mrc p15, 0, %0, c9, c13, 2"
-				     : "=r" (value));
-	} else
+	if (!armv7_pmnc_counter_valid(idx))
 		pr_err("CPU%u reading wrong counter %d\n",
 			smp_processor_id(), idx);
+	else if (idx == ARMV7_IDX_CYCLE_COUNTER)
+		asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (value));
+	else if (armv7_pmnc_select_counter(idx) == idx)
+		asm volatile("mrc p15, 0, %0, c9, c13, 2" : "=r" (value));
 
 	return value;
 }
 
 static inline void armv7pmu_write_counter(int idx, u32 value)
 {
-	if (idx == ARMV7_CYCLE_COUNTER)
-		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" (value));
-	else if ((idx >= ARMV7_COUNTER0) && (idx <= ARMV7_COUNTER_LAST)) {
-		if (armv7_pmnc_select_counter(idx) == idx)
-			asm volatile("mcr p15, 0, %0, c9, c13, 2"
-				     : : "r" (value));
-	} else
+	if (!armv7_pmnc_counter_valid(idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
+	else if (idx == ARMV7_IDX_CYCLE_COUNTER)
+		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" (value));
+	else if (armv7_pmnc_select_counter(idx) == idx)
+		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" (value));
 }
 
 static inline void armv7_pmnc_write_evtsel(int idx, u32 val)
@@ -850,86 +812,61 @@ static inline void armv7_pmnc_write_evtsel(int idx, u32 val)
 
 static inline int armv7_pmnc_enable_counter(int idx)
 {
-	u32 val;
+	u32 counter;
 
-	if ((idx != ARMV7_CYCLE_COUNTER) &&
-	    ((idx < ARMV7_COUNTER0) || (idx > ARMV7_COUNTER_LAST))) {
-		pr_err("CPU%u enabling wrong PMNC counter"
-			" %d\n", smp_processor_id(), idx);
-		return -1;
+	if (!armv7_pmnc_counter_valid(idx)) {
+		pr_err("CPU%u enabling wrong PMNC counter %d\n",
+			smp_processor_id(), idx);
+		return -EINVAL;
 	}
 
-	if (idx == ARMV7_CYCLE_COUNTER)
-		val = ARMV7_CNTENS_C;
-	else
-		val = ARMV7_CNTENS_P(idx);
-
-	asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (val));
-
+	counter = ARMV7_IDX_TO_COUNTER(idx);
+	asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (BIT(counter)));
 	return idx;
 }
 
 static inline int armv7_pmnc_disable_counter(int idx)
 {
-	u32 val;
+	u32 counter;
 
-
-	if ((idx != ARMV7_CYCLE_COUNTER) &&
-	    ((idx < ARMV7_COUNTER0) || (idx > ARMV7_COUNTER_LAST))) {
-		pr_err("CPU%u disabling wrong PMNC counter"
-			" %d\n", smp_processor_id(), idx);
-		return -1;
+	if (!armv7_pmnc_counter_valid(idx)) {
+		pr_err("CPU%u disabling wrong PMNC counter %d\n",
+			smp_processor_id(), idx);
+		return -EINVAL;
 	}
 
-	if (idx == ARMV7_CYCLE_COUNTER)
-		val = ARMV7_CNTENC_C;
-	else
-		val = ARMV7_CNTENC_P(idx);
-
-	asm volatile("mcr p15, 0, %0, c9, c12, 2" : : "r" (val));
-
+	counter = ARMV7_IDX_TO_COUNTER(idx);
+	asm volatile("mcr p15, 0, %0, c9, c12, 2" : : "r" (BIT(counter)));
 	return idx;
 }
 
 static inline int armv7_pmnc_enable_intens(int idx)
 {
-	u32 val;
+	u32 counter;
 
-	if ((idx != ARMV7_CYCLE_COUNTER) &&
-	    ((idx < ARMV7_COUNTER0) || (idx > ARMV7_COUNTER_LAST))) {
-		pr_err("CPU%u enabling wrong PMNC counter"
-			" interrupt enable %d\n", smp_processor_id(), idx);
-		return -1;
+	if (!armv7_pmnc_counter_valid(idx)) {
+		pr_err("CPU%u enabling wrong PMNC counter IRQ enable %d\n",
+			smp_processor_id(), idx);
+		return -EINVAL;
 	}
 
-	if (idx == ARMV7_CYCLE_COUNTER)
-		val = ARMV7_INTENS_C;
-	else
-		val = ARMV7_INTENS_P(idx);
-
-	asm volatile("mcr p15, 0, %0, c9, c14, 1" : : "r" (val));
-
+	counter = ARMV7_IDX_TO_COUNTER(idx);
+	asm volatile("mcr p15, 0, %0, c9, c14, 1" : : "r" (BIT(counter)));
 	return idx;
 }
 
 static inline int armv7_pmnc_disable_intens(int idx)
 {
-	u32 val;
+	u32 counter;
 
-	if ((idx != ARMV7_CYCLE_COUNTER) &&
-	    ((idx < ARMV7_COUNTER0) || (idx > ARMV7_COUNTER_LAST))) {
-		pr_err("CPU%u disabling wrong PMNC counter"
-			" interrupt enable %d\n", smp_processor_id(), idx);
-		return -1;
+	if (!armv7_pmnc_counter_valid(idx)) {
+		pr_err("CPU%u disabling wrong PMNC counter IRQ enable %d\n",
+			smp_processor_id(), idx);
+		return -EINVAL;
 	}
 
-	if (idx == ARMV7_CYCLE_COUNTER)
-		val = ARMV7_INTENC_C;
-	else
-		val = ARMV7_INTENC_P(idx);
-
-	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (val));
-
+	counter = ARMV7_IDX_TO_COUNTER(idx);
+	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (BIT(counter)));
 	return idx;
 }
 
@@ -973,14 +910,14 @@ static void armv7_pmnc_dump_regs(void)
 	asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (val));
 	printk(KERN_INFO "CCNT  =0x%08x\n", val);
 
-	for (cnt = ARMV7_COUNTER0; cnt < ARMV7_COUNTER_LAST; cnt++) {
+	for (cnt = ARMV7_IDX_COUNTER0; cnt <= ARMV7_IDX_COUNTER_LAST; cnt++) {
 		armv7_pmnc_select_counter(cnt);
 		asm volatile("mrc p15, 0, %0, c9, c13, 2" : "=r" (val));
 		printk(KERN_INFO "CNT[%d] count =0x%08x\n",
-			cnt-ARMV7_EVENT_CNT_TO_CNTx, val);
+			ARMV7_IDX_TO_COUNTER(cnt), val);
 		asm volatile("mrc p15, 0, %0, c9, c13, 1" : "=r" (val));
 		printk(KERN_INFO "CNT[%d] evtsel=0x%08x\n",
-			cnt-ARMV7_EVENT_CNT_TO_CNTx, val);
+			ARMV7_IDX_TO_COUNTER(cnt), val);
 	}
 }
 #endif
@@ -1004,7 +941,7 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	 * Set event (if destined for PMNx counters)
 	 * We don't need to set the event if it's a cycle count
 	 */
-	if (idx != ARMV7_CYCLE_COUNTER)
+	if (idx != ARMV7_IDX_CYCLE_COUNTER)
 		armv7_pmnc_write_evtsel(idx, hwc->config_base);
 
 	/*
@@ -1069,7 +1006,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	perf_sample_data_init(&data, 0);
 
 	cpuc = &__get_cpu_var(cpu_hw_events);
-	for (idx = 0; idx <= armpmu->num_events; ++idx) {
+	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
@@ -1132,23 +1069,23 @@ static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
 
 	/* Always place a cycle counter into the cycle counter. */
 	if (event->config_base == ARMV7_PERFCTR_CPU_CYCLES) {
-		if (test_and_set_bit(ARMV7_CYCLE_COUNTER, cpuc->used_mask))
+		if (test_and_set_bit(ARMV7_IDX_CYCLE_COUNTER, cpuc->used_mask))
 			return -EAGAIN;
 
-		return ARMV7_CYCLE_COUNTER;
-	} else {
-		/*
-		 * For anything other than a cycle counter, try and use
-		 * the events counters
-		 */
-		for (idx = ARMV7_COUNTER0; idx <= armpmu->num_events; ++idx) {
-			if (!test_and_set_bit(idx, cpuc->used_mask))
-				return idx;
-		}
+		return ARMV7_IDX_CYCLE_COUNTER;
+	}
 
-		/* The counters are all in use. */
-		return -EAGAIN;
+	/*
+	 * For anything other than a cycle counter, try and use
+	 * the events counters
+	 */
+	for (idx = ARMV7_IDX_COUNTER0; idx < armpmu->num_events; ++idx) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
 	}
+
+	/* The counters are all in use. */
+	return -EAGAIN;
 }
 
 static void armv7pmu_reset(void *info)
@@ -1156,7 +1093,7 @@ static void armv7pmu_reset(void *info)
 	u32 idx, nb_cnt = armpmu->num_events;
 
 	/* The counter and interrupt enable registers are unknown at reset. */
-	for (idx = 1; idx < nb_cnt; ++idx)
+	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx)
 		armv7pmu_disable_event(NULL, idx);
 
 	/* Initialize & Reset PMNC: C and P bits */
-- 
1.7.0.4
