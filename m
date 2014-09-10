From: zhouqiao@marvell.com (Qiao Zhou)
Date: Wed, 10 Sep 2014 16:40:48 +0800
Subject: [PATCH 1/2] dma: mmp_tdma: add DMA_PREP_INTERRUPT flag support
Message-ID: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add DMA_PREP_INTERRUPT flag to support no_period_wakeup, in which
user space app doesn't want audio interrupt to wake up audio threads.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 drivers/dma/mmp_tdma.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 6ad30e2..c6bd015 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -148,10 +148,16 @@ static void mmp_tdma_chan_set_desc(struct mmp_tdma_chan *tdmac, dma_addr_t phys)
 					tdmac->reg_base + TDCR);
 }
 
+static void mmp_tdma_enable_irq(struct mmp_tdma_chan *tdmac, bool enable)
+{
+	if (enable)
+		writel(TDIMR_COMP, tdmac->reg_base + TDIMR);
+	else
+		writel(0, tdmac->reg_base + TDIMR);
+}
+
 static void mmp_tdma_enable_chan(struct mmp_tdma_chan *tdmac)
 {
-	/* enable irq */
-	writel(TDIMR_COMP, tdmac->reg_base + TDIMR);
 	/* enable dma chan */
 	writel(readl(tdmac->reg_base + TDCR) | TDCR_CHANEN,
 					tdmac->reg_base + TDCR);
@@ -163,9 +169,6 @@ static void mmp_tdma_disable_chan(struct mmp_tdma_chan *tdmac)
 	writel(readl(tdmac->reg_base + TDCR) & ~TDCR_CHANEN,
 					tdmac->reg_base + TDCR);
 
-	/* disable irq */
-	writel(0, tdmac->reg_base + TDIMR);
-
 	tdmac->status = DMA_COMPLETE;
 }
 
@@ -434,6 +437,10 @@ static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
 		i++;
 	}
 
+	/* enable interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		mmp_tdma_enable_irq(tdmac, true);
+
 	tdmac->buf_len = buf_len;
 	tdmac->period_len = period_len;
 	tdmac->pos = 0;
@@ -455,6 +462,8 @@ static int mmp_tdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	switch (cmd) {
 	case DMA_TERMINATE_ALL:
 		mmp_tdma_disable_chan(tdmac);
+		/* disable interrupt */
+		mmp_tdma_enable_irq(tdmac, false);
 		break;
 	case DMA_PAUSE:
 		mmp_tdma_pause_chan(tdmac);
-- 
1.7.0.4
