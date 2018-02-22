From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 22 Feb 2018 15:45:07 +0530
Subject: [PATCH 2/4][v4][RESEND] driver: mtd: update struct map_info's swap as
 per map requirement
In-Reply-To: <20180222101511.29631-1-prabhakar.kushwaha@nxp.com>
References: <20180222101511.29631-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180222101511.29631-3-prabhakar.kushwaha@nxp.com>
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

Resending as all patches of patchset never reaches to patchwork.

 drivers/mtd/maps/physmap_of_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/maps/physmap_of_core.c b/drivers/mtd/maps/physmap_of_core.c
index b1bd4faecfb2..6eee160dfb3d 100644
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
@@ -233,6 +234,13 @@ static int of_flash_probe(struct platform_device *dev)
 		info->list[i].map.bankwidth = be32_to_cpup(width);
 		info->list[i].map.device_node = dp;
 
+		if (of_property_read_bool(dp, "big-endian"))
+			info->list[i].map.swap = CFI_BIG_ENDIAN;
+		else if (of_property_read_bool(dp, "little-endian"))
+			info->list[i].map.swap = CFI_LITTLE_ENDIAN;
+		else
+			info->list[i].map.swap = CFI_HOST_ENDIAN;
+
 		err = of_flash_probe_gemini(dev, dp, &info->list[i].map);
 		if (err)
 			goto err_out;
-- 
2.14.1
