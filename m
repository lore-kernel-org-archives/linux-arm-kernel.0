From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:44 +0200
Subject: [PATCH v5 29/50] mtd: nand: docg4: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-30-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/docg4.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index d86a60e..4731699 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -222,10 +222,33 @@ struct docg4_priv {
  * Bytes 8 - 14 are hw-generated ecc covering entire page + oob bytes 0 - 14.
  * Byte 15 (the last) is used by the driver as a "page written" flag.
  */
-static struct nand_ecclayout docg4_oobinfo = {
-	.eccbytes = 9,
-	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {.offset = 2, .length = 5} }
+static int docg4_ooblayout_ecc(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 7;
+	oobregion->length = 9;
+
+	return 0;
+}
+
+static int docg4_ooblayout_free(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 2;
+	oobregion->length = 5;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops docg4_ooblayout_ops = {
+	.ecc = docg4_ooblayout_ecc,
+	.free = docg4_ooblayout_free,
 };
 
 /*
@@ -1209,6 +1232,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	mtd->writesize = DOCG4_PAGE_SIZE;
 	mtd->erasesize = DOCG4_BLOCK_SIZE;
 	mtd->oobsize = DOCG4_OOB_SIZE;
+	mtd_set_ooblayout(mtd, &docg4_ooblayout_ops);
 	nand->chipsize = DOCG4_CHIP_SIZE;
 	nand->chip_shift = DOCG4_CHIP_SHIFT;
 	nand->bbt_erase_shift = nand->phys_erase_shift = DOCG4_ERASE_SHIFT;
@@ -1217,7 +1241,6 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	nand->pagemask = 0x3ffff;
 	nand->badblockpos = NAND_LARGE_BADBLOCK_POS;
 	nand->badblockbits = 8;
-	nand->ecc.layout = &docg4_oobinfo;
 	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
 	nand->ecc.size = DOCG4_PAGE_SIZE;
 	nand->ecc.prepad = 8;
-- 
2.5.0
