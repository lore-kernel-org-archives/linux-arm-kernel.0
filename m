From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 19 Jul 2012 20:08:07 +0530
Subject: [PATCHv5 17/18] i2c: omap: get rid of the "complete" label
In-Reply-To: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
References: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1342708688-2342-18-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

we can ack stat and complete the command from
the errata handling itself.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 05edae3..2e48da9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -772,6 +772,17 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 		if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
+			if (stat & OMAP_I2C_STAT_NACK) {
+				dev->cmd_err |= OMAP_I2C_STAT_NACK;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			}
+
+			if (stat & OMAP_I2C_STAT_AL) {
+				dev_err(dev->dev, "Arbitration lost\n");
+				dev->cmd_err |= OMAP_I2C_STAT_AL;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			}
+
 			return -EIO;
 		}
 
@@ -872,7 +883,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			goto out;
 		}
 
-complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
@@ -935,7 +945,7 @@ complete:
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
-				goto complete;
+				goto out;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
 			continue;
@@ -951,7 +961,7 @@ complete:
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
-				goto complete;
+				goto out;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
-- 
1.7.5.4
