From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:15 +0100
Subject: [PATCH 20/23] mtd: onenand: switch to mtd_ooblayout_ops
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-21-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users. Modify the onenand drivers to switch to this
approach.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/onenand/onenand_base.c | 144 +++++++++++++++++++++----------------
 include/linux/mtd/onenand.h        |   2 -
 2 files changed, 82 insertions(+), 64 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index b5937b7..5c7ff9f 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -68,21 +68,29 @@ MODULE_PARM_DESC(otp,	"Corresponding behaviour of OneNAND in OTP"
  * flexonenand_oob_128 - oob info for Flex-Onenand with 4KB page
  * For now, we expose only 64 out of 80 ecc bytes
  */
-static struct nand_ecclayout flexonenand_oob_128 = {
-	.eccbytes	= 64,
-	.eccpos		= {
-		6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
-		22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-		70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-		86, 87, 88, 89, 90, 91, 92, 93, 94, 95,
-		102, 103, 104, 105
-		},
-	.oobfree	= {
-		{2, 4}, {18, 4}, {34, 4}, {50, 4},
-		{66, 4}, {82, 4}, {98, 4}, {114, 4}
-	}
+static int flexonenand_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 79)
+		return -ERANGE;
+
+	return ((eccbyte / 10) * 16) + 6 + (eccbyte % 10);
+}
+
+static int flexonenand_oobfree(struct mtd_info *mtd, int section,
+			       struct nand_oobfree *oobfree)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 2;
+	oobfree->length = 4;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops flexonenand_ooblayout_ops = {
+	.eccpos = flexonenand_eccpos,
+	.oobfree = flexonenand_oobfree,
 };
 
 /*
@@ -91,56 +99,69 @@ static struct nand_ecclayout flexonenand_oob_128 = {
  * Based on specification:
  * 4Gb M-die OneNAND Flash (KFM4G16Q4M, KFN8G16Q4M). Rev. 1.3, Apr. 2010
  *
- * For eccpos we expose only 64 bytes out of 72 (see struct nand_ecclayout)
- *
  * oobfree uses the spare area fields marked as
  * "Managed by internal ECC logic for Logical Sector Number area"
  */
