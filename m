From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:40:08 +0100
Subject: [PATCH 108/222] net:fec: calculate ring space rather than relying on
 comparing indices
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeUC-0007KQ-UF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calculate the space in the transmit ring rather than comparing indices.
This allows us to positively calculate the number of entries remaining,
which will be required when we handle fragmented skbs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index dba2e315f937..47d4aa2842a4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -316,6 +316,12 @@ fec_enet_tx_unmap(union bufdesc_u *bdp, struct fec_enet_private *fep)
 	dma_unmap_single(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
 }
 
+static unsigned ring_free(unsigned ins, unsigned rem, unsigned size)
+{
+	int num = rem - ins;
+	return num < 0 ? num + size : num;
+}
+
 static netdev_tx_t
 fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -331,11 +337,8 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* Fill in a Tx ring entry */
 	index = fep->tx_next;
-	bdp = fec_enet_tx_get(index, fep);
-
-	status = bdp->bd.cbd_sc;
 
-	if (status & BD_ENET_TX_READY) {
+	if (ring_free(index, fep->tx_dirty, fep->tx_ring_size) < 1) {
 		/* Ooops.  All transmit buffers are full.  Bail out.
 		 * This should not happen, since ndev->tbusy should be set.
 		 */
@@ -349,9 +352,6 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 	}
 
-	/* Clear all of the status flags */
-	status &= ~BD_ENET_TX_STATS;
-
 	/* Set buffer length and buffer pointer */
 	bufaddr = skb->data;
 	length = skb->len;
@@ -386,6 +386,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* Save skb pointer */
 	fep->tx_skbuff[index] = skb;
 
+	bdp = fec_enet_tx_get(index, fep);
 	bdp->bd.cbd_datlen = length;
 	bdp->bd.cbd_bufaddr = addr;
 
@@ -417,9 +418,9 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
 	 * it's the last BD of the frame, and to put the CRC on the end.
 	 */
-	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
-			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
-	bdp->bd.cbd_sc = status;
+	status = bdp->bd.cbd_sc & ~BD_ENET_TX_STATS;
+	bdp->bd.cbd_sc = status | BD_ENET_TX_READY | BD_ENET_TX_INTR |
+			 BD_ENET_TX_LAST | BD_ENET_TX_TC;
 
 	skb_tx_timestamp(skb);
 
@@ -428,7 +429,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	fep->tx_next = index;
 
-	if (fep->tx_next == fep->tx_dirty)
+	if (ring_free(index, fep->tx_dirty, fep->tx_ring_size) < 1)
 		netif_stop_queue(ndev);
 
 	/* Trigger transmission start */
@@ -808,17 +809,16 @@ fec_enet_tx(struct net_device *ndev)
 		/* Free the sk buffer associated with this last transmit */
 		dev_kfree_skb_any(skb);
 
-		/* Since we have freed up a buffer, the ring is no longer full
-		 */
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
-
 		fep->tx_dirty = index;
 	} while (1);
 
 	/* ERR006538: Keep the transmitter going */
 	if (index != fep->tx_next && readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
 		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
+
+	if (netif_queue_stopped(ndev) &&
+	    ring_free(fep->tx_next, fep->tx_dirty, fep->tx_ring_size))
+		netif_wake_queue(ndev);
 }
 
 
-- 
1.8.3.1
