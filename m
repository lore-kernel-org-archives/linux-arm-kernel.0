From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:40:24 +0100
Subject: [PATCH 111/222] net:fec: add scatter-gather support
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeUS-0007Kc-88@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scatter-gather support for SKB transmission.  This allows the
driver to make use of GSO, which when enabled allows the iMX6Q to
increase TCP transmission throughput from about 320 to 420Mbps,
measured with iperf 2.0.5

We adjust the minimum transmit ring space according to whether SG
support is enabled or not.  This allows non-SG configurations to avoid
the tx ring reservation necessary for SG, thereby making full use of
their available ring (since non-SG requires just one tx ring entry per
packet.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |   2 +
 drivers/net/ethernet/freescale/fec_main.c | 204 ++++++++++++++++++++++++------
 2 files changed, 164 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 1650c8440f5f..aca92660d2be 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -280,6 +280,7 @@ struct fec_enet_private {
 	struct clk *clk_enet_out;
 	struct clk *clk_ptp;
 
+	unsigned char tx_page_map[TX_RING_SIZE];
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	unsigned char *tx_bounce[TX_RING_SIZE];
 	struct	sk_buff *tx_skbuff[TX_RING_SIZE];
@@ -293,6 +294,7 @@ struct fec_enet_private {
 	/* The next free ring entry */
 	unsigned short tx_next;
 	unsigned short tx_dirty;
+	unsigned short tx_min;
 	unsigned short rx_next;
 
 	unsigned short tx_ring_size;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 47d4aa2842a4..45733f9c3c85 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -170,6 +170,9 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #error "FEC: descriptor ring size constants too large"
 #endif
 
+/* Minimum TX ring size when using NETIF_F_SG */
+#define TX_RING_SIZE_MIN_SG (2 * (MAX_SKB_FRAGS + 1))
+
 /* Interrupt events/masks. */
 #define FEC_ENET_HBERR	((uint)0x80000000)	/* Heartbeat error */
 #define FEC_ENET_BABR	((uint)0x40000000)	/* Babbling receiver */
@@ -293,10 +296,19 @@ static void fec_dump(struct net_device *ndev)
 static int
 fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 {
+	int csum_start;
+
 	/* Only run for packets requiring a checksum. */
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		return 0;
 
+	csum_start = skb_checksum_start_offset(skb);
+	if (csum_start + skb->csum_offset > skb_headlen(skb)) {
+		netdev_err(ndev, "checksum outside skb head: headlen %u start %u offset %u\n",
+			   skb_headlen(skb), csum_start, skb->csum_offset);
+		return -1;
+	}
+
 	if (unlikely(skb_cow_head(skb, 0)))
 		return -1;
 
@@ -306,14 +318,32 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 }
 
 static void
-fec_enet_tx_unmap(union bufdesc_u *bdp, struct fec_enet_private *fep)
+fec_enet_tx_unmap(unsigned index, union bufdesc_u *bdp, struct fec_enet_private *fep)
 {
 	dma_addr_t addr = bdp->bd.cbd_bufaddr;
 	unsigned length = bdp->bd.cbd_datlen;
 
 	bdp->bd.cbd_bufaddr = 0;
 
-	dma_unmap_single(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
+	if (fep->tx_page_map[index])
+		dma_unmap_page(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
+	else
+		dma_unmap_single(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
+}
+
+static void
+fec_enet_tx_unmap_range(unsigned index, unsigned last, struct fec_enet_private *fep)
+{
+	union bufdesc_u *bdp;
+
+	do {
+		if (last == 0)
+			last = fep->tx_ring_size;
+		last--;
+
+		bdp = fec_enet_tx_get(last, fep);
+		fec_enet_tx_unmap(last, bdp, fep);
+	} while (index != last);
 }
 
 static unsigned ring_free(unsigned ins, unsigned rem, unsigned size)
@@ -331,14 +361,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	union bufdesc_u *bdp;
 	void *bufaddr;
 	unsigned short	status;
-	unsigned index;
-	unsigned length;
+	unsigned index, last, length, cbd_esc;
+	int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	dma_addr_t addr;
 
 	/* Fill in a Tx ring entry */
 	index = fep->tx_next;
 
-	if (ring_free(index, fep->tx_dirty, fep->tx_ring_size) < 1) {
+	if (ring_free(index, fep->tx_dirty, fep->tx_ring_size) < 1 + nr_frags) {
 		/* Ooops.  All transmit buffers are full.  Bail out.
 		 * This should not happen, since ndev->tbusy should be set.
 		 */
@@ -354,7 +384,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* Set buffer length and buffer pointer */
 	bufaddr = skb->data;
-	length = skb->len;
+	length = skb_headlen(skb);
 
 	/*
 	 * On some FEC implementations data must be aligned on
@@ -376,38 +406,72 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* Push the data cache so the CPM does not get stale memory data. */
 	addr = dma_map_single(&fep->pdev->dev, bufaddr, length, DMA_TO_DEVICE);
-	if (dma_mapping_error(&fep->pdev->dev, addr)) {
-		dev_kfree_skb_any(skb);
-		if (net_ratelimit())
-			netdev_err(ndev, "Tx DMA memory map failed\n");
-		return NETDEV_TX_OK;
-	}
-
-	/* Save skb pointer */
-	fep->tx_skbuff[index] = skb;
+	if (dma_mapping_error(&fep->pdev->dev, addr))
+		goto release;
 
 	bdp = fec_enet_tx_get(index, fep);
 	bdp->bd.cbd_datlen = length;
 	bdp->bd.cbd_bufaddr = addr;
 
+	fep->tx_page_map[index] = 0;
+
+	cbd_esc = BD_ENET_TX_INT;
 	if (fep->bufdesc_ex) {
-		bdp->ebd.cbd_bdu = 0;
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
 			fep->hwts_tx_en)) {
-			bdp->ebd.cbd_esc = (BD_ENET_TX_TS | BD_ENET_TX_INT);
+			cbd_esc |= BD_ENET_TX_TS;
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		} else {
-			bdp->ebd.cbd_esc = BD_ENET_TX_INT;
-
 			/* Enable protocol checksum flags
 			 * We do not bother with the IP Checksum bits as they
 			 * are done by the kernel
 			 */
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
-				bdp->ebd.cbd_esc |= BD_ENET_TX_PINS;
+				cbd_esc |= BD_ENET_TX_PINS;
+		}
+		bdp->ebd.cbd_bdu = 0;
+		bdp->ebd.cbd_esc = cbd_esc;
+	}
+
+	for (last = index, f = 0; f < nr_frags; f++) {
+		const struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[f];
+
+		if (++last >= fep->tx_ring_size)
+			last = 0;
+
+		length = skb_frag_size(frag);
+
+		/* If the alignment is unsuitable, we need to bounce. */
+		if (frag->page_offset & FEC_ALIGNMENT) {
+			unsigned char *bounce = fep->tx_bounce[last];
+
+			/* FIXME: highdma? */
+			memcpy(bounce, skb_frag_address(frag), length);
+
+			addr = dma_map_single(&fep->pdev->dev, bounce,
+					      length, DMA_TO_DEVICE);
+			fep->tx_page_map[last] = 0;
+		} else {
+			addr = skb_frag_dma_map(&fep->pdev->dev, frag, 0,
+						length, DMA_TO_DEVICE);
+			fep->tx_page_map[last] = 1;
+		}
+
+		if (dma_mapping_error(&fep->pdev->dev, addr))
+			goto release_frags;
+
+		bdp = fec_enet_tx_get(last, fep);
+		bdp->bd.cbd_datlen = length;
+		bdp->bd.cbd_bufaddr = addr;
+		if (fep->bufdesc_ex) {
+			bdp->ebd.cbd_esc = cbd_esc;
+			bdp->ebd.cbd_bdu = 0;
 		}
 	}
 
+	/* Save skb pointer */
+	fep->tx_skbuff[last] = skb;
+
 	/*
 	 * We need the preceding stores to the descriptor to complete
 	 * before updating the status field, which hands it over to the
@@ -418,18 +482,30 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
 	 * it's the last BD of the frame, and to put the CRC on the end.
 	 */
-	status = bdp->bd.cbd_sc & ~BD_ENET_TX_STATS;
+	status = bdp->bd.cbd_sc & BD_ENET_TX_WRAP;
 	bdp->bd.cbd_sc = status | BD_ENET_TX_READY | BD_ENET_TX_INTR |
 			 BD_ENET_TX_LAST | BD_ENET_TX_TC;
 
+	/* Now walk backwards setting the TX_READY on each fragment */
+	for (f = nr_frags - 1; f >= 0; f--) {
+		unsigned i = index + f;
+
+		if (i >= fep->tx_ring_size)
+			i -= fep->tx_ring_size;
+
+		bdp = fec_enet_tx_get(i, fep);
+		status = bdp->bd.cbd_sc & BD_ENET_TX_WRAP;
+		bdp->bd.cbd_sc = status | BD_ENET_TX_READY | BD_ENET_TX_INTR;
+	}
+
 	skb_tx_timestamp(skb);
 
-	if (++index >= fep->tx_ring_size)
-		index = 0;
+	if (++last >= fep->tx_ring_size)
+		last = 0;
 
-	fep->tx_next = index;
+	fep->tx_next = last;
 
-	if (ring_free(index, fep->tx_dirty, fep->tx_ring_size) < 1)
+	if (ring_free(last, fep->tx_dirty, fep->tx_ring_size) < fep->tx_min)
 		netif_stop_queue(ndev);
 
 	/* Trigger transmission start */
@@ -437,6 +513,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
 
 	return NETDEV_TX_OK;
+
+ release_frags:
+	fec_enet_tx_unmap_range(index, last, fep);
+ release:
+	dev_kfree_skb_any(skb);
+	if (net_ratelimit())
+		netdev_err(ndev, "Tx DMA memory map failed\n");
+	return NETDEV_TX_OK;
 }
 
 /* Init RX & TX buffer descriptors
@@ -473,7 +557,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 		else
 			bdp->bd.cbd_sc = 0;
 		if (bdp->bd.cbd_bufaddr)
-			fec_enet_tx_unmap(bdp, fep);
+			fec_enet_tx_unmap(i, bdp, fep);
 		if (fep->tx_skbuff[i]) {
 			dev_kfree_skb_any(fep->tx_skbuff[i]);
 			fep->tx_skbuff[i] = NULL;
@@ -767,7 +851,7 @@ fec_enet_tx(struct net_device *ndev)
 		if (status & BD_ENET_TX_READY)
 			break;
 
-		fec_enet_tx_unmap(bdp, fep);
+		fec_enet_tx_unmap(index, bdp, fep);
 
 		skb = fep->tx_skbuff[index];
 		fep->tx_skbuff[index] = NULL;
@@ -787,17 +871,9 @@ fec_enet_tx(struct net_device *ndev)
 				ndev->stats.tx_fifo_errors++;
 			if (status & BD_ENET_TX_CSL) /* Carrier lost */
 				ndev->stats.tx_carrier_errors++;
-		} else {
+		} else if (skb) {
 			ndev->stats.tx_packets++;
-			ndev->stats.tx_bytes += bdp->bd.cbd_datlen;
-		}
-
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
-			fep->bufdesc_ex) {
-			struct skb_shared_hwtstamps shhwtstamps;
-
-			fec_enet_hwtstamp(fep, bdp->ebd.ts, &shhwtstamps);
-			skb_tstamp_tx(skb, &shhwtstamps);
+			ndev->stats.tx_bytes += skb->len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -806,8 +882,18 @@ fec_enet_tx(struct net_device *ndev)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		/* Free the sk buffer associated with this last transmit */
-		dev_kfree_skb_any(skb);
+		if (skb) {
+			if (fep->bufdesc_ex &&
+			    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, bdp->ebd.ts, &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			dev_kfree_skb_any(skb);
+		}
 
 		fep->tx_dirty = index;
 	} while (1);
@@ -817,7 +903,8 @@ fec_enet_tx(struct net_device *ndev)
 		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
 
 	if (netif_queue_stopped(ndev) &&
-	    ring_free(fep->tx_next, fep->tx_dirty, fep->tx_ring_size))
+	    ring_free(fep->tx_next, fep->tx_dirty, fep->tx_ring_size) >=
+	      fep->tx_min)
 		netif_wake_queue(ndev);
 }
 
@@ -1701,7 +1788,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	for (i = 0; i < fep->tx_ring_size; i++) {
 		bdp = fec_enet_tx_get(i, fep);
 		if (bdp->bd.cbd_bufaddr)
-			fec_enet_tx_unmap(bdp, fep);
+			fec_enet_tx_unmap(i, bdp, fep);
 		kfree(fep->tx_bounce[i]);
 		fep->tx_bounce[i] = NULL;
 		skb = fep->tx_skbuff[i];
@@ -1938,7 +2025,22 @@ static void fec_poll_controller(struct net_device *dev)
 }
 #endif
 
-#define FEATURES_NEED_QUIESCE NETIF_F_RXCSUM
+static netdev_features_t fec_fix_features(struct net_device *ndev,
+	netdev_features_t features)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	/*
+	 * NETIF_F_SG requires a minimum transmit ring size.  If we
+	 * have less than this size, we can't support this feature.
+	 */
+	if (fep->tx_ring_size < TX_RING_SIZE_MIN_SG)
+		features &= ~NETIF_F_SG;
+
+	return features;
+}
+
+#define FEATURES_NEED_QUIESCE (NETIF_F_RXCSUM | NETIF_F_SG)
 
 static int fec_set_features(struct net_device *netdev,
 	netdev_features_t features)
@@ -1963,6 +2065,12 @@ static int fec_set_features(struct net_device *netdev,
 			fep->csum_flags &= ~FLAG_RX_CSUM_ENABLED;
 	}
 
+	/* Set the appropriate minimum transmit ring free threshold */
+	if (features & NETIF_F_SG)
+		fep->tx_min = MAX_SKB_FRAGS + 1;
+	else
+		fep->tx_min = 1;
+
 	/* Resume the device after updates */
 	if (netif_running(netdev) && changed & FEATURES_NEED_QUIESCE) {
 		fec_restart(netdev);
@@ -1987,6 +2095,7 @@ static const struct net_device_ops fec_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= fec_poll_controller,
 #endif
+	.ndo_fix_features	= fec_fix_features,
 	.ndo_set_features	= fec_set_features,
 };
 
@@ -2052,6 +2161,17 @@ static int fec_enet_init(struct net_device *ndev)
 		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
 	}
 
+	if (!(id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)) {
+		/* don't enable SG if we need to swap frames */
+		ndev->features |= NETIF_F_SG;
+		ndev->hw_features |= NETIF_F_SG;
+	}
+
+	if (ndev->features & NETIF_F_SG)
+		fep->tx_min = MAX_SKB_FRAGS + 1;
+	else
+		fep->tx_min = 1;
+
 	fec_restart(ndev);
 
 	return 0;
-- 
1.8.3.1
