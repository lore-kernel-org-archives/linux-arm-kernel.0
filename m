From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 01:00:03 +0200
Subject: [PATCH v3 10/33] mtd: rawnand: jz4780: convert driver to nand_scan()
In-Reply-To: <20180719230026.8741-1-miquel.raynal@bootlin.com>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
Message-ID: <20180719230026.8741-11-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Harvey Hunt <harveyhuntnexus@gmail.com>
---
 drivers/mtd/nand/raw/jz4780_nand.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 49841dad347c..aca4214a6e18 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -158,9 +158,8 @@ static int jz4780_nand_ecc_correct(struct mtd_info *mtd, u8 *dat,
 	return jz4780_bch_correct(nfc->bch, &params, dat, read_ecc);
 }
 
-static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *dev)
+static int jz4780_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nand->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
 	int eccbytes;
@@ -171,7 +170,8 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 	switch (chip->ecc.mode) {
 	case NAND_ECC_HW:
 		if (!nfc->bch) {
-			dev_err(dev, "HW BCH selected, but BCH controller not found\n");
+			dev_err(nfc->dev,
+				"HW BCH selected, but BCH controller not found\n");
 			return -ENODEV;
 		}
 
@@ -180,15 +180,16 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 		chip->ecc.correct = jz4780_nand_ecc_correct;
 		/* fall through */
 	case NAND_ECC_SOFT:
-		dev_info(dev, "using %s (strength %d, size %d, bytes %d)\n",
-			(nfc->bch) ? "hardware BCH" : "software ECC",
-			chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
+		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
+			 (nfc->bch) ? "hardware BCH" : "software ECC",
+			 chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
 		break;
 	case NAND_ECC_NONE:
-		dev_info(dev, "not using ECC\n");
+		dev_info(nfc->dev, "not using ECC\n");
 		break;
 	default:
-		dev_err(dev, "ECC mode %d not supported\n", chip->ecc.mode);
+		dev_err(nfc->dev, "ECC mode %d not supported\n",
+			chip->ecc.mode);
 		return -EINVAL;
 	}
 
@@ -200,7 +201,7 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 	eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
 
 	if (eccbytes > mtd->oobsize - 2) {
-		dev_err(dev,
+		dev_err(nfc->dev,
 			"invalid ECC config: required %d ECC bytes, but only %d are available",
 			eccbytes, mtd->oobsize - 2);
 		return -EINVAL;
@@ -211,6 +212,10 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 	return 0;
 }
 
+static struct nand_controller_ops jz4780_nand_controller_ops = {
+	.attach_chip = jz4780_nand_attach_chip,
+};
+
 static int jz4780_nand_init_chip(struct platform_device *pdev,
 				struct jz4780_nand_controller *nfc,
 				struct device_node *np,
@@ -280,15 +285,8 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 	chip->controller = &nfc->controller;
 	nand_set_flash_node(chip, np);
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
-
-	ret = jz4780_nand_init_ecc(nand, dev);
-	if (ret)
-		return ret;
-
-	ret = nand_scan_tail(mtd);
+	chip->controller->ops = &jz4780_nand_controller_ops;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
-- 
2.14.1
