From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 18:14:37 +0200
Subject: [PATCH v5 22/50] mtd: nand: atmel: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459354505-32551-23-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/atmel_nand.c | 84 ++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 321d331..46a601e 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -72,30 +72,44 @@ struct atmel_nand_nfc_caps {
 	uint32_t rb_mask;
 };
 
-/* oob layout for large page size
+/*
+ * oob layout for large page size
  * bad block info is on bytes 0 and 1
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
- */
-static struct nand_ecclayout atmel_oobinfo_large = {
-	.eccbytes = 4,
-	.eccpos = {60, 61, 62, 63},
-	.oobfree = {
-		{2, 58}
-	},
-};
-
-/* oob layout for small page size
+ *
+ * oob layout for small page size
  * bad block info is on bytes 4 and 5
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
  */
-static struct nand_ecclayout atmel_oobinfo_small = {
-	.eccbytes = 4,
-	.eccpos = {0, 1, 2, 3},
-	.oobfree = {
-		{6, 10}
-	},
+static int atmel_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = 4;
+	oobregion->offset = 0;
+
+	return 0;
+}
+
+static int atmel_ooblayout_free_sp(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = 6;
+	oobregion->length = mtd->oobsize - oobregion->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops atmel_ooblayout_sp_ops = {
+	.ecc = atmel_ooblayout_ecc_sp,
+	.free = atmel_ooblayout_free_sp,
 };
 
 struct atmel_nfc {
@@ -163,8 +177,6 @@ struct atmel_nand_host {
 	int			*pmecc_delta;
 };
 
-static struct nand_ecclayout atmel_pmecc_oobinfo;
-
 /*
  * Enable NAND.
  */
@@ -483,22 +495,6 @@ static int pmecc_get_ecc_bytes(int cap, int sector_size)
 	return (m * cap + 7) / 8;
 }
 
-static void pmecc_config_ecc_layout(struct nand_ecclayout *layout,
-				    int oobsize, int ecc_len)
-{
-	int i;
-
-	layout->eccbytes = ecc_len;
-
-	/* ECC will occupy the last ecc_len bytes continuously */
-	for (i = 0; i < ecc_len; i++)
-		layout->eccpos[i] = oobsize - ecc_len + i;
-
-	layout->oobfree[0].offset = PMECC_OOB_RESERVED_BYTES;
-	layout->oobfree[0].length =
-		oobsize - ecc_len - layout->oobfree[0].offset;
-}
-
 static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
 {
 	int table_size;
@@ -1013,8 +1009,8 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct atmel_nand_host *host = nand_get_controller_data(nand_chip);
+	int eccbytes = mtd_ooblayout_count_eccbytes(mtd);
 	uint32_t val = 0;
-	struct nand_ecclayout *ecc_layout;
 	struct mtd_oob_region oobregion;
 
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
@@ -1065,12 +1061,11 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 		| PMECC_CFG_AUTO_DISABLE);
 	pmecc_writel(host->ecc, CFG, val);
 
-	ecc_layout = nand_chip->ecc.layout;
 	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
 	mtd_ooblayout_ecc(mtd, 0, &oobregion);
 	pmecc_writel(host->ecc, SADDR, oobregion.offset);
 	pmecc_writel(host->ecc, EADDR,
-		     oobregion.offset + ecc_layout->eccbytes - 1);
+		     oobregion.offset + eccbytes - 1);
 	/* See datasheet about PMECC Clock Control Register */
 	pmecc_writel(host->ecc, CLK, 2);
 	pmecc_writel(host->ecc, IDR, 0xff);
@@ -1292,11 +1287,8 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 			err_no = -EINVAL;
 			goto err;
 		}
-		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
-					mtd->oobsize,
-					nand_chip->ecc.total);
 
-		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		break;
 	default:
 		dev_warn(host->dev,
@@ -1644,19 +1636,19 @@ static int atmel_hw_nand_init_params(struct platform_device *pdev,
 	/* set ECC page size and oob layout */
 	switch (mtd->writesize) {
 	case 512:
-		nand_chip->ecc.layout = &atmel_oobinfo_small;
+		mtd_set_ooblayout(mtd, &atmel_ooblayout_sp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
 		break;
 	case 1024:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
 		break;
 	case 2048:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
 		break;
 	case 4096:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
 		break;
 	default:
-- 
2.5.0
