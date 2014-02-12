From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 16:55:41 +0100
Subject: [PATCH 07/14] net: axienet: Support phy-less mode of operation
In-Reply-To: <cover.1392220536.git.michal.simek@xilinx.com>
References: <cover.1392220536.git.michal.simek@xilinx.com>
Message-ID: <2dce248d6285beb10f3d4fcfba3c3a087e2c139f.1392220536.git.michal.simek@xilinx.com>
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
index 9595403..9cc9e59 100644
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
@@ -1609,7 +1608,8 @@ static int axienet_of_probe(struct platform_device *op)
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;

 	lp->phy_node = of_parse_phandle(op->dev.of_node, "phy-handle", 0);
-	ret = axienet_mdio_setup(lp, op->dev.of_node);
+	if (lp->phy_node)
+		ret = axienet_mdio_setup(lp, op->dev.of_node);
 	if (ret)
 		dev_warn(&op->dev, "error registering MDIO bus\n");

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/74f29ff1/attachment-0001.sig>
