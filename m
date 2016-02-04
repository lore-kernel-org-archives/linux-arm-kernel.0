From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  4 Feb 2016 11:07:06 +0100
Subject: [PATCH v2 43/51] mtd: nand: s3c2410: switch to mtd_ooblayout_ops
In-Reply-To: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1454580434-32078-44-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/s3c2410.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 9c9397b..efa339b 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -84,11 +84,33 @@
 
 /* new oob placement block for use with hardware ecc generation
  */
+static int s3c2410_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oov_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 0;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static int s3c2410_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oov_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 8;
+	oobregion->length = 8;
+
+	return 0;
+}
 
-static struct nand_ecclayout nand_hw_eccoob = {
-	.eccbytes = 3,
-	.eccpos = {0, 1, 2},
-	.oobfree = {{8, 8}}
+const struct mtd_ooblayout_ops s3c2410_ooblayout_ops = {
+	.eccpos = s3c2410_eccpos,
+	.oobfree = s3c2410_oobfree,
 };
 
 /* controller and mtd information */
@@ -919,7 +941,7 @@ static void s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 	} else {
 		chip->ecc.size	    = 512;
 		chip->ecc.bytes	    = 3;
-		chip->ecc.layout    = &nand_hw_eccoob;
+		mtd_set_ooblayout(nand_to_mtd(chip), &s3c2410_ooblayout_ops);
 	}
 }
 
-- 
2.1.4
