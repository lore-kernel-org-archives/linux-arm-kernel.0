From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:57 +0200
Subject: [PATCH v5 42/50] mtd: nand: sh_flctl: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-43-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sh_flctl.c | 87 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 4814402..fa46610 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -43,26 +43,73 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sh_flctl.h>
 
-static struct nand_ecclayout flctl_4secc_oob_16 = {
-	.eccbytes = 10,
-	.eccpos = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
-	.oobfree = {
-		{.offset = 12,
-		. length = 4} },
+static int flctl_4secc_ooblayout_sp_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int flctl_4secc_ooblayout_sp_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 12;
+	oobregion->length = 4;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops flctl_4secc_oob_smallpage_ops = {
+	.ecc = flctl_4secc_ooblayout_sp_ecc,
+	.free = flctl_4secc_ooblayout_sp_free,
 };
 
-static struct nand_ecclayout flctl_4secc_oob_64 = {
-	.eccbytes = 4 * 10,
-	.eccpos = {
-		 6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63 },
-	.oobfree = {
-		{.offset =  2, .length = 4},
-		{.offset = 16, .length = 6},
-		{.offset = 32, .length = 6},
-		{.offset = 48, .length = 6} },
+static int flctl_4secc_ooblayout_lp_ecc(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * 16) + 6;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int flctl_4secc_ooblayout_lp_free(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = section * 16;
+	oobregion->length = 6;
+
+	if (!section) {
+		oobregion->offset += 2;
+		oobregion->length -= 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops flctl_4secc_oob_largepage_ops = {
+	.ecc = flctl_4secc_ooblayout_lp_ecc,
+	.free = flctl_4secc_ooblayout_lp_free,
 };
 
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
@@ -987,10 +1034,10 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 
 	if (flctl->hwecc) {
 		if (mtd->writesize == 512) {
-			chip->ecc.layout = &flctl_4secc_oob_16;
+			mtd_set_ooblayout(mtd, &flctl_4secc_oob_smallpage_ops);
 			chip->badblock_pattern = &flctl_4secc_smallpage;
 		} else {
-			chip->ecc.layout = &flctl_4secc_oob_64;
+			mtd_set_ooblayout(mtd, &flctl_4secc_oob_largepage_ops);
 			chip->badblock_pattern = &flctl_4secc_largepage;
 		}
 
-- 
2.5.0
