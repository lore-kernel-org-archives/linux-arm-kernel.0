From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Jul 2011 16:38:56 +0800
Subject: [PATCH v3] mtd: dataflash: add device tree probe support
In-Reply-To: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310719136-21565-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for mtd_dataflash driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
Changes since v2:
 * Change compatible string to "at45" from "at45xxx"
 * Add "#ifdef CONFIG_OF" for dataflash_dt_ids

Changes since v1:
 * Add "atmel,at45xxx" into the match table
 * Add binding document

 .../devicetree/bindings/mtd/atmel-dataflash.txt    |   14 ++++++++++++++
 drivers/mtd/devices/mtd_dataflash.c                |   18 ++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-dataflash.txt

diff --git a/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
new file mode 100644
index 0000000..ef66ddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
@@ -0,0 +1,14 @@
+* Atmel Data Flash
+
+Required properties:
+- compatible : "atmel,<model>", "atmel,<series>", "atmel,dataflash".
+
+Example:
+
+flash at 1 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+	spi-max-frequency = <25000000>;
+	reg = <1>;
+};
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 8f6b02c..c86fa57 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -17,6 +17,8 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/math64.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -24,7 +26,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
-
 /*
  * DataFlash is a kind of SPI flash.  Most AT45 chips have two buffers in
  * each chip, which may be used for double buffered I/O; but this driver
@@ -98,6 +99,16 @@ struct dataflash {
 	struct mtd_info		mtd;
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id dataflash_dt_ids[] = {
+	{ .compatible = "atmel,at45", },
+	{ .compatible = "atmel,dataflash", },
+	{ /* sentinel */ }
+};
+#else
+#define dataflash_dt_ids NULL
+#endif
+
 /* ......................................................................... */
 
 /*
@@ -634,6 +645,7 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 {
 	struct dataflash		*priv;
 	struct mtd_info			*device;
+	struct mtd_part_parser_data	ppdata;
 	struct flash_platform_data	*pdata = spi->dev.platform_data;
 	char				*otp_tag = "";
 	int				err = 0;
@@ -675,7 +687,8 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 			pagesize, otp_tag);
 	dev_set_drvdata(&spi->dev, priv);
 
-	err = mtd_device_parse_register(device, NULL, 0,
+	ppdata.of_node = spi->dev.of_node;
+	err = mtd_device_parse_register(device, NULL, &ppdata,
 			pdata ? pdata->parts : NULL,
 			pdata ? pdata->nr_parts : 0);
 
@@ -926,6 +939,7 @@ static struct spi_driver dataflash_driver = {
 		.name		= "mtd_dataflash",
 		.bus		= &spi_bus_type,
 		.owner		= THIS_MODULE,
+		.of_match_table = dataflash_dt_ids,
 	},
 
 	.probe		= dataflash_probe,
-- 
1.7.4.1
