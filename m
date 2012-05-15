From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 15 May 2012 22:47:34 +0800
Subject: [PATCH v7 1/3] MTD: at91: extract hw ecc initialization to one
 function
In-Reply-To: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1337093256-19117-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hong Xu <hong.xu@atmel.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c     |  147 ++++++++++++++++++++-----------------
 drivers/mtd/nand/atmel_nand_ecc.h |    8 +-
 2 files changed, 85 insertions(+), 70 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2165576..52ca295 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -42,20 +42,15 @@
 
 #include <mach/cpu.h>
 
+/* Hardware ECC registers */
+#include "atmel_nand_ecc.h"
+
 static int use_dma = 1;
 module_param(use_dma, int, 0);
 
 static int on_flash_bbt = 0;
 module_param(on_flash_bbt, int, 0);
 
-/* Register access macros */
-#define ecc_readl(add, reg)				\
-	__raw_readl(add + ATMEL_ECC_##reg)
-#define ecc_writel(add, reg, value)			\
-	__raw_writel((value), add + ATMEL_ECC_##reg)
-
-#include "atmel_nand_ecc.h"	/* Hardware ECC registers */
-
 /* oob layout for large page size
  * bad block info is on bytes 0 and 1
  * the bytes have to be consecutives to avoid
@@ -523,6 +518,75 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 }
 #endif
 
+static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
+					 struct atmel_nand_host *host)
+{
+	struct resource		*regs;
+	struct mtd_info		*mtd;
+	struct nand_chip	*nand_chip;
+
+	nand_chip = &host->nand_chip;
+	mtd = &host->mtd;
+
+	nand_chip->ecc.mode = NAND_ECC_SOFT;
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!regs) {
+		dev_err(host->dev, "Can't get I/O resource regs\n" \
+			"Rolling back on software ECC\n");
+	} else {
+		host->ecc = ioremap(regs->start, resource_size(regs));
+		if (host->ecc == NULL) {
+			printk(KERN_ERR "atmel_nand: ioremap failed\n");
+			return -EIO;
+		}
+
+		nand_chip->ecc.mode = NAND_ECC_HW;
+		nand_chip->ecc.calculate = atmel_nand_calculate;
+		nand_chip->ecc.correct = atmel_nand_correct;
+		nand_chip->ecc.hwctl = atmel_nand_hwctl;
+		nand_chip->ecc.read_page = atmel_nand_read_page;
+		nand_chip->ecc.bytes = 4;
+		nand_chip->ecc.strength = 1;
+
+		/* ECC is calculated for the whole page (1 step) */
+		nand_chip->ecc.size = mtd->writesize;
+
+		/* set ECC page size and oob layout */
+		switch (mtd->writesize) {
+		case 512:
+			nand_chip->ecc.layout = &atmel_oobinfo_small;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
+			break;
+		case 1024:
+			nand_chip->ecc.layout = &atmel_oobinfo_large;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
+			break;
+		case 2048:
+			nand_chip->ecc.layout = &atmel_oobinfo_large;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
+			break;
+		case 4096:
+			nand_chip->ecc.layout = &atmel_oobinfo_large;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
+			break;
+		default:
+			/* page size not handled by HW ECC */
+			/* switching back to soft ECC */
+			nand_chip->ecc.mode = NAND_ECC_SOFT;
+			nand_chip->ecc.calculate = NULL;
+			nand_chip->ecc.correct = NULL;
+			nand_chip->ecc.hwctl = NULL;
+			nand_chip->ecc.read_page = NULL;
+			nand_chip->ecc.postpad = 0;
+			nand_chip->ecc.prepad = 0;
+			nand_chip->ecc.bytes = 0;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Probe for the NAND device.
  */
@@ -531,7 +595,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct atmel_nand_host *host;
 	struct mtd_info *mtd;
 	struct nand_chip *nand_chip;
-	struct resource *regs;
 	struct resource *mem;
 	struct mtd_part_parser_data ppdata = {};
 	int res;
@@ -583,29 +646,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		nand_chip->dev_ready = atmel_nand_device_ready;
 
 	nand_chip->ecc.mode = host->board.ecc_mode;
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!regs && nand_chip->ecc.mode == NAND_ECC_HW) {
-		printk(KERN_ERR "atmel_nand: can't get I/O resource "
-				"regs\nFalling back on software ECC\n");
-		nand_chip->ecc.mode = NAND_ECC_SOFT;
-	}
-
-	if (nand_chip->ecc.mode == NAND_ECC_HW) {
-		host->ecc = ioremap(regs->start, resource_size(regs));
-		if (host->ecc == NULL) {
-			printk(KERN_ERR "atmel_nand: ioremap failed\n");
-			res = -EIO;
-			goto err_ecc_ioremap;
-		}
-		nand_chip->ecc.calculate = atmel_nand_calculate;
-		nand_chip->ecc.correct = atmel_nand_correct;
-		nand_chip->ecc.hwctl = atmel_nand_hwctl;
-		nand_chip->ecc.read_page = atmel_nand_read_page;
-		nand_chip->ecc.bytes = 4;
-		nand_chip->ecc.strength = 1;
-	}
-
 	nand_chip->chip_delay = 20;		/* 20us command delay time */
 
 	if (host->board.bus_width_16)	/* 16-bit bus width */
@@ -657,40 +697,9 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	}
 
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
-		/* ECC is calculated for the whole page (1 step) */
-		nand_chip->ecc.size = mtd->writesize;
-
-		/* set ECC page size and oob layout */
-		switch (mtd->writesize) {
-		case 512:
-			nand_chip->ecc.layout = &atmel_oobinfo_small;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
-			break;
-		case 1024:
-			nand_chip->ecc.layout = &atmel_oobinfo_large;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
-			break;
-		case 2048:
-			nand_chip->ecc.layout = &atmel_oobinfo_large;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
-			break;
-		case 4096:
-			nand_chip->ecc.layout = &atmel_oobinfo_large;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
-			break;
-		default:
-			/* page size not handled by HW ECC */
-			/* switching back to soft ECC */
-			nand_chip->ecc.mode = NAND_ECC_SOFT;
-			nand_chip->ecc.calculate = NULL;
-			nand_chip->ecc.correct = NULL;
-			nand_chip->ecc.hwctl = NULL;
-			nand_chip->ecc.read_page = NULL;
-			nand_chip->ecc.postpad = 0;
-			nand_chip->ecc.prepad = 0;
-			nand_chip->ecc.bytes = 0;
-			break;
-		}
+		res = atmel_hw_nand_init_params(pdev, host);
+		if (res != 0)
+			goto err_hw_ecc;
 	}
 
 	/* second phase scan */
