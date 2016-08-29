From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 29 Aug 2016 16:48:13 -0500
Subject: [PATCH v8 2/9] arm64: pmu: Probe default hw/cache counters
In-Reply-To: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1472507300-9844-3-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8 machines can identify the micro/arch defined counters
that are available on a machine. Add all these counters to the
default armv8 perf map. At run-time disable the counters which
are not available on the given PMU.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 45 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 3aac598..f650548 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -191,13 +191,23 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
 /* PMUv3 HW events mapping. */
+
+/*
+ * ARMv8 Architectural defined events, not all of these may
+ * be supported on any given implementation. Undefined events will
+ * be disabled at run-time.
+ */
 static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
 };
 
 /* ARM Cortex-A53 HW events mapping. */
@@ -259,6 +269,15 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
 
+	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE,
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL,
+	[C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1D_TLB,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
+	[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB,
+
 	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
 	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
@@ -906,9 +925,22 @@ static void armv8pmu_reset(void *info)
 
 static int armv8_pmuv3_map_event(struct perf_event *event)
 {
-	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				&armv8_pmuv3_perf_cache_map,
-				ARMV8_PMU_EVTYPE_EVENT);
+	int hw_event_id;
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+
+	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				       &armv8_pmuv3_perf_cache_map,
+				       ARMV8_PMU_EVTYPE_EVENT);
+	if (hw_event_id < 0)
+		return hw_event_id;
+
+	/* disable micro/arch events not supported by this PMU */
+	if ((hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS) &&
+		!test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
+			return -EOPNOTSUPP;
+	}
+
+	return hw_event_id;
 }
 
 static int armv8_a53_map_event(struct perf_event *event)
@@ -1045,8 +1077,13 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{},
 };
 
+/*
+ * Non DT systems have their micro/arch events probed at run-time.
+ * A fairly complete list of generic events are provided and ones that
+ * aren't supported by the current PMU are disabled.
+ */
 static const struct pmu_probe_info armv8_pmu_probe_table[] = {
-	PMU_PROBE(0, 0, armv8_pmuv3_init), /* if all else fails... */
+	PMU_PROBE(0, 0, armv8_pmuv3_init), /* enable all defined counters */
 	{ /* sentinel value */ }
 };
 
-- 
2.5.5
