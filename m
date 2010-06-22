From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 23:13:05 +0800
Subject: [PATCH 25/29] pxa3xx_nand: reimplement the read oob logic
Message-ID: <mailman.146.1280297104.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For readoob command only need the content of oob part, it certainly
don't need the controller transfer the data part, which greatly
downgrade the performance.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  182 +++++++++++++++++++++-------------------
 1 files changed, 96 insertions(+), 86 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index fbe455e..ba15baf 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -198,30 +198,28 @@ struct pxa3xx_nand {
 	uint32_t		command;
 	uint16_t		data_size;	/* data size in FIFO */
 	uint16_t		oob_size;
-	uint32_t		bad_count;
 	unsigned char		*dma_buff;
 	unsigned char		*data_buff;
 	unsigned char		*oob_buff;
+	uint8_t			chip_select;
+	uint8_t			total_cmds;
 	uint32_t		buf_start;
 	uint32_t		buf_count;
+
+	uint32_t		state;
+	uint32_t		bad_count;
 	uint16_t		data_column;
 	uint16_t		oob_column;
-
-	/* relate to the command */
-	uint8_t			chip_select;
-	uint8_t			ecc_strength;
-	unsigned int		state;
 	int			use_dma;	/* use DMA ? */
 	int 			retcode;
+	uint8_t			ecc_strength;

 	/* cached register value */
 	uint8_t			cmd_seqs;
-	uint8_t			total_cmds;
 	uint8_t			wait_ready[CMD_POOL_SIZE];
 	uint32_t		ndcb0[CMD_POOL_SIZE];
-	uint32_t		ndcb1;
+	uint32_t		ndcb1[CMD_POOL_SIZE];
 	uint32_t		ndcb2;
-	uint32_t		ndcb3[CMD_POOL_SIZE];
 };

 static int use_dma = 1;
@@ -350,8 +348,8 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 	struct pxa3xx_nand *nand = info->nand_data;
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;

