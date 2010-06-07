From: leiwen@marvell.com (Lei Wen)
Date: Mon, 7 Jun 2010 15:13:50 +0800
Subject: [PATCH 19/25] pxa3xx_nand: support ecc requirement higher
Message-ID: <mailman.44.1276839588.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

than 4bit per 512 bytes

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  118 ++++++++++++++++++++++++----------------
 1 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e4ccf7c..04bf875 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -33,6 +33,8 @@
 #define BCH_THRESHOLD           (8)
 #define CMD_POOL_SIZE           (5)
 #define READ_ID_BYTES		(4)
+#define BCH_STRENGTH		(4)
+#define HAMMING_STRENGTH	(1)

 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
@@ -84,9 +86,9 @@
 #define NDCR_RDDREQM            (0x1 << 1)
 #define NDCR_WRCMDREQM          (0x1)

+#define NDSR_MASK		(0xffffffff)
 #define NDSR_ERR_CNT_MASK       (0x1F << 16)
 #define NDSR_ERR_CNT(x)         (((x) << 16) & NDSR_ERR_CNT_MASK)
-#define NDSR_MASK		(0xfff)
 #define NDSR_RDY                (0x1 << 12)
 #define NDSR_FLASH_RDY          (0x1 << 11)
 #define NDSR_CS0_PAGED		(0x1 << 10)
@@ -103,6 +105,7 @@

 #define NDCB0_CMD_XTYPE_MASK    (0x7 << 29)
 #define NDCB0_CMD_XTYPE(x)      (((x) << 29) & NDCB0_CMD_XTYPE_MASK)
+#define NDCB0_LEN_OVRD		(0x1 << 28)
 #define NDCB0_ST_ROW_EN         (0x1 << 26)
 #define NDCB0_AUTO_RS		(0x1 << 25)
 #define NDCB0_CSEL		(0x1 << 24)
@@ -194,7 +197,7 @@ struct pxa3xx_nand_flash {
 	uint16_t 	page_size;	/* Page size in bytes */
 	uint8_t		flash_width;	/* Width of Flash memory (DWIDTH_M) */
 	uint8_t 	dfc_width;	/* Width of flash controller(DWIDTH_C) */
-	uint8_t		ecc_type;	/* Which ECC is applied */
+	uint8_t		ecc_strength;	/* How strong a ecc should be applied */
 	uint32_t	num_blocks;	/* Number of physical blocks in Flash */
 	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
 };
@@ -205,7 +208,7 @@ struct pxa3xx_nand_info {
 	int			page_addr;
 	uint16_t		page_size;
 	uint8_t			chip_select;
-	uint8_t			use_ecc;
+	uint8_t			ecc_strength;

 	/* calculated from pxa3xx_nand_flash data */
 	uint8_t			col_addr_cycles;
@@ -250,8 +253,8 @@ struct pxa3xx_nand {

 	/* relate to the command */
 	uint8_t			chip_select;
+	uint8_t			ecc_strength;
 	unsigned int		state;
-	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */
 	int 			retcode;

@@ -262,6 +265,7 @@ struct pxa3xx_nand {
 	uint32_t		ndcb0[CMD_POOL_SIZE];
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;
+	uint32_t		ndcb3[CMD_POOL_SIZE];
 };

 static int use_dma = 1;
@@ -293,17 +297,17 @@ static struct pxa3xx_nand_timing __devinitdata
timing[] = {
 };

 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-{ 		0,	0,	0,   0,	   0,  0,  0, ECC_NONE,      0, &timing[0], },
-{ "64MiB 16-bit",  0x46ec, 0xffff,  32,  512, 16, 16, ECC_HAMMIN,
4096, &timing[1], },
-{ "256MiB 8-bit",  0xdaec, 0xffff,  64, 2048,  8,  8, ECC_HAMMIN,
2048, &timing[1], },
-{ "1GiB 8-bit",    0xd3ec, 0xffff, 128, 2048,  8,  8, ECC_BCH,
4096, &timing[1], },
-{ "4GiB 8-bit",    0xd7ec, 0x29d5, 128, 4096,  8,  8, ECC_BCH,
8192, &timing[1], },
-{ "128MiB 8-bit",  0xa12c, 0xffff,  64, 2048,  8,  8, ECC_HAMMIN,
1024, &timing[2], },
-{ "128MiB 16-bit", 0xb12c, 0xffff,  64, 2048, 16, 16, ECC_HAMMIN,
1024, &timing[2], },
-{ "512MiB 8-bit",  0xdc2c, 0xffff,  64, 2048,  8,  8, ECC_HAMMIN,
4096, &timing[2], },
-{ "512MiB 16-bit", 0xcc2c, 0xffff,  64, 2048, 16, 16, ECC_HAMMIN,
4096, &timing[2], },
-{ "1GiB 8-bit",    0x382c, 0xffff, 128, 4096,  8,  8, ECC_BCH,
2048, &timing[2], },
-{ "256MiB 16-bit", 0xba20, 0xffff,  64, 2048, 16, 16, ECC_HAMMIN,
2048, &timing[3], },
+{ 		0,	0,	0,   0,	   0,  0,  0, 0,    0, &timing[0], },
+{ "64MiB 16-bit",  0x46ec, 0xffff,  32,  512, 16, 16, 1, 4096, &timing[1], },
+{ "256MiB 8-bit",  0xdaec, 0xffff,  64, 2048,  8,  8, 1, 2048, &timing[1], },
+{ "1GiB 8-bit",    0xd3ec, 0xffff, 128, 2048,  8,  8, 4, 4096, &timing[1], },
+{ "4GiB 8-bit",    0xd7ec, 0x29d5, 128, 4096,  8,  8, 8, 8192, &timing[1], },
+{ "128MiB 8-bit",  0xa12c, 0xffff,  64, 2048,  8,  8, 1, 1024, &timing[2], },
+{ "128MiB 16-bit", 0xb12c, 0xffff,  64, 2048, 16, 16, 1, 1024, &timing[2], },
+{ "512MiB 8-bit",  0xdc2c, 0xffff,  64, 2048,  8,  8, 1, 4096, &timing[2], },
+{ "512MiB 16-bit", 0xcc2c, 0xffff,  64, 2048, 16, 16, 1, 4096, &timing[2], },
+{ "1GiB 8-bit",    0x382c, 0xffff, 128, 4096,  8,  8, 4, 2048, &timing[2], },
+{ "256MiB 16-bit", 0xba20, 0xffff,  64, 2048, 16, 16, 1, 2048, &timing[3], },
 };

 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
@@ -358,16 +362,15 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 			return;
 		}

