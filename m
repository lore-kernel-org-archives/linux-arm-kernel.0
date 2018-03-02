From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:54 +0100
Subject: [PATCH 46/52] mtd: rawnand: sm_common: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-47-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sm_common.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index 71b791634ee4..895cc2e455e5 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -161,20 +161,9 @@ static struct nand_flash_dev nand_xd_flash_ids[] = {
 	{NULL}
 };
 
-int sm_register_device(struct mtd_info *mtd, int smartmedia)
+static int sm_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
-
-	chip->options |= NAND_SKIP_BBTSCAN;
-
-	/* Scan for card properties */
-	chip->flash_ids = smartmedia ? nand_smartmedia_flash_ids :
-				       nand_xd_flash_ids;
-	ret = nand_scan_ident(mtd, 1, NULL);
-
-	if (ret)
-		return ret;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	/* Bad block marker position */
 	chip->badblockpos = 0x05;
@@ -189,12 +178,29 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 	else
 		return -ENODEV;
 
-	ret = nand_scan_tail(mtd);
+	return 0;
+}
 
+int sm_register_device(struct mtd_info *mtd, int smartmedia)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
+
+	chip->options |= NAND_SKIP_BBTSCAN;
+
+	/* Scan for card properties */
+	chip->flash_ids = smartmedia ? nand_smartmedia_flash_ids :
+				       nand_xd_flash_ids;
+	chip->ecc.attach_chip = sm_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
-	return mtd_device_register(mtd, NULL, 0);
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret)
+		nand_release(mtd);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sm_register_device);
 
-- 
2.14.1
