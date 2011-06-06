From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:54 +0100
Subject: [PATCH 10/11] ARM: perf: add support for the Cortex-A5 PMU
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Cortex-A5 PMU to the ARMv7 perf-event
backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |    1 +
 arch/arm/kernel/perf_event.c      |    3 +
 arch/arm/kernel/perf_event_v7.c   |  146 +++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index c4aa4e8..207bd3c 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -24,6 +24,7 @@ enum arm_perf_pmu_ids {
 	ARM_PERF_PMU_ID_V6MP,
 	ARM_PERF_PMU_ID_CA8,
 	ARM_PERF_PMU_ID_CA9,
+	ARM_PERF_PMU_ID_CA5,
 	ARM_NUM_PMU_IDS,
 };
 
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index d53c0ab..df4e517 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -660,6 +660,9 @@ init_hw_perf_events(void)
 		case 0xC090:	/* Cortex-A9 */
 			armpmu = armv7_a9_pmu_init();
 			break;
+		case 0xC050:	/* Cortex-A5 */
+			armpmu = armv7_a5_pmu_init();
+			break;
 		}
 	/* Intel CPUs [xscale]. */
 	} else if (0x69 == implementor) {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 01b1145..db1d6c4 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -153,6 +153,21 @@ enum armv7_a9_perf_types {
 	ARMV7_PERFCTR_PLE_RQST_PROG		= 0xA5
 };
 
+/* ARMv7 Cortex-A5 specific event types */
+enum armv7_a5_perf_types {
+	ARMV7_PERFCTR_IRQ_TAKEN			= 0x86,
+	ARMV7_PERFCTR_FIQ_TAKEN			= 0x87,
+
+	ARMV7_PERFCTR_EXT_MEM_RQST		= 0xc0,
+	ARMV7_PERFCTR_NC_EXT_MEM_RQST		= 0xc1,
+	ARMV7_PERFCTR_PREFETCH_LINEFILL		= 0xc2,
+	ARMV7_PERFCTR_PREFETCH_LINEFILL_DROP	= 0xc3,
+	ARMV7_PERFCTR_ENTER_READ_ALLOC		= 0xc4,
+	ARMV7_PERFCTR_READ_ALLOC		= 0xc5,
+
+	ARMV7_PERFCTR_STALL_SB_FULL		= 0xc9,
+};
+
 /*
  * Cortex-A8 HW events mapping
  *
@@ -379,6 +394,122 @@ static const unsigned armv7_a9_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 };
 
 /*
+ * Cortex-A5 HW events mapping
+ */
+static const unsigned armv7_a5_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]	    = ARMV7_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]	    = ARMV7_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_CACHE_MISSES]	    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARMV7_PERFCTR_PC_WRITE,
+	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]	    = HW_OP_UNSUPPORTED,
+};
+
+static const unsigned armv7_a5_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_DCACHE_ACCESS,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_DCACHE_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_DCACHE_ACCESS,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_DCACHE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_PREFETCH_LINEFILL,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_PREFETCH_LINEFILL_DROP,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_IFETCH_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_IFETCH_MISS,
+		},
+		/*
+		 * The prefetch counters don't differentiate between the I
+		 * side and the D side.
+		 */
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_PREFETCH_LINEFILL,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_PREFETCH_LINEFILL_DROP,
+		},
+	},
+	[C(LL)] = {
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
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_ITLB_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_ITLB_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_PC_BRANCH_PRED,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_PC_BRANCH_PRED,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+};
+
+/*
  * Perf Events counters
  */
 enum armv7_counters {
@@ -910,6 +1041,16 @@ static const struct arm_pmu *__init armv7_a9_pmu_init(void)
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
+
+static const struct arm_pmu *__init armv7_a5_pmu_init(void)
+{
+	armv7pmu.id		= ARM_PERF_PMU_ID_CA5;
+	armv7pmu.name		= "ARMv7 Cortex-A5";
+	armv7pmu.cache_map	= &armv7_a5_perf_cache_map;
+	armv7pmu.event_map	= &armv7_a5_perf_map;
+	armv7pmu.num_events	= armv7_read_num_pmnc_events();
+	return &armv7pmu;
+}
 #else
 static const struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
@@ -920,4 +1061,9 @@ static const struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
 	return NULL;
 }
+
+static const struct arm_pmu *__init armv7_a5_pmu_init(void)
+{
+	return NULL;
+}
 #endif	/* CONFIG_CPU_V7 */
-- 
1.7.0.4
