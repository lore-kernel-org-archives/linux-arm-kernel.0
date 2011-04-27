From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Apr 2011 10:57:16 +0100
Subject: [PATCH] ARM: perf: remove erroneous check on active_events
Message-ID: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When initialising a PMU, there is a check to protect against races with
other CPUs filling all of the available event slots. Since armpmu_add
checks that an event can be scheduled, we do not need to do this at
initialisation time. Furthermore the current code is broken because it
assumes that atomic_inc_not_zero will unconditionally increment
active_counts and then tries to decrement it again on failure.

This patch removes the broken, redundant code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/kernel/perf_event.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index fd6403c..29a0cf8 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -560,11 +560,6 @@ static int armpmu_event_init(struct perf_event *event)
 	event->destroy = hw_perf_event_destroy;
 
 	if (!atomic_inc_not_zero(&active_events)) {
-		if (atomic_read(&active_events) > armpmu->num_events) {
-			atomic_dec(&active_events);
-			return -ENOSPC;
-		}
-
 		mutex_lock(&pmu_reserve_mutex);
 		if (atomic_read(&active_events) == 0) {
 			err = armpmu_reserve_hardware();
-- 
1.7.0.4
