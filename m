From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Tue, 15 Dec 2015 15:22:26 +0800
Subject: [PATCH v3] i2c: mediatek: fix i2c multi transfer issue in high speed
 mode
Message-ID: <1450164146-28995-1-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For mt8173 platform with auto restart support, when doing i2c multi
transfer in high speed, we should ignore the first restart irq after
the master code, otherwise the first transfer will be discarded.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>
---
Change in v3:
ignore the first restart irq after the master code when doing
i2c multi transfer in high speed.

change in v2:
fix i2c checkpatch error.

---
 drivers/i2c/busses/i2c-mt65xx.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index dc4aac6..aec8e6c 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -155,6 +155,7 @@ struct mtk_i2c {
 	u16 timing_reg;
 	u16 high_speed_reg;
 	unsigned char auto_restart;
+	bool ignore_restart_irq;
 	const struct mtk_i2c_compatible *dev_comp;
 };
 
@@ -539,6 +540,14 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		}
 	}
 
+	if (i2c->auto_restart && num >= 2 && i2c->speed_hz > MAX_FS_MODE_SPEED)
+		/* ignore the first restart irq after the master code,
+		 * otherwise the first transfer will be discarded.
+		 */
+		i2c->ignore_restart_irq = true;
+	else
+		i2c->ignore_restart_irq = false;
+
 	while (left_num--) {
 		if (!msgs->buf) {
 			dev_dbg(i2c->dev, "data buffer is NULL.\n");
@@ -592,8 +601,16 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 	 * i2c->irq_stat need keep the two interrupt value.
 	 */
 	i2c->irq_stat |= intr_stat;
-	if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
-		complete(&i2c->msg_complete);
+
+	if (i2c->ignore_restart_irq && (i2c->irq_stat & restart_flag)) {
+		i2c->ignore_restart_irq = false;
+		i2c->irq_stat = 0;
+		writew(I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG | I2C_TRANSAC_START,
+		       i2c->base + OFFSET_START);
+	} else {
+		if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
+			complete(&i2c->msg_complete);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.8.1.1.dirty
