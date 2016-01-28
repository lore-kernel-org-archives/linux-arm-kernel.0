From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:57 -0700
Subject: [PATCH net-next 33/40] net: fec: shrink the window for 'tx int lost'
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-34-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perform skb_tx_timestamp before transferring ownership

This shrinks the window for 'tx int lost'
If the packet is transmitted and napi clears the tx interrupt
before the txq->bd.cur assignment, then the tx interrupt is
effectively lost.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9da2c6d..512b1ad 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -510,27 +510,24 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
 	/* Save skb pointer */
 	txq->tx_skbuff[index] = skb;
+	last_bdp = fec_enet_get_nextdesc(last_bdp, &txq->bd);
+	skb_tx_timestamp(skb);
 
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
 	wmb();
 
-	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
-	 * it's the last BD of the frame, and to put the CRC on the end.
+	/* Send it on its way.  Transfer ownership
+	 * Make sure the update to bdp and tx_skbuff are performed before
+	 * the update to txq->bd.cur.
+	 * Keep window for interrupt between the next 3 lines as small as
+	 * possible, to avoid "tx int lost" in case no more tx interrupts
+	 * happen within 2 seconds.
 	 */
 	bdp->cbd_sc = status;
-
-	/* If this was the last BD in the ring, start at the beginning again. */
-	bdp = fec_enet_get_nextdesc(last_bdp, &txq->bd);
-
-	skb_tx_timestamp(skb);
-
-	/* Make sure the update to bdp and tx_skbuff are performed before
-	 * txq->bd.cur.
-	 */
 	wmb();
-	txq->bd.cur = bdp;
+	txq->bd.cur = last_bdp;
 
 	/* Trigger transmission start */
 	writel(0, txq->bd.reg_desc_active);
@@ -719,12 +716,12 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	 * transferring ownership.
 	 */
 	wmb();
-	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	/* Send it on its way.  Transfer ownership
+	 * Keep window for interrupt between the next 3 lines as small as
+	 * possible, to avoid "tx int lost" in case no more tx interrupts
+	 * happen within 2 seconds.
 	 */
 	first_bdp->cbd_sc = status;
-	/* Make sure ownership is transferred before the
-	 * update to txq->bd.cur.
-	 */
 	wmb();
 	txq->bd.cur = bdp;
 
-- 
2.5.0
