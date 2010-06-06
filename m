From: leiwen@marvell.com (Lei Wen)
Date: Sun, 6 Jun 2010 17:25:02 +0800
Subject: [PATCH 17/25] pxa3xx_nand: use the buff passed from upper
Message-ID: <mailman.34.1276839531.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

layer directly if not use dma

For dma enabling case, we couldn't avoid the memcpy, for the buffer
in the upper layer may not be the physical consecutive.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  300 ++++++++++++++++++++++++----------------
 1 files changed, 182 insertions(+), 118 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index bdcc881..67acea4 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -201,6 +201,7 @@ struct pxa3xx_nand_flash {
 struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;
 	/* page size of attached chip */
+	int			page_addr;
 	uint16_t		page_size;
 	uint8_t			chip_select;
 	uint8_t			use_ecc;
@@ -229,8 +230,8 @@ struct pxa3xx_nand {
 	int			drcmr_dat;
 	int			drcmr_cmd;
 	int 			data_dma_ch;
-	dma_addr_t 		data_buff_phys;
-	dma_addr_t 		data_desc_addr;
+	dma_addr_t 		dma_buff_phys;
+	dma_addr_t 		dma_desc_addr;
 	struct pxa_dma_desc	*data_desc;

 	struct pxa3xx_nand_info *info[NUM_CHIP_SELECT];
@@ -534,25 +535,25 @@ static void start_data_dma(struct pxa3xx_nand
*nand, int dir_out)
 	desc_oob->ddadr = desc->ddadr = DDADR_STOP;
 	desc_oob->dcmd = desc->dcmd = DCMD_WIDTH4 | DCMD_BURST32;
 	if (dir_out) {
-		desc->dsadr = nand->data_buff_phys + nand->data_column;
+		desc->dsadr = nand->dma_buff_phys + nand->data_column;
 		desc->dtadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_ENDIRQEN | DCMD_INCSRCADDR | DCMD_FLOWTRG |
(data_len + oob_len);
 	} else {
 		if (nand->oob_size > 0) {
-			desc_oob->dtadr = nand->data_buff_phys
+			desc_oob->dtadr = nand->dma_buff_phys
 					+ info->page_size + nand->oob_column;
 			desc_oob->dcmd |= DCMD_ENDIRQEN | DCMD_INCTRGADDR | DCMD_FLOWSRC | oob_len;
-			desc->ddadr = nand->data_desc_addr + sizeof(struct pxa_dma_desc);
+			desc->ddadr = nand->dma_desc_addr + sizeof(struct pxa_dma_desc);
 			desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC | data_len;
 		}
 		else
 			desc->dcmd |= DCMD_ENDIRQEN | DCMD_INCTRGADDR | DCMD_FLOWSRC | data_len;
-		desc->dtadr = nand->data_buff_phys + nand->data_column;
+		desc->dtadr = nand->dma_buff_phys + nand->data_column;
 		desc_oob->dsadr = desc->dsadr = nand->mmio_phys + NDDB;
 	}

 	DRCMR(nand->drcmr_dat) = DRCMR_MAPVLD | nand->data_dma_ch;
-	DDADR(nand->data_dma_ch) = nand->data_desc_addr;
+	DDADR(nand->data_dma_ch) = nand->dma_desc_addr;
 	DCSR(nand->data_dma_ch) |= DCSR_RUN;
 }

@@ -676,6 +677,8 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 	int addr_cycle, exec_cmd, ndcb0, i, chunks = 0;
 	struct mtd_info *mtd;
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
+	struct platform_device *pdev = nand->pdev;
+	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;

 	mtd = get_mtd_by_info(info);
 	ndcb0 = (nand->chip_select) ? NDCB0_CSEL : 0;;
@@ -685,37 +688,33 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 	/* reset data and oob column point to handle data */
 	nand->data_column	= 0;
 	nand->oob_column	= 0;
-	nand->buf_start		= 0;
-	nand->buf_count		= 0;
 	nand->total_cmds	= 1;
 	nand->cmd_seqs		= 0;
 	nand->data_size		= 0;
 	nand->oob_size		= 0;
-	nand->use_ecc		= 0;
 	nand->use_dma		= 0;
 	nand->state		= 0;
 	nand->bad_count		= 0;
 	nand->retcode		= ERR_NONE;
-	nand->command		= command;
+	nand->buf_start		= column;

 	switch (command) {
-	case NAND_CMD_READ0:
 	case NAND_CMD_PAGEPROG:
-		nand->use_ecc = info->use_ecc;
-	case NAND_CMD_READOOB:
+	case NAND_CMD_RNDOUT:
 		pxa3xx_set_datasize(info);
-		nand->oob_buff = nand->data_buff + nand->data_size;
 		nand->use_dma = use_dma;
 		chunks = info->page_size / nand->data_size;
 		break;
-	case NAND_CMD_SEQIN:
-		exec_cmd = 0;
-		break;
 	default:
 		nand->ndcb1 = 0;
 		nand->ndcb2 = 0;
+		nand->use_ecc = 0;
 		break;
 	}
+	if (nand->use_dma) {
+		nand->data_buff = nand->dma_buff;
+		nand->oob_buff = nand->dma_buff + mtd->writesize;
+	}

 	/* clear the command buffer */
 	for (i = 0; i < CMD_POOL_SIZE; i ++) {
@@ -726,68 +725,67 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,
 			+ info->col_addr_cycles);

 	switch (command) {
-	case NAND_CMD_READOOB:
 	case NAND_CMD_READ0:
-
-		cmd  = cmdset.read1;
-		if (command == NAND_CMD_READOOB)
-			nand->buf_start = mtd->writesize + column;
-		else
-			nand->buf_start = column;
-
-		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
-			nand->ndcb0[0] |= NDCB0_CMD_TYPE(0)
-					| addr_cycle
-					| (cmd & NDCB0_CMD1_MASK);
-		else {
-			if (chunks == 1)
-				nand->ndcb0[0] |= NDCB0_CMD_TYPE(0)
-						| NDCB0_DBC
-						| addr_cycle
-						| cmd;
-			else {
-				nand->total_cmds = chunks + 1;
-				nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x6)
-						| NDCB0_CMD_TYPE(0)
-						| NDCB0_DBC
-						| NDCB0_NC
-						| addr_cycle
-						| cmd;
-
-				nand->ndcb0[1] |= NDCB0_CMD_XTYPE(0x5)
-						| NDCB0_NC
-						| addr_cycle;
-
-				for (i = 2; i <= chunks; i ++)
-					nand->ndcb0[i] = nand->ndcb0[1];
-
-				nand->ndcb0[chunks] &= ~NDCB0_NC;
-				/* we should wait RnB go high again
-				 * before read out data*/
-				nand->wait_ready[1] = 1;
-			}
-		}
-
 	case NAND_CMD_SEQIN:
+		nand->use_ecc = info->use_ecc;
+	case NAND_CMD_READOOB:
+		memset(nand->data_buff, 0xff, column);
+		nand->buf_count = mtd->writesize + mtd->oobsize;
+		exec_cmd = 0;
+		info->page_addr = page_addr;
 		/* small page addr setting */
-		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
+		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
 			nand->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);
