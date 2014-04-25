From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:48 +0100
Subject: [PATCH 104/222] net:fec: use a union for the buffer descriptors
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTs-0007K9-G7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a union gives clearer C code than the existing solution, and
allows the removal of some odd code from the receive path whose
purpose was to merely store the enhanced buffer descriptor.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  13 +-
 drivers/net/ethernet/freescale/fec_main.c | 194 ++++++++++++++----------------
 2 files changed, 96 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index aecc46c33a82..30c683c0b480 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -170,6 +170,11 @@ struct bufdesc_ex {
 	unsigned short res0[4];
 };
 
+union bufdesc_u {
+	struct bufdesc bd;
+	struct bufdesc_ex ebd;
+};
+
 /*
  *	The following definitions courtesy of commproc.h, which where
  *	Copyright (c) 1997 Dan Malek (dmalek at jlc.net).
@@ -283,12 +288,12 @@ struct fec_enet_private {
 	/* CPM dual port RAM relative addresses */
 	dma_addr_t	bd_dma;
 	/* Address of Rx and Tx buffers */
-	struct bufdesc	*rx_bd_base;
-	struct bufdesc	*tx_bd_base;
+	union bufdesc_u	*rx_bd_base;
+	union bufdesc_u	*tx_bd_base;
 	/* The next free ring entry */
-	struct bufdesc	*cur_rx, *cur_tx;
+	union bufdesc_u	*cur_rx, *cur_tx;
 	/* The ring entries to be free()ed */
-	struct bufdesc	*dirty_tx;
+	union bufdesc_u	*dirty_tx;
 
 	unsigned short tx_ring_size;
 	unsigned short rx_ring_size;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c7fe6eb8be12..b9d0f0c8cae1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -228,56 +228,53 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 static int mii_cnt;
 
 static inline
-struct bufdesc *fec_enet_get_nextdesc(struct bufdesc *bdp, struct fec_enet_private *fep)
+union bufdesc_u *fec_enet_get_nextdesc(union bufdesc_u *bdp, struct fec_enet_private *fep)
 {
-	struct bufdesc *new_bd = bdp + 1;
-	struct bufdesc_ex *ex_new_bd = (struct bufdesc_ex *)bdp + 1;
-	struct bufdesc_ex *ex_base;
-	struct bufdesc *base;
+	union bufdesc_u *base;
 	int ring_size;
 
 	if (bdp >= fep->tx_bd_base) {
 		base = fep->tx_bd_base;
 		ring_size = fep->tx_ring_size;
-		ex_base = (struct bufdesc_ex *)fep->tx_bd_base;
 	} else {
 		base = fep->rx_bd_base;
 		ring_size = fep->rx_ring_size;
-		ex_base = (struct bufdesc_ex *)fep->rx_bd_base;
 	}
 
-	if (fep->bufdesc_ex)
-		return (struct bufdesc *)((ex_new_bd >= (ex_base + ring_size)) ?
-			ex_base : ex_new_bd);
-	else
-		return (new_bd >= (base + ring_size)) ?
-			base : new_bd;
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebd = &bdp->ebd + 1;
+		return ebd >= (&base->ebd + ring_size) ?
+			base : (union bufdesc_u *)ebd;
+	} else {
+		struct bufdesc *bd = &bdp->bd + 1;
+		return bd >= (&base->bd + ring_size) ?
+			base : (union bufdesc_u *)bd;
+	}
 }
 
 static inline
