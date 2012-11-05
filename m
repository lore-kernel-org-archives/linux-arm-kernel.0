From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 5 Nov 2012 17:53:43 +0530
Subject: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently after the reset the sysc is written with hardcoded values.
The patch reads the sysc register and writes back the same value
after reset.

- Some unnecessary rev checks can be optimised.
- Also due to whatever reason the hwmod flags are changed
we will not reset the values.
- In some of the cases the minor values of the 2430 register
is different(0x37) in that case the autoidle setting may be missed.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 25f1564..a09acdc 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -302,7 +302,11 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
 static int omap_i2c_reset(struct omap_i2c_dev *dev)
 {
 	unsigned long timeout;
+	u16 sysc;
+
 	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
+		sysc = omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG);
+
 		/* Disable I2C controller before soft reset */
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
 			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
@@ -324,22 +328,8 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
 		}
 
 		/* SYSC register is cleared by the reset; rewrite it */
-		if (dev->rev == OMAP_I2C_REV_ON_2430) {
-
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
-					   SYSC_AUTOIDLE_MASK);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, sysc);
 
-		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
-			dev->syscstate = SYSC_AUTOIDLE_MASK;
-			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
-			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
-			      __ffs(SYSC_SIDLEMODE_MASK));
-			dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
-			      __ffs(SYSC_CLOCKACTIVITY_MASK));
-
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
-							dev->syscstate);
-		}
 	}
 	return 0;
 }
-- 
1.7.5.4
