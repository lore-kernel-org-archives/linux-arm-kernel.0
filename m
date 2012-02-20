From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Feb 2012 12:07:26 +0000
Subject: [PATCH] ARM: perf: limit sample_period to half max_period in
 non-sampling mode
Message-ID: <1329739646-17058-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, the PMU does not stop counting after an overflow and therefore
IRQ latency affects the new counter value read by the kernel. This is
significant for non-sampling runs where it is possible for the new value
to overtake the previous one, causing the delta to be out by up to
max_period events.

Commit a737823d ("ARM: 6835/1: perf: ensure overflows aren't missed due
to IRQ latency") attempted to fix this problem by allowing interrupt
handlers to pass an overflow flag to the event update function, causing
the overflow calculation to assume that the counter passed through zero
when going from prev to new. Unfortunately, this doesn't work when
overflow occurs on the perf_task_tick path because we have the flag
cleared and end up computing a large negative delta.

This patch removes the overflow flag from armpmu_event_update and
instead limits the sample_period to half of the max_period for
non-sampling profiling runs.

Cc: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h          |    2 +-
 arch/arm/kernel/perf_event.c        |   22 +++++++++++-----------
 arch/arm/kernel/perf_event_v6.c     |    2 +-
 arch/arm/kernel/perf_event_v7.c     |    2 +-
 arch/arm/kernel/perf_event_xscale.c |    4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index b5a5be2..90114fa 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -134,7 +134,7 @@ int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type);
 
 u64 armpmu_event_update(struct perf_event *event,
 			struct hw_perf_event *hwc,
-			int idx, int overflow);
+			int idx);
 
 int armpmu_event_set_period(struct perf_event *event,
 			    struct hw_perf_event *hwc,
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5bb91bf..56173ae 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -180,7 +180,7 @@ armpmu_event_set_period(struct perf_event *event,
 u64
 armpmu_event_update(struct perf_event *event,
 		    struct hw_perf_event *hwc,
-		    int idx, int overflow)
+		    int idx)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	u64 delta, prev_raw_count, new_raw_count;
@@ -193,13 +193,7 @@ again:
 			     new_raw_count) != prev_raw_count)
 		goto again;
 
-	new_raw_count &= armpmu->max_period;
-	prev_raw_count &= armpmu->max_period;
-
-	if (overflow)
-		delta = armpmu->max_period - prev_raw_count + new_raw_count + 1;
-	else
-		delta = new_raw_count - prev_raw_count;
+	delta = (new_raw_count - prev_raw_count) & armpmu->max_period;
 
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
@@ -216,7 +210,7 @@ armpmu_read(struct perf_event *event)
 	if (hwc->idx < 0)
 		return;
 
-	armpmu_event_update(event, hwc, hwc->idx, 0);
+	armpmu_event_update(event, hwc, hwc->idx);
 }
 
 static void
@@ -232,7 +226,7 @@ armpmu_stop(struct perf_event *event, int flags)
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		armpmu->disable(hwc, hwc->idx);
 		barrier(); /* why? */
-		armpmu_event_update(event, hwc, hwc->idx, 0);
+		armpmu_event_update(event, hwc, hwc->idx);
 		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	}
 }
@@ -518,7 +512,13 @@ __hw_perf_event_init(struct perf_event *event)
 	hwc->config_base	    |= (unsigned long)mapping;
 
 	if (!hwc->sample_period) {
-		hwc->sample_period  = armpmu->max_period;
+		/*
+		 * For non-sampling runs, limit the sample_period to half
+		 * of the counter width. That way, the new counter value
+		 * is far less likely to overtake the previous one unless
+		 * you have some serious IRQ latency issues.
+		 */
+		hwc->sample_period  = armpmu->max_period >> 1;
 		hwc->last_period    = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 533be99..88bf152 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -524,7 +524,7 @@ armv6pmu_handle_irq(int irq_num,
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx, 1);
+		armpmu_event_update(event, hwc, idx);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 6933244..6f48861 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -963,7 +963,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx, 1);
+		armpmu_event_update(event, hwc, idx);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 3b99d82..831e019 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -259,7 +259,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx, 1);
+		armpmu_event_update(event, hwc, idx);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
@@ -596,7 +596,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx, 1);
+		armpmu_event_update(event, hwc, idx);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
-- 
1.7.4.1
