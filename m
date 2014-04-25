From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:11 +0100
Subject: [PATCH 126/222] net:fec: unsorted hacks
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWB-0007Ld-3b@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  16 +++-
 drivers/net/ethernet/freescale/fec_main.c | 126 +++++++++++++++++-------------
 2 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index bfcab01131cc..09bdf6fea8ea 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -208,6 +208,7 @@ union bufdesc_u {
 #define BD_ENET_RX_OV           ((ushort)0x0002)
 #define BD_ENET_RX_CL           ((ushort)0x0001)
 #define BD_ENET_RX_STATS        ((ushort)0x013f)        /* All status bits */
+#define BD_ENET_RX_ERROR	((ushort)0x003f)
 
 /* Enhanced buffer descriptor control/status used by Ethernet receive */
 #define BD_ENET_RX_VLAN         0x00000004
@@ -230,10 +231,17 @@ union bufdesc_u {
 #define BD_ENET_TX_STATS        ((ushort)0x03ff)        /* All status bits */
 
 /*enhanced buffer descriptor control/status used by Ethernet transmit*/
-#define BD_ENET_TX_INT          0x40000000
-#define BD_ENET_TX_TS           0x20000000
-#define BD_ENET_TX_PINS         0x10000000
-#define BD_ENET_TX_IINS         0x08000000
+#define BD_ENET_TX_INT          BIT(30)
+#define BD_ENET_TX_TS           BIT(29)
+#define BD_ENET_TX_PINS         BIT(28)
+#define BD_ENET_TX_IINS         BIT(27)
+#define BD_ENET_TX_TXE		BIT(15)
+#define BD_ENET_TX_UE		BIT(13)
+#define BD_ENET_TX_EE		BIT(12)
+#define BD_ENET_TX_FE		BIT(11)
+#define BD_ENET_TX_LCE		BIT(10)
+#define BD_ENET_TX_OE		BIT(9)
+#define BD_ENET_TX_TSE		BIT(8)
 
 
 /* This device has up to three irqs on some platforms */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 441e472f7779..7330bc5c64e0 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -85,16 +85,6 @@ static void set_multicast_list(struct net_device *ndev);
 #define FEC_QUIRK_HAS_CSUM		(1 << 5)
 /* Controller has hardware vlan support */
 #define FEC_QUIRK_HAS_VLAN		(1 << 6)
-/* ENET IP errata ERR006358
- *
- * If the ready bit in the transmit buffer descriptor (TxBD[R]) is previously
- * detected as not set during a prior frame transmission, then the
- * ENET_TDAR[TDAR] bit is cleared@a later time, even if additional TxBDs
- * were added to the ring and the ENET_TDAR[TDAR] bit is set. This results in
- * frames not being transmitted until there is a 0-to-1 transition on
- * ENET_TDAR[TDAR].
- */
-#define FEC_QUIRK_ERR006358            (1 << 7)
 
 static struct platform_device_id fec_devtype[] = {
 	{
@@ -114,7 +104,7 @@ static struct platform_device_id fec_devtype[] = {
 		.name = "imx6q-fec",
 		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
 				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
-				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358,
+				FEC_QUIRK_HAS_VLAN,
 	}, {
 		.name = "mvf600-fec",
 		.driver_data = FEC_QUIRK_ENET_MAC,
@@ -293,13 +283,16 @@ static void fec_dump(struct net_device *ndev)
 	for (index = 0; index < fep->tx_ring_size; index++) {
 		bdp = fec_enet_tx_get(index, fep);
 
-		pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p\n",
+		pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p",
 			index,
 			index == fep->tx_next ? 'S' : ' ',
 			index == fep->tx_dirty ? 'H' : ' ',
 			bdp->bd.cbd_sc, bdp->bd.cbd_bufaddr,
 			bdp->bd.cbd_datlen,
 			fep->tx_skbuff[index]);
+		if (fep->flags & FEC_FLAG_BUFDESC_EX)
+			pr_cont(" %08lx", bdp->ebd.cbd_esc);
+		pr_cont("\n");
 	}
 }
 
@@ -836,13 +829,14 @@ fec_enet_tx(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	union bufdesc_u *bdp;
-	unsigned short status;
 	struct	sk_buff	*skb;
 	unsigned index = fep->tx_dirty;
 	unsigned pkts_compl, bytes_compl;
 
 	pkts_compl = bytes_compl = 0;
 	do {
+		unsigned status, cbd_esc;
+
 		if (++index >= fep->tx_ring_size)
 			index = 0;
 
@@ -862,21 +856,40 @@ fec_enet_tx(struct net_device *ndev)
 		fep->tx_skbuff[index] = NULL;
 
 		/* Check for errors. */
-		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
-				   BD_ENET_TX_RL | BD_ENET_TX_UN |
-				   BD_ENET_TX_CSL)) {
-			ndev->stats.tx_errors++;
-			if (status & BD_ENET_TX_HB)  /* No heartbeat */
-				ndev->stats.tx_heartbeat_errors++;
-			if (status & BD_ENET_TX_LC)  /* Late collision */
-				ndev->stats.tx_window_errors++;
-			if (status & BD_ENET_TX_RL)  /* Retrans limit */
-				ndev->stats.tx_aborted_errors++;
-			if (status & BD_ENET_TX_UN)  /* Underrun */
-				ndev->stats.tx_fifo_errors++;
-			if (status & BD_ENET_TX_CSL) /* Carrier lost */
-				ndev->stats.tx_carrier_errors++;
-		} else if (skb) {
+		if (fep->flags & FEC_FLAG_BUFDESC_EX) {
+			cbd_esc = bdp->ebd.cbd_esc;
+			if (cbd_esc & BD_ENET_TX_TXE) {
+				ndev->stats.tx_errors++;
+				if (cbd_esc & BD_ENET_TX_EE) { /* excess collision */
+					ndev->stats.collisions += 16;
+					ndev->stats.tx_aborted_errors++;
+				}
+				if (cbd_esc & BD_ENET_TX_LCE) /* late collision error */
+					ndev->stats.tx_window_errors++;
+				if (cbd_esc & (BD_ENET_TX_UE | BD_ENET_TX_FE | BD_ENET_TX_OE))
+					ndev->stats.tx_fifo_errors++;
+				goto next;
+			}
+		} else {
+			if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+					   BD_ENET_TX_RL | BD_ENET_TX_UN |
+					   BD_ENET_TX_CSL)) {
+				ndev->stats.tx_errors++;
+				if (status & BD_ENET_TX_HB)  /* No heartbeat */
+					ndev->stats.tx_heartbeat_errors++;
+				if (status & BD_ENET_TX_LC)  /* Late collision */
+					ndev->stats.tx_window_errors++;
+				if (status & BD_ENET_TX_RL)  /* Retrans limit */
+					ndev->stats.tx_aborted_errors++;
+				if (status & BD_ENET_TX_UN)  /* Underrun */
+					ndev->stats.tx_fifo_errors++;
+				if (status & BD_ENET_TX_CSL) /* Carrier lost */
+					ndev->stats.tx_carrier_errors++;
+				goto next;
+			}
+		}
+
+		if (skb) {
 			ndev->stats.tx_packets++;
 			ndev->stats.tx_bytes += skb->len;
 		}
@@ -886,7 +899,7 @@ fec_enet_tx(struct net_device *ndev)
 		 */
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
-
+ next:
 		if (skb) {
 			if (fep->flags & FEC_FLAG_BUFDESC_EX &&
 			    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
@@ -930,7 +943,6 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	unsigned short status;
 	struct	sk_buff	*skb;
 	ushort	pkt_len;
 	__u8 *data;
@@ -948,6 +960,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 	 */
 	do {
 		union bufdesc_u *bdp = fec_enet_rx_get(index, fep);
+		unsigned status, cbd_esc;
 
 		status = bdp->bd.cbd_sc;
 		if (status & BD_ENET_RX_EMPTY)
@@ -966,29 +979,37 @@ fec_enet_rx(struct net_device *ndev, int budget)
 
 		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
 
-		/* Check for errors. */
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
-			ndev->stats.rx_errors++;
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-			}
-			if (status & BD_ENET_RX_NO)	/* Frame alignment */
-				ndev->stats.rx_frame_errors++;
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			if (status & BD_ENET_RX_OV)	/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
+		if (fep->flags & FEC_FLAG_BUFDESC_EX) {
+			cbd_esc = bdp->ebd.cbd_esc;
+			if (!(fep->flags & FEC_FLAG_RX_VLAN))
+				cbd_esc &= ~BD_ENET_RX_VLAN;
+		} else {
+			cbd_esc = 0;
 		}
 
-		/* Report late collisions as a frame error.
-		 * On this error, the BD is closed, but we don't know what we
-		 * have in the buffer.  So, just drop this frame on the floor.
-		 */
-		if (status & BD_ENET_RX_CL) {
+		/* Check for errors. */
+		if (status & BD_ENET_RX_ERROR) {
 			ndev->stats.rx_errors++;
-			ndev->stats.rx_frame_errors++;
+
+			/*
+			 * Report late collisions as a frame error.  On this
+			 * error, the BD is closed, but we don't know what we
+			 * have in the buffer.  So, just drop this frame on
+			 * the floor.
+			 */
+			if (status & BD_ENET_RX_CL) {
+				ndev->stats.rx_frame_errors++;
+			} else {
+				if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH))
+					/* Frame too long or too short. */
+					ndev->stats.rx_length_errors++;
+				if (status & BD_ENET_RX_NO)	/* Frame alignment */
+					ndev->stats.rx_frame_errors++;
+				if (status & BD_ENET_RX_CR)	/* CRC Error */
+					ndev->stats.rx_crc_errors++;
+				if (status & BD_ENET_RX_OV)	/* FIFO overrun */
+					ndev->stats.rx_fifo_errors++;
+			}
 			goto rx_processing_done;
 		}
 
@@ -1006,8 +1027,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 
 		/* If this is a VLAN packet remove the VLAN Tag */
 		vlan_packet_rcvd = false;
-		if (fep->flags & FEC_FLAG_RX_VLAN &&
-		    bdp->ebd.cbd_esc & BD_ENET_RX_VLAN) {
+		if (cbd_esc & BD_ENET_RX_VLAN) {
 			/* Push and remove the vlan tag */
 			struct vlan_hdr *vlan_header =
 					(struct vlan_hdr *) (data + ETH_HLEN);
@@ -1047,7 +1067,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 						  skb_hwtstamps(skb));
 
 			if (fep->flags & FEC_FLAG_RX_CSUM) {
-				if (!(bdp->ebd.cbd_esc & FLAG_RX_CSUM_ERROR)) {
+				if (!(cbd_esc & FLAG_RX_CSUM_ERROR)) {
 					/* don't check it */
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				} else {
-- 
1.8.3.1
