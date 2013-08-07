From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 7 Aug 2013 17:58:11 +0800
Subject: [PATCH] mtd: atmel_nand: move the sanity check to the beginning of
 pmecc_enable()
Message-ID: <1375869491-25137-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is better to do the sanity check for the parameter before any hardware
operation.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 1ffa52f..0e365da 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -905,15 +905,15 @@ static void pmecc_enable(struct atmel_nand_host *host, int ecc_op)
 {
 	u32 val;
 
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
-	val = pmecc_readl_relaxed(host->ecc, CFG);
-
 	if (ecc_op != NAND_ECC_READ && ecc_op != NAND_ECC_WRITE) {
 		dev_err(host->dev, "atmel_nand: wrong pmecc operation type!");
 		return;
 	}
 
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+	val = pmecc_readl_relaxed(host->ecc, CFG);
+
 	if (ecc_op == NAND_ECC_READ)
 		pmecc_writel(host->ecc, CFG, (val & ~PMECC_CFG_WRITE_OP)
 			| PMECC_CFG_AUTO_ENABLE);
-- 
1.7.9.5
