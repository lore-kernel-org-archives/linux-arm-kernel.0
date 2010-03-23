From: leiwen@marvell.com (Lei Wen)
Date: Tue, 23 Mar 2010 22:41:47 +0800
Subject: [PATCH] pxa3xx_nand: add bch ecc support
Message-ID: <mailman.379.1273136882.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the controller internal bch ecc engine when need.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  137 ++++++++++++++++++++++++++++++----------
 1 files changed, 104 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index f8b16be..fb1af4c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -29,6 +29,7 @@
 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
 #define NAND_STOP_DELAY		(2 * HZ/50)
 #define PAGE_CHUNK_SIZE		(2048)
+#define BCH_THRESHOLD           (8)

 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
@@ -38,12 +39,15 @@
 #define NDPCR		(0x18) /* Page Count Register */
 #define NDBDR0		(0x1C) /* Bad Block Register 0 */
 #define NDBDR1		(0x20) /* Bad Block Register 1 */
+#define NDECCCTRL	(0x28) /* ECC Control Register */
 #define NDDB		(0x40) /* Data Buffer */
 #define NDCB0		(0x48) /* Command Buffer0 */
 #define NDCB1		(0x4C) /* Command Buffer1 */
 #define NDCB2		(0x50) /* Command Buffer2 */

 #define NDCR_SPARE_EN		(0x1 << 31)
+#define NDSR_ERR_CNT_MASK       (0x1F << 16)
+#define NDSR_ERR_CNT(x)         (((x) << 16) & NDSR_ERR_CNT_MASK)
 #define NDCR_ECC_EN		(0x1 << 30)
 #define NDCR_DMA_EN		(0x1 << 29)
 #define NDCR_ND_RUN		(0x1 << 28)
@@ -92,6 +96,13 @@
 #define NDCB0_CMD1_MASK		(0xff)
 #define NDCB0_ADDR_CYC_SHIFT	(16)

+/* ECC Control Register */
+#define NDECCCTRL_ECC_SPARE_MSK (0xFF << 7)
+#define NDECCCTRL_ECC_SPARE(x)  (((x) << 7) & NDECCCTRL_ECC_SPARE_MSK)
+#define NDECCCTRL_ECC_THR_MSK   (0x3F << 1)
+#define NDECCCTRL_ECC_THRESH(x) (((x) << 1) & NDECCCTRL_ECC_THR_MSK)
+#define NDECCCTRL_BCH_EN        (0x1)
+
 /* macros for registers read/write */
 #define nand_writel(info, off, val)	\
 	__raw_writel((val), (info)->mmio_base + (off))
@@ -122,6 +133,13 @@ enum {
 	STATE_IS_WRITE		= (1 << 7),
 };

