From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 15:43:35 +0530
Subject: [PATCHv3 15/17] i2c: omap: simplify IRQ exit path
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340964817-8599-16-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

instead of having multiple return points, use
a goto statement to make that clearer.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2cd3b9a..1196417 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -873,24 +873,21 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
 		if (count++ == 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		/*
@@ -903,8 +900,7 @@ complete:
 						OMAP_I2C_STAT_XRDY |
 						OMAP_I2C_STAT_XDR |
 						OMAP_I2C_STAT_ARDY));
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		if (stat & OMAP_I2C_STAT_RDR) {
@@ -973,19 +969,19 @@ complete:
 			dev_err(dev->dev, "Receive overrun\n");
 			err |= OMAP_I2C_STAT_ROVR;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ROVR);
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
 			err |= OMAP_I2C_STAT_XUDF;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF);
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
+			goto out;
 		}
 	} while (stat);
 
+out:
+	omap_i2c_complete_cmd(dev, err);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.5.4
