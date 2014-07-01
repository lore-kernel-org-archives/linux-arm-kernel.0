From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:15 +0100
Subject: [PATCH 5/8] arm: perf: xscale: condense event maps
In-Reply-To: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1404227478-9645-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have macros for declaring fully invalid event maps, put them
to work for the XScale PMU event maps. While this necessitates repeating
common indices, we no longer need to refer to *_UNSUPPORTED events at
all, and it makes it possible for the even maps to fit on a single page
on a reasonably sized monitor.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_xscale.c | 117 +++++-------------------------------
 1 file changed, 15 insertions(+), 102 deletions(-)

diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 63990c4..3d47984 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -48,118 +48,31 @@ enum xscale_counters {
 };
 
 static const unsigned xscale_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= XSCALE_PERFCTR_CCNT,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= XSCALE_PERFCTR_INSTRUCTION,
-	[PERF_COUNT_HW_CACHE_REFERENCES]	= HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_CACHE_MISSES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= XSCALE_PERFCTR_BRANCH,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= XSCALE_PERFCTR_BRANCH_MISS,
-	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= XSCALE_PERFCTR_ICACHE_NO_DELIVER,
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
 };
 
 static const unsigned xscale_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 					   [PERF_COUNT_HW_CACHE_OP_MAX]
 					   [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
-	[C(L1D)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= XSCALE_PERFCTR_DCACHE_ACCESS,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_DCACHE_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= XSCALE_PERFCTR_DCACHE_ACCESS,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_DCACHE_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(L1I)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_ICACHE_MISS,
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
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_DTLB_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_DTLB_MISS,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(ITLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_ITLB_MISS,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= XSCALE_PERFCTR_ITLB_MISS,
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
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= XSCALE_PERFCTR_DCACHE_ACCESS,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= XSCALE_PERFCTR_DCACHE_MISS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= XSCALE_PERFCTR_DCACHE_ACCESS,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= XSCALE_PERFCTR_DCACHE_MISS,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= XSCALE_PERFCTR_ICACHE_MISS,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= XSCALE_PERFCTR_DTLB_MISS,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= XSCALE_PERFCTR_DTLB_MISS,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= XSCALE_PERFCTR_ITLB_MISS,
+	[C(ITLB)][C(OP_WRITE)][C(RESULT_MISS)]	= XSCALE_PERFCTR_ITLB_MISS,
 };
 
 #define	XSCALE_PMU_ENABLE	0x001
-- 
1.9.1
