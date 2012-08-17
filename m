From: sr@denx.de (Stefan Roese)
Date: Fri, 17 Aug 2012 15:22:32 +0200
Subject: [PATCH v2] mtd: physmap_of: Add "no-unaligned-direct-access" DT
 property
Message-ID: <1345209752-22938-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms (e.g. MPC5200) a direct 1:1 mapping may cause
problems with JFFS2 usage, as the local bus (LPB) doesn't support
unaligned accesses as implemented in the JFFS2 code via memcpy().
By defining "no-unaligned-direct-access", the flash will not be
exposed directly to the MTD users (e.g. JFFS2) any more.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Stephan Gatzka <Stephan.Gatzka@hbm.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Albrecht Dress <albrecht.dress@arcor.de>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
v2:
- Changed "map-indirect" to "no-unaligned-direct-access" because of
  David's comments.

 Documentation/devicetree/bindings/mtd/mtd-physmap.txt |  7 +++++++
 drivers/mtd/maps/physmap_of.c                         | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index a63c2bd7..94de19b 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -16,6 +16,13 @@ file systems on embedded devices.
  - #address-cells, #size-cells : Must be present if the device has
    sub-nodes representing partitions (see below).  In this case
    both #address-cells and #size-cells must be equal to 1.
+ - no-unaligned-direct-access: boolean to disable the default direct
+   mapping of the flash.
+   On some platforms (e.g. MPC5200) a direct 1:1 mapping may cause
+   problems with JFFS2 usage, as the local bus (LPB) doesn't support
+   unaligned accesses as implemented in the JFFS2 code via memcpy().
+   By defining "no-unaligned-direct-access", the flash will not be
+   exposed directly to the MTD users (e.g. JFFS2) any more.
 
 For JEDEC compatible devices, the following additional properties
 are defined:
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 2e6fb68..6f19aca 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -169,6 +169,7 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 	struct mtd_info **mtd_list = NULL;
 	resource_size_t res_size;
 	struct mtd_part_parser_data ppdata;
+	bool map_indirect;
 
 	match = of_match_device(of_flash_match, &dev->dev);
 	if (!match)
@@ -192,6 +193,8 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 	}
 	count /= reg_tuple_size;
 
+	map_indirect = of_property_read_bool(dp, "no-unaligned-direct-access");
+
 	err = -ENOMEM;
 	info = kzalloc(sizeof(struct of_flash) +
 		       sizeof(struct of_flash_list) * count, GFP_KERNEL);
@@ -247,6 +250,17 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 
 		simple_map_init(&info->list[i].map);
 
+		/*
+		 * On some platforms (e.g. MPC5200) a direct 1:1 mapping
+		 * may cause problems with JFFS2 usage, as the local bus (LPB)
+		 * doesn't support unaligned accesses as implemented in the
+		 * JFFS2 code via memcpy(). By setting NO_XIP, the
+		 * flash will not be exposed directly to the MTD users
+		 * (e.g. JFFS2) any more.
+		 */
+		if (map_indirect)
+			info->list[i].map.phys = NO_XIP;
+
 		if (probe_type) {
 			info->list[i].mtd = do_map_probe(probe_type,
 							 &info->list[i].map);
-- 
1.7.11.2
