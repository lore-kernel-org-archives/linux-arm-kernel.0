From: josh.wu@atmel.com (Josh Wu)
Date: Sat, 26 May 2012 21:24:35 +0800
Subject: [PATCH v9 1/3] MTD: at91: extract hw ecc initialization to one
 function and use relaxed read/write
In-Reply-To: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1338038677-6752-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use _relaxed read/write in most place. And use writel in operations of Control Register since it needs memory barrier.

Signed-off-by: Hong Xu <hong.xu@atmel.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c     |  158 ++++++++++++++++++++-----------------
 drivers/mtd/nand/atmel_nand_ecc.h |   11 ++-
 2 files changed, 94 insertions(+), 75 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2165576..ba61153 100644
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
@@ -304,13 +299,13 @@ static int atmel_nand_calculate(struct mtd_info *mtd,
 	unsigned int ecc_value;
 
 	/* get the first 2 ECC bytes */
-	ecc_value = ecc_readl(host->ecc, PR);
+	ecc_value = ecc_readl_relaxed(host->ecc, PR);
 
 	ecc_code[0] = ecc_value & 0xFF;
 	ecc_code[1] = (ecc_value >> 8) & 0xFF;
 
 	/* get the last 2 ECC bytes */
-	ecc_value = ecc_readl(host->ecc, NPR) & ATMEL_ECC_NPARITY;
+	ecc_value = ecc_readl_relaxed(host->ecc, NPR) & ATMEL_ECC_NPARITY;
 
 	ecc_code[2] = ecc_value & 0xFF;
 	ecc_code[3] = (ecc_value >> 8) & 0xFF;
@@ -406,16 +401,16 @@ static int atmel_nand_correct(struct mtd_info *mtd, u_char *dat,
 	unsigned int ecc_word, ecc_bit;
 
 	/* get the status from the Status Register */
-	ecc_status = ecc_readl(host->ecc, SR);
+	ecc_status = ecc_readl_relaxed(host->ecc, SR);
 
 	/* if there's no error */
 	if (likely(!(ecc_status & ATMEL_ECC_RECERR)))
 		return 0;
 
 	/* get error bit offset (4 bits) */
-	ecc_bit = ecc_readl(host->ecc, PR) & ATMEL_ECC_BITADDR;
+	ecc_bit = ecc_readl_relaxed(host->ecc, PR) & ATMEL_ECC_BITADDR;
 	/* get word address (12 bits) */
-	ecc_word = ecc_readl(host->ecc, PR) & ATMEL_ECC_WORDADDR;
+	ecc_word = ecc_readl_relaxed(host->ecc, PR) & ATMEL_ECC_WORDADDR;
 	ecc_word >>= 4;
 
 	/* if there are multiple errors */
@@ -523,6 +518,76 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
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
+		dev_err(host->dev,
+			"Can't get I/O resource regs, use software ECC\n");
+		return 0;
+	}
+
+	host->ecc = ioremap(regs->start, resource_size(regs));
+	if (host->ecc == NULL) {
+		dev_err(host->dev, "ioremap failed\n");
+		return -EIO;
+	}
+
+	nand_chip->ecc.mode = NAND_ECC_HW;
+	nand_chip->ecc.calculate = atmel_nand_calculate;
+	nand_chip->ecc.correct = atmel_nand_correct;
+	nand_chip->ecc.hwctl = atmel_nand_hwctl;
+	nand_chip->ecc.read_page = atmel_nand_read_page;
+	nand_chip->ecc.bytes = 4;
+	nand_chip->ecc.strength = 1;
+
+	/* ECC is calculated for the whole page (1 step) */
+	nand_chip->ecc.size = mtd->writesize;
+
+	/* set ECC page size and oob layout */
+	switch (mtd->writesize) {
+	case 512:
+		nand_chip->ecc.layout = &atmel_oobinfo_small;
+		ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
+		break;
+	case 1024:
+		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
+		break;
+	case 2048:
+		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
+		break;
+	case 4096:
+		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		ecc_writel_relaxed(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
+		break;
+	default:
+		/* page size not handled by HW ECC */
+		/* switching back to soft ECC */
+		nand_chip->ecc.mode = NAND_ECC_SOFT;
+		nand_chip->ecc.calculate = NULL;
+		nand_chip->ecc.correct = NULL;
+		nand_chip->ecc.hwctl = NULL;
+		nand_chip->ecc.read_page = NULL;
+		nand_chip->ecc.postpad = 0;
+		nand_chip->ecc.prepad = 0;
+		nand_chip->ecc.bytes = 0;
+		break;
+	}
+
+	return 0;
+}
+
 /*
  * Probe for the NAND device.
  */
@@ -531,7 +596,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct atmel_nand_host *host;
 	struct mtd_info *mtd;
 	struct nand_chip *nand_chip;
-	struct resource *regs;
 	struct resource *mem;
 	struct mtd_part_parser_data ppdata = {};
 	int res;
@@ -583,29 +647,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
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
@@ -657,40 +698,9 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
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
@@ -707,15 +717,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
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
index 578c776..5cbff11 100644
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
@@ -36,4 +36,13 @@
 #define ATMEL_ECC_NPR		0x10			/* NParity register */
 #define		ATMEL_ECC_NPARITY	(0xffff << 0)		/* NParity */
 
+/* Relaxed version of Register Access Macros */
+#define ecc_readl_relaxed(add, reg)				\
+	readl_relaxed(add + ATMEL_ECC_##reg)
+#define ecc_writel_relaxed(add, reg, value)			\
+	writel_relaxed((value), add + ATMEL_ECC_##reg)
+/* Register Write Macros with memory barries, use to write control regiser */
+#define ecc_writel(add, reg, value)				\
+	writel((value), add + ATMEL_ECC_##reg)
+
 #endif
-- 
1.7.10