-struct bufdesc *fec_enet_get_prevdesc(struct bufdesc *bdp, struct fec_enet_private *fep)
+union bufdesc_u *fec_enet_get_prevdesc(union bufdesc_u *bdp, struct fec_enet_private *fep)
 {
-	struct bufdesc *new_bd = bdp - 1;
-	struct bufdesc_ex *ex_new_bd = (struct bufdesc_ex *)bdp - 1;
-	struct bufdesc_ex *ex_base;
-	struct bufdesc *base;
+	union bufdesc_u *base;
 	int ring_size;
 
 	if (bdp >= fep->tx_bd_base) {
 		base = fep->tx_bd_base;
 		ring_size = fep->tx_ring_size;
-		ex_base = (struct bufdesc_ex *)fep->tx_bd_base;
 	} else {
 		base = fep->rx_bd_base;
 		ring_size = fep->rx_ring_size;
-		ex_base = (struct bufdesc_ex *)fep->rx_bd_base;
 	}
 
-	if (fep->bufdesc_ex)
-		return (struct bufdesc *)((ex_new_bd < ex_base) ?
-			(ex_new_bd + ring_size) : ex_new_bd);
-	else
-		return (new_bd < base) ? (new_bd + ring_size) : new_bd;
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebd = &bdp->ebd - 1;
+		return (union bufdesc_u *)(ebd < &base->ebd ?
+			ebd + ring_size : ebd);
+	} else {
+		struct bufdesc *bd = &bdp->bd - 1;
+		return (union bufdesc_u *)(bd < &base->bd ?
+			bd + ring_size : bd);
+	}
 }
 
 static void *swap_buffer(void *bufaddr, int len)
@@ -294,7 +291,7 @@ static void *swap_buffer(void *bufaddr, int len)
 static void fec_dump(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct bufdesc *bdp = fep->tx_bd_base;
+	union bufdesc_u *bdp = fep->tx_bd_base;
 	unsigned index = 0;
 
 	netdev_info(ndev, "TX ring dump\n");
@@ -305,7 +302,8 @@ static void fec_dump(struct net_device *ndev)
 			index,
 			bdp == fep->cur_tx ? 'S' : ' ',
 			bdp == fep->dirty_tx ? 'H' : ' ',
-			bdp->cbd_sc, bdp->cbd_bufaddr, bdp->cbd_datlen,
+			bdp->bd.cbd_sc, bdp->bd.cbd_bufaddr,
+			bdp->bd.cbd_datlen,
 			fep->tx_skbuff[index]);
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 		index++;
@@ -328,12 +326,12 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 }
 
 static void
-fec_enet_tx_unmap(struct bufdesc *bdp, struct fec_enet_private *fep)
+fec_enet_tx_unmap(union bufdesc_u *bdp, struct fec_enet_private *fep)
 {
-	dma_addr_t addr = bdp->cbd_bufaddr;
-	unsigned length = bdp->cbd_datlen;
+	dma_addr_t addr = bdp->bd.cbd_bufaddr;
+	unsigned length = bdp->bd.cbd_datlen;
 
-	bdp->cbd_bufaddr = 0;
+	bdp->bd.cbd_bufaddr = 0;
 
 	dma_unmap_single(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
 }
@@ -344,7 +342,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	struct bufdesc *bdp;
+	union bufdesc_u *bdp;
 	void *bufaddr;
 	unsigned short	status;
 	unsigned int index;
@@ -354,7 +352,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* Fill in a Tx ring entry */
 	bdp = fep->cur_tx;
 
-	status = bdp->cbd_sc;
+	status = bdp->bd.cbd_sc;
 
 	if (status & BD_ENET_TX_READY) {
 		/* Ooops.  All transmit buffers are full.  Bail out.
@@ -383,10 +381,9 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	 * and get it aligned. Ugh.
 	 */
 	if (fep->bufdesc_ex)
-		index = (struct bufdesc_ex *)bdp -
-			(struct bufdesc_ex *)fep->tx_bd_base;
+		index = &bdp->ebd - &fep->tx_bd_base->ebd;
 	else
-		index = bdp - fep->tx_bd_base;
+		index = &bdp->bd - &fep->tx_bd_base->bd;
 
 	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
 		memcpy(fep->tx_bounce[index], skb->data, length);
@@ -413,26 +410,24 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* Save skb pointer */
 	fep->tx_skbuff[index] = skb;
 
-	bdp->cbd_datlen = length;
-	bdp->cbd_bufaddr = addr;
+	bdp->bd.cbd_datlen = length;
+	bdp->bd.cbd_bufaddr = addr;
 
 	if (fep->bufdesc_ex) {
-
-		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-		ebdp->cbd_bdu = 0;
+		bdp->ebd.cbd_bdu = 0;
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
 			fep->hwts_tx_en)) {
-			ebdp->cbd_esc = (BD_ENET_TX_TS | BD_ENET_TX_INT);
+			bdp->ebd.cbd_esc = (BD_ENET_TX_TS | BD_ENET_TX_INT);
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		} else {
-			ebdp->cbd_esc = BD_ENET_TX_INT;
+			bdp->ebd.cbd_esc = BD_ENET_TX_INT;
 
 			/* Enable protocol checksum flags
 			 * We do not bother with the IP Checksum bits as they
 			 * are done by the kernel
 			 */
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
-				ebdp->cbd_esc |= BD_ENET_TX_PINS;
+				bdp->ebd.cbd_esc |= BD_ENET_TX_PINS;
 		}
 	}
 
