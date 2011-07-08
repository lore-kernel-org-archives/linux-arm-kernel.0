From: leiwen@marvell.com (Lei Wen)
Date: Fri, 08 Jul 2011 14:56:35 -0000
Subject: [PATCH 2/6] pxa3xx_nand: rework irq logic
In-Reply-To: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
References: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
Message-ID: <1298019428-7809-3-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all irq when we start the nand controller, and
put all the transaction logic in the pxa3xx_nand_irq.

By doing this way, we could dramatically increase the
performance by avoid unnecessary delay.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/nand/pxa3xx_nand.c |  400 +++++++++++++++++++---------------------
 1 files changed, 188 insertions(+), 212 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 6c0587b..dac522c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -27,6 +27,7 @@
 #include <plat/pxa3xx_nand.h>
 
 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
+#define NAND_STOP_DELAY		(2 * HZ/50)
 
 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
@@ -52,16 +53,18 @@
 #define NDCR_ND_MODE		(0x3 << 21)
 #define NDCR_NAND_MODE   	(0x0)
 #define NDCR_CLR_PG_CNT		(0x1 << 20)
-#define NDCR_CLR_ECC		(0x1 << 19)
+#define NDCR_STOP_ON_UNCOR	(0x1 << 19)
 #define NDCR_RD_ID_CNT_MASK	(0x7 << 16)
 #define NDCR_RD_ID_CNT(x)	(((x) << 16) & NDCR_RD_ID_CNT_MASK)
 
 #define NDCR_RA_START		(0x1 << 15)
 #define NDCR_PG_PER_BLK		(0x1 << 14)
 #define NDCR_ND_ARB_EN		(0x1 << 12)
+#define NDCR_INT_MASK           (0xFFF)
 
 #define NDSR_MASK		(0xfff)
-#define NDSR_RDY		(0x1 << 11)
+#define NDSR_RDY                (0x1 << 12)
+#define NDSR_FLASH_RDY          (0x1 << 11)
 #define NDSR_CS0_PAGED		(0x1 << 10)
 #define NDSR_CS1_PAGED		(0x1 << 9)
 #define NDSR_CS0_CMDD		(0x1 << 8)
@@ -104,13 +107,15 @@ enum {
 };
 
 enum {
-	STATE_READY	= 0,
+	STATE_IDLE = 0,
 	STATE_CMD_HANDLE,
 	STATE_DMA_READING,
 	STATE_DMA_WRITING,
 	STATE_DMA_DONE,
 	STATE_PIO_READING,
 	STATE_PIO_WRITING,
+	STATE_CMD_DONE,
+	STATE_READY,
 };
 
 struct pxa3xx_nand_info {
@@ -292,7 +297,48 @@ static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 	}
 }
 
-static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
+/**
+ * NOTE: it is a must to set ND_RUN firstly, then write
+ * command buffer, otherwise, it does not work.
+ * We enable all the interrupt@the same time, and
+ * let pxa3xx_nand_irq to handle all logic.
+ */
+static void pxa3xx_nand_start(struct pxa3xx_nand_info *info)
+{
+	uint32_t ndcr;
+
+	ndcr = info->reg_ndcr;
+	ndcr |= info->use_ecc ? NDCR_ECC_EN : 0;
+	ndcr |= info->use_dma ? NDCR_DMA_EN : 0;
+	ndcr |= NDCR_ND_RUN;
+
+	/* clear status bits and run */
+	nand_writel(info, NDCR, 0);
+	nand_writel(info, NDSR, NDSR_MASK);
+	nand_writel(info, NDCR, ndcr);
+}
+
+static void pxa3xx_nand_stop(struct pxa3xx_nand_info *info)
+{
+	uint32_t ndcr;
+	int timeout = NAND_STOP_DELAY;
+
+	/* wait RUN bit in NDCR become 0 */
+	ndcr = nand_readl(info, NDCR);
+	while ((ndcr & NDCR_ND_RUN) && (timeout -- > 0)) {
+		ndcr = nand_readl(info, NDCR);
+		udelay(1);
+	}
+
+	if (timeout <= 0) {
+		ndcr &= ~NDCR_ND_RUN;
+		nand_writel(info, NDCR, ndcr);
+	}
+	/* clear status bits */
+	nand_writel(info, NDSR, NDSR_MASK);
+}
+
+static void prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
 		uint16_t cmd, int column, int page_addr)
 {
 	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
@@ -319,21 +365,18 @@ static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
 
 	if (cmd == cmdset->program)
 		info->ndcb0 |= NDCB0_CMD_TYPE(1) | NDCB0_AUTO_RS;
-
-	return 0;
 }
 
