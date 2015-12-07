From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:11 +0100
Subject: [PATCH 16/23] mtd: docg3: switch to mtd_ooblayout_ops
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-17-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/devices/docg3.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 6b516e1..7463dd8 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -73,10 +73,34 @@ MODULE_PARM_DESC(reliable_mode, "Set the docg3 mode (0=normal MLC, 1=fast, "
  * @eccpos: ecc positions (byte 7 is Hamming ECC, byte 8-14 are BCH ECC)
  * @oobfree: free pageinfo bytes (byte 0 until byte 6, byte 15
  */
-static struct nand_ecclayout docg3_oobinfo = {
-	.eccbytes = 8,
-	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14},
-	.oobfree = {{0, 7}, {15, 1} },
+static int docg3_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte >= 8)
+		return -ERANGE;
+
+	return eccbyte + 7;
+}
+
+static int docg3_oobfree(struct mtd_info *mtd, int section,
+			 struct nand_oobfree *oobfree)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobfree->offset = 0;
+		oobfree->length = 7;
+	} else {
+		oobfree->offset = 15;
+		oobfree->length = 1;
+	}
+
+	return 0;
+}
+
+static const struct nand_ooblayout_ops nand_ooblayout_docg3_ops = {
+	.eccpos = docg3_eccpos,
+	.oobfree = docg3_oobfree,
 };
 
 static inline u8 doc_readb(struct docg3 *docg3, u16 reg)
@@ -1857,7 +1881,7 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 	mtd->_read_oob = doc_read_oob;
 	mtd->_write_oob = doc_write_oob;
 	mtd->_block_isbad = doc_block_isbad;
-	mtd_set_ecclayout(mtd, &docg3_oobinfo);
+	mtd_set_ooblayout_ops(mtd, &nand_ooblayout_docg3_ops);
 	mtd->oobavail = 8;
 	mtd->ecc_strength = DOC_ECC_BCH_T;
 
-- 
2.1.4
