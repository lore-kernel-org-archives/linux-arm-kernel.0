From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:49 +0200
Subject: [PATCH v5 34/50] mtd: nand: gpmi: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-35-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 52 ++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 3a29b65..316b5ac 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -47,10 +47,44 @@ static struct nand_bbt_descr gpmi_bbt_descr = {
  * We may change the layout if we can get the ECC info from the datasheet,
  * else we will use all the (page + OOB).
  */
-static struct nand_ecclayout gpmi_hw_ecclayout = {
-	.eccbytes = 0,
-	.eccpos = { 0, },
-	.oobfree = { {.offset = 0, .length = 0} }
+static int gpmi_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
+	struct bch_geometry *geo = &this->bch_geometry;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = geo->page_size - mtd->writesize;
+
+	return 0;
+}
+
+static int gpmi_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
+	struct bch_geometry *geo = &this->bch_geometry;
+
+	if (section)
+		return -ERANGE;
+
+	/* The available oob size we have. */
+	if (geo->page_size < mtd->writesize + mtd->oobsize) {
+		oobregion->offset = geo->page_size - mtd->writesize;
+		oobregion->length = mtd->oobsize - oobregion->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops gpmi_ooblayout_ops = {
+	.ecc = gpmi_ooblayout_ecc,
+	.free = gpmi_ooblayout_free,
 };
 
 static const struct gpmi_devdata gpmi_devdata_imx23 = {
@@ -141,7 +175,6 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 	struct bch_geometry *geo = &this->bch_geometry;
 	struct nand_chip *chip = &this->nand;
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct nand_oobfree *of = gpmi_hw_ecclayout.oobfree;
 	unsigned int block_mark_bit_offset;
 
 	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
@@ -229,12 +262,6 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 	geo->page_size = mtd->writesize + geo->metadata_size +
 		(geo->gf_len * geo->ecc_strength * geo->ecc_chunk_count) / 8;
 
-	/* The available oob size we have. */
-	if (geo->page_size < mtd->writesize + mtd->oobsize) {
-		of->offset = geo->page_size - mtd->writesize;
-		of->length = mtd->oobsize - of->offset;
-	}
-
 	geo->payload_size = mtd->writesize;
 
 	geo->auxiliary_status_offset = ALIGN(geo->metadata_size, 4);
@@ -1841,6 +1868,7 @@ static void gpmi_nand_exit(struct gpmi_nand_data *this)
 static int gpmi_init_last(struct gpmi_nand_data *this)
 {
 	struct nand_chip *chip = &this->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct bch_geometry *bch_geo = &this->bch_geometry;
 	int ret;
@@ -1862,7 +1890,7 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	ecc->mode	= NAND_ECC_HW;
 	ecc->size	= bch_geo->ecc_chunk_size;
 	ecc->strength	= bch_geo->ecc_strength;
-	ecc->layout	= &gpmi_hw_ecclayout;
+	mtd_set_ooblayout(mtd, &gpmi_ooblayout_ops);
 
 	/*
 	 * We only enable the subpage read when:
-- 
2.5.0
