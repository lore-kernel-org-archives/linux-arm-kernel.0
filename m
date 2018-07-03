From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  4 Jul 2018 00:00:12 +0200
Subject: [PATCH v2 15/32] mtd: rawnand: mtk: convert driver to nand_scan()
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Message-ID: <20180703220029.19565-16-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/mtk_nand.c | 71 +++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 75c845adb050..a81cd36596e1 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1250,13 +1250,50 @@ static int mtk_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
 	return 0;
 }
 
+static int mtk_nfc_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct device *dev = mtd->dev.parent;
+	struct mtk_nfc *nfc = nand_get_controller_data(chip);
+	struct mtk_nfc_nand_chip *mtk_nand = to_mtk_nand(chip);
+	int len;
+	int ret;
+
+	if (chip->options & NAND_BUSWIDTH_16) {
+		dev_err(dev, "16bits buswidth not supported");
+		return -EINVAL;
+	}
+
+	/* store bbt magic in page, cause OOB is not protected */
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+	ret = mtk_nfc_ecc_init(dev, mtd);
+	if (ret)
+		return ret;
+
+	ret = mtk_nfc_set_spare_per_sector(&mtk_nand->spare_per_sector, mtd);
+	if (ret)
+		return ret;
+
+	mtk_nfc_set_fdm(&mtk_nand->fdm, mtd);
+	mtk_nfc_set_bad_mark_ctl(&mtk_nand->bad_mark, mtd);
+
+	len = mtd->writesize + mtd->oobsize;
+	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL);
+	if (!nfc->buffer)
+		return  -ENOMEM;
+
+	return 0;
+}
+
 static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 				  struct device_node *np)
 {
 	struct mtk_nfc_nand_chip *chip;
 	struct nand_chip *nand;
 	struct mtd_info *mtd;
-	int nsels, len;
+	int nsels;
 	u32 tmp;
 	int ret;
 	int i;
@@ -1324,36 +1361,8 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 
 	mtk_nfc_hw_init(nfc);
 
-	ret = nand_scan_ident(mtd, nsels, NULL);
-	if (ret)
-		return ret;
-
-	/* store bbt magic in page, cause OOB is not protected */
-	if (nand->bbt_options & NAND_BBT_USE_FLASH)
-		nand->bbt_options |= NAND_BBT_NO_OOB;
-
-	ret = mtk_nfc_ecc_init(dev, mtd);
-	if (ret)
-		return -EINVAL;
-
-	if (nand->options & NAND_BUSWIDTH_16) {
-		dev_err(dev, "16bits buswidth not supported");
-		return -EINVAL;
-	}
-
-	ret = mtk_nfc_set_spare_per_sector(&chip->spare_per_sector, mtd);
-	if (ret)
-		return ret;
-
-	mtk_nfc_set_fdm(&chip->fdm, mtd);
-	mtk_nfc_set_bad_mark_ctl(&chip->bad_mark, mtd);
-
-	len = mtd->writesize + mtd->oobsize;
-	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL);
-	if (!nfc->buffer)
-		return  -ENOMEM;
-
-	ret = nand_scan_tail(mtd);
+	nand->controller->attach_chip = mtk_nfc_attach_chip;
+	ret = nand_scan(mtd, nsels);
 	if (ret)
 		return ret;
 
-- 
2.14.1
