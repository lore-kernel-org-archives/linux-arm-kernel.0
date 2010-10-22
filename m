From: leiwen@marvell.com (Lei Wen)
Date: Fri, 22 Oct 2010 18:14:41 +0800
Subject: [PATCH V3 3/6] pxa3xx_nand: discard wait_for_event, write_cmd,
	__readid function
In-Reply-To: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
References: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
Message-ID: <1287742484-4276-4-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have rework the irq process, we don't need additional
delay in wait_for_event. Also write_cmd and __readid is also
discarded for the same reason.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/nand/pxa3xx_nand.c |   77 +---------------------------------------
 1 files changed, 1 insertions(+), 76 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index dc24000..a7f623f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -258,25 +258,6 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
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
@@ -414,35 +395,6 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
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
 static void handle_data_pio(struct pxa3xx_nand_info *info)
 {
 	switch (info->state) {
@@ -789,33 +741,6 @@ static int pxa3xx_nand_ecc_correct(struct mtd_info *mtd,
 	return 0;
 }
 
-static int __readid(struct pxa3xx_nand_info *info, uint32_t *id)
-{
-	const struct pxa3xx_nand_cmdset *cmdset = info->cmdset;
-	uint32_t ndcr;
-	uint8_t  id_buff[8];
-
-	prepare_other_cmd(info, cmdset->read_id);
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
@@ -868,7 +793,7 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 
 	page_per_block = ndcr & NDCR_PG_PER_BLK ? 64 : 32;
 	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
-	/* set info fields needed to __readid */
+	/* set info fields needed to read id */
 	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;
 
-- 
1.7.0.4
