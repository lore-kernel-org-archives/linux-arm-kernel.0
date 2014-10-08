From: zhangzhiqiang.zhang@huawei.com (zhangzhiqiang)
Date: Wed, 8 Oct 2014 11:06:12 +0800
Subject: [PATCH] arm: armv7: perf: fix armv7 ref-cycles error
Message-ID: <5434AA24.7010600@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all,
----------------------------------------

ref-cycles event is specially to Intel core, but can still used in arm architecture
with the wrong return value with 3.10 stable. for instance:

 perf stat -e ref-cycles sleep 1

 Performance counter stats for 'sleep 1':

  	0 ref-cycles

       1.002381916 seconds time elapsed

this patch fix the bug and make it return NOT SUPPORTED
distinctly.

In upstream this bug has been fixed by other way(not primary for the bug), which changes more than one file
and more than 1000 lines. the primary commit is 6b7658ec8a100b608e59e3cde353434db51f5be0.
besides we can not simply cherry-pick.

Signed-off-by: Zhiqiang Zhang <zhangzhiqiang.zhang@huawei.com>
---
 arch/arm/kernel/perf_event_v7.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 039cffb..c3d24aa 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -126,6 +126,7 @@ static const unsigned armv7_a8_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV7_A8_PERFCTR_STALL_ISIDE,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_REF_CPU_CYCLES]	= HW_OP_UNSUPPORTED,
 };

 static const unsigned armv7_a8_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
@@ -250,6 +251,7 @@ static const unsigned armv7_a9_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV7_A9_PERFCTR_STALL_ICACHE,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV7_A9_PERFCTR_STALL_DISPATCH,
+	[PERF_COUNT_HW_REF_CPU_CYCLES]	= HW_OP_UNSUPPORTED,
 };

 static const unsigned armv7_a9_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
@@ -374,6 +376,7 @@ static const unsigned armv7_a5_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES]		= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = HW_OP_UNSUPPORTED,
 };

 static const unsigned armv7_a5_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
@@ -496,6 +499,7 @@ static const unsigned armv7_a15_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV7_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = HW_OP_UNSUPPORTED,
 };

 static const unsigned armv7_a15_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
@@ -620,6 +624,7 @@ static const unsigned armv7_a7_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV7_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= HW_OP_UNSUPPORTED,
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = HW_OP_UNSUPPORTED,
 };

 static const unsigned armv7_a7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
--

so, can we fix it in this way and put it into 3.10 stable repo.
