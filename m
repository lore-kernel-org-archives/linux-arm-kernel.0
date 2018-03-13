From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 13 Mar 2018 17:42:06 +0100
Subject: [PATCH v1 7/8] dmaengine: stm32-dma: fix incomplete configuration in
 cyclic mode
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1520959327-25760-8-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When in cyclic mode, the configuration is updated after having started the
DMA hardware (STM32_DMA_SCR_EN) leading to incomplete configuration of
SMxAR registers.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index a11cbee..38c545d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -538,6 +538,8 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
 }
 
+static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan);
+
 static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
@@ -580,6 +582,9 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	if (status)
 		stm32_dma_irq_clear(chan, status);
 
+	if (chan->desc->cyclic)
+		stm32_dma_configure_next_sg(chan);
+
 	stm32_dma_dump_reg(chan);
 
 	/* Start DMA */
@@ -689,8 +694,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
 		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
-		if (chan->desc->cyclic)
-			stm32_dma_configure_next_sg(chan);
+
 	}
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
-- 
2.7.4
