From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:09 +0100
Subject: [PATCH 08/10] ARM: perf: index PMU registers from zero
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM PMU code used to use 1-based indices for PMU registers. This caused
several data structures (pmu_hw_events::{active_events, used_mask, events})
to have an unused element at index zero. ARMPMU_MAX_HWEVENTS still takes
this indexing into account, and currently equates to 33.

This patch updates the core ARM perf code to use the 0th index again.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index d507fe1..00e57f1 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -35,7 +35,7 @@ static struct platform_device *pmu_device;
 static DEFINE_RAW_SPINLOCK(pmu_lock);
 
 /*
- * ARMv6 supports a maximum of 3 events, starting from index 1. If we add
+ * ARMv6 supports a maximum of 3 events, starting from index 0. If we add
  * another platform that supports more, we need to increase this to be the
  * largest of all platforms.
  *
@@ -43,7 +43,7 @@ static DEFINE_RAW_SPINLOCK(pmu_lock);
  *  cycle counter CCNT + 31 events counters CNT0..30.
  *  Cortex-A8 has 1+4 counters, Cortex-A9 has 1+6 counters.
  */
-#define ARMPMU_MAX_HWEVENTS		33
+#define ARMPMU_MAX_HWEVENTS		32
 
 /* The events for a given CPU. */
 struct cpu_hw_events {
@@ -597,7 +597,7 @@ static void armpmu_enable(struct pmu *pmu)
 	if (!armpmu)
 		return;
 
-	for (idx = 0; idx <= armpmu->num_events; ++idx) {
+	for (idx = 0; idx < armpmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 
 		if (!event)
-- 
1.7.0.4
