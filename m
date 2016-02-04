From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  4 Feb 2016 11:06:54 +0100
Subject: [PATCH v2 31/51] mtd: nand: diskonchip: switch to mtd_ooblayout_ops
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1454580434-32078-32-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/diskonchip.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index f170f3c..9fb63b4 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -960,10 +960,38 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
  * safer.  The only problem with it is that any code that parses oobfree must
  * be able to handle out-of-order segments.
  */
-static struct nand_ecclayout doc200x_oobinfo = {
-	.eccbytes = 6,
-	.eccpos = {0, 1, 2, 3, 4, 5},
-	.oobfree = {{8, 8}, {6, 2}}
+static int doc200x_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = 6;
+
+	return 0;
+}
+
+static int doc200x_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 8;
+		oobregion->length = 8;
+	} else {
+		oobregion->offset = 6;
+		oobregion->length = 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops doc200x_ooblayout_ops = {
+	.ecc = doc200x_ooblayout_ecc,
+	.free = doc200x_ooblayout_free,
 };
 
 /* Find the (I)NFTL Media Header, and optionally also the mirror media header.
@@ -1537,6 +1565,7 @@ static int __init doc_probe(unsigned long physadr)
 	nand->bbt_md		= nand->bbt_td + 1;
 
 	mtd->owner		= THIS_MODULE;
+	mtd_set_ooblayout(mtd, &doc200x_ooblayout_ops);
 
 	nand_set_controller_data(nand, doc);
 	nand->select_chip	= doc200x_select_chip;
@@ -1548,7 +1577,6 @@ static int __init doc_probe(unsigned long physadr)
 	nand->ecc.calculate	= doc200x_calculate_ecc;
 	nand->ecc.correct	= doc200x_correct_data;
 
-	nand->ecc.layout	= &doc200x_oobinfo;
 	nand->ecc.mode		= NAND_ECC_HW_SYNDROME;
 	nand->ecc.size		= 512;
 	nand->ecc.bytes		= 6;
-- 
2.1.4
