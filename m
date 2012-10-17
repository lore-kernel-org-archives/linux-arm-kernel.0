From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Oct 2012 15:39:54 -0000
Subject: [RFC/NOT FOR MERGING 4/5] i2c: omap: don't re-enable IRQs after
 masking them
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Message-ID: <1350488043-5053-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP I2C driver will re-enable IRQs right after
masking them during suspend.

That's not what we want. We want to keep IRQs
masked until our resume method is called.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..7eeae11 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1247,14 +1247,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 
 	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
 
-	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
-		iv = omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
-	} else {
-		omap_i2c_write_reg(_dev, OMAP_I2C_STAT_REG, _dev->iestate);
-
-		/* Flush posted write */
-		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
-	}
+	/* Flush posted write */
+	omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
 
 	return 0;
 }
-- 
1.8.0.rc0
