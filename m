From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 10 Mar 2016 10:15:22 +0100
Subject: [PATCH 1/5] dmaengine: sun6i: Fix the access of the IRQ register
In-Reply-To: <cover.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
Message-ID: <f2fb59f3f06600a50ce95886ad25375eafc937da.1457606136.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address of the IRQ register is computed, but its value was not
used and the register access was done by the channel index instead.
Then, only the first DMA channel was working.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 2db12e4..2ec320d 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -381,9 +381,9 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
 	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
 
-	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_offset));
+	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
 	irq_val |= DMA_IRQ_QUEUE << (irq_offset * DMA_IRQ_CHAN_WIDTH);
-	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_offset));
+	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
 
 	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
 	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
-- 
2.7.2
