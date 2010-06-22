From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 20:28:19 +0800
Subject: [PATCH 04/29] pxa3xx_nand: remove the flash info in driver structure
Message-ID: <mailman.98.1280296600.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After probe, all info already transfer to driver structure.
There is no need to keep the original flash info.
So that we could safely free the flash info in memory, which may grows
larger when more flash is suported.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  116 +++++++++++++++-------------------------
 1 files changed, 44 insertions(+), 72 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index b605147..50e08db 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -117,7 +117,7 @@ struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;

 	struct platform_device	 *pdev;
-	const struct pxa3xx_nand_flash *flash_info;
+	struct pxa3xx_nand_cmdset *cmdset;

 	struct clk		*clk;
 	void __iomem		*mmio_base;
@@ -131,6 +131,7 @@ struct pxa3xx_nand_info {
 	int			drcmr_cmd;

 	unsigned char		*data_buff;
+	unsigned char		*oob_buff;
 	dma_addr_t 		data_buff_phys;
 	size_t			data_buff_size;
 	int 			data_dma_ch;
@@ -149,7 +150,8 @@ struct pxa3xx_nand_info {
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */

-	size_t			data_size;	/* data size in FIFO */
+	unsigned int		page_size;	/* page size of attached chip */
+	unsigned int		data_size;	/* data size in FIFO */
 	int 			retcode;
 	struct completion 	cmd_complete;

@@ -158,6 +160,10 @@ struct pxa3xx_nand_info {
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;

+	/* timing calcuted from setting */
+	uint32_t		ndtr0cs0;
+	uint32_t		ndtr1cs0;
+
 	/* calculated from pxa3xx_nand_flash data */
 	size_t		oob_size;
 	size_t		read_id_bytes;
@@ -174,8 +180,6 @@ MODULE_PARM_DESC(use_dma, "enable DMA for data
transfering to/from NAND HW");
  * Default NAND flash controller configuration setup by the
  * bootloader. This configuration is used only when pdata->keep_config is set
  */
-static struct pxa3xx_nand_timing default_timing;
-static struct pxa3xx_nand_flash default_flash;
 static struct pxa3xx_nand_cmdset default_cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
@@ -223,23 +227,9 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 #define NDTR1_tWHR(c)	(min((c), 15) << 4)
 #define NDTR1_tAR(c)	(min((c), 15) << 0)

-#define tCH_NDTR0(r)	(((r) >> 19) & 0x7)
-#define tCS_NDTR0(r)	(((r) >> 16) & 0x7)
-#define tWH_NDTR0(r)	(((r) >> 11) & 0x7)
-#define tWP_NDTR0(r)	(((r) >> 8) & 0x7)
-#define tRH_NDTR0(r)	(((r) >> 3) & 0x7)
-#define tRP_NDTR0(r)	(((r) >> 0) & 0x7)
-
-#define tR_NDTR1(r)	(((r) >> 16) & 0xffff)
-#define tWHR_NDTR1(r)	(((r) >> 4) & 0xf)
-#define tAR_NDTR1(r)	(((r) >> 0) & 0xf)
-
 /* convert nano-seconds to nand flash controller clock cycles */
 #define ns2cycle(ns, clk)	(int)(((ns) * (clk / 1000000) / 1000) - 1)

-/* convert nand flash controller clock cycles to nano-seconds */
-#define cycle2ns(c, clk)	((((c) + 1) * 1000000 + clk / 500) / (clk / 1000))
-
 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 				   const struct pxa3xx_nand_timing *t)
 {
@@ -257,6 +247,8 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,
 		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
 		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));

+	info->ndtr0cs0 = ndtr0;
+	info->ndtr1cs0 = ndtr1;
 	nand_writel(info, NDTR0CS0, ndtr0);
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
@@ -280,23 +272,24 @@ static int wait_for_event(struct
pxa3xx_nand_info *info, uint32_t event)
 	return -ETIMEDOUT;
 }

-static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
-			uint16_t cmd, int column, int page_addr)
+static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
-	const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
-
 	/* calculate data size */
