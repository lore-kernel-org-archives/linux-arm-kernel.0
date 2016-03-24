From: ashoks@broadcom.com (Ashok Kumar)
Date: Thu, 24 Mar 2016 05:52:38 -0700
Subject: [PATCH v2 4/6] arm64/perf: Add Broadcom Vulcan PMU support
In-Reply-To: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
References: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1458823960-32760-5-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom Vulcan uses ARMv8 PMUv3 and supports most of
the ARMv8 recommended implementation defined events.

Added Vulcan events mapping for perf and perf_cache map.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 arch/arm64/kernel/perf_event.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index a025ec2..e8b985c 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -231,6 +231,20 @@ static const unsigned armv8_thunder_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
 };
 
+/* Broadcom Vulcan events mapping */
+static const unsigned armv8_vulcan_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
+};
+
 static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_OP_MAX]
 						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -323,6 +337,36 @@ static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 };
 
+static const unsigned armv8_vulcan_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					      [PERF_COUNT_HW_CACHE_OP_MAX]
+					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE,
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
+	[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
+
+	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
+	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
+
+	[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
+	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
+};
+
 #define ARMV8_EVENT_ATTR_RESOLVE(m) #m
 #define ARMV8_EVENT_ATTR(name, config) \
 	PMU_EVENT_ATTR_STRING(name, armv8_event_attr_##name, \
@@ -940,6 +984,13 @@ static int armv8_thunder_map_event(struct perf_event *event)
 				ARMV8_EVTYPE_EVENT);
 }
 
+static int armv8_vulcan_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv8_vulcan_perf_map,
+				&armv8_vulcan_perf_cache_map,
+				ARMV8_EVTYPE_EVENT);
+}
+
 static unsigned int armv8pmu_read_num_pmnc_events(void)
 {
 	unsigned int nb_cnt;
@@ -1076,12 +1127,20 @@ static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 	return armv8_pmu_init(cpu_pmu);
 }
 
+static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name			= "armv8_brcm_vulcan";
+	cpu_pmu->map_event		= armv8_vulcan_map_event;
+	return armv8_pmu_init(cpu_pmu);
+}
+
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
 	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
 	{.compatible = "arm,cortex-a57-pmu",	.data = armv8_a57_pmu_init},
 	{.compatible = "arm,cortex-a72-pmu",	.data = armv8_a72_pmu_init},
 	{.compatible = "cavium,thunder-pmu",	.data = armv8_thunder_pmu_init},
+	{.compatible = "brcm,vulcan-pmu",	.data = armv8_vulcan_pmu_init},
 	{},
 };
 
-- 
2.1.0
