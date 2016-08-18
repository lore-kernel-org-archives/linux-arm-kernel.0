From: zhongjiang@huawei.com (zhongjiang)
Date: Thu, 18 Aug 2016 21:09:26 +0800
Subject: [PATCH] mm,
 numa: boot cpu should bound to the node0 when node_off enable
Message-ID: <1471525766-12803-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present, boot cpu will bound to a node from device tree when node_off enable.
if the node is not initialization, it will lead to a following problem.

 next_zones_zonelist+0x18/0x80
 __build_all_zonelists+0x1e0/0x288
 build_all_zonelists_init+0x10/0x1c
 build_all_zonelists+0x114/0x128
 start_kernel+0x1a0/0x414

The patch fix it by fallback to node 0. therefore, the cpu will bound to the node
correctly.

Signed-off-by: zhongjiang <zhongjiang@huawei.com>
---
 arch/arm64/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4dcd7d6..1f8f5da 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -119,7 +119,7 @@ void numa_store_cpu_info(unsigned int cpu)
 void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 {
 	/* fallback to node 0 */
-	if (nid < 0 || nid >= MAX_NUMNODES)
+	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
 		nid = 0;
 
 	cpu_to_node_map[cpu] = nid;
-- 
1.7.12.4
