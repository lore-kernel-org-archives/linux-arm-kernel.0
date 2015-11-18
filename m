From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 Nov 2015 23:04:12 +0100
Subject: [PATCH 2/4] mtd: nand: sunxi: add missing of_node_put
In-Reply-To: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447884254-26336-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
+  of_node_put(child);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mtd/nand/sunxi_nand.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 2ed52e4..1bbcc0c 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1391,8 +1391,10 @@ static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 
 	for_each_child_of_node(np, nand_np) {
 		ret = sunxi_nand_chip_init(dev, nfc, nand_np);
-		if (ret)
+		if (ret) {
+			of_node_put(nand_np);
 			return ret;
+		}
 	}
 
 	return 0;
