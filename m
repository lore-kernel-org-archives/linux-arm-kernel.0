From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 Dec 2016 17:54:28 +0100
Subject: [PATCH v2 07/16] net: mvpp2: adapt the mvpp2_rxq_*_pool_set functions
 to PPv2.2
In-Reply-To: <1482857677-16166-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482857677-16166-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1482857677-16166-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MVPP2_RXQ_CONFIG_REG register has a slightly different layout
between PPv2.1 and PPv2.2, so this commit adapts the functions modifying
this register to accommodate for both the PPv2.1 and PPv2.2 cases.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 160b787..8fc818d 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -50,9 +50,11 @@
 #define     MVPP2_SNOOP_PKT_SIZE_MASK		0x1ff
 #define     MVPP2_SNOOP_BUF_HDR_MASK		BIT(9)
 #define     MVPP2_RXQ_POOL_SHORT_OFFS		20
-#define     MVPP2_RXQ_POOL_SHORT_MASK		0x700000
+#define     MVPP21_RXQ_POOL_SHORT_MASK		0x700000
+#define     MVPP22_RXQ_POOL_SHORT_MASK		0xf00000
 #define     MVPP2_RXQ_POOL_LONG_OFFS		24
-#define     MVPP2_RXQ_POOL_LONG_MASK		0x7000000
+#define     MVPP21_RXQ_POOL_LONG_MASK		0x7000000
+#define     MVPP22_RXQ_POOL_LONG_MASK		0xf000000
 #define     MVPP2_RXQ_PACKET_OFFSET_OFFS	28
 #define     MVPP2_RXQ_PACKET_OFFSET_MASK	0x70000000
 #define     MVPP2_RXQ_DISABLE_MASK		BIT(31)
@@ -3762,17 +3764,20 @@ static int mvpp2_bm_init(struct platform_device *pdev, struct mvpp2 *priv)
 static void mvpp2_rxq_long_pool_set(struct mvpp2_port *port,
 				    int lrxq, int long_pool)
 {
-	u32 val;
+	u32 val, mask;
 	int prxq;
 
 	/* Get queue physical ID */
 	prxq = port->rxqs[lrxq]->id;
 
-	val = mvpp2_read(port->priv, MVPP2_RXQ_CONFIG_REG(prxq));
-	val &= ~MVPP2_RXQ_POOL_LONG_MASK;
-	val |= ((long_pool << MVPP2_RXQ_POOL_LONG_OFFS) &
-		    MVPP2_RXQ_POOL_LONG_MASK);
+	if (port->priv->hw_version == MVPP21)
+		mask = MVPP21_RXQ_POOL_LONG_MASK;
+	else
+		mask = MVPP22_RXQ_POOL_LONG_MASK;
 
+	val = mvpp2_read(port->priv, MVPP2_RXQ_CONFIG_REG(prxq));
+	val &= ~mask;
+	val |= (long_pool << MVPP2_RXQ_POOL_LONG_OFFS) & mask;
 	mvpp2_write(port->priv, MVPP2_RXQ_CONFIG_REG(prxq), val);
 }
 
@@ -3780,17 +3785,20 @@ static void mvpp2_rxq_long_pool_set(struct mvpp2_port *port,
 static void mvpp2_rxq_short_pool_set(struct mvpp2_port *port,
 				     int lrxq, int short_pool)
 {
-	u32 val;
+	u32 val, mask;
 	int prxq;
 
 	/* Get queue physical ID */
 	prxq = port->rxqs[lrxq]->id;
 
-	val = mvpp2_read(port->priv, MVPP2_RXQ_CONFIG_REG(prxq));
-	val &= ~MVPP2_RXQ_POOL_SHORT_MASK;
-	val |= ((short_pool << MVPP2_RXQ_POOL_SHORT_OFFS) &
-		    MVPP2_RXQ_POOL_SHORT_MASK);
+	if (port->priv->hw_version == MVPP21)
+		mask = MVPP21_RXQ_POOL_SHORT_MASK;
+	else
+		mask = MVPP22_RXQ_POOL_SHORT_MASK;
 
+	val = mvpp2_read(port->priv, MVPP2_RXQ_CONFIG_REG(prxq));
+	val &= ~mask;
+	val |= (short_pool << MVPP2_RXQ_POOL_SHORT_OFFS) & mask;
 	mvpp2_write(port->priv, MVPP2_RXQ_CONFIG_REG(prxq), val);
 }
 
-- 
2.7.4
