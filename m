From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:11 +0100
Subject: [PATCH 10/10] ARM: perf: add mode exclusion for Cortex-A15 PMU
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A15 PMU implements the PMUv2 specification and therefore
has support for some mode exclusion.

This patch adds support for excluding user, kernel and hypervisor counts
from a given event.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   58 +++++++++++++++++++++++++++++++++------
 1 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 0934c82..fe6c931 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -17,6 +17,9 @@
  */
 
 #ifdef CONFIG_CPU_V7
+
+static struct arm_pmu armv7pmu;
+
 /*
  * Common ARMv7 event types
  *
@@ -709,16 +712,24 @@ static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 #define	ARMV7_PMNC_MASK		0x3f	 /* Mask for writable bits */
 
 /*
- * EVTSEL: Event selection reg
- */
-#define	ARMV7_EVTSEL_MASK	0xff		/* Mask for writable bits */
-
-/*
  * FLAG: counters overflow flag status reg
  */
 #define	ARMV7_FLAG_MASK		0xffffffff	/* Mask for writable bits */
 #define	ARMV7_OVERFLOWED_MASK	ARMV7_FLAG_MASK
 
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV7_EVTYPE_MASK	0xc00000ff	/* Mask for writable bits */
+#define	ARMV7_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv2
+ */
+#define	ARMV7_EXCLUDE_PL1	(1 << 31)
+#define	ARMV7_EXCLUDE_USER	(1 << 30)
+#define	ARMV7_INCLUDE_HYP	(1 << 27)
+
 static inline u32 armv7_pmnc_read(void)
 {
 	u32 val;
@@ -805,7 +816,7 @@ static inline void armv7pmu_write_counter(int idx, u32 value)
 static inline void armv7_pmnc_write_evtsel(int idx, u32 val)
 {
 	if (armv7_pmnc_select_counter(idx) == idx) {
-		val &= ARMV7_EVTSEL_MASK;
+		val &= ARMV7_EVTYPE_MASK;
 		asm volatile("mcr p15, 0, %0, c9, c13, 1" : : "r" (val));
 	}
 }
@@ -939,9 +950,10 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 
 	/*
 	 * Set event (if destined for PMNx counters)
-	 * We don't need to set the event if it's a cycle count
+	 * We only need to set the event for the cycle counter if we
+	 * have the ability to perform event filtering.
 	 */
-	if (idx != ARMV7_IDX_CYCLE_COUNTER)
+	if (armv7pmu.set_event_filter || idx != ARMV7_IDX_CYCLE_COUNTER)
 		armv7_pmnc_write_evtsel(idx, hwc->config_base);
 
 	/*
@@ -1066,9 +1078,10 @@ static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
 				  struct hw_perf_event *event)
 {
 	int idx;
+	unsigned long evtype = event->config_base & ARMV7_EVTYPE_EVENT;
 
 	/* Always place a cycle counter into the cycle counter. */
-	if (event->config_base == ARMV7_PERFCTR_CPU_CYCLES) {
+	if (evtype == ARMV7_PERFCTR_CPU_CYCLES) {
 		if (test_and_set_bit(ARMV7_IDX_CYCLE_COUNTER, cpuc->used_mask))
 			return -EAGAIN;
 
@@ -1088,6 +1101,32 @@ static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
+/*
+ * Add an event filter to a given event. This will only work for PMUv2 PMUs.
+ */
+static int armv7pmu_set_event_filter(struct hw_perf_event *event,
+				     struct perf_event_attr *attr)
+{
+	unsigned long config_base = 0;
+
+	if (attr->exclude_idle)
+		return -EPERM;
+	if (attr->exclude_user)
+		config_base |= ARMV7_EXCLUDE_USER;
+	if (attr->exclude_kernel)
+		config_base |= ARMV7_EXCLUDE_PL1;
+	if (!attr->exclude_hv)
+		config_base |= ARMV7_INCLUDE_HYP;
+
+	/*
+	 * Install the filter into config_base as this is used to
+	 * construct the event type.
+	 */
+	event->config_base = config_base;
+
+	return 0;
+}
+
 static void armv7pmu_reset(void *info)
 {
 	u32 idx, nb_cnt = armpmu->num_events;
@@ -1162,6 +1201,7 @@ static struct arm_pmu *__init armv7_a15_pmu_init(void)
 	armv7pmu.cache_map	= &armv7_a15_perf_cache_map;
 	armv7pmu.event_map	= &armv7_a15_perf_map;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
+	armv7pmu.set_event_filter = armv7pmu_set_event_filter;
 	return &armv7pmu;
 }
 #else
-- 
1.7.0.4
