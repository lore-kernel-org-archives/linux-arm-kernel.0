From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 15:43:32 +0530
Subject: [PATCHv3 12/17] i2c: omap: bus: add a receiver flag
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340964817-8599-13-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

that way we can ignore TX IRQs while in receiver
mode and ignore RX IRQs while in transmitter mode.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9f04976..00d5adc 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -196,6 +196,7 @@ struct omap_i2c_dev {
 						 */
 	u8			rev;
 	unsigned		b_hw:1;		/* bad h/w fixes */
+	unsigned		receiver:1;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
 	u16			pscstate;
 	u16			scllstate;
@@ -512,6 +513,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
+	dev->receiver = !!(msg->flags & I2C_M_RD);
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
@@ -856,6 +858,13 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 		stat &= bits;
 
+		/* If we're in receiver mode, ignore XDR/XRDY */
+		if (dev->receiver) {
+			stat &= ~(OMAP_I2C_STAT_XDR | OMAP_I2C_STAT_XRDY);
+		} else {
+			stat &= ~(OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_RRDY);
+		}
+
 		if (!stat) {
 			/* my work here is done */
 			return IRQ_HANDLED;
-- 
1.7.5.4
