From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 2 Apr 2018 11:23:43 +0800
Subject: [PATCH v3 1/2] net: mvneta: split rxq/txq init and txq deinit into
 SW and HW parts
In-Reply-To: <20180402112229.508e1feb@xhacker.debian>
References: <20180402112229.508e1feb@xhacker.debian>
Message-ID: <20180402112343.54ddfadd@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to prepare the suspend/resume improvement in next patch. The
SW parts can be optimized out during resume.

As for rxq handling during suspend, we'd like to drop packets by
calling mvneta_rxq_drop_pkts() which is both SW and HW operation,
so we don't split rxq deinit.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 85 +++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 30aab9bf77cc..f96815853108 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2796,10 +2796,8 @@ static void mvneta_rx_reset(struct mvneta_port *pp)
 
 /* Rx/Tx queue initialization/cleanup methods */
 
-/* Create a specified RX queue */
-static int mvneta_rxq_init(struct mvneta_port *pp,
-			   struct mvneta_rx_queue *rxq)
-
+static int mvneta_rxq_sw_init(struct mvneta_port *pp,
+			      struct mvneta_rx_queue *rxq)
 {
 	rxq->size = pp->rx_ring_size;
 
@@ -2812,6 +2810,12 @@ static int mvneta_rxq_init(struct mvneta_port *pp,
 
 	rxq->last_desc = rxq->size - 1;
 
+	return 0;
+}
+
+static void mvneta_rxq_hw_init(struct mvneta_port *pp,
+			       struct mvneta_rx_queue *rxq)
+{
 	/* Set Rx descriptors queue starting address */
 	mvreg_write(pp, MVNETA_RXQ_BASE_ADDR_REG(rxq->id), rxq->descs_phys);
 	mvreg_write(pp, MVNETA_RXQ_SIZE_REG(rxq->id), rxq->size);
@@ -2835,6 +2839,20 @@ static int mvneta_rxq_init(struct mvneta_port *pp,
 		mvneta_rxq_short_pool_set(pp, rxq);
 		mvneta_rxq_non_occup_desc_add(pp, rxq, rxq->size);
 	}
+}
+
+/* Create a specified RX queue */
+static int mvneta_rxq_init(struct mvneta_port *pp,
+			   struct mvneta_rx_queue *rxq)
+
+{
+	int ret;
+
+	ret = mvneta_rxq_sw_init(pp, rxq);
+	if (ret < 0)
+		return ret;
+
+	mvneta_rxq_hw_init(pp, rxq);
 
 	return 0;
 }
@@ -2857,9 +2875,8 @@ static void mvneta_rxq_deinit(struct mvneta_port *pp,
 	rxq->descs_phys        = 0;
 }
 
-/* Create and initialize a tx queue */
-static int mvneta_txq_init(struct mvneta_port *pp,
-			   struct mvneta_tx_queue *txq)
+static int mvneta_txq_sw_init(struct mvneta_port *pp,
+			      struct mvneta_tx_queue *txq)
 {
 	int cpu;
 
@@ -2872,7 +2889,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 	txq->tx_stop_threshold = txq->size - MVNETA_MAX_SKB_DESCS;
 	txq->tx_wake_threshold = txq->tx_stop_threshold / 2;
 
-
 	/* Allocate memory for TX descriptors */
 	txq->descs = dma_alloc_coherent(pp->dev->dev.parent,
 					txq->size * MVNETA_DESC_ALIGNED_SIZE,
@@ -2882,14 +2898,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 
 	txq->last_desc = txq->size - 1;
 
-	/* Set maximum bandwidth for enabled TXQs */
-	mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0x03ffffff);
-	mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0x3fffffff);
-
-	/* Set Tx descriptors queue starting address */
-	mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), txq->descs_phys);
-	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), txq->size);
-
 	txq->tx_skb = kmalloc_array(txq->size, sizeof(*txq->tx_skb),
 				    GFP_KERNEL);
 	if (!txq->tx_skb) {
@@ -2910,7 +2918,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 				  txq->descs, txq->descs_phys);
 		return -ENOMEM;
 	}
-	mvneta_tx_done_pkts_coal_set(pp, txq, txq->done_pkts_coal);
 
 	/* Setup XPS mapping */
 	if (txq_number > 1)
@@ -2923,9 +2930,38 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 	return 0;
 }
 
+static void mvneta_txq_hw_init(struct mvneta_port *pp,
+			       struct mvneta_tx_queue *txq)
+{
+	/* Set maximum bandwidth for enabled TXQs */
+	mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0x03ffffff);
+	mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0x3fffffff);
+
+	/* Set Tx descriptors queue starting address */
+	mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), txq->descs_phys);
+	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), txq->size);
+
+	mvneta_tx_done_pkts_coal_set(pp, txq, txq->done_pkts_coal);
+}
+
+/* Create and initialize a tx queue */
+static int mvneta_txq_init(struct mvneta_port *pp,
+			   struct mvneta_tx_queue *txq)
+{
+	int ret;
+
+	ret = mvneta_txq_sw_init(pp, txq);
+	if (ret < 0)
+		return ret;
+
+	mvneta_txq_hw_init(pp, txq);
+
+	return 0;
+}
+
 /* Free allocated resources when mvneta_txq_init() fails to allocate memory*/
-static void mvneta_txq_deinit(struct mvneta_port *pp,
-			      struct mvneta_tx_queue *txq)
+static void mvneta_txq_sw_deinit(struct mvneta_port *pp,
+				 struct mvneta_tx_queue *txq)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(pp->dev, txq->id);
 
@@ -2946,7 +2982,11 @@ static void mvneta_txq_deinit(struct mvneta_port *pp,
 	txq->last_desc         = 0;
 	txq->next_desc_to_proc = 0;
 	txq->descs_phys        = 0;
+}
 
+static void mvneta_txq_hw_deinit(struct mvneta_port *pp,
+				 struct mvneta_tx_queue *txq)
+{
 	/* Set minimum bandwidth for disabled TXQs */
 	mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
 	mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
@@ -2956,6 +2996,13 @@ static void mvneta_txq_deinit(struct mvneta_port *pp,
 	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
 }
 
+static void mvneta_txq_deinit(struct mvneta_port *pp,
+			      struct mvneta_tx_queue *txq)
+{
+	mvneta_txq_sw_deinit(pp, txq);
+	mvneta_txq_hw_deinit(pp, txq);
+}
+
 /* Cleanup all Tx queues */
 static void mvneta_cleanup_txqs(struct mvneta_port *pp)
 {
-- 
2.16.3
