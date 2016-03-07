From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:17 +0100
Subject: [PATCH v4 27/52] mtd: nand: brcm: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-28-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 258 +++++++++++++++++++++--------------
 1 file changed, 157 insertions(+), 101 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index e052839..4c3c0a9 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -781,127 +781,183 @@ static inline bool is_hamming_ecc(struct brcmnand_cfg *cfg)
 }
 
 /*
- * Returns a nand_ecclayout strucutre for the given layout/configuration.
- * Returns NULL on failure.
+ * Set mtd->ooblayout to the appropriate mtd_ooblayout_ops given
+ * the layout/configuration.
+ * Returns -ERRCODE on failure.
  */
-static struct nand_ecclayout *brcmnand_create_layout(int ecc_level,
-						     struct brcmnand_host *host)
+static int brcmnand_hamming_ooblayout_ecc(struct mtd_info *mtd, int section,
+					  struct mtd_oob_region *oobregion)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_cfg *cfg = &host->hwcfg;
-	int i, j;
-	struct nand_ecclayout *layout;
-	int req;
-	int sectors;
-	int sas;
-	int idx1, idx2;
-
-	layout = devm_kzalloc(&host->pdev->dev, sizeof(*layout), GFP_KERNEL);
-	if (!layout)
-		return NULL;
-
-	sectors = cfg->page_size / (512 << cfg->sector_size_1k);
-	sas = cfg->spare_area_size << cfg->sector_size_1k;
-
-	/* Hamming */
-	if (is_hamming_ecc(cfg)) {
-		for (i = 0, idx1 = 0, idx2 = 0; i < sectors; i++) {
-			/* First sector of each page may have BBI */
-			if (i == 0) {
-				layout->oobfree[idx2].offset = i * sas + 1;
-				/* Small-page NAND use byte 6 for BBI */
-				if (cfg->page_size == 512)
-					layout->oobfree[idx2].offset--;
-				layout->oobfree[idx2].length = 5;
-			} else {
-				layout->oobfree[idx2].offset = i * sas;
-				layout->oobfree[idx2].length = 6;
-			}
-			idx2++;
-			layout->eccpos[idx1++] = i * sas + 6;
-			layout->eccpos[idx1++] = i * sas + 7;
-			layout->eccpos[idx1++] = i * sas + 8;
-			layout->oobfree[idx2].offset = i * sas + 9;
-			layout->oobfree[idx2].length = 7;
-			idx2++;
-			/* Leave zero-terminated entry for OOBFREE */
-			if (idx1 >= MTD_MAX_ECCPOS_ENTRIES_LARGE ||
-				    idx2 >= MTD_MAX_OOBFREE_ENTRIES_LARGE - 1)
-				break;
-		}
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
 
-		return layout;
-	}
+	if (section >= sectors)
+		return -ERANGE;
 
