From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 14 Aug 2012 19:48:59 +0530
Subject: [PATCHv6 17/24] i2c: omap: get rid of the "complete" label
In-Reply-To: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1344953946-13005-18-git-send-email-shubhrajyoti@ti.com>
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
index dfbf667..dfdcc2b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -775,6 +775,17 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
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
 
@@ -875,7 +886,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			goto out;
 		}
 
-complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
@@ -938,7 +948,7 @@ complete:
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
-				goto complete;
+				goto out;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
 			continue;
@@ -954,7 +964,7 @@ complete:
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
-				goto complete;
+				goto out;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
-- 
1.7.5.4
