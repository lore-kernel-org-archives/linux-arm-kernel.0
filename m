From: leiwen@marvell.com (Lei Wen)
Date: Mon, 31 May 2010 14:05:46 +0800
Subject: [PATCH 05/25] pxa3xx_nand: rework irq logic
Message-ID: <mailman.14.1276839377.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all irq when we start the nand controller, and
put all the transaction logic in the pxa3xx_nand_irq.

By doing this way, we could dramatically increase the
performance by avoid unnecessary delay.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  382 +++++++++++++++-------------------------
 1 files changed, 140 insertions(+), 242 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 1f52701..753346f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -27,6 +27,7 @@
 #include <plat/pxa3xx_nand.h>

 #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
+#define NAND_STOP_DELAY		(2 * HZ/50)

 /* registers and bit definitions */
 #define NDCR		(0x00) /* Control register */
@@ -49,6 +50,7 @@
 #define NDCR_DWIDTH_M		(0x1 << 26)
 #define NDCR_PAGE_SZ		(0x1 << 24)
 #define NDCR_NCSX		(0x1 << 23)
+#define NDCR_STOP_ON_UNCOR	(0x1 << 22)
 #define NDCR_ND_MODE		(0x3 << 21)
 #define NDCR_NAND_MODE   	(0x0)
 #define NDCR_CLR_PG_CNT		(0x1 << 20)
@@ -59,9 +61,11 @@
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
@@ -104,13 +108,14 @@ enum {
 };

 enum {
-	STATE_READY	= 0,
-	STATE_CMD_HANDLE,
-	STATE_DMA_READING,
-	STATE_DMA_WRITING,
-	STATE_DMA_DONE,
-	STATE_PIO_READING,
-	STATE_PIO_WRITING,
+	STATE_CMD_WAIT_DONE	= 1,
+	STATE_DATA_PROCESSING	= (1 << 1),
+	STATE_DATA_DONE		= (1 << 2),
+	STATE_PAGE_DONE		= (1 << 3),
+	STATE_CMD_DONE		= (1 << 4),
+	STATE_READY		= (1 << 5),
+	STATE_CMD_PREPARED	= (1 << 6),
+	STATE_IS_WRITE		= (1 << 7),
 };

 struct pxa3xx_nand_timing {
@@ -305,25 +310,6 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,
 	nand_writel(info, NDTR1CS0, ndtr1);
 }

-#define WAIT_EVENT_TIMEOUT	10
-
-static int wait_for_event(struct pxa3xx_nand_info *info, uint32_t event)
-{
-	int timeout = WAIT_EVENT_TIMEOUT;
-	uint32_t ndsr;
-
-	while (timeout--) {
-		ndsr = nand_readl(info, NDSR) & NDSR_MASK;
-		if (ndsr & event) {
-			nand_writel(info, NDSR, ndsr);
-			return 0;
-		}
-		udelay(10);
-	}
-
-	return -ETIMEDOUT;
-}
-
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
@@ -343,7 +329,47 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
 	}
 }

-static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
+/**
+ * NOTE: it is a must to set ND_RUN firstly, then write
+ * command buffer, otherwise, it does not work.
+ * We enable all the interrupt at the same time, and
+ * let pxa3xx_nand_irq to handle all logic.
+ */
+static void pxa3xx_nand_start(struct pxa3xx_nand_info *info)
+{
+	uint32_t ndcr;
+
+	ndcr = info->reg_ndcr;
+	ndcr |= NDCR_ECC_EN;
+	ndcr |= info->use_dma ? NDCR_DMA_EN : NDCR_STOP_ON_UNCOR;
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
+	do {
+		/* clear status bits */
+		nand_writel(info, NDSR, NDSR_MASK);
+		ndcr = nand_readl(info, NDCR);
+		udelay(1);
+	} while ((ndcr & NDCR_ND_RUN) && (timeout -- > 0));
+
+	if (timeout <= 0) {
+		ndcr &= ~(NDCR_ND_RUN);
+		nand_writel(info, NDCR, ndcr);
+	}
+}
+
+static void prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
 		uint16_t cmd, int column, int page_addr)
 {
 	pxa3xx_set_datasize(info);
@@ -369,21 +395,18 @@ static int prepare_read_prog_cmd(struct
pxa3xx_nand_info *info,

 	if (cmd == cmdset.program)
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
 	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
 	info->ndcb1 = 0;
@@ -398,10 +421,7 @@ static int prepare_other_cmd(struct
pxa3xx_nand_info *info, uint16_t cmd)
 	} else if (cmd == cmdset.reset || cmd == cmdset.lock ||
 		   cmd == cmdset.unlock) {
 		info->ndcb0 |= NDCB0_CMD_TYPE(5);
-	} else
-		return -EINVAL;
-
-	return 0;
+	}
 }

 static void enable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
