From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  2 Jul 2018 22:59:44 +0100
Subject: [PATCH v4 3/7] arm_pmu: Add support for 64bit event counters
In-Reply-To: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1530568788-26458-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each PMU has a set of 32bit event counters. But in some
special cases, the events could be counted using counters
which are effectively 64bit wide.

e.g, Arm V8 PMUv3 has a 64 bit cycle counter which can count
only the CPU cycles. Also, the PMU can chain the event counters
to effectively count as a 64bit counter.

Add support for tracking the events that uses 64bit counters.
This only affects the periods set for each counter in the core
driver.

Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3:
 - Replace ternary operator with if..else for max_period
 - Added Acked-by from Mark R
---
 drivers/perf/arm_pmu.c       | 16 ++++++++++------
 include/linux/perf/arm_pmu.h |  6 ++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 6ddc00d..8cad6b5 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -28,9 +28,12 @@
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 
-static inline u64 arm_pmu_max_period(void)
+static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
-	return (1ULL << 32) - 1;
+	if (event->hw.flags & ARMPMU_EVT_64BIT)
+		return GENMASK_ULL(63, 0);
+	else
+		return GENMASK_ULL(31, 0);
 }
 
 static int
@@ -122,7 +125,7 @@ int armpmu_event_set_period(struct perf_event *event)
 	u64 max_period;
 	int ret = 0;
 
-	max_period = arm_pmu_max_period();
+	max_period = arm_pmu_event_max_period(event);
 	if (unlikely(left <= -period)) {
 		left = period;
 		local64_set(&hwc->period_left, left);
@@ -148,7 +151,7 @@ int armpmu_event_set_period(struct perf_event *event)
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	armpmu->write_counter(event, (u64)(-left) & 0xffffffff);
+	armpmu->write_counter(event, (u64)(-left) & max_period);
 
 	perf_event_update_userpage(event);
 
@@ -160,7 +163,7 @@ u64 armpmu_event_update(struct perf_event *event)
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	u64 delta, prev_raw_count, new_raw_count;
-	u64 max_period = arm_pmu_max_period();
+	u64 max_period = arm_pmu_event_max_period(event);
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
@@ -368,6 +371,7 @@ __hw_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int mapping;
 
+	hwc->flags = 0;
 	mapping = armpmu->map_event(event);
 
 	if (mapping < 0) {
@@ -410,7 +414,7 @@ __hw_perf_event_init(struct perf_event *event)
 		 * is far less likely to overtake the previous one unless
 		 * you have some serious IRQ latency issues.
 		 */
-		hwc->sample_period  = arm_pmu_max_period() >> 1;
+		hwc->sample_period  = arm_pmu_event_max_period(event) >> 1;
 		hwc->last_period    = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index f7126a2..10f92e1 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -25,6 +25,12 @@
  */
 #define ARMPMU_MAX_HWEVENTS		32
 
+/*
+ * ARM PMU hw_event flags
+ */
+/* Event uses a 64bit counter */
+#define ARMPMU_EVT_64BIT		1
+
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
 #define CACHE_OP_UNSUPPORTED		0xFFFF
-- 
2.7.4
