From: hw.claudio@gmail.com (hw.claudio at gmail.com)
Date: Wed,  4 Nov 2015 12:24:13 +0100
Subject: [RFC] arm64: perf: associate LL with L2 cache accesses and refills
Message-ID: <1446636253-7519-1-git-send-email-hw.claudio@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudio Fontana <claudio.fontana@huawei.com>

Signed-off-by: Claudio Fontana <claudio.fontana@huawei.com>
Cc: Ammar Saeed <ammar.saeed@huawei.com>
---

Hello,

as part of some experiments with the Juno ARM64 board, we needed to get
readings from the PMU regarding L2 Cache hits and misses, but we noticed
that the L2 Cache Access and Refill performance counters were not hooked
up in the perf API. We just did that, and that seems to produce correct
results on the Juno.

However I guess that these registers are not hooked up by default due to
differences between different boards...how could this be done taking
account of the different possible implementations? 

I send this as an initial RFC to try to kickoff discussion about this.

Thank you,

Claudio Fontana

 arch/arm64/kernel/perf_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f9a74d4..f72f2ff 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -728,6 +728,11 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
 	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
 
+	[C(LL)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS,
+	[C(LL)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL,
+	[C(LL)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS,
+	[C(LL)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL,
+
 	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
 	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
 	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
-- 
1.8.5.3