-
-			nand->ndcb2 = 0;
-		}
 		else {
 			nand->ndcb1 = ((page_addr & 0xFFFF) << 16)
 					| (column & 0xFFFF);

 			if (page_addr & 0xFF0000)
 				nand->ndcb2 = (page_addr & 0xFF0000) >> 16;
+		}
+		break;
+
+	case NAND_CMD_RNDOUT:
+		cmd = cmdset.read1;
+		if (nand->command == NAND_CMD_READOOB) {
+			nand->buf_start = mtd->writesize + column;
+			nand->buf_count = mtd->oobsize;
+		}
+
+		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)
+			|| !(pdata->controller_attrs & PXA3XX_NAKED_CMD_EN)) {
+			if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
+				nand->ndcb0[0] |= NDCB0_CMD_TYPE(0)
+						| addr_cycle
+						| (cmd & NDCB0_CMD1_MASK);
 			else
-				nand->ndcb2 = 0;
+				nand->ndcb0[0] |= NDCB0_CMD_TYPE(0)
+						| NDCB0_DBC
+						| addr_cycle
+						| cmd;
+			break;
 		}

-		nand->buf_count = mtd->writesize + mtd->oobsize;
-		memset(nand->data_buff, 0xFF, nand->buf_count);
+		nand->total_cmds = chunks + 1;
+		nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x6)
+				| NDCB0_CMD_TYPE(0)
+				| NDCB0_DBC
+				| NDCB0_NC
+				| addr_cycle
+				| cmd;
+
+		nand->ndcb0[1] |= NDCB0_CMD_XTYPE(0x5)
+				| NDCB0_NC
+				| addr_cycle;
+
+		for (i = 2; i <= chunks; i ++)
+			nand->ndcb0[i] = nand->ndcb0[1];
+
+		nand->ndcb0[chunks] &= ~NDCB0_NC;
+		/* we should wait RnB go high again
+		 * before read out data*/
+		nand->wait_ready[1] = 1;

 		break;

