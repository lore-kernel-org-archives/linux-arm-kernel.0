From: stefan@agner.ch (Stefan Agner)
Date: Tue, 15 Jul 2014 14:56:20 +0200
Subject: [PATCH v3 3/4] can: flexcan: switch on clocks before accessing ecr
 register
In-Reply-To: <cover.1405428166.git.stefan@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
Message-ID: <c80f9d2ec80d01088e51be61a4e7845cbfe58f6a.1405428166.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
[stefan at agner.ch: added return check for clk_enable_prepare]

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/net/can/flexcan.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f425ec2..89745aa 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -383,12 +383,26 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg = flexcan_read(&regs->ecr);
+	u32 reg, err;
+
+	err = clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->clk_per);
+	if (err)
+		goto out_disable_ipg;
+
+	reg = flexcan_read(&regs->ecr);
 
 	bec->txerr = (reg >> 0) & 0xff;
 	bec->rxerr = (reg >> 8) & 0xff;
 
-	return 0;
+	clk_disable_unprepare(priv->clk_per);
+ out_disable_ipg:
+	clk_disable_unprepare(priv->clk_ipg);
+
+	return err;
 }
 
 static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.0.1
