From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 21 Feb 2012 12:37:38 +0800
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler to
 avoid oops
Message-ID: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds one check in irq handler to skip handling deleted
counter for avoiding oops.

When one counter is deleted, event reference(hw_events->events[idx])
will be cleared but the hw overflow status may be kept, so the
hw event may be handled and oops will be triggered in irq handler if
pmu irq from other events come.

The another candidate fix is to clear the overflow status for the
event in arm_pmu->disable(), but looks it is a bit more complicated
and has no obvious advantage than the fix in this patch.
---
 arch/arm/kernel/perf_event_v7.c     |    3 ++-
 arch/arm/kernel/perf_event_xscale.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 54964dc..05762e4 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1082,8 +1082,9 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 		/*
 		 * We have a single interrupt for all counters. Check that
 		 * each counter has overflowed before we process it.
+		 * Do not handle deleted counter.
 		 */
-		if (!armv7_pmnc_counter_has_overflowed(pmnc, idx))
+		if (!armv7_pmnc_counter_has_overflowed(pmnc, idx) || !event)
 			continue;
 
 		hwc = &event->hw;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 831e019..1e07aec 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -592,7 +592,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
-		if (!xscale2_pmnc_counter_has_overflowed(pmnc, idx))
+		if (!xscale2_pmnc_counter_has_overflowed(pmnc, idx) || !event)
 			continue;
 
 		hwc = &event->hw;
-- 
1.7.9
