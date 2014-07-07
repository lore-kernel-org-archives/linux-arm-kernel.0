From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 08 Jul 2014 00:22:59 +0100
Subject: [PATCH A 06/12] net: fec: ensure that a disconnected phy isn't
 configured
In-Reply-To: <20140707232148.GG21766@n2100.arm.linux.org.uk>
References: <20140707232148.GG21766@n2100.arm.linux.org.uk>
Message-ID: <E1X4IFP-0004x1-H0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we disconnect from a phy, we should forget our pointer to it so we
don't accidentally try to configure it.  We handle a NULL phy pointer
correctly in most places, except fec_enet_set_pauseparam().  Fix this
too.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6a03d7eced4d..cf805468eecc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1875,6 +1875,9 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	if (!fep->phy_dev)
+		return -ENODEV;
+
 	if (pause->tx_pause != pause->rx_pause) {
 		netdev_info(ndev,
 			"hardware only support enable/disable both tx and rx");
@@ -2186,6 +2189,7 @@ fec_enet_close(struct net_device *ndev)
 
 	phy_stop(fep->phy_dev);
 	phy_disconnect(fep->phy_dev);
+	fep->phy_dev = NULL;
 
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
-- 
1.8.3.1
