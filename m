From: leiwen@marvell.com (Lei Wen)
Date: Mon, 22 Mar 2010 19:42:27 +0800
Subject: [PATCH] pxa3xx_nand: remove detect configure function
Message-ID: <mailman.375.1273136796.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For large page size nand chip, like 4k and 8k, we unable to
just use register setting left by bootloader to actually tell
the original page size. This is due to limitaton of the hardware,
it only has a little more than 2k ram buffer internal.

So when we try to do 4k or larger page size chip operation,
we need to seperate the original page size to what we could
offer, like 2k or less.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   78 ----------------------------------------
 1 files changed, 0 insertions(+), 78 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 7a8ff38..2c7f925 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -218,13 +218,6 @@ static int use_dma = 1;
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
@@ -824,77 +817,6 @@ static int pxa3xx_nand_config_flash(struct
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
-static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
-{
-	uint32_t ndcr = nand_readl(info, NDCR);
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
-
-	pxa3xx_nand_detect_timing(info, &default_timing);
-	memcpy(&default_flash.timing, &default_timing, sizeof(default_timing));
-
-	return 0;
-}
-
 /* the maximum possible buffer size for large page with OOB data
  * is: 2048 + 64 = 2112 bytes, allocate a page here for both the
  * data buffer and the DMA descriptor
-- 
1.5.6.5
