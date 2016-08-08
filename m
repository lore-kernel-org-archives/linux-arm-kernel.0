From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 8 Aug 2016 17:18:11 +0800
Subject: [PATCH v5 06/14] of_numa: Use of_get_next_parent to simplify code
In-Reply-To: <1470647899-6324-1-git-send-email-thunder.leizhen@huawei.com>
References: <1470647899-6324-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1470647899-6324-7-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Use of_get_next_parent() instead of open-code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
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
2.5.0
