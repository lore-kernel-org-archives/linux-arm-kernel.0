From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 15 Jan 2014 00:46:52 +0100
Subject: [PATCH net-next 2/2] net: mvneta: make mvneta_txq_done() return void
In-Reply-To: <cover.1389742334.git.arno@natisbad.org>
References: <cover.1389742334.git.arno@natisbad.org>
Message-ID: <1e35971f3ee9f4d120bff5fe98179160998ea0fa.1389742334.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The function return parameter is not used in mvneta_tx_done_gbe(),
where the function is called. This patch makes the function return
void.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 8c5150124b5e..f418f4f20f94 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1314,15 +1314,16 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
 }
 
 /* Handle end of transmission */
-static int mvneta_txq_done(struct mvneta_port *pp,
+static void mvneta_txq_done(struct mvneta_port *pp,
 			   struct mvneta_tx_queue *txq)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(pp->dev, txq->id);
 	int tx_done;
 
 	tx_done = mvneta_txq_sent_desc_proc(pp, txq);
-	if (tx_done == 0)
-		return tx_done;
+	if (!tx_done)
+		return;
+
 	mvneta_txq_bufs_free(pp, txq, tx_done);
 
 	txq->count -= tx_done;
@@ -1331,8 +1332,6 @@ static int mvneta_txq_done(struct mvneta_port *pp,
 		if (txq->size - txq->count >= MAX_SKB_FRAGS + 1)
 			netif_tx_wake_queue(nq);
 	}
-
-	return tx_done;
 }
 
 static void *mvneta_frag_alloc(const struct mvneta_port *pp)
-- 
1.8.5.2
