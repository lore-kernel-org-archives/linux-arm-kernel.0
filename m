From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:21 +0100
Subject: [PATCH 26/39] arm/imx/dma-v1: don't use deprecated symbols DMA_BASE
	and MXC_INT_DMACH0
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-26-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Makefile      |    1 -
 arch/arm/plat-mxc/dma-mx1-mx2.c |  160 ++++++++++++++++++++++-----------------
 2 files changed, 90 insertions(+), 71 deletions(-)

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index f9c604a..4074c18 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -8,7 +8,6 @@ obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o
 obj-$(CONFIG_ARCH_MX1) += iomux-mx1-mx2.o dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MX2) += iomux-mx1-mx2.o dma-mx1-mx2.o
 CFLAGS_iomux-mx1-mx2.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
-CFLAGS_dma-mx1-mx2.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
diff --git a/arch/arm/plat-mxc/dma-mx1-mx2.c b/arch/arm/plat-mxc/dma-mx1-mx2.c
index 9c1b3f9..eddc965 100644
--- a/arch/arm/plat-mxc/dma-mx1-mx2.c
+++ b/arch/arm/plat-mxc/dma-mx1-mx2.c
@@ -128,6 +128,18 @@ struct imx_dma_channel {
 	int hw_chaining;
 };
 
+static void __iomem *imx_dmav1_baseaddr;
+
+static void imx_dmav1_writel(unsigned val, unsigned offset)
+{
+	__raw_writel(val, imx_dmav1_baseaddr + offset);
+}
+
+static unsigned imx_dmav1_readl(unsigned offset)
+{
+	return __raw_readl(imx_dmav1_baseaddr + offset);
+}
+
 static struct imx_dma_channel imx_dma_channels[IMX_DMA_CHANNELS];
 
 static struct clk *dma_clk;
@@ -140,7 +152,6 @@ static int imx_dma_hw_chain(struct imx_dma_channel *imxdma)
 		return 0;
 }
 
-
 /*
  * imx_dma_sg_next - prepare next chunk for scatter-gather DMA emulation
  */
@@ -160,17 +171,17 @@ static inline int imx_dma_sg_next(int channel, struct scatterlist *sg)
 		imxdma->resbytes -= now;
 
 	if ((imxdma->dma_mode & DMA_MODE_MASK) == DMA_MODE_READ)
-		__raw_writel(sg->dma_address, DMA_BASE + DMA_DAR(channel));
+		imx_dmav1_writel(sg->dma_address, DMA_DAR(channel));
 	else
-		__raw_writel(sg->dma_address, DMA_BASE + DMA_SAR(channel));
+		imx_dmav1_writel(sg->dma_address, DMA_SAR(channel));
 
-	__raw_writel(now, DMA_BASE + DMA_CNTR(channel));
+	imx_dmav1_writel(now, DMA_CNTR(channel));
 
 	pr_debug("imxdma%d: next sg chunk dst 0x%08x, src 0x%08x, "
 		"size 0x%08x\n", channel,
-		 __raw_readl(DMA_BASE + DMA_DAR(channel)),
-		 __raw_readl(DMA_BASE + DMA_SAR(channel)),
-		 __raw_readl(DMA_BASE + DMA_CNTR(channel)));
+		 imx_dmav1_readl(DMA_DAR(channel)),
+		 imx_dmav1_readl(DMA_SAR(channel)),
+		 imx_dmav1_readl(DMA_CNTR(channel)));
 
 	return now;
 }
@@ -218,27 +229,26 @@ imx_dma_setup_single(int channel, dma_addr_t dma_address,
 			channel, __func__, (unsigned int)dma_address,
 			dma_length, dev_addr);
 