@@ -707,15 +716,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		return res;
 
 err_scan_tail:
+	if (host->ecc)
+		iounmap(host->ecc);
+err_hw_ecc:
 err_scan_ident:
 err_no_card:
 	atmel_nand_disable(host);
 	platform_set_drvdata(pdev, NULL);
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
-	if (host->ecc)
-		iounmap(host->ecc);
-err_ecc_ioremap:
 	iounmap(host->io_base);
 err_nand_ioremap:
 	kfree(host);
diff --git a/drivers/mtd/nand/atmel_nand_ecc.h b/drivers/mtd/nand/atmel_nand_ecc.h
index 578c776..b437567 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -3,7 +3,7 @@
  * Based on AT91SAM9260 datasheet revision B.
  *
  * Copyright (C) 2007 Andrew Victor
- * Copyright (C) 2007 Atmel Corporation.
+ * Copyright (C) 2007 - 2012 Atmel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -36,4 +36,10 @@
 #define ATMEL_ECC_NPR		0x10			/* NParity register */
 #define		ATMEL_ECC_NPARITY	(0xffff << 0)		/* NParity */
 
+/* Register Access Macros */
+#define ecc_readl(add, reg)				\
+	__raw_readl(add + ATMEL_ECC_##reg)
+#define ecc_writel(add, reg, value)			\
+	__raw_writel((value), add + ATMEL_ECC_##reg)
+
 #endif
-- 
1.7.10
