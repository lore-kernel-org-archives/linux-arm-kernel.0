From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:18 +0200
Subject: [PATCH 02/13] i2c: OMAP: Add DT support for i2c controller
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: G, Manjunath Kondaiah <manjugk@ti.com>

Add initial DT support to retrieve the frequency using a
DT attribute instead of the pdata pointer if CONFIG_OF is enabled.

These changes will not affect non DT builds and existing functionality
is retained.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
[b-cousson at ti.com: fix the wrong freq calculation]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2a072ff..4052279 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,6 +38,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_i2c.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
@@ -972,6 +973,16 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id omap_i2c_of_match[] = {
+	{.compatible = "ti,omap-i2c", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
+#else
+#define omap_i2c_of_match NULL
+#endif
+
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -1008,12 +1019,17 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
+	speed = 100;	/* Default speed */
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
-	} else {
-		speed = 100;	/* Default speed */
-		dev->set_mpu_wkup_lat = NULL;
+#if defined(CONFIG_OF)
+	} else if (pdev->dev.of_node) {
+		u32 prop;
+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+					  &prop))
+			speed = prop / 1000; /* convert Hz into kHz */
+#endif
 	}
 
 	dev->speed = speed;
@@ -1178,6 +1194,7 @@ static struct platform_driver omap_i2c_driver = {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
 		.pm	= OMAP_I2C_PM_OPS,
+		.of_match_table = omap_i2c_of_match,
 	},
 };
 
-- 
1.7.0.4
