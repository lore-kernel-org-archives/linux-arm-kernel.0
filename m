From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  7 Mar 2017 16:53:03 +0100
Subject: [PATCHv3 net-next 05/22] net: mvpp2: remove
 mvpp2_txq_pend_desc_num_get() function
In-Reply-To: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1488902000-2658-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvpp2_txq_pend_desc_num_get() function only selects a TX queue, and
reads the number of pending descriptors. It is used in only one place,
in mvpp2_txq_clean(), where the TX queue has already been selected by a
write to MVPP2_TXQ_NUM_REG.

Therefore, this function is useless, and the caller can simply read the
value of the MVPP2_TXQ_PENDING_REG register instead.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 60cc020..9ddda20 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4123,18 +4123,6 @@ static u32 mvpp2_bm_cookie_build(struct mvpp2_rx_desc *rx_desc)
 
 /* Tx descriptors helper methods */
 
-/* Get number of Tx descriptors waiting to be transmitted by HW */
-static int mvpp2_txq_pend_desc_num_get(struct mvpp2_port *port,
-				       struct mvpp2_tx_queue *txq)
-{
-	u32 val;
-
-	mvpp2_write(port->priv, MVPP2_TXQ_NUM_REG, txq->id);
-	val = mvpp2_read(port->priv, MVPP2_TXQ_PENDING_REG);
-
-	return val & MVPP2_TXQ_PENDING_MASK;
-}
-
 /* Get pointer to next Tx descriptor to be processed (send) by HW */
 static struct mvpp2_tx_desc *
 mvpp2_txq_next_desc_get(struct mvpp2_tx_queue *txq)
@@ -4740,7 +4728,8 @@ static void mvpp2_txq_clean(struct mvpp2_port *port, struct mvpp2_tx_queue *txq)
 		mdelay(1);
 		delay++;
 
-		pending = mvpp2_txq_pend_desc_num_get(port, txq);
+		pending = mvpp2_read(port->priv, MVPP2_TXQ_PENDING_REG) &
+			MVPP2_TXQ_PENDING_MASK;
 	} while (pending);
 
 	val &= ~MVPP2_TXQ_DRAIN_EN_MASK;
-- 
2.7.4
