From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:06 +0100
Subject: [PATCH 084/222] net:fec: stop the phy before shutting down the MAC
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeSE-0007In-A2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the network interface goes down, stop the phy to prevent further
link up status changes before taking the MAC or netif sections down.
This prevents further reception of link up events which could
potentially call fec_restart().

Since phy_stop() takes the mutex which adjust_link() runs under, we
also ensure that adjust_link() will not already be processing a link
up event.

We also need to do this when suspending as well - we don't want a
mis-timed phy state change to restart the MAC after we have stopped
it for suspend, and thus need to restart the phy when resuming.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 634046c73734..765ea90b99ed 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1842,12 +1842,13 @@ fec_enet_close(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	phy_stop(fep->phy_dev);
+
 	/* Don't know what to do yet. */
 	napi_disable(&fep->napi);
 	netif_tx_disable(ndev);
 	fec_stop(ndev);
 
-	phy_stop(fep->phy_dev);
 	phy_disconnect(fep->phy_dev);
 	fep->phy_dev = NULL;
 
@@ -2333,6 +2334,7 @@ fec_suspend(struct device *dev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
+		phy_stop(fep->phy_dev);
 		fec_stop(ndev);
 		netif_device_detach(ndev);
 	}
@@ -2385,6 +2387,7 @@ fec_resume(struct device *dev)
 	if (netif_running(ndev)) {
 		fec_restart(ndev, fep->full_duplex);
 		netif_device_attach(ndev);
+		phy_start(fep->phy_dev);
 	}
 
 	return 0;
-- 
1.8.3.1
