From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:40:03 +0100
Subject: [PATCH 107/222] net:fec: better indexing for receive descriptor ring
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeU7-0007KM-Qx@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the previous commit to the receive descriptor ring as well.  This
gets rid of the two nextdesc/prevdesc functions, since we now just need
to get the descriptor for an index instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  2 +-
 drivers/net/ethernet/freescale/fec_main.c | 98 +++++++++++--------------------
 2 files changed, 35 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index c5a72c4bd07d..4b92758b51b8 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -293,7 +293,7 @@ struct fec_enet_private {
 	/* The next free ring entry */
 	unsigned short tx_next;
 	unsigned short tx_dirty;
-	union bufdesc_u *cur_rx;
+	unsigned short rx_next;
 
 	unsigned short tx_ring_size;
 	unsigned short rx_ring_size;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index aec802b778f7..dba2e315f937 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -241,44 +241,20 @@ fec_enet_tx_get(unsigned index, struct fec_enet_private *fep)
 	return bdp;
 }
 
-static inline
-union bufdesc_u *fec_enet_get_nextdesc(union bufdesc_u *bdp, struct fec_enet_private *fep)
+static union bufdesc_u *
+fec_enet_rx_get(unsigned index, struct fec_enet_private *fep)
 {
-	union bufdesc_u *base;
-	int ring_size;
-
-	base = fep->rx_bd_base;
-	ring_size = fep->rx_ring_size;
-
-	if (fep->bufdesc_ex) {
-		struct bufdesc_ex *ebd = &bdp->ebd + 1;
-		return ebd >= (&base->ebd + ring_size) ?
-			base : (union bufdesc_u *)ebd;
-	} else {
-		struct bufdesc *bd = &bdp->bd + 1;
-		return bd >= (&base->bd + ring_size) ?
-			base : (union bufdesc_u *)bd;
-	}
-}
+	union bufdesc_u *base = fep->rx_bd_base;
+	union bufdesc_u *bdp;
 
-static inline
-union bufdesc_u *fec_enet_get_prevdesc(union bufdesc_u *bdp, struct fec_enet_private *fep)
-{
-	union bufdesc_u *base;
-	int ring_size;
+	index &= fep->rx_ring_size - 1;
 
-	base = fep->rx_bd_base;
-	ring_size = fep->rx_ring_size;
+	if (fep->bufdesc_ex)
+		bdp = (union bufdesc_u *)(&base->ebd + index);
+	else
+		bdp = (union bufdesc_u *)(&base->bd + index);
 
-	if (fep->bufdesc_ex) {
-		struct bufdesc_ex *ebd = &bdp->ebd - 1;
-		return (union bufdesc_u *)(ebd < &base->ebd ?
-			ebd + ring_size : ebd);
-	} else {
-		struct bufdesc *bd = &bdp->bd - 1;
-		return (union bufdesc_u *)(bd < &base->bd ?
-			bd + ring_size : bd);
-	}
+	return bdp;
 }
 
 static void *swap_buffer(void *bufaddr, int len)
@@ -471,22 +447,20 @@ static void fec_enet_bd_init(struct net_device *dev)
 	unsigned int i;
 
 	/* Initialize the receive buffer descriptors. */
-	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
+		bdp = fec_enet_rx_get(i, fep);
 
 		/* Initialize the BD for every fragment in the page. */
 		if (bdp->bd.cbd_bufaddr)
 			bdp->bd.cbd_sc = BD_ENET_RX_EMPTY;
 		else
 			bdp->bd.cbd_sc = 0;
-		bdp = fec_enet_get_nextdesc(bdp, fep);
-	}
 
-	/* Set the last buffer to wrap */
-	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->bd.cbd_sc |= BD_SC_WRAP;
+		if (i == fep->rx_ring_size - 1)
+			bdp->bd.cbd_sc |= BD_SC_WRAP;
+	}
 
-	fep->cur_rx = fep->rx_bd_base;
+	fep->rx_next = 0;
 
 	/* ...and the same for transmit */
 	for (i = 0; i < fep->tx_ring_size; i++) {
@@ -848,7 +822,7 @@ fec_enet_tx(struct net_device *ndev)
 }
 
 