@@ -420,71 +440,23 @@ static void disable_int(struct pxa3xx_nand_info
*info, uint32_t int_mask)
 	nand_writel(info, NDCR, ndcr | int_mask);
 }

-/* NOTE: it is a must to set ND_RUN firstly, then write command buffer
- * otherwise, it does not work
- */
-static int write_cmd(struct pxa3xx_nand_info *info)
-{
-	uint32_t ndcr;
-
-	/* clear status bits and run */
-	nand_writel(info, NDSR, NDSR_MASK);
-
-	ndcr = info->reg_ndcr;
-
-	ndcr |= info->use_ecc ? NDCR_ECC_EN : 0;
-	ndcr |= info->use_dma ? NDCR_DMA_EN : 0;
-	ndcr |= NDCR_ND_RUN;
-
-	nand_writel(info, NDCR, ndcr);
-
-	if (wait_for_event(info, NDSR_WRCMDREQ)) {
-		printk(KERN_ERR "timed out writing command\n");
-		return -ETIMEDOUT;
-	}
-
-	nand_writel(info, NDCB0, info->ndcb0);
-	nand_writel(info, NDCB0, info->ndcb1);
-	nand_writel(info, NDCB0, info->ndcb2);
-	return 0;
-}
-
-static int handle_data_pio(struct pxa3xx_nand_info *info)
+static void handle_data_pio(struct pxa3xx_nand_info *info)
 {
-	int ret, timeout = CHIP_DELAY_TIMEOUT;
-
-	switch (info->state) {
-	case STATE_PIO_WRITING:
+	if (info->state & STATE_IS_WRITE) {
 		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
 		if (info->oob_size > 0)
 			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
 					DIV_ROUND_UP(info->oob_size, 4));

-		enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
-
-		ret = wait_for_completion_timeout(&info->cmd_complete, timeout);
-		if (!ret) {
-			printk(KERN_ERR "program command time out\n");
-			return -1;
-		}
-		break;
-	case STATE_PIO_READING:
+	}
+	else {
 		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
 				DIV_ROUND_UP(info->data_size, 4));
 		if (info->oob_size > 0)
 			__raw_readsl(info->mmio_base + NDDB, info->oob_buff,
 					DIV_ROUND_UP(info->oob_size, 4));
-
-		break;
-	default:
-		printk(KERN_ERR "%s: invalid state %d\n", __func__,
-				info->state);
-		return -EINVAL;
 	}
-
-	info->state = STATE_READY;
-	return 0;
 }

 static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
@@ -520,93 +492,59 @@ static void pxa3xx_nand_data_dma_irq(int
channel, void *data)

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
+	enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
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
+	if (status & NDSR_DBERR)
+		info->retcode = ERR_DBERR;
+	if (status & NDSR_SBERR)
+		info->retcode = ERR_SBERR;
+	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {

+		info->state |= STATE_DATA_PROCESSING;
+		/* whether use dma to transfer data */
 		if (info->use_dma) {
-			info->state = STATE_DMA_READING;
+			disable_int(info, NDSR_WRDREQ);
 			start_data_dma(info, 0);
-		} else {
-			info->state = STATE_PIO_READING;
-			complete(&info->cmd_complete);
-		}
-	} else if (status & NDSR_WRDREQ) {
-		disable_int(info, NDSR_WRDREQ);
-		if (info->use_dma) {
-			info->state = STATE_DMA_WRITING;
-			start_data_dma(info, 1);
-		} else {
-			info->state = STATE_PIO_WRITING;
-			complete(&info->cmd_complete);
-		}
-	} else if (status & (NDSR_CS0_BBD | NDSR_CS0_CMDD)) {
-		if (status & NDSR_CS0_BBD)
-			info->retcode = ERR_BBERR;
+			goto NORMAL_IRQ_EXIT;
+		} else
+			handle_data_pio(info);

