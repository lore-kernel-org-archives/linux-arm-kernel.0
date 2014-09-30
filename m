From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 03:15:17 +0100
Subject: [PATCH v2 3/5] spi-nor: Make spi_nor_scan() take a chip type name,
 not an spi_device_id
In-Reply-To: <1412043222.9388.81.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
Message-ID: <1412043317.9388.84.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers currently call spi_nor_match_id() and then spi_nor_scan().
This adds a dependency on struct spi_device_id which we want to
avoid.  Make spi_nor_scan() do it for them.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/devices/m25p80.c      | 13 +++++--------
 drivers/mtd/spi-nor/fsl-quadspi.c |  7 +------
 drivers/mtd/spi-nor/spi-nor.c     | 13 +++++++++----
 include/linux/mtd/spi-nor.h       | 20 ++------------------
 4 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 204bec1..d9578b9 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -193,7 +193,7 @@ static int m25p_probe(struct spi_device *spi)
 {
 	struct mtd_part_parser_data	ppdata;
 	struct flash_platform_data	*data;
-	const struct spi_device_id *id = NULL;
+	const char *name = NULL;
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode = SPI_NOR_NORMAL;
@@ -236,16 +236,13 @@ static int m25p_probe(struct spi_device *spi)
 	 * If that's the case, respect "type" and ignore a "name".
 	 */
 	if (data && data->type)
-		id = spi_nor_match_id(data->type);
+		name = data->type;
 
 	/* If we didn't get name from platform, simply use "modalias". */
-	if (!id) {
-		id = spi_nor_match_id(spi_get_device_id(spi)->name);
-		if (WARN_ON(!id))
-			return -ENODEV;
-	}
+	if (!name)
+		name = spi_get_device_id(spi)->name;
 
-	ret = spi_nor_scan(nor, id, mode);
+	ret = spi_nor_scan(nor, name, mode);
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
index c2f0573..171c665 100644
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
 	struct device *dev = nor->dev;
 	struct mtd_info *mtd = nor->mtd;
@@ -922,6 +924,10 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	if (ret)
 		return ret;
 
+	id = spi_nor_match_id(name);
+	if (!id)
+		return -ENODEV;
+
 	info = (void *)id->driver_data;
 
 	if (info->jedec_id) {
@@ -1110,7 +1116,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
 
-const struct spi_device_id *spi_nor_match_id(const char *name)
+static const struct spi_device_id *spi_nor_match_id(const char *name)
 {
 	const struct spi_device_id *id = spi_nor_ids;
 
@@ -1121,7 +1127,6 @@ const struct spi_device_id *spi_nor_match_id(const char *name)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(spi_nor_match_id);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 66af67a..c48ad49 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -184,31 +184,15 @@ struct spi_nor {
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
- *
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
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/f32af4c5/attachment.sig>
