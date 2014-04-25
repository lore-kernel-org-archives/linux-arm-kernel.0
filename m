From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:36 +0100
Subject: [PATCH 090/222] net:fec: quiesce packet processing before stopping
 device in fec_suspend()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeSi-0007JD-V1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fec_suspend() calls fec_stop() to stop the transmit ring while the
transmit packet processing is still active.  This can lead to the
transmit queue being restarted by an intervening packet queued for
transmission, or by the tx quirk timer expiring. Fix this by moving the
call to fec_enet_netif_quiesce() before fec_stop().  We must remove the
corresponding call to fec_enet_netif_quiesce() from the resume path.

We also need to avoid calling fec_enet_netif_quiesce() inside
fec_enet_close() to cover the failed resume scenario otherwise
fec_enet_close() will hang in napi_disable().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 02e121a19d87..927c283e43b1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1860,10 +1860,11 @@ fec_enet_close(struct net_device *ndev)
 
 	phy_stop(fep->phy_dev);
 
-	napi_disable(&fep->napi);
-	netif_tx_disable(ndev);
-	if (netif_device_present(ndev))
+	if (netif_device_present(ndev)) {
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
 		fec_stop(ndev);
+	}
 
 	phy_disconnect(fep->phy_dev);
 	fep->phy_dev = NULL;
@@ -2354,8 +2355,11 @@ fec_suspend(struct device *dev)
 	rtnl_lock();
 	if (netif_running(ndev)) {
 		phy_stop(fep->phy_dev);
-		fec_stop(ndev);
+		napi_disable(&fep->napi);
+		netif_tx_lock_bh(ndev);
 		netif_device_detach(ndev);
+		netif_tx_unlock_bh(ndev);
+		fec_stop(ndev);
 	}
 	rtnl_unlock();
 
@@ -2407,12 +2411,10 @@ fec_resume(struct device *dev)
 
 	rtnl_lock();
 	if (netif_running(ndev)) {
-		napi_disable(&fep->napi);
-		netif_tx_lock_bh(ndev);
 		fec_restart(ndev, fep->full_duplex);
+		netif_tx_lock_bh(ndev);
 		netif_device_attach(ndev);
 		netif_tx_unlock_bh(ndev);
-		netif_device_attach(ndev);
 		napi_enable(&fep->napi);
 		phy_start(fep->phy_dev);
 	}
-- 
1.8.3.1
