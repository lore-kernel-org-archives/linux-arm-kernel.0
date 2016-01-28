From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:31 -0700
Subject: [PATCH net-next 07/40] net: fec: don't transfer ownership until
 descriptor write is complete
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-8-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e8f35fb..b87f80d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -388,6 +388,10 @@ fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 
 		bdp->cbd_bufaddr = addr;
 		bdp->cbd_datlen = frag_len;
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		wmb();
 		bdp->cbd_sc = status;
 	}
 
@@ -497,6 +501,10 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	bdp->cbd_datlen = buflen;
 	bdp->cbd_bufaddr = addr;
+	/* Make sure the updates to rest of the descriptor are performed before
+	 * transferring ownership.
+	 */
+	wmb();
 
 	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
 	 * it's the last BD of the frame, and to put the CRC on the end.
@@ -1467,7 +1475,6 @@ rx_processing_done:
 
 		/* Mark the buffer empty */
 		status |= BD_ENET_RX_EMPTY;
-		bdp->cbd_sc = status;
 
 		if (fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
@@ -1476,6 +1483,11 @@ rx_processing_done:
 			ebdp->cbd_prot = 0;
 			ebdp->cbd_bdu = 0;
 		}
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		wmb();
+		bdp->cbd_sc = status;
 
 		/* Update BD pointer to next entry */
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
-- 
2.5.0