-/* During a receive, the cur_rx points to the current incoming buffer.
+/* During a receive, the rx_next points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
@@ -859,7 +833,6 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	union bufdesc_u *bdp;
 	unsigned short status;
 	struct	sk_buff	*skb;
 	ushort	pkt_len;
@@ -867,7 +840,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	int	pkt_received = 0;
 	bool	vlan_packet_rcvd = false;
 	u16	vlan_tag;
-	int	index = 0;
+	unsigned index = fep->rx_next;
 
 #ifdef CONFIG_M532x
 	flush_cache_all();
@@ -876,12 +849,16 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = fep->cur_rx;
+	do {
+		union bufdesc_u *bdp = fec_enet_rx_get(index, fep);
 
-	while (!((status = bdp->bd.cbd_sc) & BD_ENET_RX_EMPTY)) {
+		status = bdp->bd.cbd_sc;
+		if (status & BD_ENET_RX_EMPTY)
+			break;
 
 		if (pkt_received >= budget)
 			break;
+
 		pkt_received++;
 
 		/* Since we have allocated space to hold a complete frame,
@@ -923,10 +900,6 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		pkt_len = bdp->bd.cbd_datlen;
 		ndev->stats.rx_bytes += pkt_len;
 
-		if (fep->bufdesc_ex)
-			index = &bdp->ebd - &fep->rx_bd_base->ebd;
-		else
-			index = &bdp->bd - &fep->rx_bd_base->bd;
 		data = fep->rx_skbuff[index]->data;
 		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
@@ -1017,16 +990,16 @@ fec_enet_rx(struct net_device *ndev, int budget)
 		status |= BD_ENET_RX_EMPTY;
 		bdp->bd.cbd_sc = status;
 
-		/* Update BD pointer to next entry */
-		bdp = fec_enet_get_nextdesc(bdp, fep);
-
 		/* Doing this here will keep the FEC running while we process
 		 * incoming frames.  On a heavily loaded network, we should be
 		 * able to keep up at the expense of system resources.
 		 */
 		writel(0, fep->hwp + FEC_R_DES_ACTIVE);
-	}
-	fep->cur_rx = bdp;
+
+		if (++index >= fep->rx_ring_size)
+			index = 0;
+	} while (1);
+	fep->rx_next = index;
 
 	return pkt_received;
 }
@@ -1713,8 +1686,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	struct sk_buff *skb;
 	union bufdesc_u *bdp;
 
-	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
+		bdp = fec_enet_rx_get(i, fep);
+
 		skb = fep->rx_skbuff[i];
 		fep->rx_skbuff[i] = NULL;
 		if (skb) {
@@ -1722,7 +1696,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 			dev_kfree_skb(skb);
 		}
-		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
 	for (i = 0; i < fep->tx_ring_size; i++) {
@@ -1745,7 +1718,6 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	struct sk_buff *skb;
 	union bufdesc_u *bdp;
 
-	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
 		dma_addr_t addr;
 
@@ -1763,19 +1735,17 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 		}
 
 		fep->rx_skbuff[i] = skb;
+		bdp = fec_enet_rx_get(i, fep);
 		bdp->bd.cbd_bufaddr = addr;
 		bdp->bd.cbd_sc = BD_ENET_RX_EMPTY;
+		/* Set the last buffer to wrap. */
+		if (i == fep->rx_ring_size - 1)
+			bdp->bd.cbd_sc |= BD_SC_WRAP;
 
 		if (fep->bufdesc_ex)
 			bdp->ebd.cbd_esc = BD_ENET_RX_INT;
-
-		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->bd.cbd_sc |= BD_SC_WRAP;
-
 	for (i = 0; i < fep->tx_ring_size; i++) {
 		bdp = fec_enet_tx_get(i, fep);
 		fep->tx_bounce[i] = kmalloc(FEC_ENET_TX_FRSIZE, GFP_KERNEL);
-- 
1.8.3.1
