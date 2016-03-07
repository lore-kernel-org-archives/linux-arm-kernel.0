From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 10:47:16 +0100
Subject: [PATCH v4 26/52] mtd: nand: bf5xx: switch to mtd_ooblayout_ops
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457344062-11633-27-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/bf5xx_nand.c | 51 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 7f6b30e..b38f414 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -109,28 +109,33 @@ static const unsigned short bfin_nfc_pin_req[] =
 	 0};
 
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-static struct nand_ecclayout bootrom_ecclayout = {
-	.eccbytes = 24,
-	.eccpos = {
-		0x8 * 0, 0x8 * 0 + 1, 0x8 * 0 + 2,
-		0x8 * 1, 0x8 * 1 + 1, 0x8 * 1 + 2,
-		0x8 * 2, 0x8 * 2 + 1, 0x8 * 2 + 2,
-		0x8 * 3, 0x8 * 3 + 1, 0x8 * 3 + 2,
-		0x8 * 4, 0x8 * 4 + 1, 0x8 * 4 + 2,
-		0x8 * 5, 0x8 * 5 + 1, 0x8 * 5 + 2,
-		0x8 * 6, 0x8 * 6 + 1, 0x8 * 6 + 2,
-		0x8 * 7, 0x8 * 7 + 1, 0x8 * 7 + 2
-	},
-	.oobfree = {
-		{ 0x8 * 0 + 3, 5 },
-		{ 0x8 * 1 + 3, 5 },
-		{ 0x8 * 2 + 3, 5 },
-		{ 0x8 * 3 + 3, 5 },
-		{ 0x8 * 4 + 3, 5 },
-		{ 0x8 * 5 + 3, 5 },
-		{ 0x8 * 6 + 3, 5 },
-		{ 0x8 * 7 + 3, 5 },
-	}
+static int bootrom_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = section * 8;
+	oobregion->length = 3;
+
+	return 0;
+}
+
+static int bootrom_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobregion->offset = (section * 8) + 3;
+	oobregion->length = 5;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops bootrom_ooblayout_ops = {
+	.ecc = bootrom_ooblayout_ecc,
+	.free = bootrom_ooblayout_free,
 };
 #endif
 
@@ -800,7 +805,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	/* setup hardware ECC data struct */
 	if (hardware_ecc) {
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-		chip->ecc.layout = &bootrom_ecclayout;
+		mtd_set_ooblayout(mtd, &bootrom_ooblayout_ops);
 #endif
 		chip->read_buf      = bf5xx_nand_dma_read_buf;
 		chip->write_buf     = bf5xx_nand_dma_write_buf;
-- 
2.1.4
