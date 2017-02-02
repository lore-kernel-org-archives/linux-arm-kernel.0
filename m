From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Feb 2017 16:51:31 +0100
Subject: [PATCHv3 net-next 02/12] net: mvpp2: handle too large value handling
 in mvpp2_rx_pkts_coal_set()
In-Reply-To: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1486050701-27899-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, mvpp2_rx_pkts_coal_set() does the following to avoid setting
a too large value for the RX coalescing by packet number:

  val = (pkts & MVPP2_OCCUPIED_THRESH_MASK);

This means that if you set a value that is slightly higher the the
maximum number of packets, you in fact get a very low value. It makes a
lot more sense to simply check if the value is too high, and if it's too
high, limit it to the maximum possible value.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 7613c4f..3fd5a9f 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4381,11 +4381,12 @@ static void mvpp2_txp_max_tx_size_set(struct mvpp2_port *port)
 static void mvpp2_rx_pkts_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_rx_queue *rxq)
 {
-	u32 val;
+	if (rxq->pkts_coal > MVPP2_OCCUPIED_THRESH_MASK)
+		rxq->pkts_coal = MVPP2_OCCUPIED_THRESH_MASK;
 
-	val = (rxq->pkts_coal & MVPP2_OCCUPIED_THRESH_MASK);
 	mvpp2_write(port->priv, MVPP2_RXQ_NUM_REG, rxq->id);
-	mvpp2_write(port->priv, MVPP2_RXQ_THRESH_REG, val);
+	mvpp2_write(port->priv, MVPP2_RXQ_THRESH_REG,
+		    rxq->pkts_coal);
 }
 
 /* Set the time delay in usec before Rx interrupt */
-- 
2.7.4
