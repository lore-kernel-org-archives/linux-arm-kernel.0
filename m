From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  3 Aug 2017 10:41:56 +0200
Subject: [PATCH net-next v2 2/7] net: mvpp2: remove RX queue group reset code
In-Reply-To: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
References: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170803084201.30305-3-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RX queue group allocation is anyway re-done later in
mvpp2_port_init(), so resetting it in mvpp2_init() is not very useful,
and will be annoying as we are going to rework the RX queue group
allocation logic.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 4b36a15..537d2b4 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6845,23 +6845,6 @@ static int mvpp2_init(struct platform_device *pdev, struct mvpp2 *priv)
 	/* Rx Fifo Init */
 	mvpp2_rx_fifo_init(priv);
 
-	/* Reset Rx queue group interrupt configuration */
-	for (i = 0; i < MVPP2_MAX_PORTS; i++) {
-		if (priv->hw_version == MVPP21) {
-			mvpp2_write(priv, MVPP21_ISR_RXQ_GROUP_REG(i),
-				    rxq_number);
-			continue;
-		} else {
-			u32 val;
-
-			val = (i << MVPP22_ISR_RXQ_GROUP_INDEX_GROUP_OFFSET);
-			mvpp2_write(priv, MVPP22_ISR_RXQ_GROUP_INDEX_REG, val);
-
-			val = (rxq_number << MVPP22_ISR_RXQ_SUB_GROUP_SIZE_OFFSET);
-			mvpp2_write(priv, MVPP22_ISR_RXQ_SUB_GROUP_CONFIG_REG, val);
-		}
-	}
-
 	if (priv->hw_version == MVPP21)
 		writel(MVPP2_EXT_GLOBAL_CTRL_DEFAULT,
 		       priv->lms_base + MVPP2_MNG_EXTENDED_GLOBAL_CTRL_REG);
-- 
2.9.4