-static struct nand_ecclayout onenand_oob_128 = {
-	.eccbytes	= 64,
-	.eccpos		= {
-		7, 8, 9, 10, 11, 12, 13, 14, 15,
-		23, 24, 25, 26, 27, 28, 29, 30, 31,
-		39, 40, 41, 42, 43, 44, 45, 46, 47,
-		55, 56, 57, 58, 59, 60, 61, 62, 63,
-		71, 72, 73, 74, 75, 76, 77, 78, 79,
-		87, 88, 89, 90, 91, 92, 93, 94, 95,
-		103, 104, 105, 106, 107, 108, 109, 110, 111,
-		119
-	},
-	.oobfree	= {
-		{2, 3}, {18, 3}, {34, 3}, {50, 3},
-		{66, 3}, {82, 3}, {98, 3}, {114, 3}
-	}
+static int onenand_oob_128_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte >= 72)
+		return -ERANGE;
+
+	return ((eccbyte / 9) * 16) + 7 + (eccbyte % 9);
+}
+
+static int onenand_oob_128_oobfree(struct mtd_info *mtd, int section,
+				   struct nand_oobfree *oobfree)
+{
+	if (section >= 8)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 2;
+	oobfree->length = 3;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops onenand_oob_128_ooblayout_ops = {
+	.eccpos = onenand_oob_128_eccpos,
+	.oobfree = onenand_oob_128_oobfree,
 };
 
 /**
- * onenand_oob_64 - oob info for large (2KB) page
+ * onenand_oob_32_64 - oob info for large (2KB) page
  */
-static struct nand_ecclayout onenand_oob_64 = {
-	.eccbytes	= 20,
-	.eccpos		= {
-		8, 9, 10, 11, 12,
-		24, 25, 26, 27, 28,
-		40, 41, 42, 43, 44,
-		56, 57, 58, 59, 60,
-		},
-	.oobfree	= {
-		{2, 3}, {14, 2}, {18, 3}, {30, 2},
-		{34, 3}, {46, 2}, {50, 3}, {62, 2}
+static int onenand_oob_32_64_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	int eccbytes = (mtd->oobsize / 32) * 10;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return ((eccbyte / 5) * 16) + 8 + (eccbyte % 5);
+}
+
+static int onenand_oob_32_64_oobfree(struct mtd_info *mtd, int section,
+				     struct nand_oobfree *oobfree)
+{
+	int sections = (mtd->oobsize / 32) * 2;
+
+	if (section >= sections)
+		return -ERANGE;
+
+	if (section & 1) {
+		oobfree->offset = ((section - 1) * 16) + 14;
+		oobfree->length = 2;
+	} else  {
+		oobfree->offset = (section * 16) + 2;
+		oobfree->length = 3;
 	}
-};
 
-/**
- * onenand_oob_32 - oob info for middle (1KB) page
- */
-static struct nand_ecclayout onenand_oob_32 = {
-	.eccbytes	= 10,
-	.eccpos		= {
-		8, 9, 10, 11, 12,
-		24, 25, 26, 27, 28,
-		},
-	.oobfree	= { {2, 3}, {14, 2}, {18, 3}, {30, 2} }
+	return 0;
+}
+
+const struct mtd_ooblayout_ops onenand_oob_32_64_ooblayout_ops = {
+	.eccpos = onenand_oob_32_64_eccpos,
+	.oobfree = onenand_oob_32_64_oobfree,
 };
 
 static const unsigned char ffchars[] = {
@@ -4019,22 +4040,22 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	switch (mtd->oobsize) {
 	case 128:
 		if (FLEXONENAND(this)) {
-			this->ecclayout = &flexonenand_oob_128;
+			mtd_set_ooblayout(mtd, &flexonenand_ooblayout_ops);
 			mtd->subpage_sft = 0;
 		} else {
-			this->ecclayout = &onenand_oob_128;
+			mtd_set_ooblayout(mtd, &onenand_oob_128_ooblayout_ops);
 			mtd->subpage_sft = 2;
 		}
 		if (ONENAND_IS_NOP_1(this))
 			mtd->subpage_sft = 0;
 		break;
 	case 64:
-		this->ecclayout = &onenand_oob_64;
+		mtd_set_ooblayout(mtd, &onenand_oob_32_64_ooblayout_ops);
 		mtd->subpage_sft = 2;
 		break;
 
 	case 32:
-		this->ecclayout = &onenand_oob_32;
+		mtd_set_ooblayout(mtd, &onenand_oob_32_64_ooblayout_ops);
 		mtd->subpage_sft = 1;
 		break;
 
@@ -4043,7 +4064,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 			__func__, mtd->oobsize);
 		mtd->subpage_sft = 0;
 		/* To prevent kernel oops */
-		this->ecclayout = &onenand_oob_32;
+		mtd_set_ooblayout(mtd, &onenand_oob_32_64_ooblayout_ops);
 		break;
 	}
 
@@ -4059,7 +4080,6 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	     mtd_oobfree(mtd, i++, &oobfree))
 		mtd->oobavail += oobfree.length;
 
-	mtd_set_ecclayout(mtd, this->ecclayout);
 	mtd->ecc_strength = 1;
 
 	/* Fill in remaining MTD driver data */
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 4596503..0aaa98b 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -80,7 +80,6 @@ struct onenand_bufferram {
  * @page_buf:		[INTERN] page main data buffer
  * @oob_buf:		[INTERN] page oob data buffer
  * @subpagesize:	[INTERN] holds the subpagesize
- * @ecclayout:		[REPLACEABLE] the default ecc placement scheme
  * @bbm:		[REPLACEABLE] pointer to Bad Block Management
  * @priv:		[OPTIONAL] pointer to private chip date
  */
@@ -134,7 +133,6 @@ struct onenand_chip {
 #endif
 
 	int			subpagesize;
-	struct nand_ecclayout	*ecclayout;
 
 	void			*bbm;
 
-- 
2.1.4
