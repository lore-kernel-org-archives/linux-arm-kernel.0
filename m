From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 16 Aug 2012 19:33:41 +0530
Subject: [PATCHv7 10/24] i2c: omap: ack IRQ in parts
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1345125835-15524-11-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

According to flow diagrams on OMAP TRMs,
we should ACK the IRQ as they happen.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[Ack the stat OMAP_I2C_STAT_AL in case of arbitration lost]
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8b80799..0adbfb1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -850,21 +850,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		}
 
 complete:
-		/*
-		 * Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
-		 * acked after the data operation is complete.
-		 * Ref: TRM SWPU114Q Figure 18-31
-		 */
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
-				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
-				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-
-		if (stat & OMAP_I2C_STAT_NACK)
+		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		/*
@@ -941,12 +939,18 @@ complete:
 
 		if (stat & OMAP_I2C_STAT_ROVR) {
 			dev_err(dev->dev, "Receive overrun\n");
-			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
+			err |= OMAP_I2C_STAT_ROVR;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ROVR);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
-			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
+			err |= OMAP_I2C_STAT_XUDF;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 	} while (stat);
 
-- 
1.7.5.4
