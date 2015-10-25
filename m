From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 25 Oct 2015 14:57:00 +0100
Subject: [PATCH 1/8] net: thunderx: add missing of_node_put
In-Reply-To: <1445781427-7110-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445781427-7110-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1445781427-7110-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
local idexpression r.n;
expression r,e;
@@

 for_each_child_of_node(r,n) {
   ...
(
   of_node_put(n);
|
   e = n
|
+  of_node_put(n);
?  break;
)
   ...
 }
... when != n
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 574c492..180aa9f 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -977,8 +977,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		SET_NETDEV_DEV(&bgx->lmac[lmac].netdev, &bgx->pdev->dev);
 		bgx->lmac[lmac].lmacid = lmac;
 		lmac++;
-		if (lmac == MAX_LMAC_PER_BGX)
+		if (lmac == MAX_LMAC_PER_BGX) {
+			of_node_put(np_child);
 			break;
+		}
 	}
 	return 0;
 }
