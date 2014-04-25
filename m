From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:01 +0100
Subject: [PATCH 083/222] net:fec: remove useless fep->opened
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeS9-0007Ij-6d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

napi_disable() waits until the NAPI processing has completed, and then
prevents any further polls.  At this point, the driver then clears
fep->opened.  The NAPI poll function uses this to stop processing in
the receive path.  Hence, it will never see this variable cleared,
because the NAPI poll has to complete before it will be cleared.

Therefore, this variable serves no purpose, so let's remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      | 1 -
 drivers/net/ethernet/freescale/fec_main.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 3b8d6d19ff05..88ef53b18ae7 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -301,7 +301,6 @@ struct fec_enet_private {
 
 	struct	platform_device *pdev;
 
-	int	opened;
 	int	dev_id;
 
 	/* Phylib and MDIO interface */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 94861870e741..634046c73734 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -914,9 +914,6 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		if ((status & BD_ENET_RX_LAST) == 0)
 			netdev_err(ndev, "rcv is not +last\n");
 
-		if (!fep->opened)
-			goto rx_processing_done;
-
 		/* Check for errors. */
 		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
 			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
@@ -1837,7 +1834,6 @@ fec_enet_open(struct net_device *ndev)
 	napi_enable(&fep->napi);
 	phy_start(fep->phy_dev);
 	netif_start_queue(ndev);
-	fep->opened = 1;
 	return 0;
 }
 
@@ -1848,7 +1844,6 @@ fec_enet_close(struct net_device *ndev)
 
 	/* Don't know what to do yet. */
 	napi_disable(&fep->napi);
-	fep->opened = 0;
 	netif_tx_disable(ndev);
 	fec_stop(ndev);
 
-- 
1.8.3.1
