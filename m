From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:54:54 +0800
Subject: [PATCH v8 03/16] of/numa: add nid check for memory block
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the numa-id which was configured in memory@ devicetree node is greater
than MAX_NUMNODES, we should report a warning. We have done this for cpus
and distance-map dt nodes, this patch help them to be consistent.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/of/of_numa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 7b3fbdc..c1bd62c 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -75,6 +75,11 @@ static int __init of_numa_parse_memory_nodes(void)
 			 */
 			continue;

+		if (nid >= MAX_NUMNODES) {
+			pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);
+			r = -EINVAL;
+		}
+
 		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
 			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);

--
2.5.0
