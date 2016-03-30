From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:45 +0200
Subject: [PATCH v5 30/50] mtd: nand: fsl_elbc: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-31-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/fsl_elbc_nand.c | 83 +++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 059d5f7..487eae0 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -79,32 +79,53 @@ struct fsl_elbc_fcm_ctrl {
 
 /* These map to the positions used by the FCM hardware ECC generator */
 
-/* Small Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm0 = {
-	.eccbytes = 3,
-	.eccpos = {6, 7, 8},
-	.oobfree = { {0, 5}, {9, 7} },
-};
+static int fsl_elbc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 
-/* Small Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm1 = {
-	.eccbytes = 3,
-	.eccpos = {8, 9, 10},
-	.oobfree = { {0, 5}, {6, 2}, {11, 5} },
-};
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
 
-/* Large Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
-	.eccbytes = 12,
-	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
-	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
-};
+	oobregion->offset = (16 * section) + 6;
+	if (priv->fmr & FMR_ECCM)
+		oobregion->offset += 2;
 
-/* Large Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
-	.eccbytes = 12,
-	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
-	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int fsl_elbc_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
+
+	if (section > chip->ecc.steps)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 0;
+		if (mtd->writesize > 512)
+			oobregion->offset++;
+		oobregion->length = (priv->fmr & FMR_ECCM) ? 7 : 5;
+	} else {
+		oobregion->offset = (16 * section) -
+				    ((priv->fmr & FMR_ECCM) ? 5 : 7);
+		if (section < chip->ecc.steps)
+			oobregion->length = 13;
+		else
+			oobregion->length = mtd->oobsize - oobregion->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsl_elbc_ooblayout_ops = {
+	.ecc = fsl_elbc_ooblayout_ecc,
+	.free = fsl_elbc_ooblayout_free,
 };
 
 /*
@@ -657,8 +678,8 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	        chip->ecc.bytes);
 	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.total = %d\n",
 	        chip->ecc.total);
-	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
-	        chip->ecc.layout);
+	dev_dbg(priv->dev, "fsl_elbc_init: mtd->ooblayout = %p\n",
+		mtd->ooblayout);
 	dev_dbg(priv->dev, "fsl_elbc_init: mtd->flags = %08x\n", mtd->flags);
 	dev_dbg(priv->dev, "fsl_elbc_init: mtd->size = %lld\n", mtd->size);
 	dev_dbg(priv->dev, "fsl_elbc_init: mtd->erasesize = %d\n",
@@ -675,14 +696,6 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	} else if (mtd->writesize == 2048) {
 		priv->page_size = 1;
 		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
-		/* adjust ecc setup if needed */
-		if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
-		    BR_DECC_CHK_GEN) {
-			chip->ecc.size = 512;
-			chip->ecc.layout = (priv->fmr & FMR_ECCM) ?
-			                   &fsl_elbc_oob_lp_eccm1 :
-			                   &fsl_elbc_oob_lp_eccm0;
-		}
 	} else {
 		dev_err(priv->dev,
 		        "fsl_elbc_init: page size %d is not supported\n",
@@ -780,9 +793,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
 	    BR_DECC_CHK_GEN) {
 		chip->ecc.mode = NAND_ECC_HW;
-		/* put in small page settings and adjust later if needed */
-		chip->ecc.layout = (priv->fmr & FMR_ECCM) ?
-				&fsl_elbc_oob_sp_eccm1 : &fsl_elbc_oob_sp_eccm0;
+		mtd_set_ooblayout(mtd, &fsl_elbc_ooblayout_ops);
 		chip->ecc.size = 512;
 		chip->ecc.bytes = 3;
 		chip->ecc.strength = 1;
-- 
2.5.0
