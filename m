From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:43 -0700
Subject: [PATCH net-next 19/40] net: fec: dump all tx queues in fec_dump
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-20-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dump all tx queues, not just queue 0.
Also, disable fec interrupts first.
The interrupts will be reenabled in fec_restart.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 36 +++++++++++++++++--------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1759705..1225282 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -271,26 +271,30 @@ static void swap_buffer2(void *dst_buf, void *src_buf, int len)
 static void fec_dump(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct bufdesc *bdp;
-	struct fec_enet_priv_tx_q *txq;
-	int index = 0;
+	int i;
 
+	/* Disable all FEC interrupts */
+	writel(0, fep->hwp + FEC_IMASK);
 	netdev_info(ndev, "TX ring dump\n");
 	pr_info("Nr     SC     addr       len  SKB\n");
 
-	txq = fep->tx_queue[0];
-	bdp = txq->bd.base;
-
-	do {
-		pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p\n",
-			index,
-			bdp == txq->bd.cur ? 'S' : ' ',
-			bdp == txq->dirty_tx ? 'H' : ' ',
-			bdp->cbd_sc, bdp->cbd_bufaddr, bdp->cbd_datlen,
-			txq->tx_skbuff[index]);
-		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
-		index++;
-	} while (bdp != txq->bd.base);
+	for (i = 0; i < fep->num_tx_queues; i++) {
+		struct fec_enet_priv_tx_q *txq = fep->tx_queue[i];
+		struct bufdesc *bdp = txq->bd.base;
+		int index = 0;
+
+		pr_info("tx queue %d\n", i);
+		do {
+			pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p\n",
+				index,
+				bdp == txq->bd.cur ? 'S' : ' ',
+				bdp == txq->dirty_tx ? 'H' : ' ',
+				bdp->cbd_sc, bdp->cbd_bufaddr, bdp->cbd_datlen,
+				txq->tx_skbuff[index]);
+			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+			index++;
+		} while (bdp != txq->bd.base);
+	}
 }
 
 static inline bool is_ipv4_pkt(struct sk_buff *skb)
-- 
2.5.0
