From: joel@joelfernandes.org (Joel Fernandes (Google))
Date: Tue, 16 Oct 2018 17:00:03 -0700
Subject: [PATCH for-stable] dmaengine: stm32-dma: fix incomplete
 configuration in cyclic mode
Message-ID: <20181017000003.GC140578@joelaf.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

commit e57cb3b3f10d005410f09d4598cc6d62b833f2b0 upstream.

When in cyclic mode, the configuration is updated after having started the
DMA hardware (STM32_DMA_SCR_EN) leading to incomplete configuration of
SMxAR registers.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4099948b6914..fae7de54f00a 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -441,6 +441,8 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
 }
 
+static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan);
+
 static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 {
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
@@ -483,6 +485,9 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	if (status)
 		stm32_dma_irq_clear(chan, status);
 
+	if (chan->desc->cyclic)
+		stm32_dma_configure_next_sg(chan);
+
 	stm32_dma_dump_reg(chan);
 
 	/* Start DMA */
@@ -576,8 +581,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
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
2.19.0.605.g01d371f741-goog