@@ -799,40 +797,42 @@ static int prepare_command_pool(struct
pxa3xx_nand *nand, int command,

 		cmd = cmdset.program;
 		nand->state |= STATE_IS_WRITE;
-		if (chunks == 1)
+		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)
+			|| !(pdata->controller_attrs & PXA3XX_NAKED_CMD_EN)) {
 			nand->ndcb0[0] |= NDCB0_CMD_TYPE(0x1)
 					| NDCB0_AUTO_RS
 					| NDCB0_ST_ROW_EN
 					| NDCB0_DBC
 					| cmd
 					| addr_cycle;
-		else {
-			nand->total_cmds = chunks + 1;
-			nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x4)
-					| NDCB0_CMD_TYPE(0x1)
+			break;
+		}
+
+		nand->total_cmds = chunks + 1;
+		nand->ndcb0[0] |= NDCB0_CMD_XTYPE(0x4)
+				| NDCB0_CMD_TYPE(0x1)
+				| NDCB0_NC
+				| NDCB0_AUTO_RS
+				| (cmd & NDCB0_CMD1_MASK)
+				| addr_cycle;
+
+		for (i = 1; i < chunks; i ++)
+			nand->ndcb0[i] |= NDCB0_CMD_XTYPE(0x5)
 					| NDCB0_NC
 					| NDCB0_AUTO_RS
-					| (cmd & NDCB0_CMD1_MASK)
+					| NDCB0_CMD_TYPE(0x1)
 					| addr_cycle;

-			for (i = 1; i < chunks; i ++)
-				nand->ndcb0[i] |= NDCB0_CMD_XTYPE(0x5)
-						| NDCB0_NC
-						| NDCB0_AUTO_RS
-						| NDCB0_CMD_TYPE(0x1)
-						| addr_cycle;
-
-			nand->ndcb0[chunks] |= NDCB0_CMD_XTYPE(0x3)
-						| NDCB0_CMD_TYPE(0x1)
-						| NDCB0_ST_ROW_EN
-						| NDCB0_DBC
-						| (cmd & NDCB0_CMD2_MASK)
-						| NDCB0_CMD1_MASK
-						| addr_cycle;
-			/* we should wait for RnB goes high which
-			 * indicate the data has been written succesfully*/
-			nand->wait_ready[nand->total_cmds] = 1;
-		}
+		nand->ndcb0[chunks] |= NDCB0_CMD_XTYPE(0x3)
+				| NDCB0_CMD_TYPE(0x1)
+				| NDCB0_ST_ROW_EN
+				| NDCB0_DBC
+				| (cmd & NDCB0_CMD2_MASK)
+				| NDCB0_CMD1_MASK
+				| addr_cycle;
+		/* we should wait for RnB goes high which
+		 * indicate the data has been written succesfully*/
+		nand->wait_ready[nand->total_cmds] = 1;
 		break;

 	case NAND_CMD_READID:
@@ -847,6 +847,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,

 	case NAND_CMD_STATUS:
 		cmd = cmdset.read_status;
+		nand->data_buff = nand->dma_buff;
 		nand->buf_count = 1;
 		nand->ndcb0[0] |= NDCB0_CMD_TYPE(4)
 				| NDCB0_ADDR_CYC(1)
@@ -883,6 +884,7 @@ static int prepare_command_pool(struct pxa3xx_nand
*nand, int command,
 		break;
 	}

+	nand->command = command;
 	return exec_cmd;
 }

@@ -1106,44 +1108,104 @@ static void free_cs_resource(struct
pxa3xx_nand_info *info, int cs)
 	nand->info[cs] = NULL;
 }

-static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
-		struct nand_chip *chip, uint8_t *buf, int page)
+static void pxa3xx_read_page(struct mtd_info *mtd, uint8_t *buf)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct nand_chip *chip = mtd->priv;
 	struct pxa3xx_nand *nand = info->nand_data;
+	int buf_blank;

-	chip->read_buf(mtd, buf, mtd->writesize);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	if (nand->retcode == ERR_SBERR) {
+	nand->data_buff = buf;
+	nand->oob_buff = chip->oob_poi;
+	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RNDOUT, 0, info->page_addr);
+	switch (nand->retcode) {
+	case ERR_SBERR:
 		switch (nand->use_ecc) {
 		case ECC_BCH:
 			if (nand->bad_count > BCH_THRESHOLD)
 				mtd->ecc_stats.corrected +=
 					(nand->bad_count - BCH_THRESHOLD);
 			break;
+
 		case ECC_HAMMIN:
 			mtd->ecc_stats.corrected ++;
+			break;
+
 		case ECC_NONE:
 		default:
 			break;
 		}
-	} else if (nand->retcode == ERR_DBERR) {
-		int buf_blank;
-
-		buf_blank = is_buf_blank(buf, mtd->writesize);
+		break;
+	case ERR_DBERR:
+		buf_blank = is_buf_blank(nand->data_buff, mtd->writesize);
 		if (!buf_blank)
 			mtd->ecc_stats.failed++;
+		break;
+	case ERR_NONE:
+		break;
+	default:
+		mtd->ecc_stats.failed++;
+		break;
 	}
