From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Feb 2014 16:54:33 +0000
Subject: [PATCH 3/3] ARM: perf: add support for the Cortex-A12 PMU
In-Reply-To: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
References: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
Message-ID: <1393001673-8589-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Albin Tonnerre <albin.tonnerre@arm.com>

Cortex-A12 implements Performance Monitors compliant with the PMUv2
architecture.

This patch adds support for the Cortex-A12 PMU to the ARM perf backend.

Signed-off-by: Albin Tonnerre <albin.tonnerre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt |   1 +
 arch/arm/kernel/perf_event_cpu.c              |   1 +
 arch/arm/kernel/perf_event_v7.c               | 158 ++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index ce731441e64f..fe5cef8976cb 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible : should be one of
 	"arm,armv8-pmuv3"
 	"arm,cortex-a15-pmu"
+	"arm,cortex-a12-pmu"
 	"arm,cortex-a9-pmu"
 	"arm,cortex-a8-pmu"
 	"arm,cortex-a7-pmu"
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 326cb58de2f8..51798d7854ac 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -222,6 +222,7 @@ static struct notifier_block cpu_pmu_hotplug_notifier = {
  */
 static struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
+	{.compatible = "arm,cortex-a12-pmu",	.data = armv7_a12_pmu_init},
 	{.compatible = "arm,cortex-a9-pmu",	.data = armv7_a9_pmu_init},
 	{.compatible = "arm,cortex-a8-pmu",	.data = armv7_a8_pmu_init},
 	{.compatible = "arm,cortex-a7-pmu",	.data = armv7_a7_pmu_init},
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 2fce4751f4c0..f4ef3981ed02 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -113,6 +113,19 @@ enum armv7_a15_perf_types {
 	ARMV7_A15_PERFCTR_PC_WRITE_SPEC			= 0x76,
 };
 
+/* ARMv7 Cortex-A12 specific event types */
+enum armv7_a12_perf_types {
+	ARMV7_A12_PERFCTR_L1_DCACHE_ACCESS_READ		= 0x40,
+	ARMV7_A12_PERFCTR_L1_DCACHE_ACCESS_WRITE	= 0x41,
+
+	ARMV7_A12_PERFCTR_L2_CACHE_ACCESS_READ		= 0x50,
+	ARMV7_A12_PERFCTR_L2_CACHE_ACCESS_WRITE		= 0x51,
+
+	ARMV7_A12_PERFCTR_PC_WRITE_SPEC			= 0x76,
+
+	ARMV7_A12_PERFCTR_PF_TLB_REFILL			= 0xe7,
+};
+
 /* ARMv7 Krait specific event types */
 enum krait_perf_types {
 	KRAIT_PMRESR0_GROUP0				= 0xcc,
@@ -750,6 +763,130 @@ static const unsigned armv7_a7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 };
 
 /*
+ * Cortex-A12 HW events mapping
+ */
+static const unsigned armv7_a12_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV7_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV7_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV7_PERFCTR_L1_DCACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV7_PERFCTR_L1_DCACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV7_A12_PERFCTR_PC_WRITE_SPEC,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV7_PERFCTR_BUS_CYCLES,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+};
+
+static const unsigned armv7_a12_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_A12_PERFCTR_L1_DCACHE_ACCESS_READ,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DCACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_A12_PERFCTR_L1_DCACHE_ACCESS_WRITE,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DCACHE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(L1I)] = {
+		/*
+		 * Not all performance counters differentiate between read
+		 * and write accesses/misses so we're not always strictly
+		 * correct, but it's the best we can do. Writes and reads get
+		 * combined in these cases.
+		 */
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_ICACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_A12_PERFCTR_L2_CACHE_ACCESS_READ,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_A12_PERFCTR_L2_CACHE_ACCESS_WRITE,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACHE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_DTLB_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_DTLB_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_A12_PERFCTR_PF_TLB_REFILL,
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_ITLB_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_ITLB_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_PC_BRANCH_PRED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_PC_BRANCH_PRED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+};
+
+/*
  * Krait HW events mapping
  */
 static const unsigned krait_perf_map[PERF_COUNT_HW_MAX] = {
@@ -1362,6 +1499,12 @@ static int armv7_a7_map_event(struct perf_event *event)
 				&armv7_a7_perf_cache_map, 0xFF);
 }
 
+static int armv7_a12_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv7_a12_perf_map,
+				&armv7_a12_perf_cache_map, 0xFF);
+}
+
 static int krait_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &krait_perf_map,
@@ -1446,6 +1589,16 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
+static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv7pmu_init(cpu_pmu);
+	cpu_pmu->name		= "ARMv7 Cortex-A12";
+	cpu_pmu->map_event	= armv7_a12_map_event;
+	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
+	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	return 0;
+}
+
 /*
  * Krait Performance Monitor Region Event Selection Register (PMRESRn)
  *
@@ -1863,6 +2016,11 @@ static inline int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	return -ENODEV;
 }
 
+static inline int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	return -ENODEV;
+}
+
 static inline int krait_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	return -ENODEV;
-- 
1.8.2.2
