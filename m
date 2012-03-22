From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 22 Mar 2012 14:54:08 +0100
Subject: [PATCH v4 08/15] dmaengine: imx-dma: remove 'in_use' field of
 'internal' structure.
In-Reply-To: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
References: <1332424455-15594-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1332424455-15594-9-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes no sense keeping an 'in_use' flag when the multiple descriptor
mechanism already prevents a new DMA transfer to be issued when another
one is in course.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/dma/imx-dma.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 82d4099..d7309e4 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -131,8 +131,6 @@ enum  imxdma_prep_type {
 struct imxdma_channel_internal {
 	unsigned int resbytes;
 
-	int in_use;
-
 	struct timer_list watchdog;
 
 	int hw_chaining;
@@ -266,9 +264,6 @@ static void imxdma_enable_hw(struct imxdma_desc *d)
 
 	pr_debug("imxdma%d: imx_dma_enable\n", channel);
 
-	if (imxdmac->internal.in_use)
-		return;
-
 	local_irq_save(flags);
 
 	imx_dmav1_writel(1 << channel, DMA_DISR);
@@ -287,7 +282,6 @@ static void imxdma_enable_hw(struct imxdma_desc *d)
 				DMA_CCR(channel));
 		}
 	}
-	imxdmac->internal.in_use = 1;
 
 	local_irq_restore(flags);
 }
@@ -307,7 +301,6 @@ static void imxdma_disable_hw(struct imxdma_channel *imxdmac)
 	imx_dmav1_writel(imx_dmav1_readl(DMA_CCR(channel)) & ~CCR_CEN,
 			DMA_CCR(channel));
 	imx_dmav1_writel(1 << channel, DMA_DISR);
-	imxdmac->internal.in_use = 0;
 	local_irq_restore(flags);
 }
 
@@ -317,7 +310,6 @@ static void imxdma_watchdog(unsigned long data)
 	int channel = imxdmac->channel;
 
 	imx_dmav1_writel(0, DMA_CCR(channel));
-	imxdmac->internal.in_use = 0;
 
 	/* Tasklet watchdog error handler */
 	tasklet_schedule(&imxdmac->dma_tasklet);
@@ -436,7 +428,6 @@ static void dma_irq_handle_channel(struct imxdma_channel *imxdmac)
 
 out:
 	imx_dmav1_writel(0, DMA_CCR(chno));
-	imxdma->in_use = 0;
 	/* Tasklet irq */
 	tasklet_schedule(&imxdmac->dma_tasklet);
 }
-- 
1.7.0.4
