From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:31:14 +0100
Subject: [PATCH 4/6] arm64: perf: add Cortex-A53 support
In-Reply-To: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
References: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657876-1362-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A53 PMU supports a few events outside of the required PMUv3
set that are rather useful.

This patch adds the event map data for said events.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |  1 +
 arch/arm64/kernel/perf_event_pmuv3.c          | 64 ++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 3b5f5d1..a65e5cf 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -8,6 +8,7 @@ Required properties:
 
 - compatible : should be one of
 	"arm,armv8-pmuv3"
+	"arm.cortex-a53-pmu"
 	"arm,cortex-a17-pmu"
 	"arm,cortex-a15-pmu"
 	"arm,cortex-a12-pmu"
diff --git a/arch/arm64/kernel/perf_event_pmuv3.c b/arch/arm64/kernel/perf_event_pmuv3.c
index 1cc7206..ea27db0 100644
--- a/arch/arm64/kernel/perf_event_pmuv3.c
+++ b/arch/arm64/kernel/perf_event_pmuv3.c
@@ -69,6 +69,11 @@ enum armv8_pmuv3_perf_types {
 	ARMV8_PMUV3_PERFCTR_BUS_CYCLES				= 0x1D,
 };
 
+/* ARMv8 Cortex-A53 specific event types. */
+enum armv8_a53_pmu_perf_types {
+	ARMV8_A53_PERFCTR_PREFETCH_LINEFILL			= 0xC2,
+};
+
 /* PMUv3 HW events mapping. */
 static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
@@ -79,6 +84,18 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+/* ARM Cortex-A53 HW events mapping. */
+static const unsigned armv8_a53_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
+};
+
 static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_OP_MAX]
 						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -95,6 +112,28 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+static const unsigned armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					      [PERF_COUNT_HW_CACHE_OP_MAX]
+					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+	[C(L1D)][C(OP_PREFETCH)][C(RESULT_MISS)] = ARMV8_A53_PERFCTR_PREFETCH_LINEFILL,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS,
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_ITLB_REFILL,
+
+	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+};
+
 /*
  * Perf Events' indices
  */
@@ -502,6 +541,13 @@ static int armv8_pmuv3_map_event(struct perf_event *event)
 				ARMV8_EVTYPE_EVENT);
 }
 
+static int armv8_a53_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv8_a53_perf_map,
+				&armv8_a53_perf_cache_map,
+				ARMV8_EVTYPE_EVENT);
+}
+
 static void armv8pmu_read_num_pmnc_events(void *info)
 {
 	int *nb_cnt = info;
@@ -520,7 +566,7 @@ static int armv8pmu_probe_num_events(struct arm_pmu *arm_pmu)
 				    &arm_pmu->num_events, 1);
 }
 
-static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
+static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
 	cpu_pmu->enable			= armv8pmu_enable_event,
@@ -532,14 +578,28 @@ static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->max_period		= (1LLU << 32) - 1,
+	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+}
+
+static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
+{
+	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_pmuv3";
 	cpu_pmu->map_event		= armv8_pmuv3_map_event;
-	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+	return armv8pmu_probe_num_events(cpu_pmu);
+}
+
+static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv8_pmu_init(cpu_pmu);
+	cpu_pmu->name			= "armv8_cortex_a53";
+	cpu_pmu->map_event		= armv8_a53_map_event;
 	return armv8pmu_probe_num_events(cpu_pmu);
 }
 
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
+	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
 	{},
 };
 
-- 
1.9.1
