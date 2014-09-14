From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 14 Sep 2014 18:11:28 +0100
Subject: [PATCH 3/5] spi-nor: Make spi_nor_scan() take a chip type name, not
 an spi_device_id
In-Reply-To: <1410714624.3040.38.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Message-ID: <1410714688.3040.41.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers currently call spi_nor_match_id() and then spi_nor_scan().
This adds a dependency on struct spi_device_id which we want to
avoid.  Make spi_nor_scan() do it for them.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/devices/m25p80.c      |  6 +-----
 drivers/mtd/spi-nor/fsl-quadspi.c |  7 +------
 drivers/mtd/spi-nor/spi-nor.c     | 29 +++++++++++++----------------
 include/linux/mtd/spi-nor.h       | 21 ++++-----------------
 4 files changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 3f0fe86..b547c39 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -196,7 +196,6 @@ static int m25p_probe(struct spi_device *spi)
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode = SPI_NOR_NORMAL;
-	const struct spi_device_id *id;
 	int ret;
 
 	flash = devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
@@ -224,10 +223,7 @@ static int m25p_probe(struct spi_device *spi)
 		mode = SPI_NOR_QUAD;
 	else if (spi->mode & SPI_RX_DUAL)
 		mode = SPI_NOR_DUAL;
-	id = spi_nor_match_id(spi_get_device_id(spi)->name);
-	if (WARN_ON(!id))
-		return -ENODEV;
-	ret = spi_nor_scan(nor, id, mode);
+	ret = spi_nor_scan(nor, spi_get_device_id(spi)->name, mode);
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
index 6f699c5..40d6f70 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -28,6 +28,8 @@
 
 #define JEDEC_MFR(_jedec_id)	((_jedec_id) >> 16)
 
+static const struct spi_device_id *spi_nor_match_id(const char *name);
+
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -908,9 +910,9 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
 
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode)
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 {
+	const struct spi_device_id	*id = NULL;
 	struct flash_info		*info;
 	struct flash_platform_data	*data;
 	struct device *dev = nor->dev;
@@ -930,21 +932,17 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	 */
 	data = dev_get_platdata(dev);
 	if (data && data->type) {
-		const struct spi_device_id *plat_id;
-
-		for (i = 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
-			plat_id = &spi_nor_ids[i];
-			if (strcmp(data->type, plat_id->name))
-				continue;
-			break;
-		}
-
-		if (i < ARRAY_SIZE(spi_nor_ids) - 1)
-			id = plat_id;
-		else
+		id = spi_nor_match_id(data->type);
+		if (!id)
 			dev_warn(dev, "unrecognized id %s\n", data->type);
 	}
 
+	if (!id && name)
+		id = spi_nor_match_id(name);
+
+	if (!id)
+		return -ENODEV;
+
 	info = (void *)id->driver_data;
 
 	if (info->jedec_id) {
@@ -1133,7 +1131,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
 
-const struct spi_device_id *spi_nor_match_id(const char *name)
+static const struct spi_device_id *spi_nor_match_id(const char *name)
 {
 	const struct spi_device_id *id = spi_nor_ids;
 
@@ -1144,7 +1142,6 @@ const struct spi_device_id *spi_nor_match_id(const char *name)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(spi_nor_match_id);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 66af67a..6f92b4b 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -184,31 +184,18 @@ struct spi_nor {
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
+ * The chip type name can be provided either through platform data or
+ * through the @name parameter.  Platform data takes precedence.
  *
  * Return: 0 for success, others for failure.
  */
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode);
-
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
-const struct spi_device_id *spi_nor_match_id(const char *name);
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
 
 #endif


-- 
Ben Hutchings
The world is coming to an end.	Please log off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140914/b3c0f038/attachment.sig>
