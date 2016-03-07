From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:20 +0100
Subject: [PATCH v4 30/52] mtd: nand: denali: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-31-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/denali.c | 50 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 30bf5f6..0476ae8 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1374,13 +1374,41 @@ static void denali_hw_init(struct denali_nand_info *denali)
  * correction
  */
 #define ECC_8BITS	14
-static struct nand_ecclayout nand_8bit_oob = {
-	.eccbytes = 14,
-};
-
 #define ECC_15BITS	26
-static struct nand_ecclayout nand_15bit_oob = {
-	.eccbytes = 26,
+
+static int denali_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *oobregion)
+{
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = denali->bbtskipbytes;
+	oobregion->length = chip->ecc.total;
+
+	return 0;
+}
+
+static int denali_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = chip->ecc.total + denali->bbtskipbytes;
+	oobregion->length = mtd->oobsize - oobregion->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops denali_ooblayout_ops = {
+	.ecc = denali_ooblayout_ecc,
+	.free = denali_ooblayout_free,
 };
 
 static uint8_t bbt_pattern[] = {'B', 'b', 't', '0' };
@@ -1561,7 +1589,6 @@ int denali_init(struct denali_nand_info *denali)
 			ECC_SECTOR_SIZE)))) {
 		/* if MLC OOB size is large enough, use 15bit ECC*/
 		denali->nand.ecc.strength = 15;
-		denali->nand.ecc.layout = &nand_15bit_oob;
 		denali->nand.ecc.bytes = ECC_15BITS;
 		iowrite32(15, denali->flash_reg + ECC_CORRECTION);
 	} else if (mtd->oobsize < (denali->bbtskipbytes +
@@ -1571,20 +1598,13 @@ int denali_init(struct denali_nand_info *denali)
 		goto failed_req_irq;
 	} else {
 		denali->nand.ecc.strength = 8;
-		denali->nand.ecc.layout = &nand_8bit_oob;
 		denali->nand.ecc.bytes = ECC_8BITS;
 		iowrite32(8, denali->flash_reg + ECC_CORRECTION);
 	}
 
+	mtd_set_ooblayout(mtd, &denali_ooblayout_ops);
 	denali->nand.ecc.bytes *= denali->devnum;
 	denali->nand.ecc.strength *= denali->devnum;
-	denali->nand.ecc.layout->eccbytes *=
-		mtd->writesize / ECC_SECTOR_SIZE;
-	denali->nand.ecc.layout->oobfree[0].offset =
-		denali->bbtskipbytes + denali->nand.ecc.layout->eccbytes;
-	denali->nand.ecc.layout->oobfree[0].length =
-		mtd->oobsize - denali->nand.ecc.layout->eccbytes -
-		denali->bbtskipbytes;
 
 	/*
 	 * Let driver know the total blocks number and how many blocks
-- 
2.1.4
