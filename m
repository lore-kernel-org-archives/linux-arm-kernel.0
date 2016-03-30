From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:43 +0200
Subject: [PATCH v5 28/50] mtd: nand: diskonchip: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-29-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/diskonchip.c | 60 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 547c100..a023ab9 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -950,20 +950,50 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
 
 //u_char mydatabuf[528];
 
-/* The strange out-of-order .oobfree list below is a (possibly unneeded)
- * attempt to retain compatibility.  It used to read:
- * 	.oobfree = { {8, 8} }
- * Since that leaves two bytes unusable, it was changed.  But the following
- * scheme might affect existing jffs2 installs by moving the cleanmarker:
- * 	.oobfree = { {6, 10} }
- * jffs2 seems to handle the above gracefully, but the current scheme seems
- * safer.  The only problem with it is that any code that parses oobfree must
- * be able to handle out-of-order segments.
- */
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
+	/*
+	 * The strange out-of-order free bytes definition is a (possibly
+	 * unneeded) attempt to retain compatibility.  It used to read:
+	 *	.oobfree = { {8, 8} }
+	 * Since that leaves two bytes unusable, it was changed.  But the
+	 * following scheme might affect existing jffs2 installs by moving the
+	 * cleanmarker:
+	 *	.oobfree = { {6, 10} }
+	 * jffs2 seems to handle the above gracefully, but the current scheme
+	 * seems safer. The only problem with it is that any code retrieving
+	 * free bytes position must be able to handle out-of-order segments.
+	 */
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
@@ -1537,6 +1567,7 @@ static int __init doc_probe(unsigned long physadr)
 	nand->bbt_md		= nand->bbt_td + 1;
 
 	mtd->owner		= THIS_MODULE;
+	mtd_set_ooblayout(mtd, &doc200x_ooblayout_ops);
 
 	nand_set_controller_data(nand, doc);
 	nand->select_chip	= doc200x_select_chip;
@@ -1548,7 +1579,6 @@ static int __init doc_probe(unsigned long physadr)
 	nand->ecc.calculate	= doc200x_calculate_ecc;
 	nand->ecc.correct	= doc200x_correct_data;
 
-	nand->ecc.layout	= &doc200x_oobinfo;
 	nand->ecc.mode		= NAND_ECC_HW_SYNDROME;
 	nand->ecc.size		= 512;
 	nand->ecc.bytes		= 6;
-- 
2.5.0
