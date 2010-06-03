From: leiwen@marvell.com (Lei Wen)
Date: Thu, 3 Jun 2010 10:26:21 +0800
Subject: [PATCH 09/25] pxa3xx_nand: clean the keep configure code
Message-ID: <mailman.33.1276839514.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  165 ++++++++++------------------------------
 1 files changed, 42 insertions(+), 123 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 481cb25..8628fc1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -146,6 +146,7 @@ struct pxa3xx_nand_cmdset {
 };

 struct pxa3xx_nand_flash {
+	char		*name;
 	uint32_t	chip_id;
 	uint16_t	page_per_block; /* Pages per block (PG_PER_BLK) */
 	uint16_t 	page_size;	/* Page size in bytes (PAGE_SZ) */
@@ -219,13 +220,6 @@ static int use_dma = 1;
 module_param(use_dma, bool, 0444);
 MODULE_PARM_DESC(use_dma, "enable DMA for data transfering to/from NAND HW");

-/*
- * Default NAND flash controller configuration setup by the
- * bootloader. This configuration is used only when pdata->keep_config is set
- */
-static struct pxa3xx_nand_timing default_timing;
-static struct pxa3xx_nand_flash default_flash;
-
 const static struct pxa3xx_nand_cmdset cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
@@ -251,15 +245,15 @@ static struct pxa3xx_nand_timing __devinitdata
timing[] = {
 };

 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-	{      0,   0,    0,  0,  0,    0, &timing[0], },
-	{ 0x46ec,  32,  512, 16, 16, 4096, &timing[1], },
-	{ 0xdaec,  64, 2048,  8,  8, 2048, &timing[1], },
-	{ 0xd7ec, 128, 4096,  8,  8, 8192, &timing[1], },
-	{ 0xa12c,  64, 2048,  8,  8, 1024, &timing[2], },
-	{ 0xb12c,  64, 2048, 16, 16, 1024, &timing[2], },
-	{ 0xdc2c,  64, 2048,  8,  8, 4096, &timing[2], },
-	{ 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2], },
-	{ 0xba20,  64, 2048, 16, 16, 2048, &timing[3], },
+	{ 		0,	0,   0,    0,  0,  0,    0, &timing[0], },
+	{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &timing[1], },
+	{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &timing[1], },
+	{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1], },
+	{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &timing[2], },
+	{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &timing[2], },
+	{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2], },
+	{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2], },
+	{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3], },
 };

 static const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
@@ -275,23 +269,8 @@ static const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
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
-
-/* convert nand flash controller clock cycles to nano-seconds */
-#define cycle2ns(c, clk)	((((c) + 1) * 1000000 + clk / 500) / (clk / 1000))
-
 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 				   const struct pxa3xx_nand_timing *t)
 {
@@ -803,7 +782,6 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,

 	/* calculate flash information */
 	info->page_size = f->page_size;
-	info->oob_buff = info->data_buff + f->page_size;
 	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

@@ -831,73 +809,14 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
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
-	struct nand_flash_dev *type = NULL;
-	uint32_t id = -1;
-	int i;
-
-	default_flash.page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
-	default_flash.page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
-	default_flash.flash_width = ndcr & NDCR_DWIDTH_M ? 16 : 8;
-	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;
-
-	/* set info fields needed to __readid */
-	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
-	info->reg_ndcr = ndcr;
-
-
-	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
-
-	/* Lookup the flash id */
-	id = (id >> 8) & 0xff;		/* device id is byte 2 */
-	for (i = 0; nand_flash_ids[i].name != NULL; i++) {
-		if (id == nand_flash_ids[i].id) {
-			type =  &nand_flash_ids[i];
-			break;
-		}
-	}
-
-	if (!type)
-		return -ENODEV;
-
-	/* fill the missing flash information */
-	i = __ffs(default_flash.page_per_block * default_flash.page_size);
-	default_flash.num_blocks = type->chipsize << (20 - i);
-
-	info->oob_size = (default_flash.page_size == 2048) ? 64 : 16;
-
-	/* calculate addressing information */
-	info->col_addr_cycles = (default_flash.page_size == 2048) ? 2 : 1;
-
-	if (default_flash.num_blocks * default_flash.page_per_block > 65536)
-		info->row_addr_cycles = 3;
-	else
-		info->row_addr_cycles = 2;

-	pxa3xx_nand_detect_timing(info, &default_timing);
-	memcpy(&default_flash.timing, &default_timing, sizeof(default_timing));
+	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
+	info->reg_ndcr = ndcr & ~(NDCR_INT_MASK | NDCR_ECC_EN | NDCR_DMA_EN
| NDCR_ND_RUN);
+	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
+	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);

 	return 0;
 }
