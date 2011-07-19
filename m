From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jul 2011 09:37:10 +0100
Subject: [RFC PATCH 04/15] ARM: perf: remove active_mask
Message-ID: <mailman.74.1313415781.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, pmu_hw_events::active_mask is used to keep track of which
events are active in hardware. As we can stop counters and their
interrupts, this is unnecessary.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c        |    8 --------
 arch/arm/kernel/perf_event_v6.c     |   19 ++++++++++++++++++-
 arch/arm/kernel/perf_event_v7.c     |    3 ---
 arch/arm/kernel/perf_event_xscale.c |    6 ------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index dfde928..438482f 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -57,12 +57,6 @@ struct cpu_hw_events {
 	 * an event. A 0 means that the counter can be used.
 	 */
 	unsigned long		used_mask[BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)];
-
-	/*
-	 * A 1 bit for an index indicates that the counter is actively being
-	 * used.
-	 */
-	unsigned long		active_mask[BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)];
 };
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
@@ -295,7 +289,6 @@ armpmu_del(struct perf_event *event, int flags)
 
 	WARN_ON(idx < 0);
 
-	clear_bit(idx, cpuc->active_mask);
 	armpmu_stop(event, PERF_EF_UPDATE);
 	cpuc->events[idx] = NULL;
 	clear_bit(idx, cpuc->used_mask);
@@ -327,7 +320,6 @@ armpmu_add(struct perf_event *event, int flags)
 	event->hw.idx = idx;
 	armpmu->disable(hwc, idx);
 	cpuc->events[idx] = event;
-	set_bit(idx, cpuc->active_mask);
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	if (flags & PERF_EF_START)
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 87f29b5..8390128 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -462,6 +462,23 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
 	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
+static int counter_is_active(unsigned long pmcr, int idx)
+{
+	unsigned long mask = 0;
+	if (idx == ARMV6_CYCLE_COUNTER)
+		mask = ARMV6_PMCR_CCOUNT_IEN;
+	else if (idx == ARMV6_COUNTER0)
+		mask = ARMV6_PMCR_COUNT0_IEN;
+	else if (idx == ARMV6_COUNTER1)
+		mask = ARMV6_PMCR_COUNT1_IEN;
+
+	if (mask)
+		return pmcr & mask;
+
+	WARN_ONCE(1, "invalid counter number (%d)\n", idx);
+	return 0;
+}
+
 static irqreturn_t
 armv6pmu_handle_irq(int irq_num,
 		    void *dev)
@@ -491,7 +508,7 @@ armv6pmu_handle_irq(int irq_num,
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
-		if (!test_bit(idx, cpuc->active_mask))
+		if (!counter_is_active(pmcr, idx))
 			continue;
 
 		/*
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index fe6c931..f4170fc 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1022,9 +1022,6 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
-		if (!test_bit(idx, cpuc->active_mask))
-			continue;
-
 		/*
 		 * We have a single interrupt for all counters. Check that
 		 * each counter has overflowed before we process it.
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 54312fc..ca89a06 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -253,9 +253,6 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
-		if (!test_bit(idx, cpuc->active_mask))
-			continue;
-
 		if (!xscale1_pmnc_counter_has_overflowed(pmnc, idx))
 			continue;
 
@@ -585,9 +582,6 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
-		if (!test_bit(idx, cpuc->active_mask))
-			continue;
-
 		if (!xscale2_pmnc_counter_has_overflowed(pmnc, idx))
 			continue;
 
-- 
1.7.0.4
