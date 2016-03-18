From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 09:48:40 +0100
Subject: [PATCH v3 1/2] dmaengine: sun6i: Fix the access of the IRQ register
In-Reply-To: <cover.1458291150.git.moinejf@free.fr>
References: <cover.1458291150.git.moinejf@free.fr>
Message-ID: <14fce8304e2df598f058edccd3cf6860b05b5145.1458291150.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ register number is computed, but this number was not used
and the register was the one indexed by the channel index instead.
Then, only the first DMA channel was working.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
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
2.7.4
