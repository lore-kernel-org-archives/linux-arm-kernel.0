From: hong.xu@atmel.com (Hong Xu)
Date: Thu,  8 Dec 2011 14:53:39 +0800
Subject: [PATCH 2/2] MTD: atmel_nand: Update driver code to support
 Programmable HW ECC controller
In-Reply-To: <1323327219-17895-1-git-send-email-hong.xu@atmel.com>
References: <1323327219-17895-1-git-send-email-hong.xu@atmel.com>
Message-ID: <1323327219-17895-2-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Programmable Hardware ECC (PMECC) controller is a programmable binary
BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
can be used to support both SLC and MLC NAND Flash devices. It supports to
generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.

To use this driver, the user needs to pass in the correction capability and
the sector size.

This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
 YAFFS2 ,UBIFS and mtd-utils.

Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c       |  235 ++++++++---
 drivers/mtd/nand/atmel_nand_ecc.h   |   78 ++++
 drivers/mtd/nand/atmel_nand_pmecc.c |  745 +++++++++++++++++++++++++++++++++++
 3 files changed, 993 insertions(+), 65 deletions(-)
 create mode 100644 drivers/mtd/nand/atmel_nand_pmecc.c

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 23e5d77..53d3682 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -15,6 +15,8 @@
  *     		(u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
  *     (C) Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
  *
+ *  Add Programmable Hardware ECC support for various AT91 SoC
+ *     (C) Copyright 2011 ATMEL, Hong Xu
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -38,7 +40,9 @@
 #include <mach/board.h>
 #include <mach/cpu.h>
 
-#ifdef CONFIG_MTD_NAND_ATMEL_ECC_HW
+#if defined(CONFIG_MTD_NAND_ATMEL_ECC_HW)
+#define hard_ecc	1
+#elif defined(CONFIG_MTD_NAND_ATMEL_PMECC_HW)
 #define hard_ecc	1
 #else
 #define hard_ecc	0
@@ -53,6 +57,8 @@
 static int use_dma = 1;
 module_param(use_dma, int, 0);
 
+#define NB_ERROR_MAX  25
+
 static int on_flash_bbt = 0;
 module_param(on_flash_bbt, int, 0);
 
@@ -62,8 +68,38 @@ module_param(on_flash_bbt, int, 0);
 #define ecc_writel(add, reg, value)			\
 	__raw_writel((value), add + ATMEL_ECC_##reg)
 
-#include "atmel_nand_ecc.h"	/* Hardware ECC registers */
+/* Register access macros for PMECC */
+#define pmecc_readl(addr, reg) \
+	__raw_readl((addr) + ATMEL_PMECC_##reg)
+
+#define pmecc_writel(addr, reg, value) \
+	__raw_writel((value), (addr) + ATMEL_PMECC_##reg)
+
+#define pmecc_readb_ecc(addr, sector, n) \
+	__raw_readb((addr) + ATMEL_PMECC_ECCx + ((sector) * 0x40) + (n))
+
+#define pmecc_readl_rem(addr, sector, n) \
+	__raw_readl((addr) + ATMEL_PMECC_REMx + ((sector) * 0x40) + ((n) * 4))
+
+#define pmerrloc_readl(addr, reg) \
+	__raw_readl((addr) + ATMEL_PMERRLOC_##reg)
+
+#define pmerrloc_writel(addr, reg, value) \
+	__raw_writel((value), (addr) + ATMEL_PMERRLOC_##reg)
+
+#define pmerrloc_writel_sigma(addr, n, value) \
+	__raw_writel((value), (addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
+
+#define pmerrloc_readl_sigma(addr, n) \
+	__raw_readl((addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
+
+#define pmerrloc_readl_el(addr, n) \
+	__raw_readl((addr) + ATMEL_PMERRLOC_ELx + ((n) * 4))
 
+/* Include Hardware ECC registers */
+#include "atmel_nand_ecc.h"
+
+#if defined(CONFIG_MTD_NAND_ATMEL_ECC_HW)
 /* oob layout for large page size
  * bad block info is on bytes 0 and 1
  * the bytes have to be consecutives to avoid
@@ -89,6 +125,7 @@ static struct nand_ecclayout atmel_oobinfo_small = {
 		{6, 10}
 	},
 };
+#endif
 
 struct atmel_nand_host {
 	struct nand_chip	nand_chip;
@@ -101,11 +138,42 @@ struct atmel_nand_host {
 
 	struct completion	comp;
 	struct dma_chan		*dma_chan;
+
+#if defined(CONFIG_MTD_NAND_ATMEL_PMECC_HW)
+	void __iomem		*pmerrloc_base;
+	void __iomem		*rom_base;
+				/* defines the error correcting capability */
+	int			tt;
+				/* The number of ecc bytes for one sector */
+	int			ecc_bytes_per_sector;
+				/* degree of the remainders, GF(2**mm) */
+	int			mm;
+				/* length of codeword, nn=2**mm -1 */
+	int			nn;
+	int			sector_number;
+
+				/* lookup table for alpha_to and index_of */
+	int16_t			*alpha_to;
+	int16_t			*index_of;
+
+	int16_t			partial_syn[100];
+	int16_t			si[100];
+				/* Sigma table */
+	int16_t			smu[NB_ERROR_MAX + 2][2 * NB_ERROR_MAX + 1];
+				/* polynomal order */
+	int16_t			lmu[NB_ERROR_MAX + 1];
+	uint8_t			ecc_table[42 * 8];
+#endif
 };
 
+#if defined(CONFIG_MTD_NAND_ATMEL_PMECC_HW)
+#include "atmel_nand_pmecc.c"
+#endif
+
 static int cpu_has_dma(void)
 {
-	return cpu_is_at91sam9rl() || cpu_is_at91sam9g45();
+	return cpu_is_at91sam9rl() || cpu_is_at91sam9g45()
+	       || cpu_is_at91sam9x5() || cpu_is_at91sam9n12();
 }
 
 /*
@@ -228,7 +296,7 @@ err_dma:
 	dma_unmap_single(dma_dev->dev, phys_addr, len, dir);
 err_buf:
 	if (err != 0)
-		dev_warn(host->dev, "Fall back to CPU I/O\n");
+		dev_dbg(host->dev, "Fall back to CPU I/O\n");
 	return err;
 }
 
@@ -258,6 +326,7 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 	memcpy_toio(chip->IO_ADDR_W, buf, len);
 }
 
+#if defined(CONFIG_MTD_NAND_ATMEL_ECC_HW)
 /*
  * Calculate HW ECC
  *
@@ -444,6 +513,84 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 	}
 }
 
+static int __init atmel_nand_init_params(struct platform_device *pdev,
+					 struct atmel_nand_host *host)
+{
+	struct resource *regs;
+	struct nand_chip *nand_chip;
+	struct mtd_info *mtd;
+
+	nand_chip = &host->nand_chip;
+	mtd = &host->mtd;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!regs && hard_ecc) {
+		dev_err(host->dev, "atmel_nand: can't get I/O resource "
+				"regs\nFalling back on software ECC\n");
+	}
+
+	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* enable ECC */
+	if (no_ecc)
+		nand_chip->ecc.mode = NAND_ECC_NONE;
+	if (hard_ecc && regs) {
+		host->ecc = ioremap(regs->start, resource_size(regs));
+		if (host->ecc == NULL) {
+			printk(KERN_ERR "atmel_nand: ioremap failed\n");
+			goto err_ecc_ioremap;
+		}
+
+		nand_chip->ecc.mode = NAND_ECC_HW;
+		nand_chip->ecc.calculate = atmel_nand_calculate;
+		nand_chip->ecc.correct = atmel_nand_correct;
+		nand_chip->ecc.hwctl = atmel_nand_hwctl;
+		nand_chip->ecc.read_page = atmel_nand_read_page;
+		nand_chip->ecc.bytes = 4;
+	}
+
+	if (nand_chip->ecc.mode == NAND_ECC_HW) {
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
+
+err_ecc_ioremap:
+	return -EIO;
+}
+#endif
+
 /*
  * Probe for the NAND device.
  */
@@ -452,9 +599,8 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct atmel_nand_host *host;
 	struct mtd_info *mtd;
 	struct nand_chip *nand_chip;
-	struct resource *regs;
 	struct resource *mem;
-	int res;
+	int res = 0;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -495,29 +641,9 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	if (host->board->rdy_pin)
 		nand_chip->dev_ready = atmel_nand_device_ready;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!regs && hard_ecc) {
-		printk(KERN_ERR "atmel_nand: can't get I/O resource "
-				"regs\nFalling back on software ECC\n");
-	}
-
 	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* enable ECC */
 	if (no_ecc)
 		nand_chip->ecc.mode = NAND_ECC_NONE;
-	if (hard_ecc && regs) {
-		host->ecc = ioremap(regs->start, resource_size(regs));
-		if (host->ecc == NULL) {
-			printk(KERN_ERR "atmel_nand: ioremap failed\n");
-			res = -EIO;
-			goto err_ecc_ioremap;
-		}
-		nand_chip->ecc.mode = NAND_ECC_HW;
-		nand_chip->ecc.calculate = atmel_nand_calculate;
-		nand_chip->ecc.correct = atmel_nand_correct;
-		nand_chip->ecc.hwctl = atmel_nand_hwctl;
-		nand_chip->ecc.read_page = atmel_nand_read_page;
-		nand_chip->ecc.bytes = 4;
-	}
 
 	nand_chip->chip_delay = 20;		/* 20us command delay time */
 
@@ -569,42 +695,13 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		goto err_scan_ident;
 	}
 
-	if (nand_chip->ecc.mode == NAND_ECC_HW) {
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
-	}
+#if defined(CONFIG_MTD_NAND_ATMEL_ECC_HW)
+	res = atmel_nand_init_params(pdev, host);
+#elif defined(CONFIG_MTD_NAND_ATMEL_PMECC_HW)
+	res = atmel_pmecc_init_params(pdev, host);
+#endif
+	if (res != 0)
+		goto err;
 
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
@@ -618,6 +715,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	if (!res)
 		return res;
 
+err:
 err_scan_tail:
 err_scan_ident:
 err_no_card:
@@ -625,9 +723,6 @@ err_no_card:
 	platform_set_drvdata(pdev, NULL);
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
-	if (host->ecc)
-		iounmap(host->ecc);
-err_ecc_ioremap:
 	iounmap(host->io_base);
 err_nand_ioremap:
 	kfree(host);
@@ -646,6 +741,16 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
 
 	atmel_nand_disable(host);
 
+#if defined(CONFIG_MTD_NAND_ATMEL_PMECC_HW)
+	if (cpu_has_pmecc())
+			pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+	if (host->pmerrloc_base) {
+		pmerrloc_writel(host->pmerrloc_base, ELDIS, PMERRLOC_DISABLE);
+		iounmap(host->pmerrloc_base);
+	}
+	if (host->rom_base)
+		iounmap(host->rom_base);
+#endif
 	if (host->ecc)
 		iounmap(host->ecc);
 
diff --git a/drivers/mtd/nand/atmel_nand_ecc.h b/drivers/mtd/nand/atmel_nand_ecc.h
index 578c776..f7ae3e3 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -36,4 +36,82 @@
 #define ATMEL_ECC_NPR		0x10			/* NParity register */
 #define		ATMEL_ECC_NPARITY	(0xffff << 0)		/* NParity */
 
+/* PMECC Register Definitions */
+#define ATMEL_PMECC_CFG			0x000	/* Configuration Register */
+#define		PMECC_CFG_BCH_ERR2		(0 << 0)
+#define		PMECC_CFG_BCH_ERR4		(1 << 0)
+#define		PMECC_CFG_BCH_ERR8		(2 << 0)
+#define		PMECC_CFG_BCH_ERR12		(3 << 0)
+#define		PMECC_CFG_BCH_ERR24		(4 << 0)
+
+#define		PMECC_CFG_SECTOR512		(0 << 4)
+#define		PMECC_CFG_SECTOR1024		(1 << 4)
+
+#define		PMECC_CFG_PAGE_1SECTOR		(0 << 8)
+#define		PMECC_CFG_PAGE_2SECTORS		(1 << 8)
+#define		PMECC_CFG_PAGE_4SECTORS		(2 << 8)
+#define		PMECC_CFG_PAGE_8SECTORS		(3 << 8)
+
+#define		PMECC_CFG_READ_OP		(0 << 12)
+#define		PMECC_CFG_WRITE_OP		(1 << 12)
+
+#define		PMECC_CFG_SPARE_ENABLE		(1 << 16)
+#define		PMECC_CFG_SPARE_DISABLE		(0 << 16)
+
+#define		PMECC_CFG_AUTO_ENABLE		(1 << 20)
+#define		PMECC_CFG_AUTO_DISABLE		(0 << 20)
+
+#define ATMEL_PMECC_SAREA		0x004	/* Spare area size */
+#define ATMEL_PMECC_SADDR		0x008	/* PMECC starting address */
+#define ATMEL_PMECC_EADDR		0x00c	/* PMECC ending address */
+#define ATMEL_PMECC_CLK			0x010	/* PMECC clock control */
+#define		PMECC_CLK_133MHZ		(2 << 0)
+
+#define ATMEL_PMECC_CTRL		0x014	/* PMECC control register */
+#define		PMECC_CTRL_RST			(1 << 0)
+#define		PMECC_CTRL_DATA			(1 << 1)
+#define		PMECC_CTRL_USER			(1 << 2)
+#define		PMECC_CTRL_ENABLE		(1 << 4)
+#define		PMECC_CTRL_DISABLE		(1 << 5)
+
+#define ATMEL_PMECC_SR			0x018	/* PMECC status register */
+#define		PMECC_SR_BUSY			(1 << 0)
+#define		PMECC_SR_ENABLE			(1 << 4)
+
+#define ATMEL_PMECC_IER			0x01c	/* PMECC interrupt enable */
+#define		PMECC_IER_ENABLE		(1 << 0)
+#define ATMEL_PMECC_IDR			0x020	/* PMECC interrupt disable */
+#define		PMECC_IER_DISABLE		(1 << 0)
+#define ATMEL_PMECC_IMR			0x024	/* PMECC interrupt mask */
+#define		PMECC_IER_MASK			(1 << 0)
+#define ATMEL_PMECC_ISR			0x028	/* PMECC interrupt status */
+#define ATMEL_PMECC_ECCx		0x040	/* PMECC ECC x */
+#define ATMEL_PMECC_REMx		0x240	/* PMECC REM x */
+
+/* PMERRLOC Register Definitions */
+#define ATMEL_PMERRLOC_ELCFG		0x000	/* Error location config */
+#define		PMERRLOC_ELCFG_SECTOR_512	(0 << 0)
+#define		PMERRLOC_ELCFG_SECTOR_1024	(1 << 0)
+#define		PMERRLOC_ELCFG_NUM_ERRORS(n)	((n) << 16)
+
+#define ATMEL_PMERRLOC_ELPRIM		0x004	/* Error location primitive */
+#define ATMEL_PMERRLOC_ELEN		0x008	/* Error location enable */
+#define ATMEL_PMERRLOC_ELDIS		0x00c	/* Error location disable */
+#define		PMERRLOC_DISABLE		(1 << 0)
+
+#define ATMEL_PMERRLOC_ELSR		0x010	/* Error location status */
+#define		PMERRLOC_ELSR_BUSY		(1 << 0)
+#define ATMEL_PMERRLOC_ELIER		0x014	/* Error location int enable */
+#define ATMEL_PMERRLOC_ELIDR		0x018	/* Error location int disable */
+#define ATMEL_PMERRLOC_ELIMR		0x01c	/* Error location int mask */
+#define ATMEL_PMERRLOC_ELISR		0x020	/* Error location int status */
+#define		PMERRLOC_ERR_NUM_MASK		(0x1f << 8)
+#define		PMERRLOC_CALC_DONE		(1 << 0)
+#define ATMEL_PMERRLOC_SIGMAx		0x028	/* Error location SIGMA x */
+#define ATMEL_PMERRLOC_ELx		0x08c	/* Error location x */
+
+/* Galois field dimension */
+#define GF_DIMENSION_13			13
+#define GF_DIMENSION_14			14
+
 #endif
diff --git a/drivers/mtd/nand/atmel_nand_pmecc.c b/drivers/mtd/nand/atmel_nand_pmecc.c
new file mode 100644
index 0000000..d1084ac
--- /dev/null
+++ b/drivers/mtd/nand/atmel_nand_pmecc.c
@@ -0,0 +1,745 @@
+/*
+ * (C) Copyright 2011 ATMEL, Hong Xu
+ *
+ * PMECC related definitions and routines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+static struct nand_ecclayout atmel_pmecc_oobinfo;
+/*
+ * Number of ECC bytes per sector is determined by both sector size
+ * and correction capability
+ *
+ * Correction Capability	Sector_512_bytes	Sector_1024_bytes
+ * =====================	================	=================
+ *                2-bits                 4-bytes                  4-bytes
+ *                4-bits                 7-bytes                  7-bytes
+ *                8-bits                13-bytes                 14-bytes
+ *               12-bits                20-bytes                 21-bytes
+ *               24-bits                39-bytes                 42-bytes
+ *
+ */
+static const int ecc_bytes_table[5][2] = {
+	{4, 4}, {7, 7}, {13, 14}, {20, 21}, {39, 42}
+};
+
+/*
+ * Return number of ecc bytes per sector according to sector size and
+ * correction capability
+ */
+static int pmecc_get_ecc_bytes(int cap, int sector_size)
+{
+	int i, j;
+
+	switch (cap) {
+	case 2:
+		i = 0;
+		break;
+	case 4:
+		i = 1;
+		break;
+	case 8:
+		i = 2;
+		break;
+	case 12:
+		i = 3;
+		break;
+	case 24:
+		i = 4;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (sector_size) {
+	case 512:
+		j = 0;
+		break;
+	case 1024:
+		j = 1;
+		break;
+	default:
+		BUG();
+	}
+
+	return ecc_bytes_table[i][j];
+}
+
+static int cpu_has_pmecc(void)
+{
+	return cpu_is_at91sam9x5() || cpu_is_at91sam9n12();
+}
+
+static void pmecc_config_ecc_layout(struct nand_ecclayout *layout, int oobsize,
+	int ecc_len)
+{
+	int i;
+
+	layout->eccbytes = ecc_len;
+
+	/* ECC will occupy the last ecc_len bytes continuously */
+	for (i = 0; i < ecc_len; i++)
+		layout->eccpos[i] = oobsize - ecc_len + i;
+
+	/* Reserve at least first 2 bytes */
+	layout->oobfree[0].offset = 2;
+	layout->oobfree[0].length = oobsize - ecc_len - 2;
+}
+
+static int16_t *pmecc_get_alpha_to(struct atmel_nand_host *host)
+{
+	int16_t *p;
+
+	if (host->board->sector_size == 512)
+		p = (int16_t *)((u32)host->rom_base +
+			AT_PMECC_LOOKUP_TABLE_OFFSET_512) +
+			AT_PMECC_LOOKUP_TABLE_SIZE_512;
+	else
+		p = (int16_t *)((u32)host->rom_base +
+			AT_PMECC_LOOKUP_TABLE_OFFSET_1024) +
+			AT_PMECC_LOOKUP_TABLE_SIZE_1024;
+	return p;
+}
+
+static int16_t *pmecc_get_index_of(struct atmel_nand_host *host)
+{
+	int16_t *p = (int16_t *)host->rom_base;
+
+	if (host->board->sector_size == 512)
+		p = (int16_t *)((u32)host->rom_base +
+			AT_PMECC_LOOKUP_TABLE_OFFSET_512);
+	else
+		p = (int16_t *)((u32)host->rom_base +
+			AT_PMECC_LOOKUP_TABLE_OFFSET_1024);
+	return p;
+}
+
+static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
+{
+	int i;
+	uint32_t value;
+	struct nand_chip *nand_chip = mtd->priv;
+	struct atmel_nand_host *host = nand_chip->priv;
+
+	/* Fill odd syndromes */
+	for (i = 0; i < host->tt; i++) {
+		value = pmecc_readl_rem(host->ecc, sector, i / 2);
+		if (i % 2 == 0)
+			value &= 0xffff;
+		else
+			value = (value & 0xffff0000) >> 16;
+		host->partial_syn[(2 * i) + 1] = value;
+	}
+}
+
+static void pmecc_substitute(struct mtd_info *mtd)
+{
+	int16_t			*si;
+	int			i, j;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+	int16_t			*alpha_to = host->alpha_to;
+	int16_t			*index_of = host->index_of;
+	int16_t			*partial_syn = host->partial_syn;
+
+	/* si[] is a table that holds the current syndrome value,
+	 * an element of that table belongs to the field
+	 */
+	si = host->si;
+
+	for (i = 1; i < 2 * NB_ERROR_MAX; i++)
+		si[i] = 0;
+
+	/* Computation 2t syndromes based on S(x) */
+	/* Odd syndromes */
+	for (i = 1; i <= 2 * host->tt - 1; i = i + 2) {
+		si[i] = 0;
+		for (j = 0; j < host->mm; j++) {
+			if (partial_syn[i] & ((unsigned short)0x1 << j))
+				si[i] = alpha_to[(i * j)] ^ si[i];
+		}
+	}
+	/* Even syndrome = (Odd syndrome) ** 2 */
+	for (i = 2; i <= 2 * host->tt; i = i + 2) {
+		j = i / 2;
+		if (si[j] == 0)
+			si[i] = 0;
+		else
+			si[i] = alpha_to[(2 * index_of[si[j]]) % host->nn];
+	}
+
+	return;
+}
+
+static void pmecc_get_sigma(struct mtd_info *mtd)
+{
+	int			i, j, k;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	uint32_t		dmu_0_count, tmp;
+	int16_t			*lmu = host->lmu;
+	int16_t			*si = host->si;
+	int16_t			tt = host->tt;
+	int16_t			*index_of = host->index_of;
+
+	/* mu          */
+	int mu[NB_ERROR_MAX + 1];
+
+	/* discrepancy */
+	int dmu[NB_ERROR_MAX + 1];
+
+	/* delta order   */
+	int delta[NB_ERROR_MAX + 1];
+
+	/* index of largest delta */
+	int ro;
+	int largest;
+	int diff;
+
+	dmu_0_count = 0;
+
+	/* First Row */
+
+	/* Mu */
+	mu[0] = -1;
+
+	for (i = 0; i < 2 * NB_ERROR_MAX + 1; i++)
+		host->smu[0][i] = 0;
+
+	host->smu[0][0] = 1;
+
+	/* discrepancy set to 1 */
+	dmu[0] = 1;
+	/* polynom order set to 0 */
+	lmu[0] = 0;
+	delta[0]  = (mu[0] * 2 - lmu[0]) >> 1;
+
+	/* Second Row */
+
+	/* Mu */
+	mu[1]  = 0;
+	/* Sigma(x) set to 1 */
+	for (i = 0; i < (2 * NB_ERROR_MAX + 1); i++)
+		host->smu[1][i] = 0;
+
+	host->smu[1][0] = 1;
+
+	/* discrepancy set to S1 */
+	dmu[1] = si[1];
+
+	/* polynom order set to 0 */
+	lmu[1] = 0;
+
+	delta[1]  = (mu[1] * 2 - lmu[1]) >> 1;
+
+	/* Init the Sigma(x) last row */
+	for (i = 0; i < (2 * NB_ERROR_MAX + 1); i++)
+		host->smu[tt + 1][i] = 0;
+
+	for (i = 1; i <= tt; i++) {
+		mu[i+1] = i << 1;
+		/* Begin Computing Sigma (Mu+1) and L(mu) */
+		/* check if discrepancy is set to 0 */
+		if (dmu[i] == 0) {
+			dmu_0_count++;
+
+			tmp = ((tt - (lmu[i] >> 1) - 1) / 2);
+			if ((tt - (lmu[i] >> 1) - 1) & 0x1)
+				tmp += 2;
+			else
+				tmp += 1;
+
+			if (dmu_0_count == tmp) {
+				for (j = 0; j <= (lmu[i] >> 1) + 1; j++)
+					host->smu[tt + 1][j] = host->smu[i][j];
+
+				lmu[tt + 1] = lmu[i];
+				return;
+			}
+
+			/* copy polynom */
+			for (j = 0; j <= lmu[i] >> 1; j++)
+				host->smu[i + 1][j] = host->smu[i][j];
+
+			/* copy previous polynom order to the next */
+			lmu[i + 1] = lmu[i];
+		} else {
+			ro = 0;
+			largest = -1;
+			/* find largest delta with dmu != 0 */
+			for (j = 0; j < i; j++) {
+				if ((dmu[j]) && (delta[j] > largest)) {
+					largest = delta[j];
+					ro = j;
+				}
+			}
+
+			/* compute difference */
+			diff = (mu[i] - mu[ro]);
+
+			/* Compute degree of the new smu polynomial */
+			if ((lmu[i] >> 1) > ((lmu[ro] >> 1) + diff))
+				lmu[i + 1] = lmu[i];
+			else
+				lmu[i + 1] = ((lmu[ro] >> 1) + diff) * 2;
+
+			/* Init smu[i+1] with 0 */
+			for (k = 0; k < (2 * NB_ERROR_MAX + 1); k++)
+				host->smu[i+1][k] = 0;
+
+			/* Compute smu[i+1] */
+			for (k = 0; k <= lmu[ro] >> 1; k++) {
+				if (!(host->smu[ro][k] && dmu[i]))
+					continue;
+
+				tmp = host->index_of[dmu[i]] +
+					(host->nn - host->index_of[dmu[ro]]) +
+					host->index_of[host->smu[ro][k]];
+				host->smu[i + 1][k + diff] =
+					host->alpha_to[tmp % host->nn];
+			}
+
+			for (k = 0; k <= lmu[i] >> 1; k++)
+				host->smu[i + 1][k] ^= host->smu[i][k];
+		}
+
+		/* End Computing Sigma (Mu+1) and L(mu) */
+		/* In either case compute delta */
+		delta[i + 1]  = (mu[i + 1] * 2 - lmu[i + 1]) >> 1;
+
+		/* Do not compute discrepancy for the last iteration */
+		if (i >= tt)
+			continue;
+
+		for (k = 0 ; k <= (lmu[i + 1] >> 1); k++) {
+			tmp = 2 * (i - 1);
+			if (k == 0)
+				dmu[i + 1] = si[tmp + 3];
+			else if (host->smu[i+1][k] && si[tmp + 3 - k]) {
+				tmp = index_of[host->smu[i + 1][k]] +
+				      index_of[si[2 * (i - 1) + 3 - k]];
+				tmp %= host->nn;
+				dmu[i + 1] = host->alpha_to[tmp] ^ dmu[i + 1];
+			}
+		}
+	}
+
+	return;
+}
+
+static int pmecc_err_location(struct mtd_info *mtd)
+{
+	int			i, gf_dimension;
+	int			err_nbr;	/* number of error */
+	int			roots_nbr;	/* number of roots */
+	int			sector_size;
+	uint32_t		val;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	sector_size = host->board->sector_size;
+	if (sector_size == 512)
+		gf_dimension = GF_DIMENSION_13;
+	else
+		gf_dimension = GF_DIMENSION_14;
+
+	/* Disable PMECC Error Location IP */
+	pmerrloc_writel(host->pmerrloc_base, ELDIS, PMERRLOC_DISABLE);
+	err_nbr = 0;
+
+	for (i = 0; i <= host->lmu[host->tt + 1] >> 1; i++) {
+		pmerrloc_writel_sigma(host->pmerrloc_base, i,
+				      host->smu[host->tt + 1][i]);
+		err_nbr++;
+	}
+
+	val = ((err_nbr - 1) << 16) | ((sector_size == 512) ? 0 : 1);
+	pmerrloc_writel(host->pmerrloc_base, ELCFG, val);
+
+	pmerrloc_writel(host->pmerrloc_base, ELEN,
+			sector_size * 8 + gf_dimension * host->tt);
+
+	while (!(pmerrloc_readl(host->pmerrloc_base, ELISR)
+		 & PMERRLOC_CALC_DONE))
+		cpu_relax();
+
+	roots_nbr = (pmerrloc_readl(host->pmerrloc_base, ELISR)
+		      & PMERRLOC_ERR_NUM_MASK) >> 8;
+
+	/* Number of roots == degree of smu hence <= tt */
+	if (roots_nbr == host->lmu[host->tt + 1] >> 1)
+		return err_nbr - 1;
+
+	/* Number of roots does not match the degree of smu
+	 * unable to correct error */
+	return -1;
+}
+
+static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf,
+		int extra_bytes, int err_nbr)
+{
+	int			i = 0;
+	int			byte_pos, bit_pos;
+	int			sector_size, ecc_size;
+	uint32_t		tmp;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	sector_size = host->board->sector_size;
+	ecc_size = nand_chip->ecc.bytes;
+
+	while (err_nbr) {
+		byte_pos = (pmerrloc_readl_el(host->pmerrloc_base, i) - 1) / 8;
+		bit_pos = (pmerrloc_readl_el(host->pmerrloc_base, i) - 1) % 8;
+		dev_info(host->dev, "PMECC correction, byte_pos: %d "
+			"bit_pos: %d\n", byte_pos, bit_pos);
+
+		if (byte_pos < (sector_size + extra_bytes)) {
+			tmp = sector_size + pmecc_readl(host->ecc, SADDR);
+			if (byte_pos < tmp) {
+				if (*(buf + byte_pos) & (1 << bit_pos))
+					*(buf + byte_pos) &=
+						(0xFF ^ (1 << bit_pos));
+				else
+					*(buf + byte_pos) |= (1 << bit_pos);
+			} else {
+				if (*(buf + byte_pos + ecc_size) &
+				     (1 << bit_pos))
+					*(buf + byte_pos + ecc_size) &=
+						(0xFF ^ (1 << bit_pos));
+				else
+					*(buf + byte_pos + ecc_size) |=
+						(1 << bit_pos);
+			}
+		}
+
+		i++;
+		err_nbr--;
+	}
+
+	return;
+}
+
+static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
+	u8 *ecc)
+{
+	int			i, err_nbr;
+	uint8_t			*buf_pos;
+	struct			nand_chip *nand_chip = mtd->priv;
+	int			eccbytes = nand_chip->ecc.bytes;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	for (i = 0; i < eccbytes; i++)
+		if (ecc[i] != 0xff)
+			goto normal_check;
+	/* Erased page, return OK */
+	return 0;
+
+normal_check:
+	for (i = 0; i < host->sector_number; i++) {
+		err_nbr = 0;
+		if (pmecc_stat & 0x1) {
+			buf_pos = buf + i * host->board->sector_size;
+
+			pmecc_gen_syndrome(mtd, i);
+			pmecc_substitute(mtd);
+			pmecc_get_sigma(mtd);
+
+			err_nbr = pmecc_err_location(mtd);
+			if (err_nbr == -1) {
+				dev_err(host->dev, "PMECC: Too many errors\n");
+				mtd->ecc_stats.failed++;
+				return -EFAULT;
+			} else {
+				pmecc_correct_data(mtd, buf_pos, 0, err_nbr);
+				mtd->ecc_stats.corrected += err_nbr;
+			}
+		}
+		pmecc_stat >>= 1;
+	}
+
+	return 0;
+}
+
+static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
+		struct nand_chip *chip, uint8_t *buf, int32_t page)
+{
+	struct atmel_nand_host *host = chip->priv;
+	int eccsize = chip->ecc.size;
+	uint32_t *eccpos = chip->ecc.layout->eccpos;
+	int err = 0, stat;
+	uint8_t *oob = chip->oob_poi;
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+	pmecc_writel(host->ecc, CFG, (pmecc_readl(host->ecc, CFG)
+		     & ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+
+	chip->read_buf(mtd, buf, eccsize);
+	chip->read_buf(mtd, oob, mtd->oobsize);
+
+	while ((pmecc_readl(host->ecc, SR) & PMECC_SR_BUSY))
+		cpu_relax();
+
+	stat = pmecc_readl(host->ecc, ISR);
+
+	if (stat != 0) {
+		if (pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]))
+			err = -1;
+	}
+
+	return err;
+}
+
+static void atmel_nand_pmecc_write_page(struct mtd_info *mtd,
+		struct nand_chip *chip, const uint8_t *buf)
+{
+	int i, j;
+	struct atmel_nand_host *host = chip->priv;
+	uint32_t *eccpos = chip->ecc.layout->eccpos;
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+
+	pmecc_writel(host->ecc, CFG, (pmecc_readl(host->ecc, CFG) |
+		PMECC_CFG_WRITE_OP) & ~PMECC_CFG_AUTO_ENABLE);
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+
+	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
+
+	while ((pmecc_readl(host->ecc, SR) & PMECC_SR_BUSY))
+		cpu_relax();
+
+	for (i = 0; i < host->sector_number; i++) {
+		for (j = 0; j < host->ecc_bytes_per_sector; j++) {
+			int pos;
+
+			pos = i * host->ecc_bytes_per_sector + j;
+			chip->oob_poi[eccpos[pos]] =
+				pmecc_readb_ecc(host->ecc, i, j);
+		}
+	}
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return;
+}
+
+static void atmel_pmecc_core_init(struct mtd_info *mtd)
+{
+	uint32_t val = 0;
+	struct nand_chip *nand_chip = mtd->priv;
+	struct atmel_nand_host *host = nand_chip->priv;
+	struct nand_ecclayout *ecc_layout;
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+
+	switch (host->tt) {
+	case 2:
+		val = PMECC_CFG_BCH_ERR2;
+		break;
+	case 4:
+		val = PMECC_CFG_BCH_ERR4;
+		break;
+	case 8:
+		val = PMECC_CFG_BCH_ERR8;
+		break;
+	case 12:
+		val = PMECC_CFG_BCH_ERR12;
+		break;
+	case 24:
+		val = PMECC_CFG_BCH_ERR24;
+		break;
+	}
+
+	if (host->board->sector_size == 512)
+		val |= PMECC_CFG_SECTOR512;
+	else if (host->board->sector_size == 1024)
+		val |= PMECC_CFG_SECTOR1024;
+
+	switch (host->sector_number) {
+	case 1:
+		val |= PMECC_CFG_PAGE_1SECTOR;
+		break;
+	case 2:
+		val |= PMECC_CFG_PAGE_2SECTORS;
+		break;
+	case 4:
+		val |= PMECC_CFG_PAGE_4SECTORS;
+		break;
+	case 8:
+		val |= PMECC_CFG_PAGE_8SECTORS;
+		break;
+	}
+
+	val |= PMECC_CFG_READ_OP | PMECC_CFG_SPARE_DISABLE
+		| PMECC_CFG_AUTO_DISABLE;
+	pmecc_writel(host->ecc, CFG, val);
+
+	ecc_layout = nand_chip->ecc.layout;
+	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
+	pmecc_writel(host->ecc, SADDR, ecc_layout->eccpos[0]);
+	pmecc_writel(host->ecc, EADDR,
+			ecc_layout->eccpos[ecc_layout->eccbytes - 1]);
+	/*
+	 * FIXME : So far only 133MHz is clear specified in datasheet
+	 *         This may change in the future
+	 */
+	pmecc_writel(host->ecc, CLK, PMECC_CLK_133MHZ);
+	pmecc_writel(host->ecc, IDR, 0xff);
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+}
+
+static int __init atmel_pmecc_init_params(struct platform_device *pdev,
+					 struct atmel_nand_host *host)
+{
+	struct mtd_info *mtd;
+	int cap, sector_size;
+	struct resource *regs;
+	struct nand_chip *nand_chip;
+	struct resource *regs_pmerr, *regs_rom;
+
+	cap = host->board->correction_cap;
+	sector_size = host->board->sector_size;
+	dev_info(host->dev, "Initialize PMECC params, cap: %d, sector: %d\n",
+		 cap, sector_size);
+
+	/* Sanity check */
+	if ((sector_size != 512) && (sector_size != 1024)) {
+		dev_err(host->dev, "Unsupported PMECC sector size: %d;"
+			" Valid sector size is 512 or 1024 bytes\n",
+			host->board->sector_size);
+		goto err;
+	}
+	if ((cap != 2) && (cap != 4) && (cap != 8) && (cap != 12) &&
+	    (cap != 24)) {
+		dev_err(host->dev, "Unsupported PMECC correction capability,"
+			" Valid is either 2, 4, 8, 12 or 24\n");
+		goto err;
+	}
+
+	nand_chip = &host->nand_chip;
+	mtd = &host->mtd;
+
+	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* By default */
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (hard_ecc && !regs) {
+		dev_warn(host->dev, "Can't get I/O resource regs\nFalling "
+				"back on software ECC\n");
+		return 0;
+	}
+
+	if (no_ecc)
+		nand_chip->ecc.mode = NAND_ECC_NONE;
+	if (hard_ecc && regs) {
+		host->ecc = ioremap(regs->start, resource_size(regs));
+		if (host->ecc == NULL) {
+			dev_err(host->dev, "atmel_nand: ioremap failed\n");
+			goto err_pmecc_ioremap;
+		}
+
+		regs_pmerr = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+		if (regs_pmerr && regs_rom) {
+			host->pmerrloc_base = ioremap(regs_pmerr->start,
+				resource_size(regs_pmerr));
+			host->rom_base = ioremap(regs_rom->start,
+				resource_size(regs_rom));
+
+			if (host->pmerrloc_base && host->rom_base) {
+				nand_chip->ecc.mode = NAND_ECC_HW;
+				nand_chip->ecc.read_page =
+					atmel_nand_pmecc_read_page;
+				nand_chip->ecc.write_page =
+					atmel_nand_pmecc_write_page;
+			} else {
+				dev_err(host->dev, "Can not get I/O resource"
+					" for HW PMECC controller!\n");
+				goto err_pmloc_ioremap;
+			}
+		}
+
+		if (nand_chip->ecc.mode != NAND_ECC_HW) {
+			dev_err(host->dev, "Can not get I/O resource"
+				" for HW ECC Rolling back to software ECC\n");
+			return 0;
+		}
+	}
+
+	if (nand_chip->ecc.mode == NAND_ECC_HW) {
+		/* ECC is calculated for the whole page (1 step) */
+		nand_chip->ecc.size = mtd->writesize;
+
+		/* set ECC page size and oob layout */
+		switch (mtd->writesize) {
+		case 2048:
+			host->mm = GF_DIMENSION_13;
+			host->nn = (1 << host->mm) - 1;
+			host->tt = cap;
+			host->sector_number = mtd->writesize / sector_size;
+			host->ecc_bytes_per_sector = pmecc_get_ecc_bytes(
+				host->tt, sector_size);
+			host->alpha_to = pmecc_get_alpha_to(host);
+			host->index_of = pmecc_get_index_of(host);
+
+			nand_chip->ecc.steps = 1;
+			nand_chip->ecc.bytes = host->ecc_bytes_per_sector *
+					       host->sector_number;
+			if (nand_chip->ecc.bytes > mtd->oobsize - 2) {
+				dev_err(host->dev, "No room for ECC bytes\n");
+				goto err;
+			}
+			nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
+			pmecc_config_ecc_layout(nand_chip->ecc.layout,
+						mtd->oobsize,
+						nand_chip->ecc.bytes);
+			break;
+		case 512:
+		case 1024:
+		case 4096:
+			/* TODO */
+			dev_warn(host->dev, "Only 2048 page size is currently"
+				"supported for PMECC, back to Software ECC\n");
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
+	/* Initialize PMECC core if applicable */
+	if ((nand_chip->ecc.mode == NAND_ECC_HW) && cpu_has_pmecc())
+		atmel_pmecc_core_init(mtd);
+
+	return 0;
+
+err:
+err_pmloc_ioremap:
+	iounmap(host->ecc);
+	if (host->pmerrloc_base)
+		iounmap(host->pmerrloc_base);
+	if (host->rom_base)
+		iounmap(host->rom_base);
+err_pmecc_ioremap:
+	return -EIO;
+}
-- 
1.7.3.3
