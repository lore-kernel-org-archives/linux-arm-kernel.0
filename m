From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 08 Jul 2014 00:22:49 +0100
Subject: [PATCH A 04/12] net: fec: use netif_tx_disable() rather than
 netif_stop_queue()
In-Reply-To: <20140707232148.GG21766@n2100.arm.linux.org.uk>
References: <20140707232148.GG21766@n2100.arm.linux.org.uk>
Message-ID: <E1X4IFF-0004wt-A0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use netif_stop_queue() in several places where we want to ensure that
the start_xmit function is not running.  netif_stop_queue() is not
sufficient to achieve that - it merely sets a flag to indicate that the
transmit queue(s) should not be run.

netif_tx_disable() gives this guarantee, since it takes the transmit
queue lock while marking the queue stopped.  This will wait for the
transmit function to complete before returning.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 4e695b742030..cb9ced738607 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -834,7 +834,7 @@ fec_restart(struct net_device *ndev, int duplex)
 	if (netif_running(ndev)) {
 		netif_device_detach(ndev);
 		napi_disable(&fep->napi);
-		netif_stop_queue(ndev);
+		netif_tx_disable(ndev);
 		netif_tx_lock_bh(ndev);
 	}
 
@@ -2181,7 +2181,7 @@ fec_enet_close(struct net_device *ndev)
 	/* Don't know what to do yet. */
 	napi_disable(&fep->napi);
 	fep->opened = 0;
-	netif_stop_queue(ndev);
+	netif_tx_disable(ndev);
 	fec_stop(ndev);
 
 	if (fep->phy_dev) {
-- 
1.8.3.1
