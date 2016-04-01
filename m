From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:24 +0200
Subject: [PATCH 04/12] mtd: nand: brcm: rely on generic DT parsing done in
 nand_scan_ident()
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core now takes care of parsing generic DT properties in
nand_scan_ident() when nand_set_flash_node() has been called.
Rely on this initialization instead of calling of_get_nand_xxx()
manually.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index e052839..6e2a52d 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -32,7 +32,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
-#include <linux/of_mtd.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/list.h>
@@ -2001,8 +2000,8 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	 */
 	chip->options |= NAND_USE_BOUNCE_BUFFER;
 
-	if (of_get_nand_on_flash_bbt(dn))
-		chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
 
 	if (brcmnand_setup_dev(host))
 		return -ENXIO;
-- 
2.5.0
