From: joel@joelfernandes.org (Joel Fernandes (Google))
Date: Mon,  8 Oct 2018 22:47:50 -0700
Subject: [PATCH 5/7] dmaengine: stm32-dma: fix DMA IRQ status handling
In-Reply-To: <20181009054752.145978-1-joel@joelfernandes.org>
References: <20181009054752.145978-1-joel@joelfernandes.org>
Message-ID: <20181009054752.145978-6-joel@joelfernandes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>

Update the way Transfer Complete and Half Transfer Complete status are
acknowledge. Even if HTI is not enabled its status is shown when reading
registers, driver has to clear it gently and not raise an error.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/stm32-dma.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 21ad359a5a59..b40486454a2c 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -34,9 +34,14 @@
 #define STM32_DMA_LIFCR			0x0008 /* DMA Low Int Flag Clear Reg */
 #define STM32_DMA_HIFCR			0x000c /* DMA High Int Flag Clear Reg */
 #define STM32_DMA_TCI			BIT(5) /* Transfer Complete Interrupt */
+#define STM32_DMA_HTI			BIT(4) /* Half Transfer Interrupt */
 #define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
 #define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
 #define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */
+#define STM32_DMA_MASKI			(STM32_DMA_TCI \
+					 | STM32_DMA_TEI \
+					 | STM32_DMA_DMEI \
+					 | STM32_DMA_FEI)
 
 /* DMA Stream x Configuration Register */
 #define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
@@ -643,13 +648,29 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 	status = stm32_dma_irq_status(chan);
 	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
 
-	if ((status & STM32_DMA_TCI) && (scr & STM32_DMA_SCR_TCIE)) {
+	if (status & STM32_DMA_TCI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
-		stm32_dma_handle_chan_done(chan);
-
-	} else {
+		if (scr & STM32_DMA_SCR_TCIE)
+			stm32_dma_handle_chan_done(chan);
+		status &= ~STM32_DMA_TCI;
+	}
+	if (status & STM32_DMA_HTI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_HTI);
+		status &= ~STM32_DMA_HTI;
+	}
+	if (status & STM32_DMA_FEI) {
+		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
+		status &= ~STM32_DMA_FEI;
+		if (!(scr & STM32_DMA_SCR_EN))
+			dev_err(chan2dev(chan), "FIFO Error\n");
+		else
+			dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+	}
+	if (status) {
 		stm32_dma_irq_clear(chan, status);
 		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
+		if (!(scr & STM32_DMA_SCR_EN))
+			dev_err(chan2dev(chan), "chan disabled by HW\n");
 	}
 
 	spin_unlock(&chan->vchan.lock);
-- 
2.19.0.605.g01d371f741-goog
