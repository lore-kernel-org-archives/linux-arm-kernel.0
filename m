From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:32 +0100
Subject: [PATCH v4 42/52] mtd: nand: omap2: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-43-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/omap2.c | 194 +++++++++++++++++++++++++++--------------------
 1 file changed, 113 insertions(+), 81 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4ebf16b..bca154a 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -169,8 +169,6 @@ struct omap_nand_info {
 	u_char				*buf;
 	int					buf_len;
 	struct gpmc_nand_regs		reg;
-	/* generated at runtime depending on ECC algorithm and layout selected */
-	struct nand_ecclayout		oobinfo;
 	/* fields specific for BCHx_HW ECC scheme */
 	struct device			*elm_dev;
 	struct device_node		*of_node;
@@ -1639,19 +1637,108 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
 	return true;
 }
 
+static int omap_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = off;
+	oobregion->length = chip->ecc.total;
+
+	return 0;
+}
+
+static int omap_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+
+	if (section)
+		return -ERANGE;
+
+	off += chip->ecc.total;
+	if (off >= mtd->oobsize)
+		return -ERANGE;
+
+	oobregion->offset = off;
+	oobregion->length = mtd->oobsize - off;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops omap_ooblayout_ops = {
+	.ecc = omap_ooblayout_ecc,
+	.free = omap_ooblayout_free,
+};
+
+static int omap_sw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	/*
+	 * When SW correction is employed, one OMAP specific marker byte is
+	 * reserved after each ECC step.
+	 */
+	oobregion->offset = off + (section * (chip->ecc.bytes + 1));
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int omap_sw_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+
+	if (section)
+		return -ERANGE;
+
+	/*
+	 * When SW correction is employed, one OMAP specific marker byte is
+	 * reserved after each ECC step.
+	 */
+	off += ((chip->ecc.bytes + 1) * chip->ecc.steps);
+	if (off >= mtd->oobsize)
+		return -ERANGE;
+
+	oobregion->offset = off;
+	oobregion->length = mtd->oobsize - off;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops omap_sw_ooblayout_ops = {
+	.ecc = omap_sw_ooblayout_ecc,
+	.free = omap_sw_ooblayout_free,
+};
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
-	struct nand_ecclayout		*ecclayout;
 	int				err;
-	int				i;
 	dma_cap_mask_t			mask;
 	unsigned			sig;
-	unsigned			oob_index;
 	struct resource			*res;
+	int				min_oobbytes;
+	int				oobbytes_per_step;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata == NULL) {
@@ -1810,7 +1897,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	/*
 	 * Bail out earlier to let NAND_ECC_SOFT code create its own
-	 * ecclayout instead of using ours.
+	 * ooblayout instead of using ours.
 	 */
 	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_SW) {
 		nand_chip->ecc.mode = NAND_ECC_SOFT;
@@ -1818,8 +1905,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* populate MTD interface based on ECC scheme */
-	ecclayout		= &info->oobinfo;
-	nand_chip->ecc.layout	= ecclayout;
 	switch (info->ecc_opt) {
 	case OMAP_ECC_HAM1_CODE_HW:
 		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
@@ -1830,19 +1915,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate        = omap_calculate_ecc;
 		nand_chip->ecc.hwctl            = omap_enable_hwecc;
 		nand_chip->ecc.correct          = omap_correct_data;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		if (nand_chip->options & NAND_BUSWIDTH_16)
-			oob_index		= BADBLOCK_MARKER_LENGTH;
-		else
-			oob_index		= 1;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* no reserved-marker in ecclayout for this ecc-scheme */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
@@ -1854,19 +1928,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
-			ecclayout->eccpos[i] = oob_index;
-			if (((i + 1) % nand_chip->ecc.bytes) == 0)
-				oob_index++;
-		}
-		/* include reserved-marker in ecclayout->oobfree calculation */
-		ecclayout->oobfree->offset	= 1 +
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
+		/* Reserve one byte for the OMAP marker */
+		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd);
 		if (!nand_chip->ecc.priv) {
@@ -1888,16 +1952,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* reserved marker already included in ecclayout->eccbytes */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 
 		err = elm_config(info->elm_dev, BCH4_ECC,
 				 mtd->writesize / nand_chip->ecc.size,
@@ -1915,19 +1971,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
-			ecclayout->eccpos[i] = oob_index;
-			if (((i + 1) % nand_chip->ecc.bytes) == 0)
-				oob_index++;
-		}
-		/* include reserved-marker in ecclayout->oobfree calculation */
-		ecclayout->oobfree->offset	= 1 +
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
+		/* Reserve one byte for the OMAP marker */
+		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd);
 		if (!nand_chip->ecc.priv) {
@@ -1949,6 +1995,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 
 		err = elm_config(info->elm_dev, BCH8_ECC,
 				 mtd->writesize / nand_chip->ecc.size,
@@ -1956,16 +2004,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (err < 0)
 			goto return_error;
 
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* reserved marker already included in ecclayout->eccbytes */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
 
 	case OMAP_ECC_BCH16_CODE_HW:
@@ -1979,6 +2017,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 
 		err = elm_config(info->elm_dev, BCH16_ECC,
 				 mtd->writesize / nand_chip->ecc.size,
@@ -1986,16 +2026,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (err < 0)
 			goto return_error;
 
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* reserved marker already included in ecclayout->eccbytes */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
 	default:
 		dev_err(&info->pdev->dev, "invalid or unsupported ECC scheme\n");
@@ -2003,13 +2033,15 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	/* all OOB bytes from oobfree->offset till end off OOB are free */
-	ecclayout->oobfree->length = mtd->oobsize - ecclayout->oobfree->offset;
 	/* check if NAND device's OOB is enough to store ECC signatures */
-	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
+	min_oobbytes = (oobbytes_per_step *
+			(mtd->writesize / nand_chip->ecc.size)) +
+		       (nand_chip->options & NAND_BUSWIDTH_16 ?
+			BADBLOCK_MARKER_LENGTH : 1);
+	if (mtd->oobsize < min_oobbytes) {
 		dev_err(&info->pdev->dev,
 			"not enough OOB bytes required = %d, available=%d\n",
-			ecclayout->eccbytes, mtd->oobsize);
+			min_oobbytes, mtd->oobsize);
 		err = -EINVAL;
 		goto return_error;
 	}
-- 
2.1.4
