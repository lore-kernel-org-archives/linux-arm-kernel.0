From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Mon, 28 Dec 2015 14:02:17 +0200
Subject: [PATCH v3 1/3] wlcore/wl12xx: spi: add power operation function
In-Reply-To: <1451304139-10899-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1451304139-10899-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1451304139-10899-2-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power function uses a consumer regulator access to update the WiFi
enable GPIO value.

Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
---
v1 -> v2: oops fix was removed to a separate fix.
v2 -> v3: no changes

 drivers/net/wireless/ti/wlcore/spi.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 44f059f..d3a4bcb 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/wl12xx.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "wlcore.h"
 #include "wl12xx_80211.h"
@@ -81,6 +82,7 @@
 struct wl12xx_spi_glue {
 	struct device *dev;
 	struct platform_device *core;
+	struct regulator *reg; /* Power regulator */
 };
 
 static void wl12xx_spi_reset(struct device *child)
@@ -318,11 +320,40 @@ static int __must_check wl12xx_spi_raw_write(struct device *child, int addr,
 	return 0;
 }
 
+/**
+ * wl12xx_spi_set_power - power on/off the wl12xx unit
+ * @child: wl12xx device handle.
+ * @enable: true/false to power on/off the unit.
+ *
+ * use the WiFi enable regulator to enable/disable the WiFi unit.
+ */
+static int wl12xx_spi_set_power(struct device *child, bool enable)
+{
+	int ret = 0;
+	struct wl12xx_spi_glue *glue = dev_get_drvdata(child->parent);
+
+	WARN_ON(!glue->reg);
+
+	/* Update regulator state */
+	if (enable) {
+		ret = regulator_enable(glue->reg);
+		if (ret)
+			dev_err(child, "Power enable failure\n");
+	} else {
+		ret =  regulator_disable(glue->reg);
+		if (ret)
+			dev_err(child, "Power disable failure\n");
+	}
+
+	return ret;
+}
+
 static struct wl1271_if_operations spi_ops = {
 	.read		= wl12xx_spi_raw_read,
 	.write		= wl12xx_spi_raw_write,
 	.reset		= wl12xx_spi_reset,
 	.init		= wl12xx_spi_init,
+	.power		= wl12xx_spi_set_power,
 	.set_block_size = NULL,
 };
 
@@ -353,6 +384,12 @@ static int wl1271_probe(struct spi_device *spi)
 	 * comes from the board-peripherals file */
 	spi->bits_per_word = 32;
 
+	glue->reg = devm_regulator_get(&spi->dev, "vwlan");
+	if (IS_ERR(glue->reg)) {
+		dev_err(glue->dev, "can't get regulator\n");
+		return PTR_ERR(glue->reg);
+	}
+
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(glue->dev, "spi_setup failed\n");
-- 
2.5.0
