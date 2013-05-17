From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 17 May 2013 17:51:45 +0800
Subject: [PATCH v2 1/4] mtd: atmel_nand: replace pmecc enable code with one
 function.
In-Reply-To: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1368784308-7600-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v1 --> v2:
 use the exist constants (NAND_ECC_READ/WRITE) instead of define new enums.

 drivers/mtd/nand/atmel_nand.c |   40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2d23d29..f747791 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -763,6 +763,29 @@ normal_check:
 	return total_err;
 }
 
+static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
+{
+	u32 val;
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+	val = pmecc_readl_relaxed(host->ecc, CFG);
+
+	if (ecc_op != NAND_ECC_READ && ecc_op != NAND_ECC_WRITE) {
+		dev_err(host->dev, "atmel_nand: wrong pmecc operation type!");
+		return;
+	}
+
+	if (ecc_op == NAND_ECC_READ)
+		pmecc_writel(host->ecc, CFG, (val & ~PMECC_CFG_WRITE_OP)
+			| PMECC_CFG_AUTO_ENABLE);
+	else
+		pmecc_writel(host->ecc, CFG, (val | PMECC_CFG_WRITE_OP)
+			& ~PMECC_CFG_AUTO_ENABLE);
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+}
+
 static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
 {
@@ -774,13 +797,7 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	unsigned long end_time;
 	int bitflips = 0;
 
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
-	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG)
-		& ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
-
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+	pmecc_enable(host, NAND_ECC_READ);
 
 	chip->read_buf(mtd, buf, eccsize);
 	chip->read_buf(mtd, oob, mtd->oobsize);
@@ -813,14 +830,7 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
 	int i, j;
 	unsigned long end_time;
 
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
-
-	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG) |
-		PMECC_CFG_WRITE_OP) & ~PMECC_CFG_AUTO_ENABLE);
-
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+	pmecc_enable(host, NAND_ECC_WRITE);
 
 	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
 
-- 
1.7.9.5
