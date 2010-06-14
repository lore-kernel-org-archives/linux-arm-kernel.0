From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 14 Jun 2010 11:57:54 -0500
Subject: [PATCH] mtd: physmap.c: use resource_size()
Message-ID: <0D753D10438DA54287A00B02708426976371223143@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Woodhouse <David.Woodhouse@intel.com>

---

diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
index 426461a..829aa4b 100644
--- a/drivers/mtd/maps/physmap.c
+++ b/drivers/mtd/maps/physmap.c
@@ -106,12 +106,12 @@ static int physmap_flash_probe(struct platform_device *dev)
 
 	for (i = 0; i < dev->num_resources; i++) {
 		printk(KERN_NOTICE "physmap platform flash device: %.8llx at %.8llx\n",
-		       (unsigned long long)(dev->resource[i].end - dev->resource[i].start + 1),
+		       (unsigned long long)resource_size(&dev->resource[i]),
 		       (unsigned long long)dev->resource[i].start);
 
 		if (!devm_request_mem_region(&dev->dev,
 			dev->resource[i].start,
-			dev->resource[i].end - dev->resource[i].start + 1,
+			resource_size(&dev->resource[i]),
 			dev_name(&dev->dev))) {
 			dev_err(&dev->dev, "Could not reserve memory region\n");
 			err = -ENOMEM;
@@ -120,7 +120,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 
 		info->map[i].name = dev_name(&dev->dev);
 		info->map[i].phys = dev->resource[i].start;
-		info->map[i].size = dev->resource[i].end - dev->resource[i].start + 1;
+		info->map[i].size = resource_size(&dev->resource[i]);
 		info->map[i].bankwidth = physmap_data->width;
 		info->map[i].set_vpp = physmap_data->set_vpp;
 		info->map[i].pfow_base = physmap_data->pfow_base;