@@ -448,8 +443,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	 */
 	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
 			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
-	bdp->cbd_sc = status;
-
+	bdp->bd.cbd_sc = status;
 
 	/* If this was the last BD in the ring, start at the beginning again. */
 	bdp = fec_enet_get_nextdesc(bdp, fep);
@@ -473,7 +467,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 static void fec_enet_bd_init(struct net_device *dev)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
-	struct bufdesc *bdp;
+	union bufdesc_u *bdp;
 	unsigned int i;
 
 	/* Initialize the receive buffer descriptors. */
@@ -481,16 +475,16 @@ static void fec_enet_bd_init(struct net_device *dev)
 	for (i = 0; i < fep->rx_ring_size; i++) {
 
 		/* Initialize the BD for every fragment in the page. */
-		if (bdp->cbd_bufaddr)
-			bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		if (bdp->bd.cbd_bufaddr)
+			bdp->bd.cbd_sc = BD_ENET_RX_EMPTY;
 		else
-			bdp->cbd_sc = 0;
+			bdp->bd.cbd_sc = 0;
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
 	/* Set the last buffer to wrap */
 	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->cbd_sc |= BD_SC_WRAP;
+	bdp->bd.cbd_sc |= BD_SC_WRAP;
 
 	fep->cur_rx = fep->rx_bd_base;
 
@@ -500,8 +494,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 	for (i = 0; i < fep->tx_ring_size; i++) {
 
 		/* Initialize the BD for every fragment in the page. */
-		bdp->cbd_sc = 0;
-		if (bdp->cbd_bufaddr)
+		bdp->bd.cbd_sc = 0;
+		if (bdp->bd.cbd_bufaddr)
 			fec_enet_tx_unmap(bdp, fep);
 		if (fep->tx_skbuff[i]) {
 			dev_kfree_skb_any(fep->tx_skbuff[i]);
@@ -512,7 +506,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 	/* Set the last buffer to wrap */
 	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->cbd_sc |= BD_SC_WRAP;
+	bdp->bd.cbd_sc |= BD_SC_WRAP;
 	fep->dirty_tx = bdp;
 }
 
@@ -765,7 +759,7 @@ static void
 fec_enet_tx(struct net_device *ndev)
 {
 	struct	fec_enet_private *fep;
-	struct bufdesc *bdp;
+	union bufdesc_u *bdp;
 	unsigned short status;
 	struct	sk_buff	*skb;
 	int	index = 0;
@@ -776,17 +770,16 @@ fec_enet_tx(struct net_device *ndev)
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, fep);
 
-	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
+	while (((status = bdp->bd.cbd_sc) & BD_ENET_TX_READY) == 0) {
 
 		/* current queue is empty */
 		if (bdp == fep->cur_tx)
 			break;
 
 		if (fep->bufdesc_ex)
-			index = (struct bufdesc_ex *)bdp -
-				(struct bufdesc_ex *)fep->tx_bd_base;
+			index = &bdp->ebd - &fep->tx_bd_base->ebd;
 		else
-			index = bdp - fep->tx_bd_base;
+			index = &bdp->bd - &fep->tx_bd_base->bd;
 
 		fec_enet_tx_unmap(bdp, fep);
 
@@ -810,19 +803,18 @@ fec_enet_tx(struct net_device *ndev)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-			ndev->stats.tx_bytes += bdp->cbd_datlen;
+			ndev->stats.tx_bytes += bdp->bd.cbd_datlen;
 		}
 
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
 			fep->bufdesc_ex) {
 			struct skb_shared_hwtstamps shhwtstamps;
 			unsigned long flags;
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
 
 			memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 			spin_lock_irqsave(&fep->tmreg_lock, flags);
 			shhwtstamps.hwtstamp = ns_to_ktime(
-				timecounter_cyc2time(&fep->tc, ebdp->ts));
+				timecounter_cyc2time(&fep->tc, bdp->ebd.ts));
 			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 			skb_tstamp_tx(skb, &shhwtstamps);
 		}
