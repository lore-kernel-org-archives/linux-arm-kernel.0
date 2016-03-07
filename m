From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:41 +0100
Subject: [PATCH v4 51/52] mtd: nand: kill the ecc->layout field
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-52-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all NAND drivers have switch to mtd_ooblayout_ops, we can kill
the ecc->layout field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 7 -------
 drivers/mtd/nand/nand_bch.c  | 9 ---------
 include/linux/mtd/nand.h     | 2 --
 3 files changed, 18 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 779a385..e273c92 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4162,13 +4162,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
 
 	/*
-	 * Set the provided ECC layout. If ecc->layout is NULL, the MTD core
-	 * will just leave mtd->ooblayout to NULL, if it's not NULL, it will
-	 * set ->ooblayout to the default ecclayout wrapper.
-	 */
-	mtd_set_ecclayout(mtd, ecc->layout);
-
-	/*
 	 * If no default placement scheme is given, select an appropriate one.
 	 */
 	if (!mtd->ooblayout && (ecc->mode != NAND_ECC_SOFT_BCH)) {
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index e29e75f..ca9b2a4 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -158,15 +158,6 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 
 	eccsteps = mtd->writesize/eccsize;
 
-	/*
-	 * Rely on the default ecclayout to ooblayout wrapper provided by MTD
-	 * core if ecc.layout is not NULL.
-	 * FIXME: this should be removed when all callers have moved to the
-	 * mtd_ooblayout_ops approach.
-	 */
-	if (nand->ecc.layout)
-		mtd_set_ecclayout(mtd, nand->ecc.layout);
-
 	/* if no ecc placement scheme was provided, build one */
 	if (!mtd->ooblayout) {
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 82a005a..fdcc2b8 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -466,7 +466,6 @@ struct nand_hw_control {
  * @prepad:	padding information for syndrome based ECC generators
  * @postpad:	padding information for syndrome based ECC generators
  * @options:	ECC specific options (see NAND_ECC_XXX flags defined above)
- * @layout:	ECC layout control struct pointer
  * @priv:	pointer to private ECC control data
  * @hwctl:	function to control hardware ECC generator. Must only
  *		be provided if an hardware ECC is available
@@ -516,7 +515,6 @@ struct nand_ecc_ctrl {
 	int prepad;
 	int postpad;
 	unsigned int options;
-	struct nand_ecclayout	*layout;
 	void *priv;
 	void (*hwctl)(struct mtd_info *mtd, int mode);
 	int (*calculate)(struct mtd_info *mtd, const uint8_t *dat,
-- 
2.1.4