-		__raw_writel(dev_addr, DMA_BASE + DMA_SAR(channel));
-		__raw_writel(dma_address, DMA_BASE + DMA_DAR(channel));
-		__raw_writel(imxdma->ccr_from_device,
-				DMA_BASE + DMA_CCR(channel));
+		imx_dmav1_writel(dev_addr, DMA_SAR(channel));
+		imx_dmav1_writel(dma_address, DMA_DAR(channel));
+		imx_dmav1_writel(imxdma->ccr_from_device, DMA_CCR(channel));
 	} else if ((dmamode & DMA_MODE_MASK) == DMA_MODE_WRITE) {
 		pr_debug("imxdma%d: %s dma_addressg=0x%08x dma_length=%d "
 			"dev_addr=0x%08x for write\n",
 			channel, __func__, (unsigned int)dma_address,
 			dma_length, dev_addr);
 
-		__raw_writel(dma_address, DMA_BASE + DMA_SAR(channel));
-		__raw_writel(dev_addr, DMA_BASE + DMA_DAR(channel));
-		__raw_writel(imxdma->ccr_to_device,
-				DMA_BASE + DMA_CCR(channel));
+		imx_dmav1_writel(dma_address, DMA_SAR(channel));
+		imx_dmav1_writel(dev_addr, DMA_DAR(channel));
+		imx_dmav1_writel(imxdma->ccr_to_device,
+				DMA_CCR(channel));
 	} else {
 		printk(KERN_ERR "imxdma%d: imx_dma_setup_single bad dmamode\n",
 		       channel);
 		return -EINVAL;
 	}
 
-	__raw_writel(dma_length, DMA_BASE + DMA_CNTR(channel));
+	imx_dmav1_writel(dma_length, DMA_CNTR(channel));
 
 	return 0;
 }
@@ -316,17 +326,15 @@ imx_dma_setup_sg(int channel,
 			"dev_addr=0x%08x for read\n",
 			channel, __func__, sg, sgcount, dma_length, dev_addr);
 