@@ -1006,14 +925,17 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 	struct pxa3xx_nand_info *info = mtd->priv;
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
+	struct nand_flash_dev pxa3xx_flash_ids[2] = {{NULL,}, {NULL,}};
 	const struct pxa3xx_nand_flash *f = NULL;
 	struct nand_chip *chip = mtd->priv;
 	uint32_t id = -1;
+	uint64_t chipsize;
 	int i, ret;

-	if (pdata->keep_config)
+	if (pdata->keep_config) {
 		if (pxa3xx_nand_detect_config(info) == 0)
-			return 0;
+			goto KEEP_CONFIG;
+	}

 	ret = pxa3xx_nand_sensing(info);
 	if (!ret) {
@@ -1043,22 +965,11 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 			f = &builtin_flash_types[i - pdata->num_flash + 1];

 		/* find the chip in default list */
-		if (f->chip_id == id) {
-			pxa3xx_nand_config_flash(info, f);
-			mtd->writesize = f->page_size;
-			mtd->writesize_shift = ffs(mtd->writesize) - 1;
-			mtd->writesize_mask = (1 << mtd->writesize_shift) - 1;
-			mtd->oobsize = mtd->writesize / 32;
-			mtd->erasesize = f->page_size * f->page_per_block;
-			mtd->erasesize_shift = ffs(mtd->erasesize) - 1;
-			mtd->erasesize_mask = (1 << mtd->erasesize_shift) - 1;
-
-			mtd->name = mtd_names[0];
+		if (f->chip_id == id)
 			break;
-		}
 	}

-	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash)) {
+	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
 		kfree(mtd);
 		info->mtd = NULL;
 		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
@@ -1066,20 +977,28 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 		return -EINVAL;
 	}

+	pxa3xx_nand_config_flash(info, f);
+	pxa3xx_flash_ids[0].name = f->name;
+	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
+	pxa3xx_flash_ids[0].pagesize = f->page_size;
+	chipsize = (uint64_t)f->num_blocks * f->page_per_block * f->page_size;
+	pxa3xx_flash_ids[0].chipsize = chipsize >> 20;
+	pxa3xx_flash_ids[0].erasesize = f->page_size * f->page_per_block;
+	pxa3xx_flash_ids[0].options = (f->flash_width == 16) ? NAND_BUSWIDTH_16 : 0;
+KEEP_CONFIG:
+	if (nand_scan_ident(mtd, 1, pxa3xx_flash_ids))
+		return -ENODEV;
+	/* calculate addressing information */
+	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
+	info->oob_buff = info->data_buff + mtd->writesize;
+	if ((mtd->size >> chip->page_shift) > 65536)
+		info->row_addr_cycles = 3;
+	else
+		info->row_addr_cycles = 2;
+	mtd->name = mtd_names[0];
 	chip->ecc.mode = NAND_ECC_HW;
-	chip->ecc.size = f->page_size;
-	chip->chipsize 	= (uint64_t)f->num_blocks * f->page_per_block
-				* f->page_size;
-	mtd->size = chip->chipsize;
-
-	/* Calculate the address shift from the page size */
-	chip->page_shift = ffs(mtd->writesize) - 1;
-	chip->pagemask = mtd_div_by_ws(chip->chipsize, mtd) - 1;
-	chip->numchips = 1;
-	chip->bbt_erase_shift = chip->phys_erase_shift = ffs(mtd->erasesize) - 1;
-
-	chip->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
-	chip->options |= NAND_NO_AUTOINCR;
+	chip->ecc.size = mtd->writesize;
+	chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16: 0;
 	chip->options |= NAND_NO_READRDY;
 	chip->options |= NAND_USE_FLASH_BBT;

-- 
1.7.0.4
