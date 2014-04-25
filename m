From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:25 +0100
Subject: [PATCH 076/222] net:fec: use netif_tx_disable() rather than
 netif_stop_queue()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRZ-0007IF-ES@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use netif_stop_queue() in several places where we want to ensure that
the start_xmit function is not running.  netif_stop_queue() is not
sufficient to achieve that - it merely sets a flag to indicate that the
transmit queue(s) should not be run.

netif_tx_disable() gives this guarantee, since it takes the transmit
queue lock while marking the queue stopped.  This will wait for the
transmit function to complete before returning.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7d506ae2dbba..1c84f3a6f3a7 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -522,7 +522,7 @@ fec_restart(struct net_device *ndev, int duplex)
 	if (netif_running(ndev)) {
 		netif_device_detach(ndev);
 		napi_disable(&fep->napi);
-		netif_stop_queue(ndev);
+		netif_tx_disable(ndev);
 		netif_tx_lock_bh(ndev);
 	}
 
@@ -1821,7 +1821,7 @@ fec_enet_close(struct net_device *ndev)
 	/* Don't know what to do yet. */
 	napi_disable(&fep->napi);
 	fep->opened = 0;
-	netif_stop_queue(ndev);
+	netif_tx_disable(ndev);
 	fec_stop(ndev);
 
 	phy_stop(fep->phy_dev);
-- 
1.8.3.1
