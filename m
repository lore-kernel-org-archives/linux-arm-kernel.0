From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jan 2012 11:34:34 +0000
Subject: [PATCH] ARM: perf: add support for the Cortex-A7 PMU
Message-ID: <1327059274-14290-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A7 implements an ARMv7-compatible PMU compliant with the PMUv2
architecture specification.

This patch adds support for the PMU to the ARM perf backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |    1 +
 arch/arm/kernel/perf_event.c      |    3 +
 arch/arm/kernel/perf_event_v7.c   |  145 +++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 99cfe36..ee7c056 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -26,6 +26,7 @@ enum arm_perf_pmu_ids {
 	ARM_PERF_PMU_ID_CA9,
 	ARM_PERF_PMU_ID_CA5,
 	ARM_PERF_PMU_ID_CA15,
+	ARM_PERF_PMU_ID_CA7,
 	ARM_NUM_PMU_IDS,
 };
 
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5bb91bf..ab59c3b 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -712,6 +712,9 @@ init_hw_perf_events(void)
 		case 0xC0F0:	/* Cortex-A15 */
 			cpu_pmu = armv7_a15_pmu_init();
 			break;
+		case 0xC070:	/* Cortex-A7 */
+			cpu_pmu = armv7_a7_pmu_init();
+			break;
 		}
 	/* Intel CPUs [xscale]. */
 	} else if (0x69 == implementor) {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 6933244..9f342b6 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -610,6 +610,130 @@ static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 };
 
 /*
+ * Cortex-A7 HW events mapping
+ */
+static const unsigned armv7_a7_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV7_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV7_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV7_PERFCTR_L1_DCACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV7_PERFCTR_L1_DCACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV7_PERFCTR_PC_WRITE,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV7_PERFCTR_BUS_CYCLES,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+};
+
+static const unsigned armv7_a7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		/*
+		 * The performance counters don't differentiate between read
+		 * and write accesses/misses so this isn't strictly correct,
+		 * but it's the best we can do. Writes and reads get
+		 * combined.
+		 */
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DCACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DCACHE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_ICACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_ICACHE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L2_CACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L2_CACHE_ACCESS,
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
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
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
  * Perf Events' indices
  */
 #define	ARMV7_IDX_CYCLE_COUNTER	0
@@ -1095,6 +1219,12 @@ static int armv7_a15_map_event(struct perf_event *event)
 				&armv7_a15_perf_cache_map, 0xFF);
 }
 
+static int armv7_a7_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv7_a7_perf_map,
+				&armv7_a7_perf_cache_map, 0xFF);
+}
+
 static struct arm_pmu armv7pmu = {
 	.handle_irq		= armv7pmu_handle_irq,
 	.enable			= armv7pmu_enable_event,
@@ -1155,6 +1285,16 @@ static struct arm_pmu *__init armv7_a15_pmu_init(void)
 	armv7pmu.set_event_filter = armv7pmu_set_event_filter;
 	return &armv7pmu;
 }
+
+static struct arm_pmu *__init armv7_a7_pmu_init(void)
+{
+	armv7pmu.id		= ARM_PERF_PMU_ID_CA7;
+	armv7pmu.name		= "ARMv7 Cortex-A7";
+	armv7pmu.map_event	= armv7_a7_map_event;
+	armv7pmu.num_events	= armv7_read_num_pmnc_events();
+	armv7pmu.set_event_filter = armv7pmu_set_event_filter;
+	return &armv7pmu;
+}
 #else
 static struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
@@ -1175,4 +1315,9 @@ static struct arm_pmu *__init armv7_a15_pmu_init(void)
 {
 	return NULL;
 }
+
+static struct arm_pmu *__init armv7_a7_pmu_init(void)
+{
+	return NULL;
+}
 #endif	/* CONFIG_CPU_V7 */
-- 
1.7.4.1
