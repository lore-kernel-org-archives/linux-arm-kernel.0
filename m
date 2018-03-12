From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Mon, 12 Mar 2018 13:42:21 +0530
Subject: [PATCH 2/2][v6] driver: mtd: update struct map_info's swap as per map
 requirement
Message-ID: <20180312081221.8246-1-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not necessary for all device's maps to be CFI_HOST_ENDIAN.
Maps device can be Big endian or little endian.

Currently it is being taken care using CONFIG_MTD_CFI_LE_BYTE_SWAP or
CONFIG_MTD_CFI_BE_BYTE_SWAP i.e. compile time.

Now update struct map_info's swap field based on device characteristics
defined in device tree.

Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Changes for v2: Incorporated review comments from Boris Brezillon
http://patchwork.ozlabs.org/patch/758381/
Changes for v3: None
Changes for v4: Updated code as per new defined binding of physmap.txt
Changes for v5: Avoid map.swap set in case of endiannes not defined in dts file
Changes for v6: Sending as it is

 drivers/mtd/maps/physmap_of_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/maps/physmap_of_core.c b/drivers/mtd/maps/physmap_of_core.c
index b1bd4faecfb2..527b1682381f 100644
--- a/drivers/mtd/maps/physmap_of_core.c
+++ b/drivers/mtd/maps/physmap_of_core.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/concat.h>
+#include <linux/mtd/cfi_endian.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -233,6 +234,11 @@ static int of_flash_probe(struct platform_device *dev)
 		info->list[i].map.bankwidth = be32_to_cpup(width);
 		info->list[i].map.device_node = dp;
 
+		if (of_property_read_bool(dp, "big-endian"))
+			info->list[i].map.swap = CFI_BIG_ENDIAN;
+		else if (of_property_read_bool(dp, "little-endian"))
+			info->list[i].map.swap = CFI_LITTLE_ENDIAN;
+
 		err = of_flash_probe_gemini(dev, dp, &info->list[i].map);
 		if (err)
 			goto err_out;
-- 
2.14.1
