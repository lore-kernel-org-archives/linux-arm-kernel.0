From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:15:01 +0200
Subject: [PATCH v5 46/50] mtd: nand: qcom: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-47-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Archit Taneja <architt@codeaurora.org>
---
 drivers/mtd/nand/qcom_nandc.c | 79 +++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index 012c202..8c3db3c 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -1708,61 +1708,52 @@ static void qcom_nandc_select_chip(struct mtd_info *mtd, int chipnr)
  * This layout is read as is when ECC is disabled. When ECC is enabled, the
  * inaccessible Bad Block byte(s) are ignored when we write to a page/oob,
  * and assumed as 0xffs when we read a page/oob. The ECC, unused and
- * dummy/real bad block bytes are grouped as ecc bytes in nand_ecclayout (i.e,
- * ecc->bytes is the sum of the three).
+ * dummy/real bad block bytes are grouped as ecc bytes (i.e, ecc->bytes is
+ * the sum of the three).
  */
-
-static struct nand_ecclayout *
-qcom_nand_create_layout(struct qcom_nand_host *host)
+static int qcom_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
 {
-	struct nand_chip *chip = &host->chip;
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct nand_ecclayout *layout;
-	int i, j, steps, pos = 0, shift = 0;
 
-	layout = devm_kzalloc(nandc->dev, sizeof(*layout), GFP_KERNEL);
-	if (!layout)
-		return NULL;
+	if (section > 1)
+		return -ERANGE;
 
-	steps = mtd->writesize / ecc->size;
-	layout->eccbytes = steps * ecc->bytes;
-
-	layout->oobfree[0].offset = (steps - 1) * ecc->bytes + host->bbm_size;
-	layout->oobfree[0].length = steps << 2;
-
-	/*
-	 * the oob bytes in the first n - 1 codewords are all grouped together
-	 * in the format:
-	 * DUMMY_BBM + UNUSED + ECC
-	 */
-	for (i = 0; i < steps - 1; i++) {
-		for (j = 0; j < ecc->bytes; j++)
-			layout->eccpos[pos++] = i * ecc->bytes + j;
+	if (!section) {
+		oobregion->length = (ecc->bytes * (ecc->steps - 1)) +
+				    host->bbm_size;
+		oobregion->offset = 0;
+	} else {
+		oobregion->length = host->ecc_bytes_hw + host->spare_bytes;
+		oobregion->offset = mtd->oobsize - oobregion->length;
 	}
 
-	/*
-	 * the oob bytes in the last codeword are grouped in the format:
-	 * BBM + FREE OOB + UNUSED + ECC
-	 */
+	return 0;
+}
 
-	/* fill up the bbm positions */
-	for (j = 0; j < host->bbm_size; j++)
-		layout->eccpos[pos++] = i * ecc->bytes + j;
+static int qcom_nand_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
 
-	/*
-	 * fill up the ecc and reserved positions, their indices are offseted
-	 * by the free oob region
-	 */
-	shift = layout->oobfree[0].length + host->bbm_size;
+	if (section)
+		return -ERANGE;
 
-	for (j = 0; j < (host->ecc_bytes_hw + host->spare_bytes); j++)
-		layout->eccpos[pos++] = i * ecc->bytes + shift + j;
+	oobregion->length = ecc->steps * 4;
+	oobregion->offset = ((ecc->steps - 1) * ecc->bytes) + host->bbm_size;
 
-	return layout;
+	return 0;
 }
 
+static const struct mtd_ooblayout_ops qcom_nand_ooblayout_ops = {
+	.ecc = qcom_nand_ooblayout_ecc,
+	.free = qcom_nand_ooblayout_free,
+};
+
 static int qcom_nand_host_setup(struct qcom_nand_host *host)
 {
 	struct nand_chip *chip = &host->chip;
@@ -1849,9 +1840,7 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
 
 	ecc->mode = NAND_ECC_HW;
 
-	ecc->layout = qcom_nand_create_layout(host);
-	if (!ecc->layout)
-		return -ENOMEM;
+	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
 
 	cwperpage = mtd->writesize / ecc->size;
 
-- 
2.5.0
