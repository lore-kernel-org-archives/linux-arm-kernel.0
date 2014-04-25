From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:12 +0100
Subject: [PATCH 097/222] net:fec: add barrier to receive path to ensure proper
 ordering
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTI-0007Jg-Np@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just as we need a barrier in the transmit path, we also need a barrier
in the receive path to ensure that we don't modify a handed over
descriptor.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2d9a6493b33b..9d2023b3e5ce 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1036,13 +1036,6 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		dma_sync_single_for_device(&fep->pdev->dev, bdp->cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 rx_processing_done:
-		/* Clear the status flags for this buffer */
-		status &= ~BD_ENET_RX_STATS;
-
-		/* Mark the buffer empty */
-		status |= BD_ENET_RX_EMPTY;
-		bdp->cbd_sc = status;
-
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
 
@@ -1051,6 +1044,19 @@ fec_enet_rx(struct net_device *ndev, int budget)
 			ebdp->cbd_bdu = 0;
 		}
 
+		/*
+		 * Ensure that the previous writes have completed before
+		 * the status update becomes visible.
+		 */
+		wmb();
+
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+		bdp->cbd_sc = status;
+
 		/* Update BD pointer to next entry */
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 
-- 
1.8.3.1
