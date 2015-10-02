From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  2 Oct 2015 10:55:05 +0100
Subject: [PATCHv4 3/6] arm64: perf: add Cortex-A57 support
In-Reply-To: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
References: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1443779708-26789-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A57 PMU supports a few events outside of the required PMUv3
set that are rather useful.

This patch adds the event map data for said events.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |  1 +
 arch/arm64/kernel/perf_event.c                | 61 +++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 2e6737b..4b7c3d9 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -8,6 +8,7 @@ Required properties:
 
 - compatible : should be one of
 	"arm,armv8-pmuv3"
+	"arm.cortex-a57-pmu"
 	"arm.cortex-a53-pmu"
 	"arm,cortex-a17-pmu"
 	"arm,cortex-a15-pmu"
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cc13395..128995a 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -74,6 +74,16 @@ enum armv8_a53_pmu_perf_types {
 	ARMV8_A53_PERFCTR_PREFETCH_LINEFILL			= 0xC2,
 };
 
+/* ARMv8 Cortex-A57 specific event types. */
+enum armv8_a57_perf_types {
+	ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_LD			= 0x40,
+	ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_ST			= 0x41,
+	ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_LD			= 0x42,
+	ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_ST			= 0x43,
+	ARMV8_A57_PERFCTR_DTLB_REFILL_LD			= 0x4c,
+	ARMV8_A57_PERFCTR_DTLB_REFILL_ST			= 0x4d,
+};
+
 /* PMUv3 HW events mapping. */
 static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
@@ -96,6 +106,16 @@ static const unsigned armv8_a53_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 };
 
+static const unsigned armv8_a57_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
+};
+
 static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_OP_MAX]
 						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -134,6 +154,31 @@ static const unsigned armv8_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+static const unsigned armv8_a57_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					      [PERF_COUNT_HW_CACHE_OP_MAX]
+					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_LD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_LD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_ACCESS_ST,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_L1_DCACHE_REFILL_ST,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS,
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_DTLB_REFILL_LD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_A57_PERFCTR_DTLB_REFILL_ST,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_ITLB_REFILL,
+
+	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+};
+
+
 /*
  * Perf Events' indices
  */
@@ -548,6 +593,13 @@ static int armv8_a53_map_event(struct perf_event *event)
 				ARMV8_EVTYPE_EVENT);
 }
 
+static int armv8_a57_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv8_a57_perf_map,
+				&armv8_a57_perf_cache_map,
+				ARMV8_EVTYPE_EVENT);
+}
+
 static void armv8pmu_read_num_pmnc_events(void *info)
 {
 	int *nb_cnt = info;
@@ -597,9 +649,18 @@ static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 	return armv8pmu_probe_num_events(cpu_pmu);
 }
 
+static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv8_pmu_init(cpu_pmu);
+	cpu_pmu->name			= "armv8_cortex_a57";
+	cpu_pmu->map_event		= armv8_a57_map_event;
+	return armv8pmu_probe_num_events(cpu_pmu);
+}
+
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
 	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
+	{.compatible = "arm,cortex-a57-pmu",	.data = armv8_a57_pmu_init},
 	{},
 };
 
-- 
1.9.1
