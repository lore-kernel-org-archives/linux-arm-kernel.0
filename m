From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 May 2018 21:07:14 +0200
Subject: [PATCH 3/5] soc: ti: knav_dma: add missing of_node_put
In-Reply-To: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1527102436-13447-4-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/soc/ti/knav_dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 224d7dd..bda3173 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -768,6 +768,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 		ret = dma_init(node, child);
 		if (ret) {
 			dev_err(&pdev->dev, "init failed with %d\n", ret);
+			of_node_put(child);
 			break;
 		}
 	}
