From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 17 Apr 2016 22:53:07 +0200
Subject: [PATCH V3 11/11] mtd: mtd: drop NAND_ECC_SOFT_BCH enum value
In-Reply-To: <1460926387-9563-1-git-send-email-zajec5@gmail.com>
References: <1460913104-27388-1-git-send-email-zajec5@gmail.com>
 <1460926387-9563-1-git-send-email-zajec5@gmail.com>
Message-ID: <1460926387-9563-12-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This value should not be part of nand_ecc_modes_t as it specifies
algorithm not a mode. We successfully managed to introduce new "algo"
field which is respected now.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/mtd/nand/fsmc_nand.c   |  3 +--
 drivers/mtd/nand/jz4780_nand.c |  1 -
 drivers/mtd/nand/nand_base.c   | 12 +++---------
 drivers/mtd/nand/nandsim.c     |  2 +-
 drivers/mtd/nand/sunxi_nand.c  |  2 --
 include/linux/mtd/nand.h       |  1 -
 6 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 0f8c63f..d4f454a 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -959,7 +959,6 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 			break;
 
 		case NAND_ECC_SOFT:
-		case NAND_ECC_SOFT_BCH:
 			if (nand->ecc.algo == NAND_ECC_BCH) {
 				dev_info(&pdev->dev, "Using 4-bit SW BCH ECC scheme\n");
 				break;
@@ -974,7 +973,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		 * Don't set layout for BCH4 SW ECC. This will be
 		 * generated later in nand_bch_init() later.
 		 */
-		if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
+		if (nand->ecc.mode == NAND_ECC_HW) {
 			switch (mtd->oobsize) {
 			case 16:
 			case 64:
diff --git a/drivers/mtd/nand/jz4780_nand.c b/drivers/mtd/nand/jz4780_nand.c
index 10f249a..daf3c42 100644
--- a/drivers/mtd/nand/jz4780_nand.c
+++ b/drivers/mtd/nand/jz4780_nand.c
@@ -179,7 +179,6 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 		chip->ecc.correct = jz4780_nand_ecc_correct;
 		/* fall through */
 	case NAND_ECC_SOFT:
-	case NAND_ECC_SOFT_BCH:
 		dev_info(dev, "using %s (strength %d, size %d, bytes %d)\n",
 			(nfc->bch) ? "hardware BCH" : "software ECC",
 			chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index e51d927..e40832d 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4084,8 +4084,7 @@ static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 
-	if (WARN_ON(ecc->mode != NAND_ECC_SOFT &&
-		    ecc->mode != NAND_ECC_SOFT_BCH))
+	if (WARN_ON(ecc->mode != NAND_ECC_SOFT))
 		return -EINVAL;
 
 	switch (ecc->algo) {
@@ -4218,8 +4217,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 	 * If no default placement scheme is given, select an appropriate one.
 	 */
 	if (!mtd->ooblayout &&
-	    !((ecc->mode == NAND_ECC_SOFT || ecc->mode == NAND_ECC_SOFT_BCH) &&
-	       ecc->algo == NAND_ECC_BCH)) {
+	    !(ecc->mode == NAND_ECC_SOFT && ecc->algo == NAND_ECC_BCH)) {
 		switch (mtd->oobsize) {
 		case 8:
 		case 16:
@@ -4313,13 +4311,11 @@ int nand_scan_tail(struct mtd_info *mtd)
 		ecc->algo = NAND_ECC_HAMMING;
 
 	case NAND_ECC_SOFT:
-	case NAND_ECC_SOFT_BCH:
 		ret = nand_set_ecc_soft_ops(mtd);
 		if (ret) {
 			ret = -EINVAL;
 			goto err_free;
 		}
-
 		break;
 
 	case NAND_ECC_NONE:
@@ -4402,7 +4398,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 	/* Large page NAND with SOFT_ECC should support subpage reads */
 	switch (ecc->mode) {
 	case NAND_ECC_SOFT:
-	case NAND_ECC_SOFT_BCH:
 		if (chip->page_shift > 9)
 			chip->options |= NAND_SUBPAGE_READ;
 		break;
@@ -4502,8 +4497,7 @@ void nand_release(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	if ((chip->ecc.mode == NAND_ECC_SOFT ||
-	     chip->ecc.mode == NAND_ECC_SOFT_BCH) &&
+	if (chip->ecc.mode == NAND_ECC_SOFT &&
 	    chip->ecc.algo == NAND_ECC_BCH)
 		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
 
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 6ff1d8d..b0074c2 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -2339,7 +2339,7 @@ static int __init ns_init_module(void)
 			retval = -EINVAL;
 			goto error;
 		}
-		chip->ecc.mode = NAND_ECC_SOFT_BCH;
+		chip->ecc.mode = NAND_ECC_SOFT;
 		chip->ecc.algo = NAND_ECC_BCH;
 		chip->ecc.size = 512;
 		chip->ecc.strength = bch;
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 1baf8983..a83a690 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1612,8 +1612,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 		return -EINVAL;
 
 	switch (ecc->mode) {
-	case NAND_ECC_SOFT_BCH:
-		break;
 	case NAND_ECC_HW:
 		ret = sunxi_nand_hw_ecc_ctrl_init(mtd, ecc, np);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index e851839..fbe8e16 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -116,7 +116,6 @@ typedef enum {
 	NAND_ECC_HW,
 	NAND_ECC_HW_SYNDROME,
 	NAND_ECC_HW_OOB_FIRST,
-	NAND_ECC_SOFT_BCH,
 } nand_ecc_modes_t;
 
 enum nand_ecc_algo {
-- 
1.8.4.5