-		switch (nand->use_ecc) {
-		case ECC_HAMMIN:
-			nand->oob_size = 40;
+		switch (nand->ecc_strength) {
+		case 0:
+			nand->oob_size = 64;
 			break;
-		case ECC_BCH:
-			nand->oob_size = 32;
+		case HAMMING_STRENGTH:
+			nand->oob_size = 40;
 			break;
 		default:
-			nand->oob_size = 64;
-			break;
+			nand->oob_size = 32;
 		}
 	} else {
 		nand->data_size = 512;
@@ -376,17 +379,16 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 			return;
 		}

-		switch (nand->use_ecc) {
-		case ECC_HAMMIN:
+		switch (nand->ecc_strength) {
+		case 0:
+			nand->oob_size = 16;
+			break;
+		case HAMMING_STRENGTH:
 			nand->oob_size = 8;
 			break;
-		case ECC_BCH:
+		default:
 			printk("Don't support BCH on small page device!!!\n");
 			BUG();
-			break;
-		default:
-			nand->oob_size = 16;
-			break;
 		}
 	}
 }
@@ -404,16 +406,16 @@ static void pxa3xx_nand_start(struct pxa3xx_nand *nand)

 	info = nand->info[nand->chip_select];
 	ndcr = info->reg_ndcr;
-	ndcr |= nand->use_dma ? NDCR_DMA_EN : NDCR_STOP_ON_UNCOR;
+	ndcr |= nand->use_dma ? NDCR_DMA_EN : 0;
 	ndcr |= NDCR_ND_RUN;

-	switch (nand->use_ecc) {
-	case ECC_BCH:
+	switch (nand->ecc_strength) {
+	default:
 		ndeccctrl |= NDECCCTRL_BCH_EN;
 		ndeccctrl |= NDECCCTRL_ECC_THRESH(BCH_THRESHOLD);
-	case ECC_HAMMIN:
+	case HAMMING_STRENGTH:
 		ndcr |= NDCR_ECC_EN;
-	default:
+	case 0:
 		break;
 	}

@@ -649,6 +651,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 			nand_writel(nand, NDCB0, nand->ndcb0[cmd_seqs]);
 			nand_writel(nand, NDCB0, ndcb1);
 			nand_writel(nand, NDCB0, ndcb2);
+			if (nand->ndcb3[cmd_seqs])
+				nand_writel(nand, NDCB0, nand->ndcb3[cmd_seqs]);
 		}
 		else
 			is_completed = 1;
@@ -705,11 +709,23 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 		pxa3xx_set_datasize(info);
 		nand->use_dma = use_dma;
 		chunks = info->page_size / nand->data_size;
+		if (info->ecc_strength > BCH_STRENGTH) {
+			i = info->ecc_strength / BCH_STRENGTH;
+			nand->data_size /= i;
+			ndcb0 |= NDCB0_LEN_OVRD;
+			chunks *= i;
+		}
 		break;