-		__raw_writel(dev_addr, DMA_BASE + DMA_SAR(channel));
-		__raw_writel(imxdma->ccr_from_device,
-				DMA_BASE + DMA_CCR(channel));
+		imx_dmav1_writel(dev_addr, DMA_SAR(channel));
+		imx_dmav1_writel(imxdma->ccr_from_device, DMA_CCR(channel));
 	} else if ((dmamode & DMA_MODE_MASK) == DMA_MODE_WRITE) {
 		pr_debug("imxdma%d: %s sg=%p sgcount=%d total length=%d "
 			"dev_addr=0x%08x for write\n",
 			channel, __func__, sg, sgcount, dma_length, dev_addr);
 
-		__raw_writel(dev_addr, DMA_BASE + DMA_DAR(channel));
-		__raw_writel(imxdma->ccr_to_device,
-				DMA_BASE + DMA_CCR(channel));
+		imx_dmav1_writel(dev_addr, DMA_DAR(channel));
+		imx_dmav1_writel(imxdma->ccr_to_device, DMA_CCR(channel));
 	} else {
 		printk(KERN_ERR "imxdma%d: imx_dma_setup_sg bad dmamode\n",
 		       channel);
@@ -360,7 +368,7 @@ imx_dma_config_channel(int channel, unsigned int config_port,
 	imxdma->ccr_from_device = config_port | (config_mem << 2) | dreq;
 	imxdma->ccr_to_device = config_mem | (config_port << 2) | dreq;
 
-	__raw_writel(dmareq, DMA_BASE + DMA_RSSR(channel));
+	imx_dmav1_writel(dmareq, DMA_RSSR(channel));
 
 	return 0;
 }
@@ -368,7 +376,7 @@ EXPORT_SYMBOL(imx_dma_config_channel);
 
 void imx_dma_config_burstlen(int channel, unsigned int burstlen)
 {
-	__raw_writel(burstlen, DMA_BASE + DMA_BLR(channel));
+	imx_dmav1_writel(burstlen, DMA_BLR(channel));
 }
 EXPORT_SYMBOL(imx_dma_config_burstlen);
 
@@ -398,7 +406,7 @@ imx_dma_setup_handlers(int channel,
 	}
 
 	local_irq_save(flags);
-	__raw_writel(1 << channel, DMA_BASE + DMA_DISR);
+	imx_dmav1_writel(1 << channel, DMA_DISR);
 	imxdma->irq_handler = irq_handler;
 	imxdma->err_handler = err_handler;
 	imxdma->data = data;
@@ -462,12 +470,10 @@ void imx_dma_enable(int channel)
 
 	local_irq_save(flags);
 
-	__raw_writel(1 << channel, DMA_BASE + DMA_DISR);
-	__raw_writel(__raw_readl(DMA_BASE + DMA_DIMR) & ~(1 << channel),
-		DMA_BASE + DMA_DIMR);
-	__raw_writel(__raw_readl(DMA_BASE + DMA_CCR(channel)) | CCR_CEN |
-		CCR_ACRPT,
-		DMA_BASE + DMA_CCR(channel));
+	imx_dmav1_writel(1 << channel, DMA_DISR);
+	imx_dmav1_writel(imx_dmav1_readl(DMA_DIMR) & ~(1 << channel), DMA_DIMR);
+	imx_dmav1_writel(imx_dmav1_readl(DMA_CCR(channel)) | CCR_CEN |
+		CCR_ACRPT, DMA_CCR(channel));
 
 #ifdef CONFIG_ARCH_MX2
 	if (imxdma->sg && imx_dma_hw_chain(imxdma)) {
@@ -475,9 +481,9 @@ void imx_dma_enable(int channel)
 		if (imxdma->sg) {
 			u32 tmp;
 			imx_dma_sg_next(channel, imxdma->sg);
-			tmp = __raw_readl(DMA_BASE + DMA_CCR(channel));
-			__raw_writel(tmp | CCR_RPT | CCR_ACRPT,
-				DMA_BASE + DMA_CCR(channel));
+			tmp = imx_dmav1_readl(DMA_CCR(channel));
+			imx_dmav1_writel(tmp | CCR_RPT | CCR_ACRPT,
+				DMA_CCR(channel));
 		}
 	}
 #endif
@@ -502,11 +508,10 @@ void imx_dma_disable(int channel)
 		del_timer(&imxdma->watchdog);
 
 	local_irq_save(flags);
-	__raw_writel(__raw_readl(DMA_BASE + DMA_DIMR) | (1 << channel),
-		DMA_BASE + DMA_DIMR);
-	__raw_writel(__raw_readl(DMA_BASE + DMA_CCR(channel)) & ~CCR_CEN,
-		DMA_BASE + DMA_CCR(channel));
-	__raw_writel(1 << channel, DMA_BASE + DMA_DISR);
+	imx_dmav1_writel(imx_dmav1_readl(DMA_DIMR) | (1 << channel), DMA_DIMR);
+	imx_dmav1_writel(imx_dmav1_readl(DMA_CCR(channel)) & ~CCR_CEN,
+			DMA_CCR(channel));
+	imx_dmav1_writel(1 << channel, DMA_DISR);
 	imxdma->in_use = 0;
 	local_irq_restore(flags);
 }
