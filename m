From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 15:43:23 +0530
Subject: [PATCHv3 03/17] i2c: omap: decrease indentation level on data handling
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340964817-8599-4-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

The patch intends to decrease the indentation level on the
data handling
by using the fact that else of if (dev->buf_len) is same as
if (!dev->buf_len)

if (dev->buf_len) {
	aaa;
} else {
	bbb;
	break;
}

to

if (!dev->buf_len) {
        bbb;
        break;
}
aaa;

Hence no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Changelogs updated.
 drivers/i2c/busses/i2c-omap.c |   63 ++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1df2bc9..f67e998 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -832,22 +832,7 @@ complete:
 							>> 8) & 0x3F;
 			}
 			while (num_bytes--) {
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
+				if (!dev->buf_len) {
 					if (stat & OMAP_I2C_STAT_RRDY)
 						dev_err(dev->dev,
 							"RRDY IRQ while no data"
@@ -858,6 +843,21 @@ complete:
 								" requested\n");
 					break;
 				}
+
+				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
+				*dev->buf++ = w;
+				dev->buf_len--;
+				/*
+				 * Data reg in 2430, omap3 and
+				 * omap4 is 8 bit wide
+				 */
+				if (dev->flags &
+						OMAP_I2C_FLAG_16BIT_DATA_REG) {
+					if (dev->buf_len) {
+						*dev->buf++ = w >> 8;
+						dev->buf_len--;
+					}
+				}
 			}
 			omap_i2c_ack_stat(dev,
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
@@ -874,22 +874,7 @@ complete:
 							& 0x3F;
 			}
 			while (num_bytes--) {
-				w = 0;
-				if (dev->buf_len) {
-					w = *dev->buf++;
-					dev->buf_len--;
-					/*
-					 * Data reg in 2430, omap3 and
-					 * omap4 is 8 bit wide
-					 */
-					if (dev->flags &
-						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
-						if (dev->buf_len) {
-							w |= *dev->buf++ << 8;
-							dev->buf_len--;
-						}
-					}
-				} else {
+				if (!dev->buf_len) {
 					if (stat & OMAP_I2C_STAT_XRDY)
 						dev_err(dev->dev,
 							"XRDY IRQ while no "
@@ -901,6 +886,20 @@ complete:
 					break;
 				}
 
+				w = *dev->buf++;
+				dev->buf_len--;
+				/*
+				 * Data reg in 2430, omap3 and
+				 * omap4 is 8 bit wide
+				 */
+				if (dev->flags &
+						OMAP_I2C_FLAG_16BIT_DATA_REG) {
+					if (dev->buf_len) {
+						w |= *dev->buf++ << 8;
+						dev->buf_len--;
+					}
+				}
+
 				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
 				    errata_omap3_i462(dev, &stat, &err))
 					goto complete;
-- 
1.7.5.4
