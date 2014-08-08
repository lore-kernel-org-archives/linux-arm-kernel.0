From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Fri,  8 Aug 2014 12:07:53 +0200
Subject: =?UTF-8?q?=5BPATCH=2012/14=5D=20ll=5Ftemac=3A=20delete=20unneeded=20test=20before=20of=5Fnode=5Fput?=
Message-ID: <1407492475-26283-12-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Of_node_put supports NULL as its argument, so the initial test is not
necessary.

Suggested by Uwe Kleine-K?nig.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

-if (e)
   of_node_put(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/xilinx/ll_temac_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 8a6e5c2..36f4459 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1148,8 +1148,7 @@ static int temac_of_remove(struct platform_device *op)
 	temac_mdio_teardown(lp);
 	unregister_netdev(ndev);
 	sysfs_remove_group(&lp->dev->kobj, &temac_attr_group);
-	if (lp->phy_node)
-		of_node_put(lp->phy_node);
+	of_node_put(lp->phy_node);
 	lp->phy_node = NULL;
 	iounmap(lp->regs);
 	if (lp->sdma_regs)
