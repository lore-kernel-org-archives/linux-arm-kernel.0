From: b32955@freescale.com (Huang Shijie)
Date: Tue, 3 Jul 2012 16:24:32 +0800
Subject: [PATCH 1/2] mtd: gpmi: add on-flash BBT support for gpmi nand
Message-ID: <1341303873-23040-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the on flash bbt support for gpmi nand driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/mtd/gpmi-nand.txt          |    4 ++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
index 1a5bbd3..3fb3f90 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -12,6 +12,10 @@ Required properties:
   - interrupt-names : The interrupt names "gpmi-dma", "bch";
   - fsl,gpmi-dma-channel : Should contain the dma channel it uses.
 
+Optional properties:
+  - nand-on-flash-bbt: boolean to enable on flash bbt option if not
+                       present false
+
 The device tree may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 5a90df1..a1bf31f 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -27,6 +27,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_mtd.h>
 #include "gpmi-nand.h"
 
 /* add our owner bbt descriptor */
@@ -1561,6 +1562,8 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 	chip->ecc.size		= 1;
 	chip->ecc.strength	= 8;
 	chip->ecc.layout	= &gpmi_hw_ecclayout;
+	if (of_get_nand_on_flash_bbt(this->dev->of_node))
+		chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
 
 	/* Allocate a temporary DMA buffer for reading ID in the nand_scan() */
 	this->bch_geometry.payload_size = 1024;
-- 
1.7.0.4
