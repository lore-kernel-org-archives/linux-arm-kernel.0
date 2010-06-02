From: leiwen@marvell.com (Lei Wen)
Date: Wed, 2 Jun 2010 21:54:33 +0800
Subject: [PATCH 03/25] pxa3xx_nand: remove the flash info in driver structure
Message-ID: <mailman.13.1276839365.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After probe, all info already transfer to driver structure.
There is no need to keep the original flash info.
So that we could safely free the flash info in memory, which may grows
larger when more flash is suported.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   70 ++++++++++++++++++++++++++--------------
 1 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index f939083..291610a 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -152,7 +152,6 @@ struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;

 	struct platform_device	 *pdev;
-	const struct pxa3xx_nand_flash *flash_info;

 	struct clk		*clk;
 	void __iomem		*mmio_base;
@@ -166,6 +165,7 @@ struct pxa3xx_nand_info {
 	int			drcmr_cmd;

 	unsigned char		*data_buff;
+	unsigned char		*oob_buff;
 	dma_addr_t 		data_buff_phys;
 	size_t			data_buff_size;
 	int 			data_dma_ch;
@@ -184,7 +184,8 @@ struct pxa3xx_nand_info {
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */

-	size_t			data_size;	/* data size in FIFO */
+	unsigned int		page_size;	/* page size of attached chip */
+	unsigned int		data_size;	/* data size in FIFO */
 	int 			retcode;
 	struct completion 	cmd_complete;

@@ -193,6 +194,10 @@ struct pxa3xx_nand_info {
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;

+	/* timing calcuted from setting */
+	uint32_t		ndtr0cs0;
+	uint32_t		ndtr1cs0;
+
 	/* calculated from pxa3xx_nand_flash data */
 	size_t		oob_size;
 	size_t		read_id_bytes;
@@ -293,6 +298,8 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,
 		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
 		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));

+	info->ndtr0cs0 = ndtr0;
+	info->ndtr1cs0 = ndtr1;
 	nand_writel(info, NDTR0CS0, ndtr0);
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
@@ -316,22 +323,29 @@ static int wait_for_event(struct
pxa3xx_nand_info *info, uint32_t event)
 	return -ETIMEDOUT;
 }

-static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
-			uint16_t cmd, int column, int page_addr)
+static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
+	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;

-	/* calculate data size */
-	switch (f->page_size) {
-	case 2048:
-		info->data_size = (info->use_ecc) ? 2088 : 2112;
-		break;
-	case 512:
-		info->data_size = (info->use_ecc) ? 520 : 528;
-		break;
-	default:
-		return -EINVAL;
+	info->data_size = info->page_size;
+	if (!oob_enable) {
+		info->oob_size = 0;
+		return;
 	}
+	switch (info->page_size) {
+		case 2048:
+			info->oob_size = (info->use_ecc) ? 40 : 64;
+			break;
+		case 512:
+			info->oob_size = (info->use_ecc) ? 8 : 16;
+			break;
+	}
+}
+
+static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
+		uint16_t cmd, int column, int page_addr)
+{
+	pxa3xx_set_datasize(info);

 	/* generate values for NDCBx registers */
 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
@@ -442,6 +456,9 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 	case STATE_PIO_WRITING:
 		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
+		if (info->oob_size > 0)
+			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
+					DIV_ROUND_UP(info->oob_size, 4));

 		enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);

@@ -454,6 +471,10 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 	case STATE_PIO_READING:
 		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
+		if (info->oob_size > 0)
+			__raw_readsl(info->mmio_base + NDDB, info->oob_buff,
+					DIV_ROUND_UP(info->oob_size, 4));
+
 		break;
 	default:
 		printk(KERN_ERR "%s: invalid state %d\n", __func__,
@@ -468,7 +489,7 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
 {
 	struct pxa_dma_desc *desc = info->data_desc;
-	int dma_len = ALIGN(info->data_size, 32);
+	int dma_len = ALIGN(info->data_size + info->oob_size, 32);

 	desc->ddadr = DDADR_STOP;
 	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
@@ -863,6 +884,8 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	uint32_t ndcr = 0x00000FFF; /* disable all interrupts */

 	/* calculate flash information */
+	info->page_size = f->page_size;
+	info->oob_buff = info->data_buff + f->page_size;
 	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

@@ -887,7 +910,6 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	info->reg_ndcr = ndcr;

 	pxa3xx_nand_set_timing(info, f->timing);
-	info->flash_info = f;
 	return 0;
 }

@@ -923,7 +945,6 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;

 	/* set info fields needed to __readid */
-	info->flash_info = &default_flash;
 	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;

@@ -1056,10 +1077,9 @@ static struct nand_ecclayout hw_largepage_ecclayout = {
 static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 				 struct pxa3xx_nand_info *info)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
 	struct nand_chip *this = &info->nand_chip;

-	this->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
+	this->options = (info->reg_ndcr & NDCR_DWIDTH_C) ? NAND_BUSWIDTH_16: 0;

 	this->waitfunc		= pxa3xx_nand_waitfunc;
 	this->select_chip	= pxa3xx_nand_select_chip;
@@ -1075,9 +1095,9 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
 	this->ecc.calculate	= pxa3xx_nand_ecc_calculate;
 	this->ecc.correct	= pxa3xx_nand_ecc_correct;
-	this->ecc.size		= f->page_size;
+	this->ecc.size		= info->page_size;

-	if (f->page_size == 2048)
+	if (info->page_size == 2048)
 		this->ecc.layout = &hw_largepage_ecclayout;
 	else
 		this->ecc.layout = &hw_smallpage_ecclayout;
@@ -1085,7 +1105,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->chip_delay = 25;
 }

-static int pxa3xx_nand_probe(struct platform_device *pdev)
+static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
@@ -1284,9 +1304,11 @@ static int pxa3xx_nand_resume(struct
platform_device *pdev)
 	struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
 	struct pxa3xx_nand_info *info = mtd->priv;

+	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
+	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
 	clk_enable(info->clk);

-	return pxa3xx_nand_config_flash(info, info->flash_info);
+	return 0;
 }
 #else
 #define pxa3xx_nand_suspend	NULL
-- 
1.7.0.4
