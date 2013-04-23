From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 23 Apr 2013 18:29:54 +0800
Subject: [PATCH 1/4] mtd: atmel_nand: replace pmecc enable code with one
 function.
In-Reply-To: <1366712997-17639-1-git-send-email-josh.wu@atmel.com>
References: <1366712997-17639-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1366712997-17639-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c     |   35 ++++++++++++++++++++---------------
 drivers/mtd/nand/atmel_nand_ecc.h |    7 ++++++-
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index ffcbcca..cd9aba2 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -763,6 +763,24 @@ normal_check:
 	return total_err;
 }
 
+static void pmecc_enable(struct atmel_nand_host *host, enum pmecc_op op)
+{
+	u32 val;
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+	val = pmecc_readl_relaxed(host->ecc, CFG);
+
+	if (op == PMECC_READ)
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
@@ -774,13 +792,7 @@ static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
 	unsigned long end_time;
 	int bitflips = 0;
 
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
-	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG)
-		& ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
-
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
-	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+	pmecc_enable(host, PMECC_READ);
 
 	chip->read_buf(mtd, buf, eccsize);
 	chip->read_buf(mtd, oob, mtd->oobsize);
@@ -813,14 +825,7 @@ static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
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
+	pmecc_enable(host, PMECC_WRITE);
 
 	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
 
diff --git a/drivers/mtd/nand/atmel_nand_ecc.h b/drivers/mtd/nand/atmel_nand_ecc.h
index 8a1e9a6..b397f77 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -3,7 +3,7 @@
  * Based on AT91SAM9260 datasheet revision B.
  *
  * Copyright (C) 2007 Andrew Victor
- * Copyright (C) 2007 - 2012 Atmel Corporation.
+ * Copyright (C) 2007 - 2013 Atmel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -148,4 +148,9 @@
 /* Time out value for reading PMECC status register */
 #define PMECC_MAX_TIMEOUT_MS			100
 
+enum pmecc_op {
+	PMECC_READ,
+	PMECC_WRITE,
+};
+
 #endif
-- 
1.7.9.5