+/* error code and state */
+enum {
+	ECC_NONE = 0,
+	ECC_HAMMIN,
+	ECC_BCH,
+};
+
 struct pxa3xx_nand_timing {
 	uint32_t	tCH;  /* Enable signal hold time */
 	uint32_t	tCS;  /* Enable signal setup time */
@@ -149,10 +167,11 @@ struct pxa3xx_nand_cmdset {

 struct pxa3xx_nand_flash {
 	uint32_t	chip_id;
-	uint16_t	page_per_block; /* Pages per block (PG_PER_BLK) */
-	uint16_t 	page_size;	/* Page size in bytes (PAGE_SZ) */
+	uint16_t	page_per_block; /* Pages per block */
+	uint16_t 	page_size;	/* Page size in bytes */
 	uint8_t		flash_width;	/* Width of Flash memory (DWIDTH_M) */
 	uint8_t 	dfc_width;	/* Width of flash controller(DWIDTH_C) */
+	uint8_t		ecc_type;	/* Which ECC is applied */
 	uint32_t	num_blocks;	/* Number of physical blocks in Flash */
 	struct pxa3xx_nand_timing timing;	/* NAND Flash timing */
 };
@@ -172,7 +191,10 @@ struct pxa3xx_nand_info {
 	dma_addr_t 		data_desc_addr;
 	struct pxa_dma_desc	*data_desc;
 	uint8_t			chip_select;
-	uint8_t			use_ecc;	/* use HW ECC ? */
+
+	/* use HW ECC ? */
+	/* 0:off, 1:Hammin ECC  2: BCH ECC */
+	uint8_t			use_ecc;

 	/* calculated from pxa3xx_nand_flash data */
 	uint8_t			col_addr_cycles;
@@ -241,16 +263,25 @@ const static struct pxa3xx_nand_cmdset cmdset = {
  * detect the chip id before we know how to optimize further
  */
 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-{ 0, 0, 0, 0, 0, 0, { 40, 80, 60, 100, 80, 100, 90000, 400, 40, }, },
-{ 0x46ec, 32, 512, 16, 16, 4096, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
-{ 0xdaec, 64, 2048, 8, 8, 2048, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
-{ 0xd3ec, 128, 2048, 8, 8, 4096, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
-{ 0xd7ec, 128, 4096, 8, 8, 8192, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
-{ 0xa12c, 64, 2048, 8, 8, 1024, { 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
-{ 0xb12c, 64, 2048, 16, 16, 1024, { 10, 25, 15, 25, 15, 30, 25000,
60, 10, }, },
-{ 0xdc2c, 64, 2048, 8, 8, 4096, { 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
-{ 0xcc2c, 64, 2048, 16, 16, 4096, { 10, 25, 15, 25, 15, 30, 25000,
60, 10, }, },
-{ 0xba20, 64, 2048, 16, 16, 2048, { 10, 35, 15, 25, 15, 25, 25000,
60, 10, }, },
+{ 0, 0, 0, 0, 0, 0, 0, { 40, 80, 60, 100, 80, 100, 90000, 400, 40, }, },
+{ 0x46ec, 32, 512, 16, 16, ECC_HAMMIN, 4096, \
+	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+{ 0xdaec, 64, 2048, 8, 8, ECC_HAMMIN, 2048, \
+	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+{ 0xd3ec, 128, 2048, 8, 8, ECC_BCH, 4096, \
+	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+{ 0xd7ec, 128, 4096, 8, 8, ECC_BCH, 8192, \
+	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+{ 0xa12c, 64, 2048, 8, 8, ECC_HAMMIN, 1024, \
+	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+{ 0xb12c, 64, 2048, 16, 16, ECC_HAMMIN, 1024, \
+	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+{ 0xdc2c, 64, 2048, 8, 8, ECC_HAMMIN, 4096, \
+	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+{ 0xcc2c, 64, 2048, 16, 16, ECC_HAMMIN, 4096, \
+	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+{ 0xba20, 64, 2048, 16, 16, ECC_HAMMIN, 2048, \
+	{ 10, 35, 15, 25, 15, 25, 25000, 60, 10, }, },
 };

 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
@@ -313,18 +344,43 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 	struct pxa3xx_nand *nand = info->nand_data;
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;

-	nand->data_size = info->page_size;
-	if (!oob_enable) {
-		nand->oob_size = 0;
-		return;
-	}
-	switch (info->page_size) {
-		case 2048:
-			nand->oob_size = (nand->use_ecc) ? 40 : 64;
+	if (info->page_size >= PAGE_CHUNK_SIZE) {
+		nand->data_size = PAGE_CHUNK_SIZE;
+		if (!oob_enable) {
+			nand->oob_size = 0;
+			return;
+		}
+
+		switch (nand->use_ecc) {
+		case ECC_HAMMIN:
+			nand->oob_size = 40;
+			break;
+		case ECC_BCH:
+			nand->oob_size = 32;
+			break;
+		default:
+			nand->oob_size = 64;
+			break;
+		}
+	} else {
+		nand->data_size = 512;
+		if (!oob_enable) {
+			nand->oob_size = 0;
+			return;
+		}
+
+		switch (nand->use_ecc) {
+		case ECC_HAMMIN:
+			nand->oob_size = 8;
+			break;
+		case ECC_BCH:
+			printk("Don't support BCH on small page device!!!\n");
+			BUG();
 			break;
-		case 512:
-			nand->oob_size = (nand->use_ecc) ? 8 : 16;
+		default:
+			nand->oob_size = 16;
 			break;
+		}
 	}
 }

@@ -337,16 +393,26 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 static void pxa3xx_nand_start(struct pxa3xx_nand *nand)
 {
 	struct pxa3xx_nand_info *info;
-	uint32_t ndcr;
+	uint32_t ndcr, ndeccctrl = 0;

 	info = nand->info[nand->chip_select];
 	ndcr = info->reg_ndcr;
-	ndcr |= nand->use_ecc ? NDCR_ECC_EN : 0;
 	ndcr |= nand->use_dma ? NDCR_DMA_EN : NDCR_STOP_ON_UNCOR;
 	ndcr |= NDCR_ND_RUN;

+	switch (nand->use_ecc) {
+	case ECC_BCH:
+		ndeccctrl |= NDECCCTRL_BCH_EN;
+		ndeccctrl |= NDECCCTRL_ECC_THRESH(BCH_THRESHOLD);
+	case ECC_HAMMIN:
+		ndcr |= NDCR_ECC_EN;
+	default:
+		break;
+	}
+
 	/* clear status bits and run */
 	nand_writel(nand, NDCR, 0);
+	nand_writel(nand, NDECCCTRL, ndeccctrl);
 	nand_writel(nand, NDSR, NDSR_MASK);
 	nand_writel(nand, NDCR, ndcr);
 }
@@ -462,6 +528,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	info            = nand->info[cs];

 	status = nand_readl(nand, NDSR);
+	nand->bad_count = (status & NDSR_ERR_CNT_MASK) >> 16;
 	if (status & NDSR_DBERR)
 		nand->retcode = ERR_DBERR;
 	if (status & NDSR_SBERR)
@@ -789,6 +856,7 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	uint32_t ndcr = 0;

 	/* calculate flash information */
+	info->use_ecc = f->ecc_type;
 	info->page_size = f->page_size;
 	info->oob_buff = info->data_buff + f->page_size;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
@@ -873,13 +941,16 @@ static int pxa3xx_nand_read_page_hwecc(struct
mtd_info *mtd,

 	if (nand->retcode == ERR_SBERR) {
 		switch (nand->use_ecc) {
-			case 1:
-				mtd->ecc_stats.corrected++;
-				break;
-
-			case 0:
-			default:
-				break;
+		case ECC_BCH:
+			if (nand->bad_count > BCH_THRESHOLD)
+				mtd->ecc_stats.corrected +=
+					(nand->bad_count - BCH_THRESHOLD);
+			break;
+		case ECC_HAMMIN:
+			mtd->ecc_stats.corrected ++;
+		case ECC_NONE:
+		default:
+			break;
 		}
 	} else if (nand->retcode == ERR_DBERR) {
 		int buf_blank;
@@ -1086,8 +1157,8 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 	nand->mmio_phys = r->start;

 	/* initialize all interrupts to be disabled */
-	disable_int(nand, NDSR_MASK);
 	irq = platform_get_irq(pdev, 0);
+	disable_int(nand, NDCR_INT_MASK);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no IRQ resource defined\n");
 		ret = -ENXIO;
-- 
1.5.6.5
