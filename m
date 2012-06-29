From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 15:43:27 +0530
Subject: [PATCHv3 07/17] i2c: omap: improve i462 errata handling
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340964817-8599-8-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

Make it not depend on ISR's local variables
in order to make it easier to re-factor the
transmit data loop.
Also since we are waiting for XUDF just before
writing data lets not flag the underflow.
This is anyways going to go once we write
the data.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   43 ++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 45bd731..870452d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -744,27 +744,30 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
  * data to DATA_REG. Otherwise some data bytes can be lost while transferring
  * them from the memory to the I2C interface.
  */
-static int errata_omap3_i462(struct omap_i2c_dev *dev, u16 *stat, int *err)
+static int errata_omap3_i462(struct omap_i2c_dev *dev)
 {
 	unsigned long timeout = 10000;
+	u16 stat;
 
-	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
-		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
+	do {
+		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		if (stat & OMAP_I2C_STAT_XUDF)
+			break;
+
+		if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
-			return -ETIMEDOUT;
+			return -EIO;
 		}
 
 		cpu_relax();
-		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-	}
+	} while (--timeout);
 
 	if (!timeout) {
 		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
 		return 0;
 	}
 
-	*err |= OMAP_I2C_STAT_XUDF;
 	return 0;
 }
 
@@ -926,9 +929,16 @@ complete:
 					}
 				}
 
-				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
-				    errata_omap3_i462(dev, &stat, &err))
-					goto complete;
+				if (dev->errata & I2C_OMAP_ERRATA_I462) {
+					int ret;
+
+					ret = errata_omap3_i462(dev);
+					stat = omap_i2c_read_reg(dev,
+							OMAP_I2C_STAT_REG);
+
+					if (ret < 0)
+						goto complete;
+				}
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
@@ -966,9 +976,16 @@ complete:
 					}
 				}
 
-				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
-				    errata_omap3_i462(dev, &stat, &err))
-					goto complete;
+				if (dev->errata & I2C_OMAP_ERRATA_I462) {
+					int ret;
+
+					ret = errata_omap3_i462(dev);
+					stat = omap_i2c_read_reg(dev,
+							OMAP_I2C_STAT_REG);
+
+					if (ret < 0)
+						goto complete;
+				}
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-- 
1.7.5.4
