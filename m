From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:22 +0200
Subject: [RFC PATCH 3/6] mtd: nand: move nand_ecc_ctrl initialization out of
 nand_scan_tail
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438264225-23796-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ECC initialization is currently done when the NAND chip is
registered to the NAND framework, but we are about to add per-partition
ECC setting.
Move the ECC initialization code into its own function so that it can be
reused for the per-partition config.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 104 ++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index ceb68ca..0321126 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3928,43 +3928,14 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
 	return corr >= ds_corr && ecc->strength >= chip->ecc_strength_ds;
 }
 
-/**
- * nand_scan_tail - [NAND Interface] Scan for the NAND device
- * @mtd: MTD device structure
- *
- * This is the second phase of the normal nand_scan() function. It fills out
- * all the uninitialized function pointers with the defaults and scans for a
- * bad block table if appropriate.
+/*
+ * Initialize ECC struct:
+ *  - fill ECC struct with default function/values when these ones are undefined
+ *  - fill ECC infos based on MTD device
  */
-int nand_scan_tail(struct mtd_info *mtd)
+static int nand_ecc_ctrl_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
 {
 	int i;
-	struct nand_chip *chip = mtd->priv;
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_buffers *nbuf;
-
-	/* New bad blocks should be marked in OOB, flash-based BBT, or both */
-	BUG_ON((chip->bbt_options & NAND_BBT_NO_OOB_BBM) &&
-			!(chip->bbt_options & NAND_BBT_USE_FLASH));
-
-	if (!(chip->options & NAND_OWN_BUFFERS)) {
-		nbuf = kzalloc(sizeof(*nbuf) + mtd->writesize
-				+ mtd->oobsize * 3, GFP_KERNEL);
-		if (!nbuf)
-			return -ENOMEM;
-		nbuf->ecccalc = (uint8_t *)(nbuf + 1);
-		nbuf->ecccode = nbuf->ecccalc + mtd->oobsize;
-		nbuf->databuf = nbuf->ecccode + mtd->oobsize;
-
-		chip->buffers = nbuf;
-	} else {
-		if (!chip->buffers)
-			return -ENOMEM;
-	}
-
-	/* Set the internal oob buffer location, just after the page data */
-	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
-
 	/*
 	 * If no default placement scheme is given, select an appropriate one.
 	 */
@@ -3989,9 +3960,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 		}
 	}
 
-	if (!chip->write_page)
-		chip->write_page = nand_write_page;
-
 	/*
 	 * Check ECC mode, default to software if 3byte/512byte hardware ECC is
 	 * selected and we have 256 byte pagesize fallback to software ECC
@@ -4161,6 +4129,64 @@ int nand_scan_tail(struct mtd_info *mtd)
 	}
 	ecc->total = ecc->steps * ecc->bytes;
 
+	return 0;
+}
+
+static void nand_ecc_cleanup(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
+{
+	if (ecc->mode == NAND_ECC_SOFT_BCH)
+		nand_bch_free((struct nand_bch_control *)ecc->priv);
+}
+
+/**
+ * nand_scan_tail - [NAND Interface] Scan for the NAND device
+ * @mtd: MTD device structure
+ *
+ * This is the second phase of the normal nand_scan() function. It fills out
+ * all the uninitialized function pointers with the defaults and scans for a
+ * bad block table if appropriate.
+ */
+int nand_scan_tail(struct mtd_info *mtd)
+{
+	int ret;
+	struct nand_chip *chip = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct nand_buffers *nbuf;
+
+	/* New bad blocks should be marked in OOB, flash-based BBT, or both */
+	BUG_ON((chip->bbt_options & NAND_BBT_NO_OOB_BBM) &&
+			!(chip->bbt_options & NAND_BBT_USE_FLASH));
+
+	if (!(chip->options & NAND_OWN_BUFFERS)) {
+		nbuf = kzalloc(sizeof(*nbuf) + mtd->writesize
+				+ mtd->oobsize * 3, GFP_KERNEL);
+		if (!nbuf)
+			return -ENOMEM;
+		nbuf->ecccalc = (uint8_t *)(nbuf + 1);
+		nbuf->ecccode = nbuf->ecccalc + mtd->oobsize;
+		nbuf->databuf = nbuf->ecccode + mtd->oobsize;
+
+		chip->buffers = nbuf;
+	} else {
+		if (!chip->buffers)
+			return -ENOMEM;
+	}
+
+	/* Set the internal oob buffer location, just after the page data */
+	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
+
+	if (!chip->write_page)
+		chip->write_page = nand_write_page;
+
+	/* Initialize ECC struct */
+	ret = nand_ecc_ctrl_init(mtd, ecc);
+	if (ret) {
+		if (!(chip->options & NAND_OWN_BUFFERS))
+			kfree(chip->buffers);
+
+		return ret;
+	}
+
 	/* Allow subpage writes up to ecc.steps. Not possible for MLC flash */
 	if (!(chip->options & NAND_NO_SUBPAGE_WRITE) && nand_is_slc(chip)) {
 		switch (ecc->steps) {
@@ -4285,9 +4311,7 @@ void nand_release(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd->priv;
 
-	if (chip->ecc.mode == NAND_ECC_SOFT_BCH)
-		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
-
+	nand_ecc_cleanup(mtd, &chip->ecc);
 	mtd_device_unregister(mtd);
 
 	/* Free bad block table memory */
-- 
1.9.1
