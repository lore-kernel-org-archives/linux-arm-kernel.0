From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Mon, 29 Sep 2014 11:47:54 +0200
Subject: [PATCH 2/2] mtd: spi-nor: make spi_nor_scan() take a chip type name,
 not spi_device_id
In-Reply-To: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
Message-ID: <1411984074-3850-2-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Hutchings <ben@decadent.org.uk>

Drivers currently call spi_nor_match_id() and then spi_nor_scan().
This adds a dependency on struct spi_device_id which we want to
avoid.  Make spi_nor_scan() do it for them.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/mtd/devices/m25p80.c      |  4 +---
 drivers/mtd/spi-nor/fsl-quadspi.c |  7 +------
 drivers/mtd/spi-nor/spi-nor.c     | 13 +++++++++----
 include/linux/mtd/spi-nor.h       | 20 +++-----------------
 4 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 822209d..bd5e4c6 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -193,7 +193,6 @@ static int m25p_probe(struct spi_device *spi)
 {
 	struct mtd_part_parser_data	ppdata;
 	struct flash_platform_data	*data;
-	const struct spi_device_id *id = NULL;
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode = SPI_NOR_NORMAL;
@@ -241,8 +240,7 @@ static int m25p_probe(struct spi_device *spi)
 	else
 		flash_name = spi->modalias;
 
-	id = spi_nor_match_id(flash_name);
-	ret = spi_nor_scan(nor, id, mode);
+	ret = spi_nor_scan(nor, flash_name, mode);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 8d659a2..d5269a2 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -881,7 +881,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
-		const struct spi_device_id *id;
 		char modalias[40];
 
 		/* skip the holes */
@@ -909,10 +908,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		if (of_modalias_node(np, modalias, sizeof(modalias)) < 0)
 			goto map_failed;
 
-		id = spi_nor_match_id(modalias);
-		if (!id)
-			goto map_failed;
-
 		ret = of_property_read_u32(np, "spi-max-frequency",
 				&q->clk_rate);
 		if (ret < 0)
@@ -921,7 +916,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
-		ret = spi_nor_scan(nor, id, SPI_NOR_QUAD);
+		ret = spi_nor_scan(nor, modalias, SPI_NOR_QUAD);
 		if (ret)
 			goto map_failed;
 
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ae16aa2..5c8e399 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -28,6 +28,8 @@
 
 #define JEDEC_MFR(_jedec_id)	((_jedec_id) >> 16)
 
+static const struct spi_device_id *spi_nor_match_id(const char *name);
+
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -911,9 +913,9 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
 
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode)
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 {
+	const struct spi_device_id	*id = NULL;
 	struct flash_info		*info;
 	struct device *dev = nor->dev;
 	struct mtd_info *mtd = nor->mtd;
@@ -925,6 +927,10 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	if (ret)
 		return ret;
 
+	id = spi_nor_match_id(name);
+	if (!id)
+		return -ENOENT;
+
 	info = (void *)id->driver_data;
 
 	if (info->jedec_id) {
@@ -1113,7 +1119,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
 
-const struct spi_device_id *spi_nor_match_id(char *name)
+static const struct spi_device_id *spi_nor_match_id(const char *name)
 {
 	const struct spi_device_id *id = spi_nor_ids;
 
@@ -1124,7 +1130,6 @@ const struct spi_device_id *spi_nor_match_id(char *name)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(spi_nor_match_id);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 9e6294f..a5a7a08 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -187,32 +187,18 @@ struct spi_nor {
 /**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
- * @id:		the spi_device_id provided by the driver
+ * @name:	the chip type name
  * @mode:	the read mode supported by the driver
  *
  * The drivers can use this fuction to scan the SPI NOR.
  * In the scanning, it will try to get all the necessary information to
  * fill the mtd_info{} and the spi_nor{}.
  *
- * The board may assigns a spi_device_id with @id which be used to compared with
- * the spi_device_id detected by the scanning.
+ * The chip type name can be provided through the @name parameter.
  *
  * Return: 0 for success, others for failure.
  */
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode);
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
 extern const struct spi_device_id spi_nor_ids[];
 
-/**
- * spi_nor_match_id() - find the spi_device_id by the name
- * @name:	the name of the spi_device_id
- *
- * The drivers use this function to find the spi_device_id
- * specified by the @name.
- *
- * Return: returns the right spi_device_id pointer on success,
- *         and returns NULL on failure.
- */
-const struct spi_device_id *spi_nor_match_id(char *name);
-
 #endif
-- 
1.8.4.5
