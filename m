From: vkale@apm.com (Vinayak Kale)
Date: Fri, 18 Oct 2013 18:29:06 +0530
Subject: [PATCH] arm64: perf: fix event number mask
Message-ID: <1382101146-16033-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes ARMV8_EVTYPE_* macros since evtCount (event number)
field width is 10bits in event selection register.

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 arch/arm64/kernel/perf_event.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cea1594..5d14470 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -784,8 +784,8 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define	ARMV8_EVTYPE_MASK	0xc80000ff	/* Mask for writable bits */
-#define	ARMV8_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
+#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
+#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
 
 /*
  * Event filters for PMUv3
@@ -1175,7 +1175,8 @@ static void armv8pmu_reset(void *info)
 static int armv8_pmuv3_map_event(struct perf_event *event)
 {
 	return map_cpu_event(event, &armv8_pmuv3_perf_map,
-				&armv8_pmuv3_perf_cache_map, 0xFF);
+				&armv8_pmuv3_perf_cache_map,
+				ARMV8_EVTYPE_EVENT);
 }
 
 static struct arm_pmu armv8pmu = {
-- 
1.7.9.5
