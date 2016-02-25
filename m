From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 24 Feb 2016 17:36:56 -0700
Subject: [PATCH net-next V2 13/16] net: fec: print more debug info in
 fec_timeout
In-Reply-To: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1456360619-24390-14-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print the current interrupt flags and mask and
the interrupt state during the last interrupt in
fec_timeout.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 001200b..615cca1 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -506,6 +506,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	uint	events;
+	uint	last_ievents;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index afd4060..9a3136b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1107,6 +1107,9 @@ fec_timeout(struct net_device *ndev)
 	int i;
 	uint events = 0;
 
+	pr_err("%s: last=%x %x, mask %x\n", __func__, fep->last_ievents,
+	       readl(fep->hwp + FEC_IEVENT), readl(fep->hwp + FEC_IMASK));
+
 	for (i = 0; i < fep->num_tx_queues; i++) {
 		struct fec_enet_priv_tx_q *txq = fep->tx_queue[i];
 		int index;
@@ -1514,6 +1517,7 @@ fec_enet_interrupt(int irq, void *dev_id)
 
 	if (!int_events)
 		return IRQ_NONE;
+	fep->last_ievents = int_events;
 
 	if (int_events & (FEC_ENET_RXF | FEC_ENET_TXF)) {
 		if (napi_schedule_prep(&fep->napi)) {
-- 
2.5.0