-static int prepare_erase_cmd(struct pxa3xx_nand_info *info,
+static void prepare_erase_cmd(struct pxa3xx_nand_info *info,
 			uint16_t cmd, int page_addr)
 {
 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
 	info->ndcb0 |= NDCB0_CMD_TYPE(2) | NDCB0_AUTO_RS | NDCB0_ADDR_CYC(3);
 	info->ndcb1 = page_addr;
 	info->ndcb2 = 0;
-	return 0;
 }
 
-static int prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
+static void prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
 {
 	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
 
@@ -343,7 +386,7 @@ static int prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
 
 	info->oob_size = 0;
 	if (cmd == cmdset->read_id) {
-		info->ndcb0 |= NDCB0_CMD_TYPE(3);
+		info->ndcb0 |= NDCB0_CMD_TYPE(3) | NDCB0_ADDR_CYC(1);
 		info->data_size = 8;
 	} else if (cmd == cmdset->read_status) {
 		info->ndcb0 |= NDCB0_CMD_TYPE(4);
@@ -352,9 +395,7 @@ static int prepare_other_cmd(struct pxa3xx_nand_info *info, uint16_t cmd)
 		   cmd == cmdset->unlock) {
 		info->ndcb0 |= NDCB0_CMD_TYPE(5);
 	} else
-		return -EINVAL;
-
-	return 0;
+		BUG();
 }
 
 static void enable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
@@ -402,10 +443,8 @@ static int write_cmd(struct pxa3xx_nand_info *info)
 	return 0;
 }
 
-static int handle_data_pio(struct pxa3xx_nand_info *info)
+static void handle_data_pio(struct pxa3xx_nand_info *info)
 {
-	int ret, timeout = CHIP_DELAY_TIMEOUT;
-
 	switch (info->state) {
 	case STATE_PIO_WRITING:
 		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
@@ -413,14 +452,6 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 		if (info->oob_size > 0)
 			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
 					DIV_ROUND_UP(info->oob_size, 4));
-
-		enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
-
-		ret = wait_for_completion_timeout(&info->cmd_complete, timeout);
-		if (!ret) {
-			printk(KERN_ERR "program command time out\n");
-			return -1;
-		}
 		break;
 	case STATE_PIO_READING:
 		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
@@ -432,14 +463,11 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
 	default:
 		printk(KERN_ERR "%s: invalid state %d\n", __func__,
 				info->state);
-		return -EINVAL;
+		BUG();
 	}
-
-	info->state = STATE_READY;
-	return 0;
 }
 
