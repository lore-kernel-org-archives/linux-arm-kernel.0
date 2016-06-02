From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 2 Jun 2016 14:03:07 +0800
Subject: [PATCH 1/3] of_numa: Use of_get_next_parent to simplify code
In-Reply-To: <1464847389-11652-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464834491-12024-1-git-send-email-thunder.leizhen@huawei.com>
 <1464847389-11652-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1464847389-11652-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_get_next_parent() instead of open-code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/of/of_numa.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 3157130..ed7bd22 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -153,8 +153,6 @@ int of_node_to_nid(struct device_node *device)
 	np = of_node_get(device);
 
 	while (np) {
-		struct device_node *parent;
-
 		r = of_property_read_u32(np, "numa-node-id", &nid);
 		/*
 		 * -EINVAL indicates the property was not found, and
@@ -165,9 +163,7 @@ int of_node_to_nid(struct device_node *device)
 		if (r != -EINVAL)
 			break;
 
-		parent = of_get_parent(np);
-		of_node_put(np);
-		np = parent;
+		np = of_get_next_parent(np);
 	}
 	if (np && r)
 		pr_warn("NUMA: Invalid \"numa-node-id\" property in node %s\n",
-- 
1.7.12.4