-	/*
-	 * CONTROLLER_VERSION:
-	 *   < v5.0: ECC_REQ = ceil(BCH_T * 13/8)
-	 *  >= v5.0: ECC_REQ = ceil(BCH_T * 14/8)
-	 * But we will just be conservative.
-	 */
-	req = DIV_ROUND_UP(ecc_level * 14, 8);
-	if (req >= sas) {
-		dev_err(&host->pdev->dev,
-			"error: ECC too large for OOB (ECC bytes %d, spare sector %d)\n",
-			req, sas);
-		return NULL;
-	}
+	oobregion->offset = (section * sas) + 6;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static int brcmnand_hamming_ooblayout_free(struct mtd_info *mtd, int section,
+					   struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+
+	if (section >= sectors * 2)
+		return -ERANGE;
 
-	layout->eccbytes = req * sectors;
-	for (i = 0, idx1 = 0, idx2 = 0; i < sectors; i++) {
-		for (j = sas - req; j < sas && idx1 <
-				MTD_MAX_ECCPOS_ENTRIES_LARGE; j++, idx1++)
-			layout->eccpos[idx1] = i * sas + j;
+	oobregion->offset = (section / 2) * sas;
+
+	if (section & 1) {
+		oobregion->offset += 9;
+		oobregion->length = 7;
+	} else {
+		oobregion->length = 6;
 
 		/* First sector of each page may have BBI */
-		if (i == 0) {
-			if (cfg->page_size == 512 && (sas - req >= 6)) {
-				/* Small-page NAND use byte 6 for BBI */
-				layout->oobfree[idx2].offset = 0;
-				layout->oobfree[idx2].length = 5;
-				idx2++;
-				if (sas - req > 6) {
-					layout->oobfree[idx2].offset = 6;
-					layout->oobfree[idx2].length =
-						sas - req - 6;
-					idx2++;
-				}
-			} else if (sas > req + 1) {
-				layout->oobfree[idx2].offset = i * sas + 1;
-				layout->oobfree[idx2].length = sas - req - 1;
-				idx2++;
-			}
-		} else if (sas > req) {
-			layout->oobfree[idx2].offset = i * sas;
-			layout->oobfree[idx2].length = sas - req;
-			idx2++;
+		if (!section) {
+			/*
+			 * Small-page NAND use byte 6 for BBI while large-page
+			 * NAND use byte 0.
+			 */
+			if (cfg->page_size > 512)
+				oobregion->offset++;
+			oobregion->length--;
 		}
-		/* Leave zero-terminated entry for OOBFREE */
-		if (idx1 >= MTD_MAX_ECCPOS_ENTRIES_LARGE ||
-				idx2 >= MTD_MAX_OOBFREE_ENTRIES_LARGE - 1)
-			break;
 	}
 
-	return layout;
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops brcmnand_hamming_ooblayout_ops = {
+	.ecc = brcmnand_hamming_ooblayout_ecc,
+	.free = brcmnand_hamming_ooblayout_free,
+};
+
+static int brcmnand_bch_ooblayout_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+
+	if (section >= sectors)
+		return -ERANGE;
+
+	oobregion->offset = (section * (sas + 1)) - chip->ecc.bytes;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
 }
 
-static struct nand_ecclayout *brcmstb_choose_ecc_layout(
-		struct brcmnand_host *host)
+static int brcmnand_bch_ooblayout_free_lp(struct mtd_info *mtd, int section,
+					  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+
+	if (section >= sectors)
+		return -ERANGE;
+
+	if (sas <= chip->ecc.bytes)
+		return 0;
+
+	oobregion->offset = section * sas;
+	oobregion->length = sas - chip->ecc.bytes;
+
+	if (!section) {
+		oobregion->offset++;
+		oobregion->length--;
+	}
+
+	return 0;
+}
+
+static int brcmnand_bch_ooblayout_free_sp(struct mtd_info *mtd, int section,
+					  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+
+	if (section > 1 || sas - chip->ecc.bytes < 6 ||
+	    (section && sas - chip->ecc.bytes == 6))
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 0;
+		oobregion->length = 5;
+	} else {
+		oobregion->offset = 6;
+		oobregion->length = sas - chip->ecc.bytes - 6;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops brcmnand_bch_lp_ooblayout_ops = {
+	.ecc = brcmnand_bch_ooblayout_ecc,
+	.free = brcmnand_bch_ooblayout_free_lp,
+};
+
+static const struct mtd_ooblayout_ops brcmnand_bch_sp_ooblayout_ops = {
+	.ecc = brcmnand_bch_ooblayout_ecc,
+	.free = brcmnand_bch_ooblayout_free_sp,
+};
+
+static int brcmstb_choose_ecc_layout(struct brcmnand_host *host)
 {
-	struct nand_ecclayout *layout;
 	struct brcmnand_cfg *p = &host->hwcfg;
+	struct mtd_info *mtd = nand_to_mtd(&host->chip);
+	struct nand_ecc_ctrl *ecc = &host->chip.ecc;
 	unsigned int ecc_level = p->ecc_level;
+	int sas = p->spare_area_size << p->sector_size_1k;
+	int sectors = p->page_size / (512 << p->sector_size_1k);
 
 	if (p->sector_size_1k)
 		ecc_level <<= 1;
 
-	layout = brcmnand_create_layout(ecc_level, host);
-	if (!layout) {
+	if (is_hamming_ecc(p)) {
+		ecc->bytes = 3 * sectors;
+		mtd_set_ooblayout(mtd, &brcmnand_hamming_ooblayout_ops);
+		return 0;
+	}
+
+	/*
+	 * CONTROLLER_VERSION:
+	 *   < v5.0: ECC_REQ = ceil(BCH_T * 13/8)
+	 *  >= v5.0: ECC_REQ = ceil(BCH_T * 14/8)
+	 * But we will just be conservative.
+	 */
+	ecc->bytes = DIV_ROUND_UP(ecc_level * 14, 8);
+	if (p->page_size == 512)
+		mtd_set_ooblayout(mtd, &brcmnand_bch_sp_ooblayout_ops);
+	else
+		mtd_set_ooblayout(mtd, &brcmnand_bch_lp_ooblayout_ops);
+
+	if (ecc->bytes >= sas) {
 		dev_err(&host->pdev->dev,
-				"no proper ecc_layout for this NAND cfg\n");
-		return NULL;
+			"error: ECC too large for OOB (ECC bytes %d, spare sector %d)\n",
+			ecc->bytes, sas);
+		return -EINVAL;
 	}
 
-	return layout;
+	return 0;
 }
 
 static void brcmnand_wp(struct mtd_info *mtd, int wp)
@@ -2011,9 +2067,9 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	/* only use our internal HW threshold */
 	mtd->bitflip_threshold = 1;
 
-	chip->ecc.layout = brcmstb_choose_ecc_layout(host);
-	if (!chip->ecc.layout)
-		return -ENXIO;
+	ret = brcmstb_choose_ecc_layout(host);
+	if (ret)
+		return ret;
 
 	if (nand_scan_tail(mtd))
 		return -ENXIO;
-- 
2.1.4
