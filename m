From: leiwen@marvell.com (Lei Wen)
Date: Mon, 29 Mar 2010 10:30:26 +0800
Subject: [PATCH] pxa3xx_nand: add polling mode support
Message-ID: <mailman.387.1273137058.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add polling mode to facilitate debugging.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |  119 +++++++++++++++++++++++++++-------------
 1 files changed, 80 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 56559e1..31ebc78 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -26,9 +26,10 @@
 #include <mach/dma.h>
 #include <plat/pxa3xx_nand.h>

-#define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
+#define	CHIP_DELAY_TIMEOUT	(100 * HZ/10)
 #define NAND_STOP_DELAY		(2 * HZ/50)
 #define PAGE_CHUNK_SIZE		(2048)
+#define OOB_CHUNK_SIZE		(64)
 #define BCH_THRESHOLD           (8)
 #define CMD_POOL_SIZE           (5)
 #undef PXA3XX_NAND_DEBUG
@@ -298,6 +299,10 @@ static int use_dma = 1;
 module_param(use_dma, bool, 0444);
 MODULE_PARM_DESC(use_dma, "enable DMA for data transfering to/from NAND HW");

+static int use_polling = 0;
+module_param(use_polling, bool, 0444);
+MODULE_PARM_DESC(use_polling, "Use full polling mode");
+
 static int naked_cmd_support = 0;
 module_param(naked_cmd_support, bool, 0444);
 MODULE_PARM_DESC(naked_cmd_support, "Whether the controller support
using naked command set");
@@ -329,7 +334,7 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 { 0xd3ec, 128, 2048, 8, 8, ECC_BCH, 4096, \
 	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xd7ec, 128, 4096, 8, 8, ECC_BCH, 8192, \
-	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
+	{ 0, 10, 0, 20, 40, 30, 40, 25000, 0, 110, 10, }, },
 { 0xa12c, 64, 2048, 8, 8, ECC_HAMMIN, 1024, \
 	{ 0, 10, 25, 15, 25, 15, 30, 25000, 0, 60, 10, }, },
 { 0xb12c, 64, 2048, 16, 16, ECC_HAMMIN, 1024, \
@@ -569,7 +574,8 @@ static void pxa3xx_nand_start(struct pxa3xx_nand *nand)

 	info = nand->info[nand->chip_select];
 	ndcr = info->reg_ndcr;
-	ndcr |= nand->use_dma ? NDCR_DMA_EN : NDCR_STOP_ON_UNCOR;
+	ndcr |= nand->use_dma ? NDCR_DMA_EN : 0;
+	ndcr |= use_polling ? NDCR_INT_MASK : 0;
 	ndcr |= NDCR_ND_RUN;

 	switch (nand->use_ecc) {
@@ -764,9 +770,8 @@ static void pxa3xx_nand_data_dma_irq(int channel,
void *data)
 	nand_writel(nand, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
 }

-static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
+static int pxa3xx_nand_transaction(struct pxa3xx_nand *nand)
 {
-	struct pxa3xx_nand *nand = devid;
 	struct pxa3xx_nand_info *info;
 	unsigned int status, is_completed = 0, cs, cmd_seqs, ndcb1, ndcb2;
 	unsigned int ready, cmd_done, page_done, badblock_detect;
@@ -780,8 +785,10 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	cmd_seqs	= info->cmd_seqs;

 	status = nand_readl(nand, NDSR);
-	DBG_NAND(if (status != 0)
-		printk("\t\t==cmd seqs %x, status %x, cs %x\n", cmd_seqs, status, cs));
+	if (!status)
+		return 0;
+	DBG_NAND(printk("\t\t==cmd seqs %x, status %x, cs %x\n",
+				cmd_seqs, status, cs));
 	nand->bad_count = (status & NDSR_ERR_CNT_MASK) >> 16;
 	if (status & NDSR_DBERR)
 		nand->retcode = ERR_DBERR;
@@ -791,7 +798,7 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)

 		nand->state |= STATE_DATA_PROCESSING;
 		/* whether use dma to transfer data */
-		if (nand->use_dma) {
+		if (nand->use_dma && !use_polling) {
 			disable_int(nand, NDCR_INT_MASK);
 			start_data_dma(nand, nand->state & STATE_IS_WRITE);
 			goto NORMAL_IRQ_EXIT;
@@ -805,13 +812,20 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & ready) {
 		nand->state |= STATE_READY;
 		if (info->wait_ready[cmd_seqs]) {
-			enable_int(nand, NDCR_WRCMDREQM);
+			if (!use_polling)
+				enable_int(nand, NDCR_WRCMDREQM | NDCR_CS0_CMDDM
+						| NDCR_CS1_CMDDM);
 			if (cmd_seqs == info->total_cmds)
 				is_completed = 1;
 		}
 	}
 	if (status & cmd_done) {
 		nand->state |= STATE_CMD_DONE;
+		if (info->wait_ready[cmd_seqs] && !(nand->state & STATE_READY)) {
+			status &= ~cmd_done;
+			if (!use_polling)
+				disable_int(nand, NDCR_CS0_CMDDM | NDCR_CS1_CMDDM);
+		}
 		if (cmd_seqs == info->total_cmds && !info->wait_ready[cmd_seqs])
 			is_completed = 1;
 	}
@@ -819,7 +833,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & NDSR_WRCMDREQ) {
 		status &= ~NDSR_WRCMDREQ;
 		if (info->wait_ready[cmd_seqs] && !(nand->state & STATE_READY)) {
-			disable_int(nand, NDCR_WRCMDREQM);
+			if (!use_polling)
+				disable_int(nand, NDCR_WRCMDREQM);
 			goto IRQ_FORCE_EXIT;
 		}

@@ -849,12 +864,36 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 IRQ_FORCE_EXIT:
 	/* clear NDSR to let the controller exit the IRQ */
 	nand_writel(nand, NDSR, status);
+NORMAL_IRQ_EXIT:
+	return is_completed;
+}
+
+static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
+{
+	struct pxa3xx_nand *nand = devid;
+	int is_completed;
+
+	is_completed = pxa3xx_nand_transaction(nand);
 	if (is_completed)
 		complete(&nand->cmd_complete);
-NORMAL_IRQ_EXIT:
+
 	return IRQ_HANDLED;
 }

+static int pxa3xx_nand_polling(struct pxa3xx_nand *nand, unsigned long timeout)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < timeout; i++) {
+		ret = pxa3xx_nand_transaction(nand);
+		if (ret)
+			break;
+		udelay(5);
+	}
+
+	return ret;
+}
+
 static inline int is_buf_blank(uint8_t *buf, size_t len)
 {
 	for (; len > 0; len--)
@@ -1107,8 +1146,11 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 		nand->state |= STATE_CMD_PREPARED;
 		pxa3xx_nand_start(nand);

-		ret = wait_for_completion_timeout(&nand->cmd_complete,
-				CHIP_DELAY_TIMEOUT);
+		if (!use_polling)
+			ret = wait_for_completion_timeout(&nand->cmd_complete,
+					CHIP_DELAY_TIMEOUT);
+		else
+			ret = pxa3xx_nand_polling(nand, CHIP_DELAY_TIMEOUT);
 		if (!ret) {
 			printk(KERN_ERR "Wait time out!!!\n");
 			nand_error_dump(nand);
@@ -1229,31 +1271,30 @@ static void pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	ndcr |= (f->dfc_width == 16) ? NDCR_DWIDTH_C : 0;

 	switch (f->page_per_block) {
-		case 32:
-			ndcr |= NDCR_PG_PER_BLK(0x0);
-			break;
-		case 128:
-			ndcr |= NDCR_PG_PER_BLK(0x1);
-			break;
-		case 256:
-			ndcr |= NDCR_PG_PER_BLK(0x3);
-			break;
-		case 64:
-		default:
-			ndcr |= NDCR_PG_PER_BLK(0x2);
-			break;
+	case 32:
+		ndcr |= NDCR_PG_PER_BLK(0x0);
+		break;
+	case 128:
+		ndcr |= NDCR_PG_PER_BLK(0x1);
+		break;
+	case 256:
+		ndcr |= NDCR_PG_PER_BLK(0x3);
+		break;
+	case 64:
+	default:
+		ndcr |= NDCR_PG_PER_BLK(0x2);
+		break;
 	}

 	switch (f->page_size) {
-		case 512:
-			ndcr |= NDCR_PAGE_SZ(0x0);
-			break;
-		case 2048:
-		default:
-			ndcr |= NDCR_PAGE_SZ(0x1);
-			ndcr |= NDCR_FORCE_CSX;
-			break;
-
+	case 512:
+		ndcr |= NDCR_PAGE_SZ(0x0);
+		break;
+	case 2048:
+	default:
+		ndcr |= NDCR_PAGE_SZ(0x1);
+		ndcr |= NDCR_FORCE_CSX;
+		break;
 	}

 	ndcr |= NDCR_RD_ID_CNT(info->read_id_bytes);
@@ -1264,11 +1305,11 @@ static void pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	pxa3xx_nand_set_timing(info, &f->timing, show_timing);
 }

-/* the maximum possible buffer size for large page with OOB data
- * is: 2048 + 64 = 2112 bytes, allocate a page here for both the
- * data buffer and the DMA descriptor
+/* the max buff size should be large than
+ * the largest size of page of NAND flash
+ * that currently controller support
  */
-#define MAX_BUFF_SIZE	PAGE_SIZE
+#define MAX_BUFF_SIZE	((PAGE_CHUNK_SIZE + OOB_CHUNK_SIZE) * 2) +
sizeof(struct pxa_dma_desc)

 static struct nand_ecclayout hw_smallpage_ecclayout = {
 	.eccbytes = 6,
-- 
1.5.6.5
