From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:26 -0700
Subject: [PATCH net-next 02/40] net: fec: fix rx error counts
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-3-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On an overrun, the other flags are not
valid, so don't check them.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 36 +++++++++++++------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2c7c845..620834f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1403,37 +1403,31 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 			break;
 		pkt_received++;
 
-		/* Since we have allocated space to hold a complete frame,
-		 * the last indicator should be set.
-		 */
-		if ((status & BD_ENET_RX_LAST) == 0)
-			netdev_err(ndev, "rcv is not +last\n");
-
 		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
 		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
+			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+			   BD_ENET_RX_CL)) {
 			ndev->stats.rx_errors++;
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
+			if (status & BD_ENET_RX_OV) {
+				/* FIFO overrun */
+				ndev->stats.rx_fifo_errors++;
+				goto rx_processing_done;
+			}
+			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
+						| BD_ENET_RX_LAST)) {
 				/* Frame too long or too short. */
 				ndev->stats.rx_length_errors++;
+				if (status & BD_ENET_RX_LAST)
+					netdev_err(ndev, "rcv is not +last\n");
 			}
-			if (status & BD_ENET_RX_NO)	/* Frame alignment */
-				ndev->stats.rx_frame_errors++;
 			if (status & BD_ENET_RX_CR)	/* CRC Error */
 				ndev->stats.rx_crc_errors++;
-			if (status & BD_ENET_RX_OV)	/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-		}
-
-		/* Report late collisions as a frame error.
-		 * On this error, the BD is closed, but we don't know what we
-		 * have in the buffer.  So, just drop this frame on the floor.
-		 */
-		if (status & BD_ENET_RX_CL) {
-			ndev->stats.rx_errors++;
-			ndev->stats.rx_frame_errors++;
+			/* Report late collisions as a frame error. */
+			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+				ndev->stats.rx_frame_errors++;
 			goto rx_processing_done;
 		}
 
-- 
2.5.0