+}

+static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
+		struct nand_chip *chip, uint8_t *buf, int page)
+{
+	pxa3xx_read_page(mtd, buf);
+	if (use_dma) {
+		chip->read_buf(mtd, buf, mtd->writesize);
+		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	}
+	return 0;
+}
+
+static int pxa3xx_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+		int page, int sndcmd)
+{
+	if (sndcmd) {
+		pxa3xx_nand_cmdfunc(mtd, NAND_CMD_READOOB, 0, page);
+		pxa3xx_read_page(mtd, chip->oob_poi);
+	}
+	if (use_dma)
+		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	return 0;
 }

 static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, const uint8_t *buf)
 {
-	chip->write_buf(mtd, buf, mtd->writesize);
-	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
+	if (use_dma) {
+		chip->write_buf(mtd, buf, mtd->writesize);
+		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	}
+	else {
+		nand->data_buff = (uint8_t *)buf;
+		nand->oob_buff = chip->oob_poi;
+	}
+}
+
+static int pxa3xx_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			      int page)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
+	int status = 0;
+
+	nand->data_buff = nand->dma_buff;
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, page);
+	if (use_dma)
+		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+	else
+		nand->oob_buff = chip->oob_poi;
+	/* Send command to program the OOB data */
+	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+
+	status = chip->waitfunc(mtd, chip);
+
+	return status & NAND_STATUS_FAIL ? -EIO : 0;
 }

 static void pxa3xx_nand_erase_cmd(struct mtd_info *mtd, int page)
@@ -1191,8 +1253,8 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 		return -EINVAL;
 	}

+	nand->data_buff = (unsigned char *)&id;
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(nand->data_buff));
 	if (id != 0)
 		dev_info(&nand->pdev->dev, "Detect a flash id %x\n", id);
 	else {
@@ -1349,7 +1411,11 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		chip = (struct nand_chip *)(&mtd[1]);
 		chip->controller        = &nand->controller;
 		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
+		chip->ecc.read_page_raw = pxa3xx_nand_read_page_hwecc;
+		chip->ecc.read_oob      = pxa3xx_nand_read_oob;
 		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
+		chip->ecc.write_page_raw= pxa3xx_nand_write_page_hwecc;
+		chip->ecc.write_oob     = pxa3xx_nand_write_oob;
 		chip->waitfunc		= pxa3xx_nand_waitfunc;
 		chip->select_chip	= pxa3xx_nand_select_chip;
 		chip->cmdfunc		= pxa3xx_nand_cmdfunc;
@@ -1361,25 +1427,16 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		chip->erase_cmd		= pxa3xx_nand_erase_cmd;
 	}

-	if (use_dma == 0) {
-		nand->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
-		if (nand->data_buff == NULL) {
-			ret = -ENOMEM;
-			goto fail_free_buf;
-		}
-		goto success_exit;
-	}
-
-	nand->data_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
-			&nand->data_buff_phys, GFP_KERNEL);
-	if (nand->data_buff == NULL) {
+	nand->dma_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
+			&nand->dma_buff_phys, GFP_KERNEL);
+	if (nand->dma_buff == NULL) {
 		dev_err(&pdev->dev, "failed to allocate dma buffer\n");
 		ret = -ENOMEM;
 		goto fail_free_buf;
 	}

-	nand->data_desc = (void *)nand->data_buff + data_desc_offset;
-	nand->data_desc_addr = nand->data_buff_phys + data_desc_offset;
+	nand->data_desc = (void *)nand->dma_buff + data_desc_offset;
+	nand->dma_desc_addr = nand->dma_buff_phys + data_desc_offset;
 	nand->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
 			pxa3xx_nand_data_dma_irq, nand);
 	if (nand->data_dma_ch < 0) {
@@ -1387,7 +1444,6 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		ret = -ENXIO;
 		goto fail_free_buf;
 	}
-success_exit:
 	return 0;

 fail_free_buf:
@@ -1437,6 +1493,14 @@ static int pxa3xx_nand_remove(struct
platform_device *pdev)
 		del_mtd_device(mtd);
 		free_cs_resource(info, cs);
 	}
+	if (nand->dma_buff_phys) {
+		if (nand->data_dma_ch >= 0)
+			pxa_free_dma(nand->data_dma_ch);
+		if (nand->dma_buff)
+			dma_free_coherent(&nand->pdev->dev, MAX_BUFF_SIZE,
+					nand->dma_buff, nand->dma_buff_phys);
+		nand->dma_buff_phys = 0;
+	}
 	return 0;
 }

-- 
1.7.0.4
