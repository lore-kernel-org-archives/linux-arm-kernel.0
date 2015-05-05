From: michal.simek@xilinx.com (Michal Simek)
Date: Tue,  5 May 2015 11:25:58 +0200
Subject: [PATCH 05/12] net: axienet: Support phy-less mode of operation
In-Reply-To: <7fb84f65a61bbe0fdb4b61a871cf4d4f7910955d.1430817941.git.michal.simek@xilinx.com>
References: <7fb84f65a61bbe0fdb4b61a871cf4d4f7910955d.1430817941.git.michal.simek@xilinx.com>
Message-ID: <9f96915ea98cb99b9c437930e08c27d5a00e465e.1430817941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srikanth Thokala <srikanth.thokala@xilinx.com>

This patch adds proper checks to handle the PHY-less case.

Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b1081e1893b0..c6f2ba056c26 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -940,11 +940,10 @@ static int axienet_open(struct net_device *ndev)
 					     PHY_INTERFACE_MODE_RGMII_ID);
 		}
 
-		if (!lp->phy_dev) {
+		if (!lp->phy_dev)
 			dev_err(lp->dev, "of_phy_connect() failed\n");
-			return -ENODEV;
-		}
-		phy_start(lp->phy_dev);
+		else
+			phy_start(lp->phy_dev);
 	}
 
 	/* Enable tasklets for Axi DMA error handling */
@@ -1606,7 +1605,8 @@ static int axienet_of_probe(struct platform_device *op)
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 
 	lp->phy_node = of_parse_phandle(op->dev.of_node, "phy-handle", 0);
-	ret = axienet_mdio_setup(lp, op->dev.of_node);
+	if (lp->phy_node)
+		ret = axienet_mdio_setup(lp, op->dev.of_node);
 	if (ret)
 		dev_warn(&op->dev, "error registering MDIO bus\n");
 
-- 
2.3.5
