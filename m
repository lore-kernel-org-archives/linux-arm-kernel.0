From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:15:00 +0200
Subject: [PATCH v5 45/50] mtd: nand: vf610: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-46-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/vf610_nfc.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 293feb1..da34de1 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -175,34 +175,6 @@ static inline struct vf610_nfc *mtd_to_nfc(struct mtd_info *mtd)
 	return container_of(mtd_to_nand(mtd), struct vf610_nfc, chip);
 }
 
-static struct nand_ecclayout vf610_nfc_ecc45 = {
-	.eccbytes = 45,
-	.eccpos = {19, 20, 21, 22, 23,
-		   24, 25, 26, 27, 28, 29, 30, 31,
-		   32, 33, 34, 35, 36, 37, 38, 39,
-		   40, 41, 42, 43, 44, 45, 46, 47,
-		   48, 49, 50, 51, 52, 53, 54, 55,
-		   56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = {
-		{.offset = 2,
-		 .length = 17} }
-};
-
-static struct nand_ecclayout vf610_nfc_ecc60 = {
-	.eccbytes = 60,
-	.eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
-		   12, 13, 14, 15, 16, 17, 18, 19,
-		   20, 21, 22, 23, 24, 25, 26, 27,
-		   28, 29, 30, 31, 32, 33, 34, 35,
-		   36, 37, 38, 39, 40, 41, 42, 43,
-		   44, 45, 46, 47, 48, 49, 50, 51,
-		   52, 53, 54, 55, 56, 57, 58, 59,
-		   60, 61, 62, 63 },
-	.oobfree = {
-		{.offset = 2,
-		 .length = 2} }
-};
-
 static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
 {
 	return readl(nfc->regs + reg);
@@ -781,14 +753,16 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		if (mtd->oobsize > 64)
 			mtd->oobsize = 64;
 
+		/*
+		 * mtd->ecclayout is not specified here because we're using the
+		 * default large page ECC layout defined in NAND core.
+		 */
 		if (chip->ecc.strength == 32) {
 			nfc->ecc_mode = ECC_60_BYTE;
 			chip->ecc.bytes = 60;
-			chip->ecc.layout = &vf610_nfc_ecc60;
 		} else if (chip->ecc.strength == 24) {
 			nfc->ecc_mode = ECC_45_BYTE;
 			chip->ecc.bytes = 45;
-			chip->ecc.layout = &vf610_nfc_ecc45;
 		} else {
 			dev_err(nfc->dev, "Unsupported ECC strength\n");
 			err = -ENXIO;
-- 
2.5.0