-	switch (f->page_size) {
+	switch (info->page_size) {
 	case 2048:
 		info->data_size = (info->use_ecc) ? 2088 : 2112;
 		break;
 	case 512:
 		info->data_size = (info->use_ecc) ? 520 : 528;
 		break;
-	default:
-		return -EINVAL;
 	}
+}
+
+static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
+		uint16_t cmd, int column, int page_addr)
+{
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
+	pxa3xx_set_datasize(info);

 	/* generate values for NDCBx registers */
 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
@@ -335,7 +328,7 @@ static int prepare_erase_cmd(struct pxa3xx_nand_info *info,

 static int prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
 {
-	const struct pxa3xx_nand_cmdset *cmdset = info->flash_info->cmdset;
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;

 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
 	info->ndcb1 = 0;
@@ -421,6 +414,7 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 	case STATE_PIO_READING:
 		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
+
 		break;
 	default:
 		printk(KERN_ERR "%s: invalid state %d\n", __func__,
@@ -572,8 +566,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 				int column, int page_addr)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	const struct pxa3xx_nand_flash *flash_info = info->flash_info;
-	const struct pxa3xx_nand_cmdset *cmdset = flash_info->cmdset;
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
 	int ret;

 	info->use_dma = (use_dma) ? 1 : 0;
@@ -797,8 +790,7 @@ static int pxa3xx_nand_ecc_correct(struct mtd_info *mtd,

 static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
-	const struct pxa3xx_nand_cmdset *cmdset = f->cmdset;
+	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
 	uint32_t ndcr;
 	uint8_t  id_buff[8];

@@ -840,6 +832,9 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 		return -EINVAL;

 	/* calculate flash information */
+	info->cmdset = f->cmdset;
+	info->page_size = f->page_size;
+	info->oob_buff = info->data_buff + f->page_size;
 	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

@@ -864,44 +859,20 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	info->reg_ndcr = ndcr;

 	pxa3xx_nand_set_timing(info, f->timing);
-	info->flash_info = f;
 	return 0;
 }

-static void pxa3xx_nand_detect_timing(struct pxa3xx_nand_info *info,
-				      struct pxa3xx_nand_timing *t)
-{
-	unsigned long nand_clk = clk_get_rate(info->clk);
-	uint32_t ndtr0 = nand_readl(info, NDTR0CS0);
-	uint32_t ndtr1 = nand_readl(info, NDTR1CS0);
-
-	t->tCH = cycle2ns(tCH_NDTR0(ndtr0), nand_clk);
-	t->tCS = cycle2ns(tCS_NDTR0(ndtr0), nand_clk);
-	t->tWH = cycle2ns(tWH_NDTR0(ndtr0), nand_clk);
-	t->tWP = cycle2ns(tWP_NDTR0(ndtr0), nand_clk);
-	t->tRH = cycle2ns(tRH_NDTR0(ndtr0), nand_clk);
-	t->tRP = cycle2ns(tRP_NDTR0(ndtr0), nand_clk);
-
-	t->tR = cycle2ns(tR_NDTR1(ndtr1), nand_clk);
-	t->tWHR = cycle2ns(tWHR_NDTR1(ndtr1), nand_clk);
-	t->tAR = cycle2ns(tAR_NDTR1(ndtr1), nand_clk);
-}
-
 static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 {
 	uint32_t ndcr = nand_readl(info, NDCR);
 	struct nand_flash_dev *type = NULL;
-	uint32_t id = -1;
+	uint32_t id = -1, page_per_block, num_blocks;
 	int i;

-	default_flash.page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
-	default_flash.page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
-	default_flash.flash_width = ndcr & NDCR_DWIDTH_M ? 16 : 8;
-	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;
-
+	page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
+	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
 	/* set info fields needed to __readid */
-	info->flash_info = &default_flash;
-	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
+	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;

 	if (__readid(info, &id))
@@ -920,22 +891,22 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 		return -ENODEV;

 	/* fill the missing flash information */
-	i = __ffs(default_flash.page_per_block * default_flash.page_size);
-	default_flash.num_blocks = type->chipsize << (20 - i);
+	i = __ffs(page_per_block * info->page_size);
+	num_blocks = type->chipsize << (20 - i);

-	info->oob_size = (default_flash.page_size == 2048) ? 64 : 16;
+	info->oob_size = (info->page_size == 2048) ? 64 : 16;

 	/* calculate addressing information */
-	info->col_addr_cycles = (default_flash.page_size == 2048) ? 2 : 1;
+	info->col_addr_cycles = (info->page_size == 2048) ? 2 : 1;

-	if (default_flash.num_blocks * default_flash.page_per_block > 65536)
+	if (num_blocks * page_per_block > 65536)
 		info->row_addr_cycles = 3;
 	else
 		info->row_addr_cycles = 2;

-	pxa3xx_nand_detect_timing(info, &default_timing);
-	default_flash.timing = &default_timing;
-	default_flash.cmdset = &default_cmdset;
+	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
+	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
+	info->cmdset = &default_cmdset;

 	return 0;
 }
@@ -1036,10 +1007,9 @@ static struct nand_ecclayout hw_largepage_ecclayout = {
 static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 				 struct pxa3xx_nand_info *info)
 {
-	const struct pxa3xx_nand_flash *f = info->flash_info;
 	struct nand_chip *this = &info->nand_chip;

-	this->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
+	this->options = (info->reg_ndcr & NDCR_DWIDTH_C) ? NAND_BUSWIDTH_16: 0;

 	this->waitfunc		= pxa3xx_nand_waitfunc;
 	this->select_chip	= pxa3xx_nand_select_chip;
@@ -1055,9 +1025,9 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
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
@@ -1264,9 +1234,11 @@ static int pxa3xx_nand_resume(struct
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
