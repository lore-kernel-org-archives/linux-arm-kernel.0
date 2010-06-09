From: leiwen@marvell.com (Lei Wen)
Date: Wed, 9 Jun 2010 16:55:14 +0800
Subject: [PATCH 24/25] pxa3xx_nand: fix write oob bug
Message-ID: <mailman.48.1276839611.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For column addressing is only used to subpage and oob operation,
and the fact that our controller is performing poor at such two
operations, disable the column addressing in writing the ndcb1.

If not add this patch, write_oob function would fail.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   42 +++++++++++++++++++++++++++++++--------
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 99f4088..96b46e1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -314,6 +314,20 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 { "256MiB 16-bit", 0xba20, 0xffff,  64, 2048, 16, 16, 1, 2048, &timing[3], },
 };

+static struct nand_ecclayout nand_oob_128_BCH = {
+	.eccbytes = 64,
+	.eccpos = {
+		64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,
+		76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
+		88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
+		100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
+		110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
+		120, 121, 122, 123, 124, 125, 126, 127},
+	.oobfree = {
+		{.offset = 2,
+		.length = 62}}
+};
+
 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};

 #define NDTR0_tADL(c)		(min_t(uint32_t, (c), 31) << 27)
@@ -599,13 +613,19 @@ static void start_data_dma(struct pxa3xx_nand
*nand, int dir_out)
 	desc_oob->ddadr = desc->ddadr = DDADR_STOP;
 	desc_oob->dcmd = desc->dcmd = DCMD_WIDTH4 | DCMD_BURST32;
 	if (dir_out) {
+		if (nand->oob_size > 0) {
+			desc_oob->dsadr = nand->dma_buff_phys + info->page_size + nand->oob_column;
+			desc_oob->dcmd |= DCMD_ENDIRQEN | DCMD_INCSRCADDR | DCMD_FLOWTRG | oob_len;
+			desc->ddadr = nand->dma_desc_addr + sizeof(struct pxa_dma_desc);
+			desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG | data_len;
+		}
+		else
+			desc->dcmd |= DCMD_ENDIRQEN | DCMD_INCSRCADDR | DCMD_FLOWTRG | data_len;
 		desc->dsadr = nand->dma_buff_phys + nand->data_column;
-		desc->dtadr = nand->mmio_phys + NDDB;
-		desc->dcmd |= DCMD_ENDIRQEN | DCMD_INCSRCADDR | DCMD_FLOWTRG |
(data_len + oob_len);
+		desc_oob->dtadr = desc->dtadr = nand->mmio_phys + NDDB;
 	} else {
 		if (nand->oob_size > 0) {
-			desc_oob->dtadr = nand->dma_buff_phys
-					+ info->page_size + nand->oob_column;
+			desc_oob->dtadr = nand->dma_buff_phys + info->page_size + nand->oob_column;
 			desc_oob->dcmd |= DCMD_ENDIRQEN | DCMD_INCTRGADDR | DCMD_FLOWSRC | oob_len;
 			desc->ddadr = nand->dma_desc_addr + sizeof(struct pxa_dma_desc);
 			desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC | data_len;
@@ -766,11 +786,13 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	uint16_t cmd;
 	int addr_cycle, exec_cmd, ndcb0, i, chunks = 0;
 	struct mtd_info *mtd;
+	struct nand_chip *chip;
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
 	struct platform_device *pdev = nand->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;

 	mtd = get_mtd_by_info(info);
+	chip = mtd->priv;
 	ndcb0 = (nand->chip_select) ? NDCB0_CSEL : 0;;
 	addr_cycle = 0;
 	exec_cmd = 1;
@@ -825,11 +847,9 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 		info->page_addr = page_addr;
 		/* small page addr setting */
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
-			nand->ndcb1[0] = ((page_addr & 0xFFFFFF) << 8)
-					| (column & 0xFF);
+			nand->ndcb1[0] = ((page_addr & 0xFFFFFF) << 8);
 		else {
-			nand->ndcb1[0] = ((page_addr & 0xFFFF) << 16)
-					| (column & 0xFFFF);
+			nand->ndcb1[0] = ((page_addr & 0xFFFF) << 16);

 			if (page_addr & 0xFF0000)
 				nand->ndcb2 = (page_addr & 0xFF0000) >> 16;
@@ -892,7 +912,9 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		break;

 	case NAND_CMD_PAGEPROG:
-		if (is_buf_blank(nand->data_buff, (mtd->writesize + mtd->oobsize))) {
+		if (is_buf_blank(nand->data_buff, mtd->writesize) &&
+		    is_buf_blank(nand->oob_buff + chip->ecc.layout->oobfree[0].offset,
+			    chip->ecc.layout->oobfree[0].length)) {
 			exec_cmd = 0;
 			break;
 		}
@@ -1394,6 +1416,8 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 	}

 	pxa3xx_nand_config_flash(info, f);
+	if (f->page_size == 4096 && f->ecc_strength == 4)
+		chip->ecc.layout = &nand_oob_128_BCH;
 	pxa3xx_flash_ids[0].name = f->name;
 	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
 	pxa3xx_flash_ids[0].pagesize = f->page_size;
-- 
1.7.0.4
