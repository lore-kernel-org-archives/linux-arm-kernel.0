From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:18 +0100
Subject: [PATCH v4 28/52] mtd: nand: cafe: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-29-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/cafe_nand.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index aa1a616..3d59330 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -459,10 +459,37 @@ static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return max_bitflips;
 }
 
-static struct nand_ecclayout cafe_oobinfo_2048 = {
-	.eccbytes = 14,
-	.eccpos = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
-	.oobfree = {{14, 50}}
+static int cafe_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = chip->ecc.total;
+
+	return 0;
+}
+
+static int cafe_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = chip->ecc.total;
+	oobregion->length = mtd->oobsize - chip->ecc.total;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops cafe_ooblayout_ops = {
+	.ecc = cafe_ooblayout_ecc,
+	.free = cafe_ooblayout_free,
 };
 
 /* Ick. The BBT code really ought to be able to work this bit out
@@ -494,12 +521,6 @@ static struct nand_bbt_descr cafe_bbt_mirror_descr_2048 = {
 	.pattern = cafe_mirror_pattern_2048
 };
 
-static struct nand_ecclayout cafe_oobinfo_512 = {
-	.eccbytes = 14,
-	.eccpos = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
-	.oobfree = {{14, 2}}
-};
-
 static struct nand_bbt_descr cafe_bbt_main_descr_512 = {
 	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
 		| NAND_BBT_2BIT | NAND_BBT_VERSION,
@@ -743,12 +764,11 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		cafe->ctl2 |= 1<<29; /* 2KiB page size */
 
 	/* Set up ECC according to the type of chip we found */
+	mtd_set_ooblayout(mtd, &cafe_ooblayout_ops);
 	if (mtd->writesize == 2048) {
-		cafe->nand.ecc.layout = &cafe_oobinfo_2048;
 		cafe->nand.bbt_td = &cafe_bbt_main_descr_2048;
 		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_2048;
 	} else if (mtd->writesize == 512) {
-		cafe->nand.ecc.layout = &cafe_oobinfo_512;
 		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
 		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
 	} else {
-- 
2.1.4