+	case NAND_CMD_READOOB:
+		if (info->ecc_strength > BCH_STRENGTH) {
+			printk(KERN_ERR "we don't support oob command if use"
+				     " 8bit per 512bytes ecc feature!!\n");
+			BUG();
+		}
 	default:
 		nand->ndcb1 = 0;
 		nand->ndcb2 = 0;
-		nand->use_ecc = 0;
+		nand->ecc_strength = 0;
 		break;
 	}
 	if (nand->use_dma) {
@@ -721,6 +737,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	for (i = 0; i < CMD_POOL_SIZE; i ++) {
 		nand->ndcb0[i] = ndcb0;
 		nand->wait_ready[i] = 0;
+		nand->ndcb3[i] = (ndcb0 & NDCB0_LEN_OVRD)? nand->data_size : 0;
 	}
 	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
 			+ info->col_addr_cycles);
@@ -728,7 +745,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	switch (command) {
 	case NAND_CMD_READ0:
 	case NAND_CMD_SEQIN:
-		nand->use_ecc = info->use_ecc;
+		nand->ecc_strength = info->ecc_strength;
 	case NAND_CMD_READOOB:
 		memset(nand->data_buff, 0xff, column);
 		nand->buf_count = mtd->writesize + mtd->oobsize;
@@ -775,7 +792,8 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 				| NDCB0_NC
 				| addr_cycle
 				| cmd;
-
+		nand->ndcb0[0] &= ~NDCB0_LEN_OVRD;
+		nand->ndcb3[0] = 0;
 		nand->ndcb0[1] |= NDCB0_CMD_XTYPE(0x5)
 				| NDCB0_NC
 				| addr_cycle;
@@ -831,6 +849,8 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 				| (cmd & NDCB0_CMD2_MASK)
 				| NDCB0_CMD1_MASK
 				| addr_cycle;
+		nand->ndcb0[chunks] &= ~NDCB0_LEN_OVRD;
+		nand->ndcb3[chunks] = 0;
 		/* we should wait for RnB goes high which
 		 * indicate the data has been written succesfully*/
 		nand->wait_ready[nand->total_cmds] = 1;
@@ -1022,7 +1042,12 @@ static void pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 		BUG();
 	}
 	/* calculate flash information */
-	info->use_ecc = f->ecc_type;
+	if (f->ecc_strength != 0 && f->ecc_strength != HAMMING_STRENGTH
+			&& (f->ecc_strength % BCH_STRENGTH != 0)) {
+		printk(KERN_ERR "ECC strength definition error, please recheck!!\n");
+		BUG();
+	}
+	info->ecc_strength = f->ecc_strength;
 	info->page_size = f->page_size;

 	/* calculate addressing information */
@@ -1066,7 +1091,9 @@ static void pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	}

 	ndcr |= NDCR_RD_ID_CNT(READ_ID_BYTES);
-	ndcr |= NDCR_SPARE_EN; /* enable spare by default */
+	/* only enable spare area when ecc is lower than 8bits per 512 bytes */
+	if (f->ecc_strength <= BCH_STRENGTH)
+		ndcr |= NDCR_SPARE_EN;

 	info->reg_ndcr = ndcr;

@@ -1086,7 +1113,7 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand *nand)
 	info->reg_ndcr = ndcr & ~(NDCR_INT_MASK | NDCR_ECC_EN | NDCR_DMA_EN
| NDCR_ND_RUN);
 	info->ndtr0cs0 = nand_readl(nand, NDTR0CS0);
 	info->ndtr1cs0 = nand_readl(nand, NDTR1CS0);
-	info->use_ecc = (ndeccctrl & NDECCCTRL_BCH_EN) ? ECC_BCH : ECC_HAMMIN;
+	info->ecc_strength = (ndeccctrl & NDECCCTRL_BCH_EN) ? BCH_STRENGTH :
HAMMING_STRENGTH;

 	return 0;
 }
@@ -1121,19 +1148,16 @@ static void pxa3xx_read_page(struct mtd_info
*mtd, uint8_t *buf)
 	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RNDOUT, 0, info->page_addr);
 	switch (nand->retcode) {
 	case ERR_SBERR:
-		switch (nand->use_ecc) {
-		case ECC_BCH:
+		switch (nand->ecc_strength) {
+		default:
 			if (nand->bad_count > BCH_THRESHOLD)
 				mtd->ecc_stats.corrected +=
 					(nand->bad_count - BCH_THRESHOLD);
 			break;

-		case ECC_HAMMIN:
+		case HAMMING_STRENGTH:
 			mtd->ecc_stats.corrected ++;
-			break;
-
-		case ECC_NONE:
-		default:
+		case 0:
 			break;
 		}
 		break;
-- 
1.7.0.4
