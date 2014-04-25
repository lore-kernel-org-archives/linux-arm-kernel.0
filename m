From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:15 +0100
Subject: [PATCH 074/222] net:fec: ensure that a disconnected phy isn't
 configured
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRP-0007I7-7i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we disconnect from a phy, we should forget our pointer to it so we
don't accidentally try to configure it.  We handle a NULL phy pointer
correctly in most places, except fec_enet_set_pauseparam().  Fix this
too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b7a5614b874d..9de899eb9f8e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1496,6 +1496,9 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	if (!fep->phy_dev)
+		return -ENODEV;
+
 	if (pause->tx_pause != pause->rx_pause) {
 		netdev_info(ndev,
 			"hardware only support enable/disable both tx and rx");
@@ -1800,6 +1803,7 @@ fec_enet_close(struct net_device *ndev)
 
 	phy_stop(fep->phy_dev);
 	phy_disconnect(fep->phy_dev);
+	fep->phy_dev = NULL;
 
 	fec_enet_free_buffers(ndev);
 
-- 
1.8.3.1
