From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  2 Sep 2015 10:30:25 +0200
Subject: [PATCH v3] mtd: nand: sunxi: rely on nand_dt_init initialization
Message-ID: <1441182625-525-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nand_dt_init(), called from nand_scan_ident(), is already parsing the
generic MTD/NAND DT properties, and initializing the nand_chip struct
accordingly.
Rely on this initialization instead of manually parsing those properties.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes since v2:
- fix a bug forcing ecc.mode to HW_ECC
Changes since v1:
- drop unused strength and blk_size variables
---
 drivers/mtd/nand/sunxi_nand.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 0c29f6c..d644548 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1076,16 +1076,9 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 			       struct device_node *np)
 {
 	struct nand_chip *nand = mtd->priv;
-	int strength;
-	int blk_size;
 	int ret;
 
-	blk_size = of_get_nand_ecc_step_size(np);
-	strength = of_get_nand_ecc_strength(np);
-	if (blk_size > 0 && strength > 0) {
-		ecc->size = blk_size;
-		ecc->strength = strength;
-	} else {
+	if (!ecc->size) {
 		ecc->size = nand->ecc_step_ds;
 		ecc->strength = nand->ecc_strength_ds;
 	}
@@ -1093,12 +1086,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 	if (!ecc->size || !ecc->strength)
 		return -EINVAL;
 
-	ecc->mode = NAND_ECC_HW;
-
-	ret = of_get_nand_ecc_mode(np);
-	if (ret >= 0)
-		ecc->mode = ret;
-
 	switch (ecc->mode) {
 	case NAND_ECC_SOFT_BCH:
 		break;
@@ -1224,15 +1211,18 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
 	nand->chip_delay = 200;
 	nand->controller = &nfc->controller;
+	/*
+	 * Set the ECC mode to the default value in case nothing is specified
+	 * in the DT.
+	 */
+	nand->ecc.mode = NAND_ECC_HW;
+	nand->dn = np;
 	nand->select_chip = sunxi_nfc_select_chip;
 	nand->cmd_ctrl = sunxi_nfc_cmd_ctrl;
 	nand->read_buf = sunxi_nfc_read_buf;
 	nand->write_buf = sunxi_nfc_write_buf;
 	nand->read_byte = sunxi_nfc_read_byte;
 
-	if (of_get_nand_on_flash_bbt(np))
-		nand->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
-
 	mtd = &chip->mtd;
 	mtd->dev.parent = dev;
 	mtd->priv = nand;
@@ -1242,6 +1232,9 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	if (ret)
 		return ret;
 
+	if (nand->bbt_options & NAND_BBT_USE_FLASH)
+		nand->bbt_options |= NAND_BBT_NO_OOB;
+
 	ret = sunxi_nand_chip_init_timings(chip, np);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
-- 
1.9.1