@@ -869,13 +861,12 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	struct bufdesc *bdp;
+	union bufdesc_u *bdp;
 	unsigned short status;
 	struct	sk_buff	*skb;
 	ushort	pkt_len;
 	__u8 *data;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	bool	vlan_packet_rcvd = false;
 	u16	vlan_tag;
 	int	index = 0;
@@ -889,7 +880,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	 */
 	bdp = fep->cur_rx;
 
-	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
+	while (!((status = bdp->bd.cbd_sc) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
 			break;
@@ -931,30 +922,24 @@ fec_enet_rx(struct net_device *ndev, int budget)
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-		pkt_len = bdp->cbd_datlen;
+		pkt_len = bdp->bd.cbd_datlen;
 		ndev->stats.rx_bytes += pkt_len;
 
 		if (fep->bufdesc_ex)
-			index = (struct bufdesc_ex *)bdp -
-				(struct bufdesc_ex *)fep->rx_bd_base;
+			index = &bdp->ebd - &fep->rx_bd_base->ebd;
 		else
-			index = bdp - fep->rx_bd_base;
+			index = &bdp->bd - &fep->rx_bd_base->bd;
 		data = fep->rx_skbuff[index]->data;
-		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
+		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 
 		if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
 			swap_buffer(data, pkt_len);
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
 		/* If this is a VLAN packet remove the VLAN Tag */
 		vlan_packet_rcvd = false;
 		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
-		    fep->bufdesc_ex && (ebdp->cbd_esc & BD_ENET_RX_VLAN)) {
+		    fep->bufdesc_ex && (bdp->ebd.cbd_esc & BD_ENET_RX_VLAN)) {
 			/* Push and remove the vlan tag */
 			struct vlan_hdr *vlan_header =
 					(struct vlan_hdr *) (data + ETH_HLEN);
@@ -998,13 +983,13 @@ fec_enet_rx(struct net_device *ndev, int budget)
 
 				spin_lock_irqsave(&fep->tmreg_lock, flags);
 				shhwtstamps->hwtstamp = ns_to_ktime(
-				    timecounter_cyc2time(&fep->tc, ebdp->ts));
+				    timecounter_cyc2time(&fep->tc, bdp->ebd.ts));
 				spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 			}
 
 			if (fep->bufdesc_ex &&
 			    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-				if (!(ebdp->cbd_esc & FLAG_RX_CSUM_ERROR)) {
+				if (!(bdp->ebd.cbd_esc & FLAG_RX_CSUM_ERROR)) {
 					/* don't check it */
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				} else {
@@ -1021,15 +1006,13 @@ fec_enet_rx(struct net_device *ndev, int budget)
 			napi_gro_receive(&fep->napi, skb);
 		}
 
-		dma_sync_single_for_device(&fep->pdev->dev, bdp->cbd_bufaddr,
+		dma_sync_single_for_device(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 rx_processing_done:
 		if (fep->bufdesc_ex) {
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-			ebdp->cbd_esc = BD_ENET_RX_INT;
-			ebdp->cbd_prot = 0;
-			ebdp->cbd_bdu = 0;
+			bdp->ebd.cbd_esc = BD_ENET_RX_INT;
+			bdp->ebd.cbd_prot = 0;
+			bdp->ebd.cbd_bdu = 0;
 		}
 
 		/*
@@ -1043,7 +1026,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 
 		/* Mark the buffer empty */
 		status |= BD_ENET_RX_EMPTY;
-		bdp->cbd_sc = status;
+		bdp->bd.cbd_sc = status;
 
 		/* Update BD pointer to next entry */
 		bdp = fec_enet_get_nextdesc(bdp, fep);
@@ -1739,14 +1722,14 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	unsigned int i;
 	struct sk_buff *skb;
-	struct bufdesc	*bdp;
+	union bufdesc_u *bdp;
 
 	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
 		skb = fep->rx_skbuff[i];
 		fep->rx_skbuff[i] = NULL;
 		if (skb) {
-			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
+			dma_unmap_single(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
 					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 			dev_kfree_skb(skb);
 		}
@@ -1755,7 +1738,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	bdp = fep->tx_bd_base;
 	for (i = 0; i < fep->tx_ring_size; i++) {
-		if (bdp->cbd_bufaddr)
+		if (bdp->bd.cbd_bufaddr)
 			fec_enet_tx_unmap(bdp, fep);
 		kfree(fep->tx_bounce[i]);
 		fep->tx_bounce[i] = NULL;
@@ -1771,7 +1754,7 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	unsigned int i;
 	struct sk_buff *skb;
-	struct bufdesc	*bdp;
+	union bufdesc_u *bdp;
 
 	bdp = fep->rx_bd_base;
 	for (i = 0; i < fep->rx_ring_size; i++) {
@@ -1791,20 +1774,18 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 		}
 
 		fep->rx_skbuff[i] = skb;
-		bdp->cbd_bufaddr = addr;
-		bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		bdp->bd.cbd_bufaddr = addr;
+		bdp->bd.cbd_sc = BD_ENET_RX_EMPTY;
 
-		if (fep->bufdesc_ex) {
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-			ebdp->cbd_esc = BD_ENET_RX_INT;
-		}
+		if (fep->bufdesc_ex)
+			bdp->ebd.cbd_esc = BD_ENET_RX_INT;
 
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->cbd_sc |= BD_SC_WRAP;
+	bdp->bd.cbd_sc |= BD_SC_WRAP;
 
 	bdp = fep->tx_bd_base;
 	for (i = 0; i < fep->tx_ring_size; i++) {
@@ -1812,20 +1793,18 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 		if (!fep->tx_bounce[i])
 			goto err_alloc;
 
-		bdp->cbd_sc = 0;
-		bdp->cbd_bufaddr = 0;
+		bdp->bd.cbd_sc = 0;
+		bdp->bd.cbd_bufaddr = 0;
 
-		if (fep->bufdesc_ex) {
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-			ebdp->cbd_esc = BD_ENET_TX_INT;
-		}
+		if (fep->bufdesc_ex)
+			bdp->ebd.cbd_esc = BD_ENET_TX_INT;
 
 		bdp = fec_enet_get_nextdesc(bdp, fep);
 	}
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, fep);
-	bdp->cbd_sc |= BD_SC_WRAP;
+	bdp->bd.cbd_sc |= BD_SC_WRAP;
 
 	return 0;
 
@@ -2063,7 +2042,7 @@ static int fec_enet_init(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	struct bufdesc *cbd_base;
+	union bufdesc_u *cbd_base;
 
 	/* Allocate memory for buffer descriptors. */
 	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &fep->bd_dma,
@@ -2087,10 +2066,11 @@ static int fec_enet_init(struct net_device *ndev)
 	/* Set receive and transmit descriptor base. */
 	fep->rx_bd_base = cbd_base;
 	if (fep->bufdesc_ex)
-		fep->tx_bd_base = (struct bufdesc *)
-			(((struct bufdesc_ex *)cbd_base) + fep->rx_ring_size);
+		fep->tx_bd_base = (union bufdesc_u *)
+			(&cbd_base->ebd + fep->rx_ring_size);
 	else
-		fep->tx_bd_base = cbd_base + fep->rx_ring_size;
+		fep->tx_bd_base = (union bufdesc_u *)
+			(&cbd_base->bd + fep->rx_ring_size);
 
 	/* The FEC Ethernet specific entries in the device structure */
 	ndev->watchdog_timeo = TX_TIMEOUT;
-- 
1.8.3.1