-	if (info->page_size >= PAGE_CHUNK_SIZE) {
-		nand->data_size = PAGE_CHUNK_SIZE;
+	if (info->page_size < PAGE_CHUNK_SIZE) {
+		nand->data_size = 512;
 		if (!oob_enable) {
 			nand->oob_size = 0;
 			return;
@@ -359,32 +357,54 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)

 		switch (nand->ecc_strength) {
 		case 0:
-			nand->oob_size = 64;
+			nand->oob_size = 16;
 			break;
 		case HAMMING_STRENGTH:
-			nand->oob_size = 40;
+			nand->oob_size = 8;
 			break;
 		default:
-			nand->oob_size = 32;
-		}
-	} else {
-		nand->data_size = 512;
-		if (!oob_enable) {
-			nand->oob_size = 0;
-			return;
+			printk("Don't support BCH on small page device!!!\n");
+			BUG();
 		}
+		return;
+	}
+	nand->data_size = PAGE_CHUNK_SIZE;
+	if (!oob_enable) {
+		nand->oob_size = 0;
+		return;
+	}

-		switch (nand->ecc_strength) {
-		case 0:
-			nand->oob_size = 16;
-			break;
+	if (nand->command == NAND_CMD_READOOB) {
+		switch (info->ecc_strength) {
 		case HAMMING_STRENGTH:
-			nand->oob_size = 8;
+			nand->ndcb1[3] = 2 * PAGE_CHUNK_SIZE + OOB_CHUNK_SIZE;
+			nand->data_size = 40;
+			break;
+		case BCH_STRENGTH:
+			nand->ndcb1[3] = 2 * PAGE_CHUNK_SIZE + OOB_CHUNK_SIZE - 2;
+			nand->data_size = 32;
 			break;
 		default:
-			printk("Don't support BCH on small page device!!!\n");
 			BUG();
 		}
+		if (info->reg_ndcr & NDCR_DWIDTH_M) {
+			nand->ndcb1[1] = PAGE_CHUNK_SIZE / 2;
+			nand->ndcb1[3] /= 2;
+		}
+		else
+			nand->ndcb1[1] = PAGE_CHUNK_SIZE;
+		nand->oob_size = 0;
+		return;
+	}
+	switch (nand->ecc_strength) {
+	case 0:
+		nand->oob_size = 64;
+		break;
+	case HAMMING_STRENGTH:
+		nand->oob_size = 40;
+		break;
+	default:
+		nand->oob_size = 32;
 	}
 }

@@ -468,9 +488,8 @@ static void nand_error_dump(struct pxa3xx_nand *nand)
 	printk(KERN_ERR "Totally %d command for sending\n",
 			nand->total_cmds);
 	for (i = 0; i < nand->total_cmds; i ++)
-		printk(KERN_ERR "NDCB0:%d: %x\n",
-				i, nand->ndcb0[i]);
-	printk(KERN_ERR "NDCB1: %x; NDCB2 %x\n", nand->ndcb1, nand->ndcb2);
+		printk(KERN_ERR "%d::NDCB0: %x, NDCB1: %x, NDCB2: %x\n",
+			i, nand->ndcb0[i], nand->ndcb1[i], nand->ndcb2);

 	printk(KERN_ERR "\nRegister DUMPing ##############\n");
 	printk(KERN_ERR "NDCR %x\n"
@@ -577,8 +596,8 @@ static void pxa3xx_nand_data_dma_irq(int channel,
void *data)
 static int pxa3xx_nand_transaction(struct pxa3xx_nand *nand)
 {
 	struct pxa3xx_nand_info *info;
-	unsigned int status, is_completed = 0, cs, cmd_seqs, ndcb1, ndcb2;
-	unsigned int ready, cmd_done, page_done, badblock_detect;
+	unsigned int status, is_completed = 0, cs, cmd_seqs;
+	unsigned int ready, cmd_done, page_done, badblock_detect, ndcb2;

 	cs		= nand->chip_select;
 	ready           = (cs) ? NDSR_RDY : NDSR_FLASH_RDY;
@@ -640,22 +659,19 @@ static int pxa3xx_nand_transaction(struct
pxa3xx_nand *nand)

 		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
 		if (cmd_seqs < nand->total_cmds) {
-			nand->cmd_seqs ++;
-			if (cmd_seqs == 0) {
-				ndcb1 = nand->ndcb1;
+			if (cmd_seqs == 0)
 				ndcb2 = nand->ndcb2;
-			}
-			else {
-				ndcb1 = 0;
+			else
 				ndcb2 = 0;
-			}
+			nand->cmd_seqs ++;
 			nand->state &= ~STATE_MASK;
 			nand->state |= STATE_CMD_WAIT_DONE;
 			nand_writel(nand, NDCB0, nand->ndcb0[cmd_seqs]);
-			nand_writel(nand, NDCB0, ndcb1);
+			nand_writel(nand, NDCB0, nand->ndcb1[cmd_seqs]);
 			nand_writel(nand, NDCB0, ndcb2);
-			if (nand->ndcb3[cmd_seqs])
-				nand_writel(nand, NDCB0, nand->ndcb3[cmd_seqs]);
+			if (nand->ndcb0[cmd_seqs] & NDCB0_LEN_OVRD)
+				nand_writel(nand, NDCB0, nand->data_size
+						+ nand->oob_size);
 		}
 		else
 			is_completed = 1;
@@ -714,24 +730,15 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	exec_cmd = 1;

 	/* reset data and oob column point to handle data */
-	nand->data_column	= 0;
-	nand->oob_column	= 0;
-	nand->total_cmds	= 1;
-	nand->cmd_seqs		= 0;
-	nand->data_size		= 0;
-	nand->oob_size		= 0;
-	nand->use_dma		= 0;
-	nand->state		= 0;
-	nand->bad_count		= 0;
-	nand->retcode		= ERR_NONE;
-	nand->buf_start		= column;
+	nand->total_cmds = 1;
+	nand->buf_start	= column;

 	switch (command) {
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_RNDOUT:
 		pxa3xx_set_datasize(info);
 		nand->use_dma = use_dma;
-		chunks = info->page_size / nand->data_size;
+		chunks = info->page_size / PAGE_CHUNK_SIZE;
 		if (info->ecc_strength > BCH_STRENGTH) {
 			i = info->ecc_strength / BCH_STRENGTH;
 			nand->data_size /= i;
@@ -746,9 +753,8 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 			BUG();
 		}
 	default:
-		nand->ndcb1 = 0;
-		nand->ndcb2 = 0;
-		nand->ecc_strength = 0;
+		i = (uint32_t)(&nand->state) - (uint32_t)nand;
+		memset(&nand->state, 0, sizeof(struct pxa3xx_nand) - i);
 		break;
 	}
 	if (nand->use_dma) {
@@ -757,11 +763,8 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	}

 	/* clear the command buffer */
-	for (i = 0; i < CMD_POOL_SIZE; i ++) {
+	for (i = 0; i < CMD_POOL_SIZE; i ++)
 		nand->ndcb0[i] = ndcb0;
-		nand->wait_ready[i] = 0;
-		nand->ndcb3[i] = (ndcb0 & NDCB0_LEN_OVRD)? nand->data_size : 0;
-	}
 	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
 			+ info->col_addr_cycles);

@@ -776,10 +779,10 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 		info->page_addr = page_addr;
 		/* small page addr setting */
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
-			nand->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
+			nand->ndcb1[0] = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);
 		else {
-			nand->ndcb1 = ((page_addr & 0xFFFF) << 16)
+			nand->ndcb1[0] = ((page_addr & 0xFFFF) << 16)
 					| (column & 0xFFFF);

 			if (page_addr & 0xFF0000)
@@ -789,11 +792,6 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,

 	case NAND_CMD_RNDOUT:
 		cmd = info->cmdset->read1;
-		if (nand->command == NAND_CMD_READOOB) {
-			nand->buf_start = mtd->writesize + column;
-			nand->buf_count = mtd->oobsize;
-		}
-
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)
 			|| !(pdata->controller_attrs & PXA3XX_NAKED_CMD_EN)) {
 			if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
@@ -805,10 +803,18 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 						| NDCB0_DBC
 						| addr_cycle
 						| cmd;
+			if (nand->command == NAND_CMD_READOOB) {
+				nand->buf_start = mtd->writesize + column;
+				nand->buf_count = mtd->oobsize;
+			}
 			break;
 		}

