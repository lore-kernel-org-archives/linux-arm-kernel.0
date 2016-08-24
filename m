From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 24 Aug 2016 15:44:42 +0800
Subject: [PATCH v7 03/14] arm64/numa: add nid check for memory block
In-Reply-To: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472024693-12912-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the same tactic to cpu and numa-distance nodes.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/of/of_numa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 7b3fbdc..afaeb9c 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -75,6 +75,11 @@ static int __init of_numa_parse_memory_nodes(void)
 			 */
 			continue;

+		if (nid >= MAX_NUMNODES) {
+			pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);
+			return -EINVAL;
+		}
+
 		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
 			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);

--
2.5.0
