From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Mar 2011 17:07:22 +0000
Subject: [PATCH v2] ARM: perf: ensure overflows aren't missed due to IRQ
	latency
Message-ID: <1300986442-20461-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a counter overflows during a perf stat profiling run it may overtake
the last known value of the counter:

    0        prev     new                0xffffffff
    |----------|-------|----------------------|

In this case, the number of events that have occurred is
(0xffffffff - prev) + new. Unfortunately, the event update code will
not realise an overflow has occurred and will instead report the event
delta as (new - prev) which may be considerably smaller than the real
count.

This patch adds an extra argument to armpmu_event_update which indicates
whether or not an overflow has occurred. If an overflow has occurred
then we use the maximum period of the counter to calculate the elapsed
events.

Cc: Jamie Iles <jamie@jamieiles.com>
Reported-by: Ashwin Chaugule <ashwinc@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Updated following feedback from Jamie so that the code is easier to read
and follows the commit log more closely in its implementation.

Will


 arch/arm/kernel/perf_event.c        |   19 +++++++++++--------
 arch/arm/kernel/perf_event_v6.c     |    2 +-
 arch/arm/kernel/perf_event_v7.c     |    2 +-
 arch/arm/kernel/perf_event_xscale.c |    4 ++--
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 7921d08..c726fbc 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -205,11 +205,9 @@ armpmu_event_set_period(struct perf_event *event,
 static u64
 armpmu_event_update(struct perf_event *event,
 		    struct hw_perf_event *hwc,
-		    int idx)
+		    int idx, int overflow)
 {
-	int shift = 64 - 32;
-	s64 prev_raw_count, new_raw_count;
-	u64 delta;
+	u64 delta, prev_raw_count, new_raw_count;
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
@@ -219,8 +217,13 @@ again:
 			     new_raw_count) != prev_raw_count)
 		goto again;
 
-	delta = (new_raw_count << shift) - (prev_raw_count << shift);
-	delta >>= shift;
+	new_raw_count &= armpmu->max_period;
+	prev_raw_count &= armpmu->max_period;
+
+	if (overflow)
+		delta = armpmu->max_period - prev_raw_count + new_raw_count;
+	else
+		delta = new_raw_count - prev_raw_count;
 
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
@@ -237,7 +240,7 @@ armpmu_read(struct perf_event *event)
 	if (hwc->idx < 0)
 		return;
 
-	armpmu_event_update(event, hwc, hwc->idx);
+	armpmu_event_update(event, hwc, hwc->idx, 0);
 }
 
 static void
@@ -255,7 +258,7 @@ armpmu_stop(struct perf_event *event, int flags)
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		armpmu->disable(hwc, hwc->idx);
 		barrier(); /* why? */
-		armpmu_event_update(event, hwc, hwc->idx);
+		armpmu_event_update(event, hwc, hwc->idx, 0);
 		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	}
 }
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index c058bfc..66ce900 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -474,7 +474,7 @@ armv6pmu_handle_irq(int irq_num,
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event, hwc, idx, 1);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index c08d07a..4960686 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -782,7 +782,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event, hwc, idx, 1);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 28cd3b0..39affbe 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -246,7 +246,7 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event, hwc, idx, 1);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
@@ -578,7 +578,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 			continue;
 
 		hwc = &event->hw;
-		armpmu_event_update(event, hwc, idx);
+		armpmu_event_update(event, hwc, idx, 1);
 		data.period = event->hw.last_period;
 		if (!armpmu_event_set_period(event, hwc, idx))
 			continue;
-- 
1.7.0.4
