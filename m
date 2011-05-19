From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:24 +0200
Subject: [PATCH 4/8] ARM i.MX: dmav1: kill SoC ifdefs
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

since we now can include all soc specific headers at once we do not
need the ifdeffery anymore.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/dma-v1.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/dma-v1.c b/arch/arm/mach-imx/dma-v1.c
index 236f149..4d76f67 100644
--- a/arch/arm/mach-imx/dma-v1.c
+++ b/arch/arm/mach-imx/dma-v1.c
@@ -475,7 +475,6 @@ void imx_dma_enable(int channel)
 	imx_dmav1_writel(imx_dmav1_readl(DMA_CCR(channel)) | CCR_CEN |
 		CCR_ACRPT, DMA_CCR(channel));
 
-#ifdef CONFIG_ARCH_MX2
 	if ((cpu_is_mx21() || cpu_is_mx27()) &&
 			imxdma->sg && imx_dma_hw_chain(imxdma)) {
 		imxdma->sg = sg_next(imxdma->sg);
@@ -487,7 +486,6 @@ void imx_dma_enable(int channel)
 				DMA_CCR(channel));
 		}
 	}
-#endif
 	imxdma->in_use = 1;
 
 	local_irq_restore(flags);
@@ -518,7 +516,6 @@ void imx_dma_disable(int channel)
 }
 EXPORT_SYMBOL(imx_dma_disable);
 
-#ifdef CONFIG_ARCH_MX2
 static void imx_dma_watchdog(unsigned long chno)
 {
 	struct imx_dma_channel *imxdma = &imx_dma_channels[chno];
@@ -530,7 +527,6 @@ static void imx_dma_watchdog(unsigned long chno)
 	if (imxdma->err_handler)
 		imxdma->err_handler(chno, imxdma->data, IMX_DMA_ERR_TIMEOUT);
 }
-#endif
 
 static irqreturn_t dma_err_handler(int irq, void *dev_id)
 {
@@ -654,10 +650,8 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 {
 	int i, disr;
 
-#ifdef CONFIG_ARCH_MX2
 	if (cpu_is_mx21() || cpu_is_mx27())
 		dma_err_handler(irq, dev_id);
-#endif
 
 	disr = imx_dmav1_readl(DMA_DISR);
 
@@ -703,7 +697,6 @@ int imx_dma_request(int channel, const char *name)
 	imxdma->name = name;
 	local_irq_restore(flags); /* request_irq() can block */
 
-#ifdef CONFIG_ARCH_MX2
 	if (cpu_is_mx21() || cpu_is_mx27()) {
 		ret = request_irq(MX2x_INT_DMACH0 + channel,
 				dma_irq_handler, 0, "DMA", NULL);
@@ -717,7 +710,6 @@ int imx_dma_request(int channel, const char *name)
 		imxdma->watchdog.function = &imx_dma_watchdog;
 		imxdma->watchdog.data = channel;
 	}
-#endif
 
 	return ret;
 }
@@ -744,10 +736,8 @@ void imx_dma_free(int channel)
 	imx_dma_disable(channel);
 	imxdma->name = NULL;
 
-#ifdef CONFIG_ARCH_MX2
 	if (cpu_is_mx21() || cpu_is_mx27())
 		free_irq(MX2x_INT_DMACH0 + channel, NULL);
-#endif
 
 	local_irq_restore(flags);
 }
@@ -803,21 +793,13 @@ static int __init imx_dma_init(void)
 	int ret = 0;
 	int i;
 
-#ifdef CONFIG_ARCH_MX1
 	if (cpu_is_mx1())
 		imx_dmav1_baseaddr = MX1_IO_ADDRESS(MX1_DMA_BASE_ADDR);
-	else
-#endif
-#ifdef CONFIG_MACH_MX21
-	if (cpu_is_mx21())
+	else if (cpu_is_mx21())
 		imx_dmav1_baseaddr = MX21_IO_ADDRESS(MX21_DMA_BASE_ADDR);
-	else
-#endif
-#ifdef CONFIG_MACH_MX27
-	if (cpu_is_mx27())
+	else if (cpu_is_mx27())
 		imx_dmav1_baseaddr = MX27_IO_ADDRESS(MX27_DMA_BASE_ADDR);
 	else
-#endif
 		return 0;
 
 	dma_clk = clk_get(NULL, "dma");
@@ -828,7 +810,6 @@ static int __init imx_dma_init(void)
 	/* reset DMA module */
 	imx_dmav1_writel(DCR_DRST, DMA_DCR);
 
-#ifdef CONFIG_ARCH_MX1
 	if (cpu_is_mx1()) {
 		ret = request_irq(MX1_DMA_INT, dma_irq_handler, 0, "DMA", NULL);
 		if (ret) {
@@ -843,7 +824,7 @@ static int __init imx_dma_init(void)
 			return ret;
 		}
 	}
-#endif
+
 	/* enable DMA module */
 	imx_dmav1_writel(DCR_DEN, DMA_DCR);
 
-- 
1.7.4.1