-		nand->total_cmds = chunks + 1;
+		if (nand->command == NAND_CMD_READOOB)
+			nand->total_cmds = 2 * chunks + 1;
+		else
+			nand->total_cmds = chunks + 1;
+
 		nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x6)
 				| NDCB0_CMD_TYPE(0)
 				| NDCB0_DBC
@@ -816,15 +822,23 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 				| addr_cycle
 				| cmd;
 		nand->ndcb0[0] &= ~NDCB0_LEN_OVRD;
-		nand->ndcb3[0] = 0;
-		nand->ndcb0[1] |= NDCB0_CMD_XTYPE(0x5)
-				| NDCB0_NC
-				| addr_cycle;

-		for (i = 2; i <= chunks; i ++)
-			nand->ndcb0[i] = nand->ndcb0[1];
+		for (i = 1; i <= nand->total_cmds - 1;) {
+			if (nand->command == NAND_CMD_READOOB) {
+				nand->ndcb0[i ++] |= NDCB0_CMD_XTYPE(0x6)
+						| NDCB0_CMD_TYPE(0)
+						| NDCB0_ADDR_CYC(info->col_addr_cycles)
+						| NDCB0_DBC
+						| NDCB0_NC
+						| (NAND_CMD_RNDOUTSTART << 8)
+						| NAND_CMD_RNDOUT;
+				nand->ndcb0[i] |= NDCB0_LEN_OVRD;
+			}
+			nand->ndcb0[i ++] |= NDCB0_CMD_XTYPE(0x5)
+					| NDCB0_NC;
+		}

-		nand->ndcb0[chunks] &= ~NDCB0_NC;
+		nand->ndcb0[nand->total_cmds - 1] &= ~NDCB0_NC;
 		/* we should wait RnB go high again
 		 * before read out data*/
 		nand->wait_ready[1] = 1;
@@ -861,18 +875,15 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 			nand->ndcb0[i] |= NDCB0_CMD_XTYPE(0x5)
 					| NDCB0_NC
 					| NDCB0_AUTO_RS
-					| NDCB0_CMD_TYPE(0x1)
-					| addr_cycle;
+					| NDCB0_CMD_TYPE(0x1);

 		nand->ndcb0[chunks] |= NDCB0_CMD_XTYPE(0x3)
-				| NDCB0_CMD_TYPE(0x1)
-				| NDCB0_ST_ROW_EN
-				| NDCB0_DBC
-				| (cmd & NDCB0_CMD2_MASK)
-				| NDCB0_CMD1_MASK
-				| addr_cycle;
+					| NDCB0_CMD_TYPE(0x1)
+					| NDCB0_ST_ROW_EN
+					| NDCB0_DBC
+					| (cmd & NDCB0_CMD2_MASK)
+					| NDCB0_CMD1_MASK;
 		nand->ndcb0[chunks] &= ~NDCB0_LEN_OVRD;
-		nand->ndcb3[chunks] = 0;
 		/* we should wait for RnB goes high which
 		 * indicate the data has been written succesfully*/
 		nand->wait_ready[nand->total_cmds] = 1;
@@ -905,8 +916,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 				| NDCB0_ADDR_CYC(3)
 				| NDCB0_DBC
 				| cmd;
-		nand->ndcb1 = page_addr;
-		nand->ndcb2 = 0;
+		nand->ndcb1[0] = page_addr;

 		break;
 	case NAND_CMD_RESET:
-- 
1.7.0.4
