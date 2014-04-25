From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:45 +0100
Subject: [PATCH 080/222] net:fec: ensure fec_enet_free_buffers() properly
 cleans the rings
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRt-0007IX-SJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we do not double-free any allocations, and that any transmit
skbuffs are properly freed when we clean up the rings.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f98ddb0923a3..08a5004970c9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1712,6 +1712,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
 		skb = fep->rx_skbuff[i];
+		fep->rx_skbuff[i] = NULL;
 		if (skb) {
 			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
@@ -1721,8 +1722,14 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	}
 
 	bdp = fep->tx_bd_base;
-	for (i = 0; i < fep->tx_ring_size; i++)
+	for (i = 0; i < fep->tx_ring_size; i++) {
 		kfree(fep->tx_bounce[i]);
+		fep->tx_bounce[i] = NULL;
+		skb = fep->tx_skbuff[i];
+		fep->tx_skbuff[i] = NULL;
+		if (skb)
+			dev_kfree_skb(skb);
+	}
 }
 
 static int fec_enet_alloc_buffers(struct net_device *ndev)
-- 
1.8.3.1
