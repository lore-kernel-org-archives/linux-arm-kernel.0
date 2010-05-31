From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 31 May 2010 18:24:34 +0200
Subject: [PATCH] ixp4xx: add support for static flash partitions
Message-ID: <20100531162434.GA4599@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for static flash partitioning from a platform
device. Also, we clean up some weirdness where statements were separated
by commas instead of semicolons. While we are at it, fix some minor bad
white space, too.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 drivers/mtd/maps/ixp4xx.c |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
index 7b05152..5345d11 100644
--- a/drivers/mtd/maps/ixp4xx.c
+++ b/drivers/mtd/maps/ixp4xx.c
@@ -108,7 +108,7 @@ static void ixp4xx_copy_from(struct map_info *map, void *to,
 
 	if (from & 1) {
 		*dest++ = BYTE1(flash_read16(src));
-                src++;
+		src++;
 		--len;
 	}
 
@@ -118,7 +118,7 @@ static void ixp4xx_copy_from(struct map_info *map, void *to,
 		*dest++ = BYTE1(data);
 		src += 2;
 		len -= 2;
-        }
+	}
 
 	if (len > 0)
 		*dest++ = BYTE0(flash_read16(src));
@@ -185,6 +185,8 @@ static int ixp4xx_flash_probe(struct platform_device *dev)
 {
 	struct flash_platform_data *plat = dev->dev.platform_data;
 	struct ixp4xx_flash_info *info;
+	const char *part_type = NULL;
+	int nr_parts = 0;
 	int err = -1;
 
 	if (!plat)
@@ -219,9 +221,9 @@ static int ixp4xx_flash_probe(struct platform_device *dev)
 	 */
 	info->map.bankwidth = 2;
 	info->map.name = dev_name(&dev->dev);
-	info->map.read = ixp4xx_read16,
-	info->map.write = ixp4xx_probe_write16,
-	info->map.copy_from = ixp4xx_copy_from,
+	info->map.read = ixp4xx_read16;
+	info->map.write = ixp4xx_probe_write16;
+	info->map.copy_from = ixp4xx_copy_from;
 
 	info->res = request_mem_region(dev->resource->start,
 			resource_size(dev->resource),
@@ -249,11 +251,28 @@ static int ixp4xx_flash_probe(struct platform_device *dev)
 	info->mtd->owner = THIS_MODULE;
 
 	/* Use the fast version */
-	info->map.write = ixp4xx_write16,
+	info->map.write = ixp4xx_write16;
+
+#ifdef CONFIG_MTD_PARTITIONS
+	nr_parts = parse_mtd_partitions(info->mtd, probes, &info->partitions,
+					dev->resource->start);
+#endif
+	if (nr_parts > 0) {
+		part_type = "dynamic";
+	} else {
+		info->partitions = plat->parts;
+		nr_parts = plat->nr_parts;
+		part_type = "static";
+	}
+	if (nr_parts == 0) {
+		printk(KERN_NOTICE "IXP4xx flash: no partition info "
+			"available, registering whole flash\n");
+		err = add_mtd_device(info->mtd);
+	} else {
+		printk(KERN_NOTICE "IXP4xx flash: using %s partition "
+			"definition\n", part_type);
+		err = add_mtd_partitions(info->mtd, info->partitions, nr_parts);
 
-	err = parse_mtd_partitions(info->mtd, probes, &info->partitions, dev->resource->start);
-	if (err > 0) {
-		err = add_mtd_partitions(info->mtd, info->partitions, err);
 		if(err)
 			printk(KERN_ERR "Could not parse partitions\n");
 	}
-- 
1.6.3.3
