From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:55 +0100
Subject: [PATCH 11/11] ARM: perf: add support for the Cortex-A15 PMU
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Cortex-A15 PMU to the ARMv7
perf-event backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |    1 +
 arch/arm/kernel/perf_event.c      |    3 +
 arch/arm/kernel/perf_event_v7.c   |  153 +++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 207bd3c..0f8e382 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -25,6 +25,7 @@ enum arm_perf_pmu_ids {
 	ARM_PERF_PMU_ID_CA8,
 	ARM_PERF_PMU_ID_CA9,
 	ARM_PERF_PMU_ID_CA5,
+	ARM_PERF_PMU_ID_CA15,
 	ARM_NUM_PMU_IDS,
 };
 
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index df4e517..262ea67 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -663,6 +663,9 @@ init_hw_perf_events(void)
 		case 0xC050:	/* Cortex-A5 */
 			armpmu = armv7_a5_pmu_init();
 			break;
+		case 0xC0F0:	/* Cortex-A15 */
+			armpmu = armv7_a15_pmu_init();
+			break;
 		}
 	/* Intel CPUs [xscale]. */
 	} else if (0x69 == implementor) {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index db1d6c4..9633178 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -168,6 +168,24 @@ enum armv7_a5_perf_types {
 	ARMV7_PERFCTR_STALL_SB_FULL		= 0xc9,
 };
 
+/* ARMv7 Cortex-A15 specific event types */
+enum armv7_a15_perf_types {
+	ARMV7_PERFCTR_L1_DCACHE_READ_ACCESS	= 0x40,
+	ARMV7_PERFCTR_L1_DCACHE_WRITE_ACCESS	= 0x41,
+	ARMV7_PERFCTR_L1_DCACHE_READ_REFILL	= 0x42,
+	ARMV7_PERFCTR_L1_DCACHE_WRITE_REFILL	= 0x43,
+
+	ARMV7_PERFCTR_L1_DTLB_READ_REFILL	= 0x4C,
+	ARMV7_PERFCTR_L1_DTLB_WRITE_REFILL	= 0x4D,
+
+	ARMV7_PERFCTR_L2_DCACHE_READ_ACCESS	= 0x50,
+	ARMV7_PERFCTR_L2_DCACHE_WRITE_ACCESS	= 0x51,
+	ARMV7_PERFCTR_L2_DCACHE_READ_REFILL	= 0x52,
+	ARMV7_PERFCTR_L2_DCACHE_WRITE_REFILL	= 0x53,
+
+	ARMV7_PERFCTR_SPEC_PC_WRITE		= 0x76,
+};
+
 /*
  * Cortex-A8 HW events mapping
  *
@@ -510,6 +528,126 @@ static const unsigned armv7_a5_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 };
 
 /*
+ * Cortex-A15 HW events mapping
+ */
+static const unsigned armv7_a15_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]	    = ARMV7_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]	    = ARMV7_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_CACHE_MISSES]	    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARMV7_PERFCTR_SPEC_PC_WRITE,
+	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]	    = ARMV7_PERFCTR_BUS_CYCLES,
+};
+
+static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_L1_DCACHE_READ_ACCESS,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_L1_DCACHE_READ_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_L1_DCACHE_WRITE_ACCESS,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_L1_DCACHE_WRITE_REFILL,
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
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_IFETCH_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_IFETCH_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_L2_DCACHE_READ_ACCESS,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_L2_DCACHE_READ_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]
+					= ARMV7_PERFCTR_L2_DCACHE_WRITE_ACCESS,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_L2_DCACHE_WRITE_REFILL,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_L1_DTLB_READ_REFILL,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_L1_DTLB_WRITE_REFILL,
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
@@ -1051,6 +1189,16 @@ static const struct arm_pmu *__init armv7_a5_pmu_init(void)
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
+
+static const struct arm_pmu *__init armv7_a15_pmu_init(void)
+{
+	armv7pmu.id		= ARM_PERF_PMU_ID_CA15;
+	armv7pmu.name		= "ARMv7 Cortex-A15";
+	armv7pmu.cache_map	= &armv7_a15_perf_cache_map;
+	armv7pmu.event_map	= &armv7_a15_perf_map;
+	armv7pmu.num_events	= armv7_read_num_pmnc_events();
+	return &armv7pmu;
+}
 #else
 static const struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
@@ -1066,4 +1214,9 @@ static const struct arm_pmu *__init armv7_a5_pmu_init(void)
 {
 	return NULL;
 }
+
+static const struct arm_pmu *__init armv7_a15_pmu_init(void)
+{
+	return NULL;
+}
 #endif	/* CONFIG_CPU_V7 */
-- 
1.7.0.4
