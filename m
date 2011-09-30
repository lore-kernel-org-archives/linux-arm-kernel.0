From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 11:15:54 +0100
Subject: [PATCH 1/3] ARM: perf: fix HW_CACHE_* events on Cortex-A9
In-Reply-To: <1317377756-5986-1-git-send-email-will.deacon@arm.com>
References: <1317377756-5986-1-git-send-email-will.deacon@arm.com>
Message-ID: <1317377756-5986-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using COHERENT_LINE_{MISS,HIT} for cache misses and references
respectively is completely wrong. Instead, use the L1D events which
are a better and more useful approximation despite ignoring instruction
traffic.

Reported-by: Alasdair Grant <alasdair.grant@arm.com>
Reported-by: Matt Horsnell <matt.horsnell@arm.com>
Reported-by: Michael Williams <michael.williams@arm.com>
Cc: stable at kernel.org
Cc: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 98b7573..1ef6d00 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -324,8 +324,8 @@ static const unsigned armv7_a9_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES]	    = ARMV7_PERFCTR_CPU_CYCLES,
 	[PERF_COUNT_HW_INSTRUCTIONS]	    =
 					ARMV7_PERFCTR_INST_OUT_OF_RENAME_STAGE,
-	[PERF_COUNT_HW_CACHE_REFERENCES]    = ARMV7_PERFCTR_COHERENT_LINE_HIT,
-	[PERF_COUNT_HW_CACHE_MISSES]	    = ARMV7_PERFCTR_COHERENT_LINE_MISS,
+	[PERF_COUNT_HW_CACHE_REFERENCES]    = ARMV7_PERFCTR_DCACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]	    = ARMV7_PERFCTR_DCACHE_REFILL,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARMV7_PERFCTR_PC_WRITE,
 	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]	    = ARMV7_PERFCTR_CLOCK_CYCLES,
-- 
1.7.0.4
