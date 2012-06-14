From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 19:24:20 +0300
Subject: [PATCH v2 10/17] i2c: omap: get rid of the "complete" label
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Message-ID: <1339691067-919-11-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we can ack stat and complete the command from
the errata handling itself.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 83ae06a..7171ea1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -893,7 +893,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			return IRQ_HANDLED;
 		}
 
-complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
@@ -957,10 +956,12 @@ complete:
 				num_bytes = dev->fifo_size;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
-				goto complete;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
+						OMAP_I2C_STAT_XDR);
+				omap_i2c_complete_cmd(dev, err);
+				return IRQ_HANDLED;
 			}
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
@@ -975,10 +976,12 @@ complete:
 				num_bytes = dev->fifo_size;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
-				goto complete;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
+						OMAP_I2C_STAT_XRDY);
+				omap_i2c_complete_cmd(dev, err);
+				return IRQ_HANDLED;
 			}
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
-- 
1.7.10.4
