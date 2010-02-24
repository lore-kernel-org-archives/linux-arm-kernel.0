From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:22 +0100
Subject: [PATCH 27/39] arm/imx/dma-v1: protect #ifdef'd blocks additionally by
	cpu_is_...
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-27-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is necessary for a multi-SoC kernel.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/dma-mx1-mx2.c |   53 ++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-mxc/dma-mx1-mx2.c b/arch/arm/plat-mxc/dma-mx1-mx2.c
index eddc965..e16014b 100644
--- a/arch/arm/plat-mxc/dma-mx1-mx2.c
+++ b/arch/arm/plat-mxc/dma-mx1-mx2.c
@@ -476,7 +476,8 @@ void imx_dma_enable(int channel)
 		CCR_ACRPT, DMA_CCR(channel));
 
 #ifdef CONFIG_ARCH_MX2
-	if (imxdma->sg && imx_dma_hw_chain(imxdma)) {
+	if ((cpu_is_mx21() || cpu_is_mx27()) &&
+			imxdma->sg && imx_dma_hw_chain(imxdma)) {
 		imxdma->sg = sg_next(imxdma->sg);
 		if (imxdma->sg) {
 			u32 tmp;
@@ -654,7 +655,8 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 	int i, disr;
 
 #ifdef CONFIG_ARCH_MX2
-	dma_err_handler(irq, dev_id);
+	if (cpu_is_mx21() || cpu_is_mx27())
+		dma_err_handler(irq, dev_id);
 #endif
 
 	disr = imx_dmav1_readl(DMA_DISR);
@@ -702,17 +704,19 @@ int imx_dma_request(int channel, const char *name)
 	local_irq_restore(flags); /* request_irq() can block */
 
 #ifdef CONFIG_ARCH_MX2
-	ret = request_irq(MX2x_INT_DMACH0 + channel, dma_irq_handler, 0, "DMA",
-			NULL);
-	if (ret) {
-		imxdma->name = NULL;
-		printk(KERN_CRIT "Can't register IRQ %d for DMA channel %d\n",
-				MX2x_INT_DMACH0 + channel, channel);
-		return ret;
+	if (cpu_is_mx21() || cpu_is_mx27()) {
+		ret = request_irq(MX2x_INT_DMACH0 + channel,
+				dma_irq_handler, 0, "DMA", NULL);
+		if (ret) {
+			imxdma->name = NULL;
+			pr_crit("Can't register IRQ %d for DMA channel %d\n",
+					MX2x_INT_DMACH0 + channel, channel);
+			return ret;
+		}
+		init_timer(&imxdma->watchdog);
+		imxdma->watchdog.function = &imx_dma_watchdog;
+		imxdma->watchdog.data = channel;
 	}
-	init_timer(&imxdma->watchdog);
-	imxdma->watchdog.function = &imx_dma_watchdog;
-	imxdma->watchdog.data = channel;
 #endif
 
 	return ret;
@@ -741,7 +745,8 @@ void imx_dma_free(int channel)
 	imxdma->name = NULL;
 
 #ifdef CONFIG_ARCH_MX2
-	free_irq(MX2x_INT_DMACH0 + channel, NULL);
+	if (cpu_is_mx21() || cpu_is_mx27())
+		free_irq(MX2x_INT_DMACH0 + channel, NULL);
 #endif
 
 	local_irq_restore(flags);
@@ -823,17 +828,19 @@ static int __init imx_dma_init(void)
 	imx_dmav1_writel(DCR_DRST, DMA_DCR);
 
 #ifdef CONFIG_ARCH_MX1
-	ret = request_irq(DMA_INT, dma_irq_handler, 0, "DMA", NULL);
-	if (ret) {
-		printk(KERN_CRIT "Wow!  Can't register IRQ for DMA\n");
-		return ret;
-	}
+	if (cpu_is_mx1()) {
+		ret = request_irq(MX1_DMA_INT, dma_irq_handler, 0, "DMA", NULL);
+		if (ret) {
+			pr_crit("Wow!  Can't register IRQ for DMA\n");
+			return ret;
+		}
 
-	ret = request_irq(DMA_ERR, dma_err_handler, 0, "DMA", NULL);
-	if (ret) {
-		printk(KERN_CRIT "Wow!  Can't register ERRIRQ for DMA\n");
-		free_irq(DMA_INT, NULL);
-		return ret;
+		ret = request_irq(MX1_DMA_ERR, dma_err_handler, 0, "DMA", NULL);
+		if (ret) {
+			pr_crit("Wow!  Can't register ERRIRQ for DMA\n");
+			free_irq(MX1_DMA_INT, NULL);
+			return ret;
+		}
 	}
 #endif
 	/* enable DMA module */
-- 
1.6.6.2
