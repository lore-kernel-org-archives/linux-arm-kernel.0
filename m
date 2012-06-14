From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 13:20:39 +0300
Subject: [PATCH 06/17] i2c: omap: improve 1p153 errata handling
In-Reply-To: <1339669250-9183-1-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
Message-ID: <1339669250-9183-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it not depend on ISR's local variables
in order to make it easier to re-factor the
transmit data loop.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   47 +++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0661ca1..52861c2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -768,21 +768,24 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
  * data to DATA_REG. Otherwise some data bytes can be lost while transferring
  * them from the memory to the I2C interface.
  */
-static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
+static int errata_omap3_1p153(struct omap_i2c_dev *dev)
 {
-	unsigned long timeout = 10000;
+	unsigned long	timeout = 10000;
+	u16		stat;
 
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
-			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
 
 		cpu_relax();
-		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-	}
+	} while (--timeout);
 
 	if (!timeout) {
 		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
@@ -946,9 +949,18 @@ complete:
 					}
 				}
 
-				if ((dev->errata & I2C_OMAP3_1P153) &&
-				    errata_omap3_1p153(dev, &stat, &err))
-					goto complete;
+				if (dev->errata & I2C_OMAP3_1P153) {
+					int ret;
+
+					ret = errata_omap3_1p153(dev);
+					stat = omap_i2c_read_reg(dev,
+							OMAP_I2C_STAT_REG);
+
+					if (ret < 0) {
+						err |= OMAP_I2C_STAT_XUDF;
+						goto complete;
+					}
+				}
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
@@ -986,9 +998,18 @@ complete:
 					}
 				}
 
-				if ((dev->errata & I2C_OMAP3_1P153) &&
-				    errata_omap3_1p153(dev, &stat, &err))
-					goto complete;
+				if (dev->errata & I2C_OMAP3_1P153) {
+					int ret;
+
+					ret = errata_omap3_1p153(dev);
+					stat = omap_i2c_read_reg(dev,
+							OMAP_I2C_STAT_REG);
+
+					if (ret < 0) {
+						err |= OMAP_I2C_STAT_XUDF;
+						goto complete;
+					}
+				}
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-- 
1.7.10.4
