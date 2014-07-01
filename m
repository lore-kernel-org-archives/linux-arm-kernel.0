From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:14 +0100
Subject: [PATCH 4/8] arm: perf: armv6: condense event maps
In-Reply-To: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1404227478-9645-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have macros for declaring fully invalid event maps, put them
to work for all the ARMv6 PMU event maps. While this necessitates
repeating common indices, we no longer need to refer to *_UNSUPPORTED
events at all, and it makes it possible for the even maps to fit on a
single page on a reasonably sized monitor.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v6.c | 271 +++++++---------------------------------
 1 file changed, 47 insertions(+), 224 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 03664b0..0fd4290 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -65,13 +65,11 @@ enum armv6_counters {
  * accesses/misses in hardware.
  */
 static const unsigned armv6_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV6_PERFCTR_CPU_CYCLES,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV6_PERFCTR_INSTR_EXEC,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_CACHE_MISSES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV6_PERFCTR_BR_EXEC,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV6_PERFCTR_BR_MISPREDICT,
-	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV6_PERFCTR_IBUF_STALL,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV6_PERFCTR_LSU_FULL_STALL,
 };
@@ -79,116 +77,31 @@ static const unsigned armv6_perf_map[PERF_COUNT_HW_MAX] = {
 static const unsigned armv6_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					  [PERF_COUNT_HW_CACHE_OP_MAX]
 					  [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
-	[C(L1D)] = {
-		/*
-		 * The performance counters don't differentiate between read
-		 * and write accesses/misses so this isn't strictly correct,
-		 * but it's the best we can do. Writes and reads get
-		 * combined.
-		 */
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= ARMV6_PERFCTR_DCACHE_ACCESS,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_DCACHE_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= ARMV6_PERFCTR_DCACHE_ACCESS,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_DCACHE_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(L1I)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_ICACHE_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(LL)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(DTLB)] = {
-		/*
-		 * The ARM performance counters can count micro DTLB misses,
-		 * micro ITLB misses and main TLB misses. There isn't an event
-		 * for TLB misses, so use the micro misses here and if users
-		 * want the main TLB misses they can use a raw counter.
-		 */
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_DTLB_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_DTLB_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(ITLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_ITLB_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= ARMV6_PERFCTR_ITLB_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(BPU)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(NODE)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	/*
+	 * The performance counters don't differentiate between read and write
+	 * accesses/misses so this isn't strictly correct, but it's the best we
+	 * can do. Writes and reads get combined.
+	 */
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV6_PERFCTR_DCACHE_ACCESS,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6_PERFCTR_DCACHE_MISS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV6_PERFCTR_DCACHE_ACCESS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6_PERFCTR_DCACHE_MISS,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6_PERFCTR_ICACHE_MISS,
+
+	/*
+	 * The ARM performance counters can count micro DTLB misses, micro ITLB
+	 * misses and main TLB misses. There isn't an event for TLB misses, so
+	 * use the micro misses here and if users want the main TLB misses they
+	 * can use a raw counter.
+	 */
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6_PERFCTR_DTLB_MISS,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6_PERFCTR_DTLB_MISS,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6_PERFCTR_ITLB_MISS,
+	[C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6_PERFCTR_ITLB_MISS,
 };
 
 enum armv6mpcore_perf_types {
@@ -220,13 +133,11 @@ enum armv6mpcore_perf_types {
  * accesses/misses in hardware.
  */
 static const unsigned armv6mpcore_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV6MPCORE_PERFCTR_CPU_CYCLES,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV6MPCORE_PERFCTR_INSTR_EXEC,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_CACHE_MISSES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV6MPCORE_PERFCTR_BR_EXEC,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV6MPCORE_PERFCTR_BR_MISPREDICT,
-	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV6MPCORE_PERFCTR_IBUF_STALL,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV6MPCORE_PERFCTR_LSU_FULL_STALL,
 };
@@ -234,114 +145,26 @@ static const unsigned armv6mpcore_perf_map[PERF_COUNT_HW_MAX] = {
 static const unsigned armv6mpcore_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					[PERF_COUNT_HW_CACHE_OP_MAX]
 					[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
-	[C(L1D)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  =
-				ARMV6MPCORE_PERFCTR_DCACHE_RDACCESS,
-			[C(RESULT_MISS)]    =
-				ARMV6MPCORE_PERFCTR_DCACHE_RDMISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  =
-				ARMV6MPCORE_PERFCTR_DCACHE_WRACCESS,
-			[C(RESULT_MISS)]    =
-				ARMV6MPCORE_PERFCTR_DCACHE_WRMISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(L1I)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = ARMV6MPCORE_PERFCTR_ICACHE_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(LL)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(DTLB)] = {
-		/*
-		 * The ARM performance counters can count micro DTLB misses,
-		 * micro ITLB misses and main TLB misses. There isn't an event
-		 * for TLB misses, so use the micro misses here and if users
-		 * want the main TLB misses they can use a raw counter.
-		 */
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = ARMV6MPCORE_PERFCTR_DTLB_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = ARMV6MPCORE_PERFCTR_DTLB_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(ITLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = ARMV6MPCORE_PERFCTR_ITLB_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = ARMV6MPCORE_PERFCTR_ITLB_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(BPU)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(NODE)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]  = CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]    = CACHE_OP_UNSUPPORTED,
-		},
-	},
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV6MPCORE_PERFCTR_DCACHE_RDACCESS,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DCACHE_RDMISS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV6MPCORE_PERFCTR_DCACHE_WRACCESS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DCACHE_WRMISS,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_ICACHE_MISS,
+
+	/*
+	 * The ARM performance counters can count micro DTLB misses, micro ITLB
+	 * misses and main TLB misses. There isn't an event for TLB misses, so
+	 * use the micro misses here and if users want the main TLB misses they
+	 * can use a raw counter.
+	 */
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DTLB_MISS,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_DTLB_MISS,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_ITLB_MISS,
+	[C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV6MPCORE_PERFCTR_ITLB_MISS,
 };
 
 static inline unsigned long
-- 
1.9.1
