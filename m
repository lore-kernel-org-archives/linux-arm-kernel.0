From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:58 +0100
Subject: [PATCH 106/222] net:fec: better indexing for transmit descriptor ring
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeU2-0007KI-N9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maintaining the transmit ring position via pointers is inefficient,
especially when it involves complex pointer manipulation, and overlap
with the receive descriptor logic.

Re-implement this using indexes, and a single function which returns
the descriptor (appropriate to the descriptor type).  As an additional
benefit, using a union allows cleaner access to the descriptor.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |   6 +-
 drivers/net/ethernet/freescale/fec_main.c | 142 ++++++++++++++----------------
 2 files changed, 67 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 30c683c0b480..c5a72c4bd07d 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -291,9 +291,9 @@ struct fec_enet_private {
 	union bufdesc_u	*rx_bd_base;
 	union bufdesc_u	*tx_bd_base;
 	/* The next free ring entry */
-	union bufdesc_u	*cur_rx, *cur_tx;
-	/* The ring entries to be free()ed */
-	union bufdesc_u	*dirty_tx;
+	unsigned short tx_next;
+	unsigned short tx_dirty;
+	union bufdesc_u *cur_rx;
 
 	unsigned short tx_ring_size;
 	unsigned short rx_ring_size;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 01e43a75089d..aec802b778f7 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -227,19 +227,28 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 
 static int mii_cnt;
 
+static union bufdesc_u *
+fec_enet_tx_get(unsigned index, struct fec_enet_private *fep)
+{
+	union bufdesc_u *base = fep->tx_bd_base;
+	union bufdesc_u *bdp;
+
+	if (fep->bufdesc_ex)
+		bdp = (union bufdesc_u *)(&base->ebd + index);
+	else
+		bdp = (union bufdesc_u *)(&base->bd + index);
+
+	return bdp;
+}
+
 static inline
 union bufdesc_u *fec_enet_get_nextdesc(union bufdesc_u *bdp, struct fec_enet_private *fep)
 {
 	union bufdesc_u *base;
 	int ring_size;
 
-	if (bdp >= fep->tx_bd_base) {
-		base = fep->tx_bd_base;
-		ring_size = fep->tx_ring_size;
-	} else {
-		base = fep->rx_bd_base;
-		ring_size = fep->rx_ring_size;
-	}
+	base = fep->rx_bd_base;
+	ring_size = fep->rx_ring_size;
 
 	if (fep->bufdesc_ex) {
 		struct bufdesc_ex *ebd = &bdp->ebd + 1;
@@ -258,13 +267,8 @@ union bufdesc_u *fec_enet_get_prevdesc(union bufdesc_u *bdp, struct fec_enet_pri
 	union bufdesc_u *base;
 	int ring_size;
 
-	if (bdp >= fep->tx_bd_base) {
-		base = fep->tx_bd_base;
-		ring_size = fep->tx_ring_size;
-	} else {
-		base = fep->rx_bd_base;
-		ring_size = fep->rx_ring_size;
-	}
+	base = fep->rx_bd_base;
+	ring_size = fep->rx_ring_size;
 
 	if (fep->bufdesc_ex) {
 		struct bufdesc_ex *ebd = &bdp->ebd - 1;
@@ -291,23 +295,23 @@ static void *swap_buffer(void *bufaddr, int len)
 static void fec_dump(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	union bufdesc_u *bdp = fep->tx_bd_base;
+	union bufdesc_u *bdp;
 	unsigned index = 0;
 
 	netdev_info(ndev, "TX ring dump\n");
 	pr_info("Nr     SC     addr       len  SKB\n");
 
-	do {
+	for (index = 0; index < fep->tx_ring_size; index++) {
+		bdp = fec_enet_tx_get(index, fep);
+
 		pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p\n",
 			index,
-			bdp == fep->cur_tx ? 'S' : ' ',
-			bdp == fep->dirty_tx ? 'H' : ' ',
+			index == fep->tx_next ? 'S' : ' ',
+			index == fep->tx_dirty ? 'H' : ' ',
 			bdp->bd.cbd_sc, bdp->bd.cbd_bufaddr,
 			bdp->bd.cbd_datlen,
 			fep->tx_skbuff[index]);
-		bdp = fec_enet_get_nextdesc(bdp, fep);
-		index++;
-	} while (bdp != fep->tx_bd_base);
+	}
 }
 
 static int
@@ -345,12 +349,13 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	union bufdesc_u *bdp;
 	void *bufaddr;
 	unsigned short	status;
-	unsigned int index;
+	unsigned index;
 	unsigned length;
 	dma_addr_t addr;
 
 	/* Fill in a Tx ring entry */
-	bdp = fep->cur_tx;
+	index = fep->tx_next;
+	bdp = fec_enet_tx_get(index, fep);
 
 	status = bdp->bd.cbd_sc;
 
@@ -380,11 +385,6 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	 * 4-byte boundaries. Use bounce buffers to copy data
 	 * and get it aligned. Ugh.
 	 */
-	if (fep->bufdesc_ex)
-		index = &bdp->ebd - &fep->tx_bd_base->ebd;
-	else
-		index = &bdp->bd - &fep->tx_bd_base->bd;
-
 	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
 		memcpy(fep->tx_bounce[index], skb->data, length);
 		bufaddr = fep->tx_bounce[index];
@@ -445,14 +445,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
 	bdp->bd.cbd_sc = status;
 
-	/* If this was the last BD in the ring, start at the beginning again. */
-	bdp = fec_enet_get_nextdesc(bdp, fep);
-
 	skb_tx_timestamp(skb);
 
-	fep->cur_tx = bdp;
+	if (++index >= fep->tx_ring_size)
+		index = 0;
 
-	if (fep->cur_tx == fep->dirty_tx)
+	fep->tx_next = index;
+
+	if (fep->tx_next == fep->tx_dirty)
 		netif_stop_queue(ndev);
 
 	/* Trigger transmission start */
@@ -489,25 +489,24 @@ static void fec_enet_bd_init(struct net_device *dev)
 	fep->cur_rx = fep->rx_bd_base;
 
 	/* ...and the same for transmit */
-	bdp = fep->tx_bd_base;
-	fep->cur_tx = bdp;
 	for (i = 0; i < fep->tx_ring_size; i++) {
+		bdp = fec_enet_tx_get(i, fep);
 
 		/* Initialize the BD for every fragment in the page. */
-		bdp->bd.cbd_sc = 0;
+		if (i == fep->tx_ring_size - 1)
+			bdp->bd.cbd_sc = BD_SC_WRAP;
+		else
+			bdp->bd.cbd_sc = 0;
 		if (bdp->bd.cbd_bufaddr)
 			fec_enet_tx_unmap(bdp, fep);
 		if (fep->tx_skbuff[i]) {
 			dev_kfree_skb_any(fep->tx_skbuff[i]);
 			fep->tx_skbuff[i] = NULL;
 		}
-		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
-	/* Set the last buffer to wrap */
-	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->bd.cbd_sc |= BD_SC_WRAP;
-	fep->dirty_tx = bdp;
+	fep->tx_next = 0;
+	fep->tx_dirty = fep->tx_ring_size - 1;
 }
 
 /*
@@ -773,28 +772,25 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 static void
 fec_enet_tx(struct net_device *ndev)
 {
-	struct	fec_enet_private *fep;
+	struct fec_enet_private *fep = netdev_priv(ndev);
 	union bufdesc_u *bdp;
 	unsigned short status;
 	struct	sk_buff	*skb;
-	int	index = 0;
+	unsigned index = fep->tx_dirty;
 
-	fep = netdev_priv(ndev);
-	bdp = fep->dirty_tx;
-
-	/* get next bdp of dirty_tx */
-	bdp = fec_enet_get_nextdesc(bdp, fep);
-
-	while (((status = bdp->bd.cbd_sc) & BD_ENET_TX_READY) == 0) {
+	do {
+		if (++index >= fep->tx_ring_size)
+			index = 0;
 
 		/* current queue is empty */
-		if (bdp == fep->cur_tx)
+		if (index == fep->tx_next)
 			break;
 
-		if (fep->bufdesc_ex)
-			index = &bdp->ebd - &fep->tx_bd_base->ebd;
-		else
-			index = &bdp->bd - &fep->tx_bd_base->bd;
+		bdp = fec_enet_tx_get(index, fep);
+
+		status = bdp->bd.cbd_sc;
+		if (status & BD_ENET_TX_READY)
+			break;
 
 		fec_enet_tx_unmap(bdp, fep);
 
@@ -838,25 +834,17 @@ fec_enet_tx(struct net_device *ndev)
 		/* Free the sk buffer associated with this last transmit */
 		dev_kfree_skb_any(skb);
 
-		fep->dirty_tx = bdp;
-
-		/* Update pointer to next buffer descriptor to be transmitted */
-		bdp = fec_enet_get_nextdesc(bdp, fep);
-
 		/* Since we have freed up a buffer, the ring is no longer full
 		 */
-		if (fep->dirty_tx != fep->cur_tx) {
-			if (netif_queue_stopped(ndev))
-				netif_wake_queue(ndev);
-		}
-	}
+		if (netif_queue_stopped(ndev))
+			netif_wake_queue(ndev);
+
+		fep->tx_dirty = index;
+	} while (1);
 
 	/* ERR006538: Keep the transmitter going */
-	if (fep->dirty_tx != fep->cur_tx &&
-	    readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
+	if (index != fep->tx_next && readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
 		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
-
-	return;
 }
 
 
@@ -1737,8 +1725,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
-	bdp = fep->tx_bd_base;
 	for (i = 0; i < fep->tx_ring_size; i++) {
+		bdp = fec_enet_tx_get(i, fep);
 		if (bdp->bd.cbd_bufaddr)
 			fec_enet_tx_unmap(bdp, fep);
 		kfree(fep->tx_bounce[i]);
@@ -1788,25 +1776,23 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	bdp = fec_enet_get_prevdesc(bdp, fep);
 	bdp->bd.cbd_sc |= BD_SC_WRAP;
 
-	bdp = fep->tx_bd_base;
 	for (i = 0; i < fep->tx_ring_size; i++) {
+		bdp = fec_enet_tx_get(i, fep);
 		fep->tx_bounce[i] = kmalloc(FEC_ENET_TX_FRSIZE, GFP_KERNEL);
 		if (!fep->tx_bounce[i])
 			goto err_alloc;
 
-		bdp->bd.cbd_sc = 0;
+		/* Set the last buffer to wrap. */
+		if (i == fep->tx_ring_size - 1)
+			bdp->bd.cbd_sc = BD_SC_WRAP;
+		else
+			bdp->bd.cbd_sc = 0;
 		bdp->bd.cbd_bufaddr = 0;
 
 		if (fep->bufdesc_ex)
 			bdp->ebd.cbd_esc = BD_ENET_TX_INT;
-
-		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->bd.cbd_sc |= BD_SC_WRAP;
-
 	return 0;
 
  err_alloc:
-- 
1.8.3.1
