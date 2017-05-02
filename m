From: alcooperx@gmail.com (Al Cooper)
Date: Tue,  2 May 2017 10:01:31 -0400
Subject: [PATCH] arm: pmu: Get PMU working when the A53 is run in 32 bit mode
Message-ID: <1493733691-43814-1-git-send-email-alcooperx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Cooper <al.cooper@broadcom.com>

When the A53 is run in A15 (32 bit) mode, the registers used to
access the counters are A15 style registers, but the actual
counters are the A53 counters not A15 counters. This patch will
select a PMU counters map for the A53 if the device tree pmu
"compatible" property includes "arm,cortex-a53-pmu".

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/arm/kernel/perf_event_v7.c | 105 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index ab6522b..f714a28 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -147,6 +147,49 @@
 
 #define SCORPION_ITLB_MISS				0x12021
 
+/* ARMV8 A53 events when running in A15 mode. */
+#define ARMV8_PMUV3_PERFCTR_INST_RETIRED			0x08
+#define ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED			0x0C
+
+#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x00
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x03
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x04
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x10
+#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x11
+#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x12
+
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL			0x01
+#define ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL			0x02
+#define ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL			0x05
+#define ARMV8_PMUV3_PERFCTR_MEM_ACCESS				0x13
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE				0x14
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_WB			0x15
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE				0x16
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL			0x17
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_WB			0x18
+#define ARMV8_PMUV3_PERFCTR_BUS_ACCESS				0x19
+#define ARMV8_PMUV3_PERFCTR_MEMORY_ERROR			0x1A
+#define ARMV8_PMUV3_PERFCTR_BUS_CYCLES				0x1D
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_ALLOCATE			0x1F
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_ALLOCATE			0x20
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED_RETIRED			0x22
+#define ARMV8_PMUV3_PERFCTR_STALL_FRONTEND			0x23
+#define ARMV8_PMUV3_PERFCTR_STALL_BACKEND			0x24
+#define ARMV8_PMUV3_PERFCTR_L1D_TLB				0x25
+#define ARMV8_PMUV3_PERFCTR_L1I_TLB				0x26
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE				0x27
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_REFILL			0x28
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_ALLOCATE			0x29
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_REFILL			0x2A
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE				0x2B
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB			0x2C
+#define ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL			0x2D
+#define ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL			0x2E
+#define ARMV8_PMUV3_PERFCTR_L2D_TLB				0x2F
+#define ARMV8_PMUV3_PERFCTR_L2I_TLB				0x30
+
+#define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
+
 /*
  * Cortex-A8 HW events mapping
  *
@@ -340,6 +383,48 @@
 };
 
 /*
+ * Cortex-A53 HW events mapping when running the A53 in A15 mode
+ */
+static const unsigned armv7_a53_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
+};
+
+static const unsigned armv7_a53_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[C(L1D)][C(OP_PREFETCH)][C(RESULT_MISS)] = ARMV8_A53_PERFCTR_PREF_LINEFILL,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE,
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
+
+	[C(LL)][C(OP_READ)][C(RESULT_ACCESS)]   = ARMV8_PMUV3_PERFCTR_L2D_CACHE,
+	[C(LL)][C(OP_READ)][C(RESULT_MISS)]     = ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL,
+	[C(LL)][C(OP_WRITE)][C(RESULT_ACCESS)]  = ARMV8_PMUV3_PERFCTR_L2D_CACHE,
+	[C(LL)][C(OP_WRITE)][C(RESULT_MISS)]    = ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL,
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
+
+	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
+	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+};
+
+/*
  * Cortex-A7 HW events mapping
  */
 static const unsigned armv7_a7_perf_map[PERF_COUNT_HW_MAX] = {
@@ -1129,6 +1214,12 @@ static int armv7_a15_map_event(struct perf_event *event)
 				&armv7_a15_perf_cache_map, 0xFF);
 }
 
+static int armv7_a53_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv7_a53_perf_map,
+				&armv7_a53_perf_cache_map, 0xFF);
+}
+
 static int armv7_a7_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv7_a7_perf_map,
@@ -1240,6 +1331,19 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	return armv7_probe_num_events(cpu_pmu);
 }
 
+static int armv7_a53_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv7pmu_init(cpu_pmu);
+	cpu_pmu->name		= "armv7_cortex_a15_on_a53";
+	cpu_pmu->map_event	= armv7_a53_map_event;
+	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv2_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
+	return armv7_probe_num_events(cpu_pmu);
+}
+
 static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	armv7pmu_init(cpu_pmu);
@@ -2000,6 +2104,7 @@ static int scorpion_mp_pmu_init(struct arm_pmu *cpu_pmu)
 }
 
 static const struct of_device_id armv7_pmu_of_device_ids[] = {
+	{.compatible = "arm,cortex-a53-pmu",	.data = armv7_a53_pmu_init},
 	{.compatible = "arm,cortex-a17-pmu",	.data = armv7_a17_pmu_init},
 	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
 	{.compatible = "arm,cortex-a12-pmu",	.data = armv7_a12_pmu_init},
-- 
1.9.0.138.g2de3478
