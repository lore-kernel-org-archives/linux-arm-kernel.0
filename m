From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 28 Oct 2014 14:23:04 +0100
Subject: [PATCHv3 9/9] net: fec: fix regression on i.MX28 introduced by
 rx_copybreak support
In-Reply-To: <1414502584-10583-1-git-send-email-LW@KARO-electronics.de>
References: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
 <1414502584-10583-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1414502584-10583-10-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 1b7bde6d659d ("net: fec: implement rx_copybreak to improve rx performance")
introduced a regression for i.MX28. The swap_buffer() function doing
the endian conversion of the received data on i.MX28 may access memory
beyond the actual packet size in the DMA buffer. fec_enet_copybreak()
does not copy those bytes, so that the last bytes of a packet may be
filled with invalid data after swapping.
This will likely lead to checksum errors on received packets.
E.g. when trying to mount an NFS rootfs:
UDP: bad checksum. From 192.168.1.225:111 to 192.168.100.73:44662 ulen 36

Do the byte swapping and copying to the new skb in one go if
necessary.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec_main.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e52864c..5ee4912 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -294,7 +294,16 @@ static void swap_buffer(void *bufaddr, int len)
 
 	for (i = 0; i < len; i += 4, buf++)
 		swab32s(buf);
+}
+
+static void swap_buffer2(void *dst_buf, void *src_buf, int len)
+{
+	int i;
+	unsigned int *src = src_buf;
+	unsigned int *dst = dst_buf;
 
+	for (i = 0; i < len; i += 4, src++, dst++)
+		*dst = swab32p(src);
 }
 
 static void fec_dump(struct net_device *ndev)
@@ -1292,7 +1301,7 @@ fec_enet_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct sk_buff
 }
 
 static bool fec_enet_copybreak(struct net_device *ndev, struct sk_buff **skb,
-			       struct bufdesc *bdp, u32 length)
+			       struct bufdesc *bdp, u32 length, bool swap)
 {
 	struct  fec_enet_private *fep = netdev_priv(ndev);
 	struct sk_buff *new_skb;
@@ -1307,7 +1316,10 @@ static bool fec_enet_copybreak(struct net_device *ndev, struct sk_buff **skb,
 	dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
 				FEC_ENET_RX_FRSIZE - fep->rx_align,
 				DMA_FROM_DEVICE);
-	memcpy(new_skb->data, (*skb)->data, length);
+	if (!swap)
+		memcpy(new_skb->data, (*skb)->data, length);
+	else
+		swap_buffer2(new_skb->data, (*skb)->data, length);
 	*skb = new_skb;
 
 	return true;
@@ -1335,6 +1347,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	u16	vlan_tag;
 	int	index = 0;
 	bool	is_copybreak;
+	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 
 #ifdef CONFIG_M532x
 	flush_cache_all();
@@ -1398,7 +1411,8 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		is_copybreak = fec_enet_copybreak(ndev, &skb, bdp, pkt_len - 4);
+		is_copybreak = fec_enet_copybreak(ndev, &skb, bdp, pkt_len - 4,
+						  need_swap);
 		if (!is_copybreak) {
 			skb_new = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
 			if (unlikely(!skb_new)) {
@@ -1413,7 +1427,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 		prefetch(skb->data - NET_IP_ALIGN);
 		skb_put(skb, pkt_len - 4);
 		data = skb->data;
-		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		if (!is_copybreak && need_swap)
 			swap_buffer(data, pkt_len);
 
 		/* Extract the enhanced buffer descriptor */
-- 
1.7.10.4
