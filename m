From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:54:27 +0530
Subject: [PATCH v2 3/4] dmaengine: zynqmp_dma: Fix issues with overflow
 interrupt
In-Reply-To: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
References: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624268-13944-4-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below issues.
--> Need to clear the channel data count register
when overflow interrupts occurs.
--> Reduce the log level from _info to _dbg when
overflow interrupt occurs.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> None.

 drivers/dma/xilinx/zynqmp_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index b9b5c0a..a297a26 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -48,6 +48,7 @@
 #define ZYNQMP_DMA_SRC_START_MSB	0x15C
 #define ZYNQMP_DMA_DST_START_LSB	0x160
 #define ZYNQMP_DMA_DST_START_MSB	0x164
+#define ZYNQMP_DMA_TOTAL_BYTE		0x188
 #define ZYNQMP_DMA_RATE_CTRL		0x18C
 #define ZYNQMP_DMA_IRQ_SRC_ACCT		0x190
 #define ZYNQMP_DMA_IRQ_DST_ACCT		0x194
@@ -513,6 +514,7 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
 static void zynqmp_dma_start(struct zynqmp_dma_chan *chan)
 {
 	writel(ZYNQMP_DMA_INT_EN_DEFAULT_MASK, chan->regs + ZYNQMP_DMA_IER);
+	writel(0, chan->regs + ZYNQMP_DMA_TOTAL_BYTE);
 	chan->idle = false;
 	writel(ZYNQMP_DMA_ENABLE, chan->regs + ZYNQMP_DMA_CTRL2);
 }
@@ -524,6 +526,8 @@ static void zynqmp_dma_start(struct zynqmp_dma_chan *chan)
  */
 static void zynqmp_dma_handle_ovfl_int(struct zynqmp_dma_chan *chan, u32 status)
 {
+	if (status & ZYNQMP_DMA_BYTE_CNT_OVRFL)
+		writel(0, chan->regs + ZYNQMP_DMA_TOTAL_BYTE);
 	if (status & ZYNQMP_DMA_IRQ_DST_ACCT_ERR)
 		readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);
 	if (status & ZYNQMP_DMA_IRQ_SRC_ACCT_ERR)
@@ -724,7 +728,7 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 
 	if (status & ZYNQMP_DMA_INT_OVRFL) {
 		zynqmp_dma_handle_ovfl_int(chan, status);
-		dev_info(chan->dev, "Channel %p overflow interrupt\n", chan);
+		dev_dbg(chan->dev, "Channel %p overflow interrupt\n", chan);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.7.4
