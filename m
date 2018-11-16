From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:49:15 +0100
Subject: [PATCH v1] dmaengine: stm32-dma: check FIFO error interrupt enable
Message-ID: <1542372555-18283-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For avoiding false FIFO detection, check FIFO Error interrupt is
enabled prior raising any errors.
This will prevent having spurious FIFO error where it shouldn't.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4903a40..48f7c0f 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -641,12 +641,13 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 {
 	struct stm32_dma_chan *chan = devid;
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
-	u32 status, scr;
+	u32 status, scr, sfcr;
 
 	spin_lock(&chan->vchan.lock);
 
 	status = stm32_dma_irq_status(chan);
 	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
+	sfcr = stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id));
 
 	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
@@ -661,10 +662,12 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	if (status & STM32_DMA_FEI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
 		status &= ~STM32_DMA_FEI;
-		if (!(scr & STM32_DMA_SCR_EN))
-			dev_err(chan2dev(chan), "FIFO Error\n");
-		else
-			dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+		if (sfcr & STM32_DMA_SFCR_FEIE) {
+			if (!(scr & STM32_DMA_SCR_EN))
+				dev_err(chan2dev(chan), "FIFO Error\n");
+			else
+				dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+		}
 	}
 	if (status) {
 		stm32_dma_irq_clear(chan, status);
-- 
2.7.4
