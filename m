From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  4 Jul 2018 00:00:24 +0200
Subject: [PATCH v2 27/32] mtd: rawnand: sm_common: convert driver to
 nand_scan_with_ids()
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Message-ID: <20180703220029.19565-28-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan_with_ids()
(alternative to nand_scan() for passing a flash IDs table) instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sm_common.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index 7f5044a79f01..b8c9cc74b1c6 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -160,19 +160,9 @@ static struct nand_flash_dev nand_xd_flash_ids[] = {
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
-	ret = nand_scan_ident(mtd, 1, smartmedia ?
-		nand_smartmedia_flash_ids : nand_xd_flash_ids);
-
-	if (ret)
-		return ret;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	/* Bad block marker position */
 	chip->badblockpos = 0x05;
@@ -187,12 +177,29 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 	else
 		return -ENODEV;
 
-	ret = nand_scan_tail(mtd);
+	return 0;
+}
 
+int sm_register_device(struct mtd_info *mtd, int smartmedia)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_flash_dev *flash_ids;
+	int ret;
+
+	chip->options |= NAND_SKIP_BBTSCAN;
+
+	/* Scan for card properties */
+	chip->hwcontrol.attach_chip = sm_attach_chip;
+	flash_ids = smartmedia ? nand_smartmedia_flash_ids : nand_xd_flash_ids;
+	ret = nand_scan_with_ids(mtd, 1, flash_ids);
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
