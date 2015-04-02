From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 2 Apr 2015 14:12:33 +0800
Subject: [PATCH] mtd: atmel_nand: add a definition for the oob reserved bytes
Message-ID: <1427955153-8851-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's better to use a macro instead of just a number.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 drivers/mtd/nand/atmel_nand.c     | 5 +++--
 drivers/mtd/nand/atmel_nand_ecc.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index feaac90..0361c19 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -485,7 +485,7 @@ static void pmecc_config_ecc_layout(struct nand_ecclayout *layout,
 	for (i = 0; i < ecc_len; i++)
 		layout->eccpos[i] = oobsize - ecc_len + i;
 
-	layout->oobfree[0].offset = 2;
+	layout->oobfree[0].offset = PMECC_OOB_RESERVED_BYTES;
 	layout->oobfree[0].length =
 		oobsize - ecc_len - layout->oobfree[0].offset;
 }
@@ -1254,7 +1254,8 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 		nand_chip->ecc.steps = mtd->writesize / sector_size;
 		nand_chip->ecc.total = nand_chip->ecc.bytes *
 			nand_chip->ecc.steps;
-		if (nand_chip->ecc.total > mtd->oobsize - 2) {
+		if (nand_chip->ecc.total >
+				mtd->oobsize - PMECC_OOB_RESERVED_BYTES) {
 			dev_err(host->dev, "No room for ECC bytes\n");
 			err_no = -EINVAL;
 			goto err;
diff --git a/drivers/mtd/nand/atmel_nand_ecc.h b/drivers/mtd/nand/atmel_nand_ecc.h
index d4035e3..668e735 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -152,4 +152,7 @@
 /* Time out value for reading PMECC status register */
 #define PMECC_MAX_TIMEOUT_MS			100
 
+/* Reserved bytes in oob area */
+#define PMECC_OOB_RESERVED_BYTES		2
+
 #endif
-- 
1.9.1