@@ -517,7 +522,7 @@ static void imx_dma_watchdog(unsigned long chno)
 {
 	struct imx_dma_channel *imxdma = &imx_dma_channels[chno];
 
-	__raw_writel(0, DMA_BASE + DMA_CCR(chno));
+	imx_dmav1_writel(0, DMA_CCR(chno));
 	imxdma->in_use = 0;
 	imxdma->sg = NULL;
 
@@ -533,17 +538,17 @@ static irqreturn_t dma_err_handler(int irq, void *dev_id)
 	unsigned int err_mask;
 	int errcode;
 
-	disr = __raw_readl(DMA_BASE + DMA_DISR);
+	disr = imx_dmav1_readl(DMA_DISR);
 
-	err_mask = __raw_readl(DMA_BASE + DMA_DBTOSR) |
-		   __raw_readl(DMA_BASE + DMA_DRTOSR) |
-		   __raw_readl(DMA_BASE + DMA_DSESR)  |
-		   __raw_readl(DMA_BASE + DMA_DBOSR);
+	err_mask = imx_dmav1_readl(DMA_DBTOSR) |
+		   imx_dmav1_readl(DMA_DRTOSR) |
+		   imx_dmav1_readl(DMA_DSESR)  |
+		   imx_dmav1_readl(DMA_DBOSR);
 
 	if (!err_mask)
 		return IRQ_HANDLED;
 
-	__raw_writel(disr & err_mask, DMA_BASE + DMA_DISR);
+	imx_dmav1_writel(disr & err_mask, DMA_DISR);
 
 	for (i = 0; i < IMX_DMA_CHANNELS; i++) {
 		if (!(err_mask & (1 << i)))
@@ -551,20 +556,20 @@ static irqreturn_t dma_err_handler(int irq, void *dev_id)
 		imxdma = &imx_dma_channels[i];
 		errcode = 0;
 
-		if (__raw_readl(DMA_BASE + DMA_DBTOSR) & (1 << i)) {
-			__raw_writel(1 << i, DMA_BASE + DMA_DBTOSR);
+		if (imx_dmav1_readl(DMA_DBTOSR) & (1 << i)) {
+			imx_dmav1_writel(1 << i, DMA_DBTOSR);
 			errcode |= IMX_DMA_ERR_BURST;
 		}
-		if (__raw_readl(DMA_BASE + DMA_DRTOSR) & (1 << i)) {
-			__raw_writel(1 << i, DMA_BASE + DMA_DRTOSR);
+		if (imx_dmav1_readl(DMA_DRTOSR) & (1 << i)) {
+			imx_dmav1_writel(1 << i, DMA_DRTOSR);
 			errcode |= IMX_DMA_ERR_REQUEST;
 		}
-		if (__raw_readl(DMA_BASE + DMA_DSESR) & (1 << i)) {
-			__raw_writel(1 << i, DMA_BASE + DMA_DSESR);
+		if (imx_dmav1_readl(DMA_DSESR) & (1 << i)) {
+			imx_dmav1_writel(1 << i, DMA_DSESR);
 			errcode |= IMX_DMA_ERR_TRANSFER;
 		}
-		if (__raw_readl(DMA_BASE + DMA_DBOSR) & (1 << i)) {
-			__raw_writel(1 << i, DMA_BASE + DMA_DBOSR);
+		if (imx_dmav1_readl(DMA_DBOSR) & (1 << i)) {
+			imx_dmav1_writel(1 << i, DMA_DBOSR);
 			errcode |= IMX_DMA_ERR_BUFFER;
 		}
 		if (imxdma->name && imxdma->err_handler) {
@@ -607,7 +612,7 @@ static void dma_irq_handle_channel(int chno)
 		if (imxdma->sg) {
 			imx_dma_sg_next(chno, imxdma->sg);
 
-			tmp = __raw_readl(DMA_BASE + DMA_CCR(chno));
+			tmp = imx_dmav1_readl(DMA_CCR(chno));
 
 			if (imx_dma_hw_chain(imxdma)) {
 				/* FIXME: The timeout should probably be
@@ -617,15 +622,13 @@ static void dma_irq_handle_channel(int chno)
 					jiffies + msecs_to_jiffies(500));
 
 				tmp |= CCR_CEN | CCR_RPT | CCR_ACRPT;
-				__raw_writel(tmp, DMA_BASE +
-						DMA_CCR(chno));
+				imx_dmav1_writel(tmp, DMA_CCR(chno));
 			} else {
-				__raw_writel(tmp & ~CCR_CEN, DMA_BASE +
-						DMA_CCR(chno));
+				imx_dmav1_writel(tmp & ~CCR_CEN, DMA_CCR(chno));
 				tmp |= CCR_CEN;
 			}
 
-			__raw_writel(tmp, DMA_BASE + DMA_CCR(chno));
+			imx_dmav1_writel(tmp, DMA_CCR(chno));
 
 			if (imxdma->prog_handler)
 				imxdma->prog_handler(chno, imxdma->data,
@@ -640,7 +643,7 @@ static void dma_irq_handle_channel(int chno)
 		}
 	}
 
-	__raw_writel(0, DMA_BASE + DMA_CCR(chno));
+	imx_dmav1_writel(0, DMA_CCR(chno));
 	imxdma->in_use = 0;
 	if (imxdma->irq_handler)
 		imxdma->irq_handler(chno, imxdma->data);
@@ -654,12 +657,12 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 	dma_err_handler(irq, dev_id);
 #endif
 
-	disr = __raw_readl(DMA_BASE + DMA_DISR);
+	disr = imx_dmav1_readl(DMA_DISR);
 
 	pr_debug("imxdma: dma_irq_handler called, disr=0x%08x\n",
 		     disr);
 
-	__raw_writel(disr, DMA_BASE + DMA_DISR);
+	imx_dmav1_writel(disr, DMA_DISR);
 	for (i = 0; i < IMX_DMA_CHANNELS; i++) {
 		if (disr & (1 << i))
 			dma_irq_handle_channel(i);
@@ -699,12 +702,12 @@ int imx_dma_request(int channel, const char *name)
 	local_irq_restore(flags); /* request_irq() can block */
 
 #ifdef CONFIG_ARCH_MX2
-	ret = request_irq(MXC_INT_DMACH0 + channel, dma_irq_handler, 0, "DMA",
+	ret = request_irq(MX2x_INT_DMACH0 + channel, dma_irq_handler, 0, "DMA",
 			NULL);
 	if (ret) {
 		imxdma->name = NULL;
 		printk(KERN_CRIT "Can't register IRQ %d for DMA channel %d\n",
-				MXC_INT_DMACH0 + channel, channel);
+				MX2x_INT_DMACH0 + channel, channel);
 		return ret;
 	}
 	init_timer(&imxdma->watchdog);
@@ -738,7 +741,7 @@ void imx_dma_free(int channel)
 	imxdma->name = NULL;
 
 #ifdef CONFIG_ARCH_MX2
-	free_irq(MXC_INT_DMACH0 + channel, NULL);
+	free_irq(MX2x_INT_DMACH0 + channel, NULL);
 #endif
 
 	local_irq_restore(flags);
@@ -796,11 +799,28 @@ static int __init imx_dma_init(void)
 	int ret = 0;
 	int i;
 
+#ifdef CONFIG_ARCH_MX1
+	if (cpu_is_mx1())
+		imx_dmav1_baseaddr = MX1_IO_ADDRESS(MX1_DMA_BASE_ADDR);
+	else
+#endif
+#ifdef CONFIG_MACH_MX21
+	if (cpu_is_mx21())
+		imx_dmav1_baseaddr = MX21_IO_ADDRESS(MX21_DMA_BASE_ADDR);
+	else
+#endif
+#ifdef CONFIG_MACH_MX27
+	if (cpu_is_mx27())
+		imx_dmav1_baseaddr = MX27_IO_ADDRESS(MX27_DMA_BASE_ADDR);
+	else
+#endif
+		BUG();
+
 	dma_clk = clk_get(NULL, "dma");
 	clk_enable(dma_clk);
 
 	/* reset DMA module */
-	__raw_writel(DCR_DRST, DMA_BASE + DMA_DCR);
+	imx_dmav1_writel(DCR_DRST, DMA_DCR);
 
 #ifdef CONFIG_ARCH_MX1
 	ret = request_irq(DMA_INT, dma_irq_handler, 0, "DMA", NULL);
@@ -817,13 +837,13 @@ static int __init imx_dma_init(void)
 	}
 #endif
 	/* enable DMA module */
-	__raw_writel(DCR_DEN, DMA_BASE + DMA_DCR);
+	imx_dmav1_writel(DCR_DEN, DMA_DCR);
 
 	/* clear all interrupts */
-	__raw_writel((1 << IMX_DMA_CHANNELS) - 1, DMA_BASE + DMA_DISR);
+	imx_dmav1_writel((1 << IMX_DMA_CHANNELS) - 1, DMA_DISR);
 
 	/* disable interrupts */
-	__raw_writel((1 << IMX_DMA_CHANNELS) - 1, DMA_BASE + DMA_DIMR);
+	imx_dmav1_writel((1 << IMX_DMA_CHANNELS) - 1, DMA_DIMR);
 
 	for (i = 0; i < IMX_DMA_CHANNELS; i++) {
 		imx_dma_channels[i].sg = NULL;
-- 
1.6.6.2
