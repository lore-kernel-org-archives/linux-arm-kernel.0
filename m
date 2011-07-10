From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 10 Jul 2011 15:35:13 +0800
Subject: [PATCH] mtd: dataflash: add device tree probe support
Message-ID: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for mtd_dataflash driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 drivers/mtd/devices/mtd_dataflash.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 8f6b02c..64d7242 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -24,6 +24,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 /*
  * DataFlash is a kind of SPI flash.  Most AT45 chips have two buffers in
@@ -98,6 +100,11 @@ struct dataflash {
 	struct mtd_info		mtd;
 };
 
+static const struct of_device_id dataflash_dt_ids[] = {
+	{ .compatible = "atmel,dataflash", },
+	{ /* sentinel */ }
+};
+
 /* ......................................................................... */
 
 /*
@@ -634,6 +641,7 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 {
 	struct dataflash		*priv;
 	struct mtd_info			*device;
+	struct mtd_part_parser_data	ppdata;
 	struct flash_platform_data	*pdata = spi->dev.platform_data;
 	char				*otp_tag = "";
 	int				err = 0;
@@ -675,7 +683,8 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 			pagesize, otp_tag);
 	dev_set_drvdata(&spi->dev, priv);
 
-	err = mtd_device_parse_register(device, NULL, 0,
+	ppdata.of_node = spi->dev.of_node;
+	err = mtd_device_parse_register(device, NULL, &ppdata,
 			pdata ? pdata->parts : NULL,
 			pdata ? pdata->nr_parts : 0);
 
@@ -926,6 +935,7 @@ static struct spi_driver dataflash_driver = {
 		.name		= "mtd_dataflash",
 		.bus		= &spi_bus_type,
 		.owner		= THIS_MODULE,
+		.of_match_table = dataflash_dt_ids,
 	},
 
 	.probe		= dataflash_probe,
-- 
1.7.4.1
