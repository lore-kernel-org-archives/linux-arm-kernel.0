From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 18 Jun 2018 17:20:09 +0530
Subject: [PATCH 4/5] net: emaclite: Fix block comments style
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1529322610-27215-5-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes below checkpatch warnings-

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: networking block comments don't use an empty /* line,
use /* Comment

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 34 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0b41cc5..e8bb7b3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -70,7 +70,8 @@
 #define XEL_TSR_XMIT_IE_MASK	 0x00000008	/* Tx interrupt enable bit */
 #define XEL_TSR_XMIT_ACTIVE_MASK 0x80000000	/* Buffer is active, SW bit
 						 * only. This is not documented
-						 * in the HW spec */
+						 * in the HW spec
+						 */
 
 /* Define for programming the MAC address into the EmacLite */
 #define XEL_TSR_PROG_MAC_ADDR	(XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_PROGRAM_MASK)
@@ -336,7 +337,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 			drvdata->next_tx_buf_to_use ^= XEL_BUFFER_OFFSET;
 	} else if (drvdata->tx_ping_pong != 0) {
 		/* If the expected buffer is full, try the other buffer,
-		 * if it is configured in HW */
+		 * if it is configured in HW
+		 */
 
 		addr = (void __iomem __force *)((u32 __force)addr ^
 						 XEL_BUFFER_OFFSET);
@@ -357,7 +359,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 	/* Update the Tx Status Register to indicate that there is a
 	 * frame to send. Set the XEL_TSR_XMIT_ACTIVE_MASK flag which
 	 * is used by the interrupt handler to check whether a frame
-	 * has been transmitted */
+	 * has been transmitted
+	 */
 	reg_data = xemaclite_readl(addr + XEL_TSR_OFFSET);
 	reg_data |= (XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_XMIT_ACTIVE_MASK);
 	xemaclite_writel(reg_data, addr + XEL_TSR_OFFSET);
@@ -395,7 +398,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		/* The instance is out of sync, try other buffer if other
 		 * buffer is configured, return 0 otherwise. If the instance is
 		 * out of sync, do not update the 'next_rx_buf_to_use' since it
-		 * will correct on subsequent calls */
+		 * will correct on subsequent calls
+		 */
 		if (drvdata->rx_ping_pong != 0)
 			addr = (void __iomem __force *)((u32 __force)addr ^
 							 XEL_BUFFER_OFFSET);
@@ -409,13 +413,15 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			return 0;	/* No data was available */
 	}
 
-	/* Get the protocol type of the ethernet frame that arrived */
+	/* Get the protocol type of the ethernet frame that arrived
+	 */
 	proto_type = ((ntohl(xemaclite_readl(addr + XEL_HEADER_OFFSET +
 			XEL_RXBUFF_OFFSET)) >> XEL_HEADER_SHIFT) &
 			XEL_RPLR_LENGTH_MASK);
 
 	/* Check if received ethernet frame is a raw ethernet frame
-	 * or an IP packet or an ARP packet */
+	 * or an IP packet or an ARP packet
+	 */
 	if (proto_type > ETH_DATA_LEN) {
 
 		if (proto_type == ETH_P_IP) {
@@ -431,7 +437,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			length = XEL_ARP_PACKET_SIZE + ETH_HLEN + ETH_FCS_LEN;
 		else
 			/* Field contains type other than IP or ARP, use max
-			 * frame size and let user parse it */
+			 * frame size and let user parse it
+			 */
 			length = ETH_FRAME_LEN + ETH_FCS_LEN;
 	} else
 		/* Use the length in the frame, plus the header and trailer */
@@ -601,11 +608,11 @@ static void xemaclite_rx_handler(struct net_device *dev)
 		return;
 	}
 
-	/*
-	 * A new skb should have the data halfword aligned, but this code is
+	/* A new skb should have the data halfword aligned, but this code is
 	 * here just in case that isn't true. Calculate how many
 	 * bytes we should reserve to get the data to start on a word
-	 * boundary */
+	 * boundary
+	 */
 	align = BUFFER_ALIGN(skb->data);
 	if (align)
 		skb_reserve(skb, align);
@@ -707,8 +714,8 @@ static int xemaclite_mdio_wait(struct net_local *lp)
 	unsigned long end = jiffies + 2;
 
 	/* wait for the MDIO interface to not be busy or timeout
-	   after some time.
-	*/
+	 * after some time.
+	 */
 	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
 			XEL_MDIOCTRL_MDIOSTS_MASK) {
 		if (time_before_eq(end, jiffies)) {
@@ -1028,7 +1035,8 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
-		 * current transmission is complete */
+		 * current transmission is complete
+		 */
 		netif_stop_queue(dev);
 		lp->deferred_skb = new_skb;
 		/* Take the time stamp now, since we can't do this in an ISR. */
-- 
2.7.4
