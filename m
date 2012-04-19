From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 19 Apr 2012 18:58:19 +0530
Subject: [PATCHv8 08/10] I2C: OMAP: fix missing handling of errata
 I2C_OMAP3_1P153
In-Reply-To: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1334842101-20670-9-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tasslehoff Kjappfot <tasskjapp@gmail.com>

i2c_probe set the dev->errata flag, but omap_i2c_init cleared the flag again.
Move the errata handling to i2c_probe.

Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d555dcd..9323201 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -427,11 +427,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
-	dev->errata = 0;
-
-	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
-		dev->errata |= I2C_OMAP_ERRATA_I207;
-
 	/* Enable interrupts */
 	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
@@ -1023,6 +1018,11 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
+	dev->errata = 0;
+
+	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
+		dev->errata |= I2C_OMAP_ERRATA_I207;
+
 	if (dev->rev <= OMAP_I2C_REV_ON_3430)
 		dev->errata |= I2C_OMAP3_1P153;
 
-- 
1.7.5.4
