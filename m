From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 3 Apr 2012 21:32:34 +0530
Subject: [PATCHv5 15/18] I2C: OMAP: make the read ready processing a separate
 function
In-Reply-To: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>
References: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1333468957-5999-16-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Makes the read ready processing a separate
function. This is to avoid extremely long level of indentation.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   86 +++++++++++++++++++++-------------------
 1 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a5b1ec1..c113f41 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -784,6 +784,49 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 	return 0;
 }
 
+static int process_read_rdy(struct omap_i2c_dev *dev)
+{
+	u8 num_bytes = 1;
+	u16 stat, w;
+
+	if (dev->errata & I2C_OMAP_ERRATA_I207)
+		i2c_omap_errata_i207(dev, stat);
+
+	if (dev->fifo_size) {
+		if (stat & OMAP_I2C_STAT_RRDY)
+			num_bytes = dev->fifo_size;
+		else    /* read RXSTAT on RDR interrupt */
+			num_bytes = (omap_i2c_read_reg(dev,
+					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
+	}
+	while (num_bytes) {
+		num_bytes--;
+		w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
+		if (dev->buf_len) {
+			*dev->buf++ = w;
+			dev->buf_len--;
+			/*
+			 * Data reg in 2430, omap3 and omap4 is 8 bit wide
+			 */
+			if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
+				if (dev->buf_len) {
+					*dev->buf++ = w >> 8;
+					dev->buf_len--;
+				}
+			}
+		} else {
+			if (stat & OMAP_I2C_STAT_RRDY)
+				dev_err(dev->dev,
+					"RRDY IRQ while no data requested\n");
+			if (stat & OMAP_I2C_STAT_RDR)
+				dev_err(dev->dev,
+					"RDR IRQ while no data requested\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
 {
@@ -834,48 +877,9 @@ complete:
 			return IRQ_HANDLED;
 		}
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
-			u8 num_bytes = 1;
-
-			if (dev->errata & I2C_OMAP_ERRATA_I207)
-				i2c_omap_errata_i207(dev, stat);
+			if (process_read_rdy(dev) == -EIO)
+				break;
 
-			if (dev->fifo_size) {
-				if (stat & OMAP_I2C_STAT_RRDY)
-					num_bytes = dev->fifo_size;
-				else    /* read RXSTAT on RDR interrupt */
-					num_bytes = (omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG)
-							>> 8) & 0x3F;
-			}
-			while (num_bytes) {
-				num_bytes--;
-				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-				if (dev->buf_len) {
-					*dev->buf++ = w;
-					dev->buf_len--;
-					/*
-					 * Data reg in 2430, omap3 and
-					 * omap4 is 8 bit wide
-					 */
-					if (dev->flags &
-						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
-						if (dev->buf_len) {
-							*dev->buf++ = w >> 8;
-							dev->buf_len--;
-						}
-					}
-				} else {
-					if (stat & OMAP_I2C_STAT_RRDY)
-						dev_err(dev->dev,
-							"RRDY IRQ while no data"
-								" requested\n");
-					if (stat & OMAP_I2C_STAT_RDR)
-						dev_err(dev->dev,
-							"RDR IRQ while no data"
-								" requested\n");
-					break;
-				}
-			}
 			omap_i2c_ack_stat(dev,
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
 			continue;
-- 
1.7.1
