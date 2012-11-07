From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 16:32:16 +0100
Subject: [PATCH 1/1] mtd: physmap_of: allow to specify the mtd name for
 retro compatiblity
Message-ID: <20121107153216.GF4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux,mtd-name allow to specify the mtd name for retro capability with
physmap-flash drivers as boot loader pass the mtd partition via the old
device name physmap-flash.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 Documentation/devicetree/bindings/mtd/mtd-physmap.txt |    3 +++
 drivers/mtd/maps/physmap_of.c                         |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 94de19b..dab7847 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -23,6 +23,9 @@ file systems on embedded devices.
    unaligned accesses as implemented in the JFFS2 code via memcpy().
    By defining "no-unaligned-direct-access", the flash will not be
    exposed directly to the MTD users (e.g. JFFS2) any more.
+ - linux,mtd-name: allow to specify the mtd name for retro capability with
+   physmap-flash drivers as boot loader pass the mtd partition via the old
+   device name physmap-flash.
 
 For JEDEC compatible devices, the following additional properties
 are defined:
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 6f19aca..9a8db0c 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -170,6 +170,7 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 	resource_size_t res_size;
 	struct mtd_part_parser_data ppdata;
 	bool map_indirect;
+	const char *mtd_name;
 
 	match = of_match_device(of_flash_match, &dev->dev);
 	if (!match)
@@ -178,6 +179,8 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 
 	reg_tuple_size = (of_n_addr_cells(dp) + of_n_size_cells(dp)) * sizeof(u32);
 
+	of_property_read_string(dp, "linux,mtd-name", &mtd_name);
+
 	/*
 	 * Get number of "reg" tuples. Scan for MTD devices on area's
 	 * described by each "reg" region. This makes it possible (including
@@ -234,7 +237,7 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 			goto err_out;
 		}
 
-		info->list[i].map.name = dev_name(&dev->dev);
+		info->list[i].map.name = mtd_name ? mtd_name : dev_name(&dev->dev);
 		info->list[i].map.phys = res.start;
 		info->list[i].map.size = res_size;
 		info->list[i].map.bankwidth = be32_to_cpup(width);
-- 
1.7.10.4
