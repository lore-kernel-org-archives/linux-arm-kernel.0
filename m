From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 21 Aug 2015 18:41:10 +0200
Subject: [PATCH] mtd: nand: sunxi: rely on nand_dt_init initialization
Message-ID: <1440175270-11334-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nand_dt_init(), called from nand_scan_ident(), is already parsing the
generic MTD/NAND DT properties, and initializing the nand_chip struct
accordingly.
Rely on this initialization instead of manually parsing those properties.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index f97a58d..6bd7099 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1166,12 +1166,7 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 	int blk_size;
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
@@ -1181,10 +1176,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 
 	ecc->mode = NAND_ECC_HW;
 
-	ret = of_get_nand_ecc_mode(np);
-	if (ret >= 0)
-		ecc->mode = ret;
-
 	switch (ecc->mode) {
 	case NAND_ECC_SOFT_BCH:
 		break;
@@ -1310,15 +1301,13 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
 	nand->chip_delay = 200;
 	nand->controller = &nfc->controller;
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
@@ -1328,6 +1317,9 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
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