-static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
+static void start_data_dma(struct pxa3xx_nand_info *info)
 {
 	struct pxa_dma_desc *desc = info->data_desc;
 	int dma_len = ALIGN(info->data_size + info->oob_size, 32);
@@ -447,14 +475,21 @@ static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
 	desc->ddadr = DDADR_STOP;
 	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
 
-	if (dir_out) {
+	switch (info->state) {
+	case STATE_DMA_WRITING:
 		desc->dsadr = info->data_buff_phys;
 		desc->dtadr = info->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG;
-	} else {
+		break;
+	case STATE_DMA_READING:
 		desc->dtadr = info->data_buff_phys;
 		desc->dsadr = info->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
+		break;
+	default:
+		printk(KERN_ERR "%s: invalid state %d\n", __func__,
+				info->state);
+		BUG();
 	}
 
 	DRCMR(info->drcmr_dat) = DRCMR_MAPVLD | info->data_dma_ch;
@@ -472,93 +507,60 @@ static void pxa3xx_nand_data_dma_irq(int channel, void *data)
 
 	if (dcsr & DCSR_BUSERR) {
 		info->retcode = ERR_DMABUSERR;
-		complete(&info->cmd_complete);
 	}
 
-	if (info->state == STATE_DMA_WRITING) {
-		info->state = STATE_DMA_DONE;
-		enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
-	} else {
-		info->state = STATE_READY;
-		complete(&info->cmd_complete);
-	}
+	info->state = STATE_DMA_DONE;
+	enable_int(info, NDCR_INT_MASK);
+	nand_writel(info, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
 }
 
 static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 {
 	struct pxa3xx_nand_info *info = devid;
-	unsigned int status;
+	unsigned int status, is_completed = 0;
 
 	status = nand_readl(info, NDSR);
 
-	if (status & (NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR)) {
-		if (status & NDSR_DBERR)
-			info->retcode = ERR_DBERR;
-		else if (status & NDSR_SBERR)
-			info->retcode = ERR_SBERR;
-
-		disable_int(info, NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR);
-
-		if (info->use_dma) {
-			info->state = STATE_DMA_READING;
-			start_data_dma(info, 0);
-		} else {
-			info->state = STATE_PIO_READING;
-			complete(&info->cmd_complete);
-		}
-	} else if (status & NDSR_WRDREQ) {
-		disable_int(info, NDSR_WRDREQ);
+	if (status & NDSR_DBERR)
+		info->retcode = ERR_DBERR;
+	if (status & NDSR_SBERR)
+		info->retcode = ERR_SBERR;
+	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {
+		/* whether use dma to transfer data */
 		if (info->use_dma) {
-			info->state = STATE_DMA_WRITING;
-			start_data_dma(info, 1);
+			disable_int(info, NDCR_INT_MASK);
+			info->state = (status & NDSR_RDDREQ) ?
+				      STATE_DMA_READING : STATE_DMA_WRITING;
+			start_data_dma(info);
+			goto NORMAL_IRQ_EXIT;
 		} else {
-			info->state = STATE_PIO_WRITING;
-			complete(&info->cmd_complete);
+			info->state = (status & NDSR_RDDREQ) ?
+				      STATE_PIO_READING : STATE_PIO_WRITING;
+			handle_data_pio(info);
 		}
-	} else if (status & (NDSR_CS0_BBD | NDSR_CS0_CMDD)) {
-		if (status & NDSR_CS0_BBD)
-			info->retcode = ERR_BBERR;
-
-		disable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
-		info->state = STATE_READY;
-		complete(&info->cmd_complete);
 	}
-	nand_writel(info, NDSR, status);
-	return IRQ_HANDLED;
-}
-
-static int pxa3xx_nand_do_cmd(struct pxa3xx_nand_info *info, uint32_t event)
-{
-	uint32_t ndcr;
-	int ret, timeout = CHIP_DELAY_TIMEOUT;
-
-	if (write_cmd(info)) {
-		info->retcode = ERR_SENDCMD;
-		goto fail_stop;
+	if (status & NDSR_CS0_CMDD) {
+		info->state = STATE_CMD_DONE;
+		is_completed = 1;
 	}
+	if (status & NDSR_FLASH_RDY)
+		info->state = STATE_READY;
 
-	info->state = STATE_CMD_HANDLE;
-
-	enable_int(info, event);
-
-	ret = wait_for_completion_timeout(&info->cmd_complete, timeout);
-	if (!ret) {
-		printk(KERN_ERR "command execution timed out\n");
-		info->retcode = ERR_SENDCMD;
-		goto fail_stop;
+	if (status & NDSR_WRCMDREQ) {
+		nand_writel(info, NDSR, NDSR_WRCMDREQ);
+		status &= ~NDSR_WRCMDREQ;
+		info->state = STATE_CMD_HANDLE;
+		nand_writel(info, NDCB0, info->ndcb0);
+		nand_writel(info, NDCB0, info->ndcb1);
+		nand_writel(info, NDCB0, info->ndcb2);
 	}
 
-	if (info->use_dma == 0 && info->data_size > 0)
-		if (handle_data_pio(info))
-			goto fail_stop;
-
-	return 0;
-
-fail_stop:
-	ndcr = nand_readl(info, NDCR);
-	nand_writel(info, NDCR, ndcr & ~NDCR_ND_RUN);
-	udelay(10);
-	return -ETIMEDOUT;
+	/* clear NDSR to let the controller exit the IRQ */
+	nand_writel(info, NDSR, status);
+	if (is_completed)
+		complete(&info->cmd_complete);
+NORMAL_IRQ_EXIT:
+	return IRQ_HANDLED;
 }
 
 static int pxa3xx_nand_dev_ready(struct mtd_info *mtd)
@@ -580,14 +582,13 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
 	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
-	int ret;
+	int ret, exec_cmd = 0;
 
 	info->use_dma = (use_dma) ? 1 : 0;
 	info->use_ecc = 0;
 	info->data_size = 0;
-	info->state = STATE_READY;
-
-	init_completion(&info->cmd_complete);
+	info->state = 0;
+	info->retcode = ERR_NONE;
 
 	switch (command) {
 	case NAND_CMD_READOOB:
@@ -596,36 +597,18 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		info->buf_start = mtd->writesize + column;
 		memset(info->data_buff, 0xFF, info->buf_count);
 
-		if (prepare_read_prog_cmd(info, cmdset->read1, column, page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR);
-
-		/* We only are OOB, so if the data has error, does not matter */
-		if (info->retcode == ERR_DBERR)
-			info->retcode = ERR_NONE;
+		prepare_read_prog_cmd(info, cmdset->read1, column, page_addr);
+		exec_cmd = 1;
 		break;
 
 	case NAND_CMD_READ0:
 		info->use_ecc = 1;
-		info->retcode = ERR_NONE;
 		info->buf_start = column;
 		info->buf_count = mtd->writesize + mtd->oobsize;
 		memset(info->data_buff, 0xFF, info->buf_count);
 
-		if (prepare_read_prog_cmd(info, cmdset->read1, column, page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR);
-
-		if (info->retcode == ERR_DBERR) {
-			/* for blank page (all 0xff), HW will calculate its ECC as
-			 * 0, which is different from the ECC information within
-			 * OOB, ignore such double bit errors
-			 */
-			if (is_buf_blank(info->data_buff, mtd->writesize))
-				info->retcode = ERR_NONE;
-		}
+		prepare_read_prog_cmd(info, cmdset->read1, column, page_addr);
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_SEQIN:
 		info->buf_start = column;
@@ -639,17 +622,13 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	case NAND_CMD_PAGEPROG:
 		info->use_ecc = (info->seqin_column >= mtd->writesize) ? 0 : 1;
 
-		if (prepare_read_prog_cmd(info, cmdset->program,
-				info->seqin_column, info->seqin_page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_WRDREQ);
+		prepare_read_prog_cmd(info, cmdset->program,
+				info->seqin_column, info->seqin_page_addr);
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_ERASE1:
-		if (prepare_erase_cmd(info, cmdset->erase, page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
+		prepare_erase_cmd(info, cmdset->erase, page_addr);
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_ERASE2:
 		break;
@@ -660,42 +639,72 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		info->buf_count = (command == NAND_CMD_READID) ?
 				info->read_id_bytes : 1;
 
-		if (prepare_other_cmd(info, (command == NAND_CMD_READID) ?
-				cmdset->read_id : cmdset->read_status))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_RDDREQ);
+		prepare_other_cmd(info, (command == NAND_CMD_READID) ?
+				cmdset->read_id : cmdset->read_status);
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_RESET:
-		if (prepare_other_cmd(info, cmdset->reset))
-			break;
-
-		ret = pxa3xx_nand_do_cmd(info, NDSR_CS0_CMDD);
-		if (ret == 0) {
-			int timeout = 2;
-			uint32_t ndcr;
-
-			while (timeout--) {
-				if (nand_readl(info, NDSR) & NDSR_RDY)
-					break;
-				msleep(10);
-			}
-
-			ndcr = nand_readl(info, NDCR);
-			nand_writel(info, NDCR, ndcr & ~NDCR_ND_RUN);
-		}
+		prepare_other_cmd(info, cmdset->reset);
+		exec_cmd = 1;
 		break;
 	default:
 		printk(KERN_ERR "non-supported command.\n");
 		break;
 	}
 
-	if (info->retcode == ERR_DBERR) {
-		printk(KERN_ERR "double bit error @ page %08x\n", page_addr);
-		info->retcode = ERR_NONE;
+	if (exec_cmd) {
+		init_completion(&info->cmd_complete);
+		pxa3xx_nand_start(info);
+
+		ret = wait_for_completion_timeout(&info->cmd_complete,
+				CHIP_DELAY_TIMEOUT);
+		if (!ret) {
+			printk(KERN_ERR "Wait time out!!!\n");
+			/* Stop State Machine for next command cycle */
+			pxa3xx_nand_stop(info);
+		}
+		info->state = STATE_IDLE;
 	}
 }
 
+static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
+		struct nand_chip *chip, const uint8_t *buf)
+{
+	chip->write_buf(mtd, buf, mtd->writesize);
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+}
+
+static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
+		struct nand_chip *chip, uint8_t *buf, int page)
+{
+	struct pxa3xx_nand_info *info = mtd->priv;
+
+	chip->read_buf(mtd, buf, mtd->writesize);
+	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	if (info->retcode == ERR_SBERR) {
+		switch (info->use_ecc) {
+		case 1:
+			mtd->ecc_stats.corrected ++;
+			break;
+		case 0:
+		default:
+			break;
+		}
+	}
+	else if (info->retcode == ERR_DBERR) {
+		/*
+		 * for blank page (all 0xff), HW will calculate its ECC as
+		 * 0, which is different from the ECC information within
+		 * OOB, ignore such double bit errors
+		 */
+		if (is_buf_blank(buf, mtd->writesize))
+			mtd->ecc_stats.failed++;
+	}
+
+	return 0;
+}
+
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
@@ -770,47 +779,13 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 	return 0;
 }
 
-static void pxa3xx_nand_ecc_hwctl(struct mtd_info *mtd, int mode)
-{
-	return;
-}
-
-static int pxa3xx_nand_ecc_calculate(struct mtd_info *mtd,
-		const uint8_t *dat, uint8_t *ecc_code)
-{
-	return 0;
-}
-
-static int pxa3xx_nand_ecc_correct(struct mtd_info *mtd,
-		uint8_t *dat, uint8_t *read_ecc, uint8_t *calc_ecc)
-{
-	struct pxa3xx_nand_info *info = mtd->priv;
-	/*
-	 * Any error include ERR_SEND_CMD, ERR_DBERR, ERR_BUSERR, we
-	 * consider it as a ecc error which will tell the caller the
-	 * read fail We have distinguish all the errors, but the
-	 * nand_read_ecc only check this function return value
-	 *
-	 * Corrected (single-bit) errors must also be noted.
-	 */
-	if (info->retcode == ERR_SBERR)
-		return 1;
-	else if (info->retcode != ERR_NONE)
-		return -1;
-
-	return 0;
-}
-
 static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
 {
 	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
 	uint32_t ndcr;
 	uint8_t  id_buff[8];
 
-	if (prepare_other_cmd(info, cmdset->read_id)) {
-		printk(KERN_ERR "failed to prepare command\n");
-		return -EINVAL;
-	}
+	prepare_other_cmd(info, cmdset->read_id);
 
 	/* Send command */
 	if (write_cmd(info))
@@ -836,7 +811,7 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
-	uint32_t ndcr = 0x00000FFF; /* disable all interrupts */
+	uint32_t ndcr = 0x0; /* enable all interrupts */
 
 	if (f->page_size != 2048 && f->page_size != 512)
 		return -EINVAL;
@@ -888,11 +863,12 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 	info->reg_ndcr = ndcr;
 	info->cmdset = &default_cmdset;
 
-	if (__readid(info, &id))
+	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
+	id = *((uint16_t *)(info->data_buff));
+	if (id == 0)
 		return -ENODEV;
 
 	/* Lookup the flash id */
-	id = (id >> 8) & 0xff;		/* device id is byte 2 */
 	for (i = 0; nand_flash_ids[i].name != NULL; i++) {
 		if (id == nand_flash_ids[i].id) {
 			type =  &nand_flash_ids[i];
@@ -935,8 +911,8 @@ static int pxa3xx_nand_detect_flash(struct pxa3xx_nand_info *info,
 	/* we use default timing to detect id */
 	f = DEFAULT_FLASH_TYPE;
 	pxa3xx_nand_config_flash(info, f);
-	if (__readid(info, &id))
-		goto fail_detect;
+	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
+	id = *((uint16_t *)(info->data_buff));
 
 	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
 		/* we first choose the flash definition from platfrom */
@@ -954,7 +930,6 @@ static int pxa3xx_nand_detect_flash(struct pxa3xx_nand_info *info,
 	dev_warn(&info->pdev->dev,
 		 "failed to detect configured nand flash; found %04x instead of\n",
 		 id);
-fail_detect:
 	return -ENODEV;
 }
 
@@ -1025,6 +1000,8 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->select_chip	= pxa3xx_nand_select_chip;
 	this->dev_ready		= pxa3xx_nand_dev_ready;
 	this->cmdfunc		= pxa3xx_nand_cmdfunc;
+	this->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
+	this->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
 	this->read_word		= pxa3xx_nand_read_word;
 	this->read_byte		= pxa3xx_nand_read_byte;
 	this->read_buf		= pxa3xx_nand_read_buf;
@@ -1032,9 +1009,6 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
 	this->verify_buf	= pxa3xx_nand_verify_buf;
 
 	this->ecc.mode		= NAND_ECC_HW;
-	this->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
-	this->ecc.calculate	= pxa3xx_nand_ecc_calculate;
-	this->ecc.correct	= pxa3xx_nand_ecc_correct;
 	this->ecc.size		= info->page_size;
 
 	if (info->page_size == 2048)
@@ -1176,10 +1150,6 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	del_mtd_device(mtd);
-#ifdef CONFIG_MTD_PARTITIONS
-	del_mtd_partitions(mtd);
-#endif
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0)
 		free_irq(irq, info);
@@ -1197,7 +1167,13 @@ static int pxa3xx_nand_remove(struct platform_device *pdev)
 	clk_disable(info->clk);
 	clk_put(info->clk);
 
-	kfree(mtd);
+	if (mtd) {
+		del_mtd_device(mtd);
+#ifdef CONFIG_MTD_PARTITIONS
+		del_mtd_partitions(mtd);
+#endif
+		kfree(mtd);
+	}
 	return 0;
 }
 
@@ -1231,10 +1207,10 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 		nr_parts = parse_mtd_partitions(info->mtd, probes, &parts, 0);
 
 		if (nr_parts)
-			return add_mtd_partitions(mtd, parts, nr_parts);
+			return add_mtd_partitions(info->mtd, parts, nr_parts);
 	}
 
-	return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
+	return add_mtd_partitions(info->mtd, pdata->parts, pdata->nr_parts);
 #else
 	return 0;
 #endif
@@ -1246,7 +1222,7 @@ static int pxa3xx_nand_suspend(struct platform_device *pdev, pm_message_t state)
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = info->mtd;
 
-	if (info->state != STATE_READY) {
+	if (info->state) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
 		return -EAGAIN;
 	}
-- 
1.7.0.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