-		disable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
-		info->state = STATE_READY;
-		complete(&info->cmd_complete);
+		info->state |= STATE_DATA_DONE;
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
+		info->state |= STATE_CMD_DONE;
+		is_completed = 1;
 	}
-
-	info->state = STATE_CMD_HANDLE;
-
-	enable_int(info, event);
-
-	ret = wait_for_completion_timeout(&info->cmd_complete, timeout);
-	if (!ret) {
-		printk(KERN_ERR "command execution timed out\n");
-		info->retcode = ERR_SENDCMD;
-		goto fail_stop;
+	if (status & NDSR_FLASH_RDY)
+		info->state |= STATE_READY;
+	if (status & NDSR_CS0_PAGED)
+		info->state |= STATE_PAGE_DONE;
+
+	if (status & NDSR_WRCMDREQ) {
+		nand_writel(info, NDSR, NDSR_WRCMDREQ);
+		status &= ~NDSR_WRCMDREQ;
+		info->state |= STATE_CMD_WAIT_DONE;
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
@@ -627,14 +565,12 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 				int column, int page_addr)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	int ret;
+	int ret, exec_cmd = 0;

 	info->use_dma = (use_dma) ? 1 : 0;
 	info->use_ecc = 0;
 	info->data_size = 0;
-	info->state = STATE_READY;
-
-	init_completion(&info->cmd_complete);
+	info->state = 0;

 	switch (command) {
 	case NAND_CMD_READOOB:
@@ -643,14 +579,13 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 		info->buf_start = mtd->writesize + column;
 		memset(info->data_buff, 0xFF, info->buf_count);

-		if (prepare_read_prog_cmd(info, cmdset.read1, column, page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR);
+		prepare_read_prog_cmd(info, cmdset.read1, column, page_addr);

 		/* We only are OOB, so if the data has error, does not matter */
 		if (info->retcode == ERR_DBERR)
 			info->retcode = ERR_NONE;
+
+		exec_cmd = 1;
 		break;

 	case NAND_CMD_READ0:
@@ -660,11 +595,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 		info->buf_count = mtd->writesize + mtd->oobsize;
 		memset(info->data_buff, 0xFF, info->buf_count);

-		if (prepare_read_prog_cmd(info, cmdset.read1, column, page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_RDDREQ | NDSR_DBERR | NDSR_SBERR);
-
+		prepare_read_prog_cmd(info, cmdset.read1, column, page_addr);
 		if (info->retcode == ERR_DBERR) {
 			/* for blank page (all 0xff), HW will calculate its ECC as
 			 * 0, which is different from the ECC information within
@@ -673,6 +604,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 			if (is_buf_blank(info->data_buff, mtd->writesize))
 				info->retcode = ERR_NONE;
 		}
+
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_SEQIN:
 		info->buf_start = column;
@@ -686,18 +619,14 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 	case NAND_CMD_PAGEPROG:
 		info->use_ecc = (info->seqin_column >= mtd->writesize) ? 0 : 1;

-		if (prepare_read_prog_cmd(info, cmdset.program,
-				info->seqin_column, info->seqin_page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_WRDREQ);
+		prepare_read_prog_cmd(info, cmdset.program,
+				info->seqin_column, info->seqin_page_addr);
+		info->state |= STATE_IS_WRITE;
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_ERASE1:
-		if (prepare_erase_cmd(info, cmdset.erase, page_addr))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
-		break;
+		prepare_erase_cmd(info, cmdset.erase, page_addr);
+		exec_cmd = 1;
 	case NAND_CMD_ERASE2:
 		break;
 	case NAND_CMD_READID:
@@ -707,39 +636,37 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 		info->buf_count = (command == NAND_CMD_READID) ?
 				info->read_id_bytes : 1;

-		if (prepare_other_cmd(info, (command == NAND_CMD_READID) ?
-				cmdset.read_id : cmdset.read_status))
-			break;
-
-		pxa3xx_nand_do_cmd(info, NDSR_RDDREQ);
+		prepare_other_cmd(info, (command == NAND_CMD_READID) ?
+				cmdset.read_id : cmdset.read_status);
+		exec_cmd = 1;
 		break;
 	case NAND_CMD_RESET:
-		if (prepare_other_cmd(info, cmdset.reset))
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
+		prepare_other_cmd(info, cmdset.reset);
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
+		info->state |= STATE_CMD_PREPARED;
+		pxa3xx_nand_start(info);
+
+		ret = wait_for_completion_timeout(&info->cmd_complete,
+				CHIP_DELAY_TIMEOUT);
+		if (!ret) {
+			printk(KERN_ERR "Wait time out!!!\n");
+		}
+		/* Stop State Machine for next command cycle */
+		pxa3xx_nand_stop(info);
+		disable_int(info, NDCR_INT_MASK);
+		info->state &= ~STATE_CMD_PREPARED;
+		if (info->retcode == ERR_DBERR) {
+			printk(KERN_ERR "double bit error @ page %08x\n", page_addr);
+			info->retcode = ERR_NONE;
+		}
 	}
 }

@@ -848,41 +775,12 @@ static int pxa3xx_nand_ecc_correct(struct mtd_info *mtd,
 	return 0;
 }

-static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
-{
-	uint32_t ndcr;
-	uint8_t  id_buff[8];
-
-	if (prepare_other_cmd(info, cmdset.read_id)) {
-		printk(KERN_ERR "failed to prepare command\n");
-		return -EINVAL;
-	}
-
-	/* Send command */
-	if (write_cmd(info))
-		goto fail_timeout;
-
-	/* Wait for CMDDM(command done successfully) */
-	if (wait_for_event(info, NDSR_RDDREQ))
-		goto fail_timeout;
-
-	__raw_readsl(info->mmio_base + NDDB, id_buff, 2);
-	*id = id_buff[0] | (id_buff[1] << 8);
-	return 0;
-
-fail_timeout:
-	ndcr = nand_readl(info, NDCR);
-	nand_writel(info, NDCR, ndcr & ~NDCR_ND_RUN);
-	udelay(10);
-	return -ETIMEDOUT;
-}
-
 static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 				    const struct pxa3xx_nand_flash *f)
 {
 	struct platform_device *pdev = info->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
-	uint32_t ndcr = 0x00000FFF; /* disable all interrupts */
+	uint32_t ndcr = 0;

 	/* calculate flash information */
 	info->page_size = f->page_size;
@@ -949,8 +847,9 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
 	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;

-	if (__readid(info, &id))
-		return -ENODEV;
+
+	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
+	id = *((uint16_t *)(info->data_buff));

 	/* Lookup the flash id */
 	id = (id >> 8) & 0xff;		/* device id is byte 2 */
@@ -997,8 +896,8 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,

 	f = &builtin_flash_types[0];
 	pxa3xx_nand_config_flash(info, f);
-	if (__readid(info, &id))
-		goto fail_detect;
+	pxa3xx_nand_cmdfunc(info->mtd, NAND_CMD_READID, 0, 0);
+	id = *((uint16_t *)(info->data_buff));

 	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
 		if (i < pdata->num_flash)
@@ -1015,7 +914,6 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 	dev_warn(&info->pdev->dev,
 			"failed to detect configured nand flash; found %04x instead of\n",
 		 id);
-fail_detect:
 	return -ENODEV;
 }

@@ -1303,7 +1201,7 @@ static int pxa3xx_nand_suspend(struct
platform_device *pdev, pm_message_t state)
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = info->mtd;

-	if (info->state != STATE_READY) {
+	if (info->state & STATE_CMD_PREPARED) {
 		dev_err(&pdev->dev, "driver busy, state = %d\n", info->state);
 		return -EAGAIN;
 	}
-- 
1.7.0.4
