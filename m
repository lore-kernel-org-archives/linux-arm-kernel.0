From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Apr 2011 10:17:04 +0100
Subject: [RFC PATCH 09/15] ARM: perf: lock PMU registers per-CPU
Message-ID: <mailman.79.1313415783.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, a single lock serialises access to CPU PMU registers. This
global locking is unnecessary as PMU registers are local to the CPU
they monitor.

This patch replaces the global lock with a per-CPU lock. As the lock is
in struct cpu_hw_events, PMUs providing a single cpu_hw_events instance
can be locked globally.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c        |   17 +++++++++-----
 arch/arm/kernel/perf_event_v6.c     |   25 +++++++++++++--------
 arch/arm/kernel/perf_event_v7.c     |   20 ++++++++++-------
 arch/arm/kernel/perf_event_xscale.c |   40 +++++++++++++++++++++--------------
 4 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5ce6c33..9331d57 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -27,12 +27,6 @@
 #include <asm/stacktrace.h>
 
 /*
- * Hardware lock to serialize accesses to PMU registers. Needed for the
- * read/modify/write sequences.
- */
-static DEFINE_RAW_SPINLOCK(pmu_lock);
-
-/*
  * ARMv6 supports a maximum of 3 events, starting from index 0. If we add
  * another platform that supports more, we need to increase this to be the
  * largest of all platforms.
@@ -55,6 +49,12 @@ struct cpu_hw_events {
 	 * an event. A 0 means that the counter can be used.
 	 */
 	unsigned long		used_mask[BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)];
+
+	/*
+	 * Hardware lock to serialize accesses to PMU registers. Needed for the
+	 * read/modify/write sequences.
+	 */
+	raw_spinlock_t		pmu_lock;
 };
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
@@ -685,6 +685,11 @@ static struct cpu_hw_events *armpmu_get_cpu_events(void)
 
 static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 {
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct cpu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
+		raw_spin_lock_init(&events->pmu_lock);
+	}
 	armpmu->get_hw_events = armpmu_get_cpu_events;
 }
 
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 8390128..68cf704 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -433,6 +433,7 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
 		      int idx)
 {
 	unsigned long val, mask, evt, flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= 0;
@@ -454,12 +455,12 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
 	 * Mask out the current event and set the counter to count the event
 	 * that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int counter_is_active(unsigned long pmcr, int idx)
@@ -544,24 +545,26 @@ static void
 armv6pmu_start(void)
 {
 	unsigned long flags, val;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val |= ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void
 armv6pmu_stop(void)
 {
 	unsigned long flags, val;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -595,6 +598,7 @@ armv6pmu_disable_event(struct hw_perf_event *hwc,
 		       int idx)
 {
 	unsigned long val, mask, evt, flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= ARMV6_PMCR_CCOUNT_IEN;
@@ -615,12 +619,12 @@ armv6pmu_disable_event(struct hw_perf_event *hwc,
 	 * of ETM bus signal assertion cycles. The external reporting should
 	 * be disabled and so this should never increment.
 	 */
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void
@@ -628,6 +632,7 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 			      int idx)
 {
 	unsigned long val, mask, flags, evt = 0;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	if (ARMV6_CYCLE_COUNTER == idx) {
 		mask	= ARMV6_PMCR_CCOUNT_IEN;
@@ -644,12 +649,12 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
 	 * simply disable the interrupt reporting.
 	 */
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static struct arm_pmu armv6pmu = {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f4170fc..68ac522 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -936,12 +936,13 @@ static void armv7_pmnc_dump_regs(void)
 static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -966,17 +967,18 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	 */
 	armv7_pmnc_enable_counter(idx);
 
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	/*
 	 * Disable counter and interrupt
 	 */
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -988,7 +990,7 @@ static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
 	 */
 	armv7_pmnc_disable_intens(idx);
 
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
@@ -1054,21 +1056,23 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 static void armv7pmu_start(void)
 {
 	unsigned long flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv7pmu_stop(void)
 {
 	unsigned long flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index ca89a06..18e4823 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -281,6 +281,7 @@ static void
 xscale1pmu_enable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long val, mask, evt, flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
@@ -302,18 +303,19 @@ xscale1pmu_enable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void
 xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long val, mask, evt, flags;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
@@ -333,12 +335,12 @@ xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -365,24 +367,26 @@ static void
 xscale1pmu_start(void)
 {
 	unsigned long flags, val;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val |= XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void
 xscale1pmu_stop(void)
 {
 	unsigned long flags, val;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static inline u32
@@ -610,6 +614,7 @@ static void
 xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags, ien, evtsel;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	ien = xscale2pmu_read_int_enable();
 	evtsel = xscale2pmu_read_event_select();
@@ -643,16 +648,17 @@ xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void
 xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
 	unsigned long flags, ien, evtsel;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
 	ien = xscale2pmu_read_int_enable();
 	evtsel = xscale2pmu_read_event_select();
@@ -686,10 +692,10 @@ xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -712,24 +718,26 @@ static void
 xscale2pmu_start(void)
 {
 	unsigned long flags, val;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
 	val |= XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void
 xscale2pmu_stop(void)
 {
 	unsigned long flags, val;
+	struct cpu_hw_events *events = armpmu->get_hw_events();
 
-	raw_spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static inline u32
-- 
1.7.0.4
