From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:59 -0700
Subject: [PATCH net-next V3 13/16] net: fec: detect tx int lost
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-14-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a tx int is lost, no need to reset
the fec. Just mark the event and call napi_schedule.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: no change
---
 drivers/net/ethernet/freescale/fec_main.c | 38 ++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index be875fd..445443d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1094,14 +1094,50 @@ fec_stop(struct net_device *ndev)
 	}
 }
 
+static const uint txint_flags[] = {
+	FEC_ENET_TXF_0, FEC_ENET_TXF_1, FEC_ENET_TXF_2
+};
 
 static void
 fec_timeout(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bufdesc *bdp;
+	unsigned short status;
+	int i;
+	uint events = 0;
 
-	fec_dump(ndev);
+	for (i = 0; i < fep->num_tx_queues; i++) {
+		struct fec_enet_priv_tx_q *txq = fep->tx_queue[i];
+		int index;
+		struct sk_buff *skb = NULL;
 
+		bdp = txq->dirty_tx;
+		while (1) {
+			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+			if (bdp == txq->bd.cur)
+				break;
+			index = fec_enet_get_bd_index(bdp, &txq->bd);
+			skb = txq->tx_skbuff[index];
+			if (skb) {
+				status = fec16_to_cpu(bdp->cbd_sc);
+				if ((status & BD_ENET_TX_READY) == 0)
+					events |= txint_flags[i];
+				break;
+			}
+		}
+	}
+	if (events) {
+		fep->events |= events;
+		/* Disable the RX/TX interrupt */
+		writel(FEC_NAPI_IMASK, fep->hwp + FEC_IMASK);
+		napi_schedule(&fep->napi);
+		netif_wake_queue(fep->netdev);
+		pr_err("%s: tx int lost\n", __func__);
+		return;
+	}
+
+	fec_dump(ndev);
 	ndev->stats.tx_errors++;
 
 	schedule_work(&fep->tx_timeout_work);
-- 
2.5.0
