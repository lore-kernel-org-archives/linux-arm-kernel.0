From: leiwen@marvell.com (Lei Wen)
Date: Tue, 8 Jun 2010 15:10:41 +0800
Subject: [PATCH 21/25] pxa3xx_nand: add polling mode support
Message-ID: <mailman.40.1276839563.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add polling mode to facilitate debugging.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    1 +
 drivers/mtd/nand/pxa3xx_nand.c               |   55 +++++++++++++++++++++----
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 72bb70e..ae63a5f 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -17,6 +17,7 @@
  * enable such tuning for those platform which support it */
 #define PXA3XX_ADV_TIME_TUNING	(1 << 4)
 #define PXA3XX_KEEP_CONFIG	(1 << 5)
+#define PXA3XX_POOLING_MODE	(1 << 6)
 struct pxa3xx_nand_platform_data {
 	unsigned int				controller_attrs;
 	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 834422d..7f8bae7 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -274,6 +274,10 @@ static int use_dma = 1;
 module_param(use_dma, bool, 0444);
 MODULE_PARM_DESC(use_dma, "enable DMA for data transfering to/from NAND HW");

+static int use_polling = 0;
+module_param(use_polling, bool, 0444);
+MODULE_PARM_DESC(use_polling, "Use full polling mode");
+
 const static struct pxa3xx_nand_cmdset cmdset = {
 	.read1		= 0x3000,
 	.read2		= 0x0050,
@@ -444,6 +448,7 @@ static void pxa3xx_nand_start(struct pxa3xx_nand *nand)
 	info = nand->info[nand->chip_select];
 	ndcr = info->reg_ndcr;
 	ndcr |= nand->use_dma ? NDCR_DMA_EN : 0;
+	ndcr |= use_polling ? NDCR_INT_MASK : 0;
 	ndcr |= NDCR_ND_RUN;

 	switch (nand->ecc_strength) {
@@ -615,9 +620,8 @@ static void pxa3xx_nand_data_dma_irq(int channel,
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
@@ -654,13 +658,20 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & ready) {
 		nand->state |= STATE_READY;
 		if (nand->wait_ready[cmd_seqs]) {
-			enable_int(nand, NDCR_WRCMDREQM);
+			if (!use_polling)
+				enable_int(nand, NDCR_WRCMDREQM | NDCR_CS0_CMDDM
+						| NDCR_CS1_CMDDM);
 			if (cmd_seqs == nand->total_cmds)
 				is_completed = 1;
 		}
 	}
 	if (status & cmd_done) {
 		nand->state |= STATE_CMD_DONE;
+		if (nand->wait_ready[cmd_seqs] && !(nand->state & STATE_READY)) {
+			status &= ~cmd_done;
+			if (!use_polling)
+				disable_int(nand, NDCR_CS0_CMDDM | NDCR_CS1_CMDDM);
+		}
 		if (cmd_seqs == nand->total_cmds && !nand->wait_ready[cmd_seqs])
 			is_completed = 1;
 	}
@@ -668,7 +679,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 	if (status & NDSR_WRCMDREQ) {
 		status &= ~NDSR_WRCMDREQ;
 		if (nand->wait_ready[cmd_seqs] && !(nand->state & STATE_READY)) {
-			disable_int(nand, NDCR_WRCMDREQM);
+			if (!use_polling)
+				disable_int(nand, NDCR_WRCMDREQM);
 			goto IRQ_FORCE_EXIT;
 		}

@@ -698,12 +710,32 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 IRQ_FORCE_EXIT:
 	/* clear NDSR to let the controller exit the IRQ */
 	nand_writel(nand, NDSR, status);
-	if (is_completed)
-		complete(&nand->cmd_complete);
 NORMAL_IRQ_EXIT:
+	return is_completed;
+}
+
+static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
+{
+	struct pxa3xx_nand *nand = devid;
+	if (pxa3xx_nand_transaction(nand))
+		complete(&nand->cmd_complete);
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
+		udelay(10);
+	}
+
+	return ret;
+}
+
 static inline int is_buf_blank(uint8_t *buf, size_t len)
 {
 	for (; len > 0; len--)
@@ -973,8 +1005,11 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
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
 			dev_err(&nand->pdev->dev, "Wait time out!!!\n");
 			nand_error_dump(nand);
@@ -1582,7 +1617,9 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 		return -ENODEV;
 	}

-	if (!(pdata->controller_attrs & PXA3XX_DMA_EN))
+	if (pdata->controller_attrs & PXA3XX_POOLING_MODE)
+		use_polling = 1;
+	if (!(pdata->controller_attrs & PXA3XX_DMA_EN) || use_polling)
 		use_dma = 0;
 	ret = alloc_nand_resource(pdev);
 	if (ret)
-- 
1.7.0.4
