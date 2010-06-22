From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 21:52:09 +0800
Subject: [PATCH 14/29] pxa3xx_nand: add bch ecc support
Message-ID: <mailman.118.1280296772.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the controller internal bch ecc engine when need.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   11 ++-
 drivers/mtd/nand/pxa3xx_nand.c               |  119 ++++++++++++++++++-------
 2 files changed, 94 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index cf42f97..9b1f9df 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -3,6 +3,12 @@

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+/* error code and state */
+enum {
+	ECC_NONE = 0,
+	ECC_HAMMIN,
+	ECC_BCH,
+};

 struct pxa3xx_nand_timing {
 	unsigned int	tCH;  /* Enable signal hold time */
@@ -32,10 +38,11 @@ struct pxa3xx_nand_cmdset {
 struct pxa3xx_nand_flash {
 	char		*name;
 	uint32_t	chip_id;
-	uint16_t	page_per_block; /* Pages per block (PG_PER_BLK) */
-	uint16_t 	page_size;	/* Page size in bytes (PAGE_SZ) */
+	uint16_t	page_per_block; /* Pages per block */
+	uint16_t 	page_size;	/* Page size in bytes */
 	uint8_t		flash_width;	/* Width of Flash memory (DWIDTH_M) */
 	uint8_t 	dfc_width;	/* Width of flash controller(DWIDTH_C) */
+	uint8_t		ecc_type;	/* Which ECC is applied */
 	uint32_t	num_blocks;	/* Number of physical blocks in Flash */
 	struct pxa3xx_nand_cmdset *cmdset;	/* NAND command set */
 	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 3dea0fe..94df2bd 100644
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
@@ -90,6 +94,13 @@
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
@@ -215,16 +226,16 @@ static struct pxa3xx_nand_timing __devinitdata
timing[] = {
 #define NAND_SETTING_MICRON      &default_cmdset, &timing[2]
 #define NAND_SETTING_ST          &default_cmdset, &timing[3]
 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0, NAND_SETTING_DEFAULT, },
-{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, NAND_SETTING_SAMSUNG, },
-{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, NAND_SETTING_SAMSUNG, },
-{ "1GiB 8-bit",    0xd3ec, 128, 2048,  8,  8, 4096, NAND_SETTING_SAMSUNG, },
-{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, NAND_SETTING_SAMSUNG, },
-{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, NAND_SETTING_MICRON, },
-{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, NAND_SETTING_MICRON, },
-{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, NAND_SETTING_MICRON, },
-{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, NAND_SETTING_MICRON, },
-{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, NAND_SETTING_ST, },
+{ "DEFAULT FLASH",      0,   0, 2048,  8,  8, ECC_NONE,      0,
NAND_SETTING_DEFAULT, },
+{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, ECC_HAMMIN, 4096,
NAND_SETTING_SAMSUNG, },
+{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, ECC_HAMMIN, 2048,
NAND_SETTING_SAMSUNG, },
+{ "1GiB 8-bit",    0xd3ec, 128, 2048,  8,  8, ECC_BCH,    4096,
NAND_SETTING_SAMSUNG, },
+{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, ECC_BCH,    8192,
NAND_SETTING_SAMSUNG, },
+{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, ECC_HAMMIN, 1024,
NAND_SETTING_MICRON, },
+{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, ECC_HAMMIN, 1024,
NAND_SETTING_MICRON, },
+{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, ECC_HAMMIN, 4096,
NAND_SETTING_MICRON, },
+{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, ECC_HAMMIN, 4096,
NAND_SETTING_MICRON, },
+{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, ECC_HAMMIN, 2048,
NAND_SETTING_ST, },
 };

 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
@@ -273,19 +284,43 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 	struct pxa3xx_nand *nand = info->nand_data;
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;

-	nand->data_size = info->page_size;
-	if (!oob_enable) {
-		nand->oob_size = 0;
-		return;
-	}
+	if (info->page_size >= PAGE_CHUNK_SIZE) {
+		nand->data_size = PAGE_CHUNK_SIZE;
+		if (!oob_enable) {
+			nand->oob_size = 0;
+			return;
+		}

-	switch (info->page_size) {
-	case 2048:
-		nand->oob_size = (nand->use_ecc) ? 40 : 64;
-		break;
-	case 512:
-		nand->oob_size = (nand->use_ecc) ? 8 : 16;
-		break;
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
+			break;
+		default:
+			nand->oob_size = 16;
+			break;
+		}
 	}
 }

@@ -298,16 +333,26 @@ static void pxa3xx_set_datasize(struct
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
@@ -420,6 +465,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	info            = nand->info[cs];

 	status = nand_readl(nand, NDSR);
+	nand->bad_count = (status & NDSR_ERR_CNT_MASK) >> 16;
 	if (status & NDSR_DBERR)
 		nand->retcode = ERR_DBERR;
 	if (status & NDSR_SBERR)
@@ -498,7 +544,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	switch (command) {
 	case NAND_CMD_READ0:
 	case NAND_CMD_PAGEPROG:
-		nand->use_ecc = 1;
+		nand->use_ecc = info->use_ecc;
 	case NAND_CMD_READOOB:
 		pxa3xx_set_datasize(info);
 		nand->oob_buff = nand->data_buff + nand->data_size;
@@ -757,6 +803,7 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 		return -EINVAL;

 	/* calculate flash information */
+	info->use_ecc = f->ecc_type;
 	info->cmdset = f->cmdset;
 	info->page_size = f->page_size;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
@@ -780,7 +827,6 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */

 	info->reg_ndcr = ndcr;
-	info->use_ecc = 1;

 	pxa3xx_nand_set_timing(info, f->timing);
 	return 0;
@@ -790,6 +836,7 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand *nand)
 {
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
 	uint32_t ndcr = nand_readl(nand, NDCR);
+	uint32_t ndeccctrl = nand_readl(nand, NDECCCTRL);

 	if (nand->chip_select > 0) {
 		printk(KERN_ERR "We could not detect configure if two cs is supported!!\n");
@@ -802,6 +849,7 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand *nand)

 	info->ndtr0cs0 = nand_readl(nand, NDTR0CS0);
 	info->ndtr1cs0 = nand_readl(nand, NDTR1CS0);
+	info->use_ecc = (ndeccctrl & NDECCCTRL_BCH_EN) ? ECC_BCH : ECC_HAMMIN;
 	info->cmdset = &default_cmdset;

 	return 0;
@@ -837,13 +885,16 @@ static int pxa3xx_nand_read_page_hwecc(struct
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
@@ -1026,8 +1077,8 @@ static int alloc_nand_resource(struct
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
1.7.0.4
