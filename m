From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 6 Aug 2015 15:22:11 +0800
Subject: [PATCH v2 2/2] i2c: mediatek: Fixup i2c ack error interrupt handling
In-Reply-To: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
References: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1438845731-17805-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When occur i2c ack error, i2c controller generate two interrupts,
first is the ack error interrupt, then the complete interrupt.
i2c interrupt handler should keep the two interrupt value, and only
call complete() for the complete interrupt.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index e28ad4c..c02e6c0 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -557,15 +557,22 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 {
 	struct mtk_i2c *i2c = dev_id;
 	u16 restart_flag = 0;
+	u16 intr_stat;
 
 	if (i2c->dev_comp->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
-	i2c->irq_stat = readw(i2c->base + OFFSET_INTR_STAT);
-	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR
-		| I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
+	intr_stat = readw(i2c->base + OFFSET_INTR_STAT);
+	writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
 
-	complete(&i2c->msg_complete);
+	/*
+	 * when occurs ack error, i2c controller generate two interrupts
+	 * first is the ack error interrupt, then the complete interrupt
+	 * i2c->irq_stat need keep the two interrupt value.
+	 */
+	i2c->irq_stat |= intr_stat;
+	if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
+		complete(&i2c->msg_complete);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.9.5
