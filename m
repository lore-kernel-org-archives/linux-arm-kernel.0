From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:37 +0200
Subject: [PATCH 2/8] ARM i.MX dma-mx1-mx2: use wrapper
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the new DMA API for i.MX1/21/27. The
old APIP is kept in the tree until all users have switched
to the new API.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/dma-v1.c                   |  142 +++++++++++++++++++++++---
 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h |    2 +-
 2 files changed, 128 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/dma-v1.c b/arch/arm/mach-imx/dma-v1.c
index 3e8c47c..d141458 100644
--- a/arch/arm/mach-imx/dma-v1.c
+++ b/arch/arm/mach-imx/dma-v1.c
@@ -35,6 +35,7 @@
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <mach/dma-v1.h>
+#include <mach/dma.h>
 
 #define DMA_DCR     0x00		/* Control Register */
 #define DMA_DISR    0x04		/* Interrupt status Register */
@@ -112,6 +113,7 @@ struct imx_dma_channel {
 	void (*irq_handler) (int, void *);
 	void (*err_handler) (int, void *, int errcode);
 	void (*prog_handler) (int, void *, struct scatterlist *);
+	void (*completion_handler) (int channel, void *data, int error);
 	void *data;
 	unsigned int dma_mode;
 	struct scatterlist *sg;
@@ -126,6 +128,11 @@ struct imx_dma_channel {
 	struct timer_list watchdog;
 
 	int hw_chaining;
+
+	dma_addr_t dev_addr;
+
+	int sgcount;
+	int sgcur;
 };
 
 static void __iomem *imx_dmav1_baseaddr;
@@ -308,6 +315,8 @@ imx_dma_setup_sg(int channel,
 	imxdma->sg = sg;
 	imxdma->dma_mode = dmamode;
 	imxdma->resbytes = dma_length;
+	imxdma->sgcount = sgcount;
+	imxdma->sgcur = 0;
 
 	if (!sg || !sgcount) {
 		printk(KERN_ERR "imxdma%d: imx_dma_setup_sg empty sg list\n",
@@ -341,8 +350,6 @@ imx_dma_setup_sg(int channel,
 		return -EINVAL;
 	}
 
-	imx_dma_sg_next(channel, sg);
-
 	return 0;
 }
 EXPORT_SYMBOL(imx_dma_setup_sg);
@@ -470,6 +477,9 @@ void imx_dma_enable(int channel)
 
 	local_irq_save(flags);
 
+	if (imxdma->sg)
+		imx_dma_sg_next(channel, imxdma->sg + imxdma->sgcur);
+
 	imx_dmav1_writel(1 << channel, DMA_DISR);
 	imx_dmav1_writel(imx_dmav1_readl(DMA_DIMR) & ~(1 << channel), DMA_DIMR);
 	imx_dmav1_writel(imx_dmav1_readl(DMA_CCR(channel)) | CCR_CEN |
@@ -478,10 +488,14 @@ void imx_dma_enable(int channel)
 #ifdef CONFIG_ARCH_MX2
 	if ((cpu_is_mx21() || cpu_is_mx27()) &&
 			imxdma->sg && imx_dma_hw_chain(imxdma)) {
-		imxdma->sg = sg_next(imxdma->sg);
-		if (imxdma->sg) {
+		imxdma->sgcur++;
+
+		if (imxdma->resbytes == IMX_DMA_LENGTH_LOOP)
+			imxdma->sgcur %= imxdma->sgcount;
+
+		if (imxdma->sgcur < imxdma->sgcount) {
 			u32 tmp;
-			imx_dma_sg_next(channel, imxdma->sg);
+			imx_dma_sg_next(channel, imxdma->sg + imxdma->sgcur);
 			tmp = imx_dmav1_readl(DMA_CCR(channel));
 			imx_dmav1_writel(tmp | CCR_RPT | CCR_ACRPT,
 				DMA_CCR(channel));
@@ -503,7 +517,7 @@ void imx_dma_disable(int channel)
 	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
 	unsigned long flags;
 
-	pr_debug("imxdma%d: imx_dma_disable\n", channel);
+	pr_info("imxdma%d: imx_dma_disable\n", channel);
 
 	if (imx_dma_hw_chain(imxdma))
 		del_timer(&imxdma->watchdog);
@@ -522,13 +536,13 @@ EXPORT_SYMBOL(imx_dma_disable);
 static void imx_dma_watchdog(unsigned long chno)
 {
 	struct imx_dma_channel *imxdma = &imx_dma_channels[chno];
+	u32 tmp;
 
-	imx_dmav1_writel(0, DMA_CCR(chno));
-	imxdma->in_use = 0;
-	imxdma->sg = NULL;
+	mod_timer(&imxdma->watchdog, jiffies + msecs_to_jiffies(500));
 
-	if (imxdma->err_handler)
-		imxdma->err_handler(chno, imxdma->data, IMX_DMA_ERR_TIMEOUT);
+	tmp = imx_dmav1_readl(DMA_CCR(chno));
+	imx_dmav1_writel(0, DMA_CCR(chno));
+	imx_dmav1_writel(tmp, DMA_CCR(chno));
 }
 #endif
 
@@ -607,11 +621,14 @@ static void dma_irq_handle_channel(int chno)
 
 	if (imxdma->sg) {
 		u32 tmp;
-		struct scatterlist *current_sg = imxdma->sg;
-		imxdma->sg = sg_next(imxdma->sg);
+		struct scatterlist *current_sg = imxdma->sg + imxdma->sgcur;
 
-		if (imxdma->sg) {
-			imx_dma_sg_next(chno, imxdma->sg);
+		imxdma->sgcur++;
+		if (imxdma->resbytes == IMX_DMA_LENGTH_LOOP)
+			imxdma->sgcur %= imxdma->sgcount;
+
+		if (imxdma->sgcur < imxdma->sgcount) {
+			imx_dma_sg_next(chno, imxdma->sg + imxdma->sgcur);
 
 			tmp = imx_dmav1_readl(DMA_CCR(chno));
 
@@ -798,6 +815,99 @@ int imx_dma_request_by_prio(const char *name, enum imx_dma_prio prio)
 }
 EXPORT_SYMBOL(imx_dma_request_by_prio);
 
+static void __irq_handler(int channel, void *data)
+{
+	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
+
+	imxdma->completion_handler(channel, data, 0);
+}
+
+static void __prog_handler(int channel, void *data, struct scatterlist *unused)
+{
+	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
+
+	imxdma->completion_handler(channel, data, 0);
+}
+
+static int config_channel(int channel, struct imx_dma_config *cfg)
+{
+	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
+	unsigned int config_port;
+
+	imxdma->completion_handler = cfg->completion_handler;
+
+	imx_dma_config_burstlen(channel, cfg->burstlen * cfg->word_size);
+	imx_dma_setup_handlers(channel, __irq_handler,
+			NULL,
+			cfg->driver_data);
+
+	imxdma->dev_addr = cfg->dma_address;
+
+	switch (cfg->word_size) {
+	case 1:
+		config_port = IMX_DMA_MEMSIZE_8;
+		break;
+	case 2:
+		config_port = IMX_DMA_MEMSIZE_16;
+		break;
+	case 4:
+		config_port = IMX_DMA_MEMSIZE_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config_port |= IMX_DMA_TYPE_FIFO;
+
+	imx_dma_config_channel(channel, config_port,
+			IMX_DMA_MEMSIZE_32, cfg->dma_request, 1);
+
+	if (cfg->flags & IMX_DMA_SG_LOOP) {
+		imxdma->resbytes = IMX_DMA_LENGTH_LOOP;
+		imx_dma_setup_progression_handler(channel, __prog_handler);
+	}
+
+	return 0;
+}
+
+static int setup_single(int channel, dma_addr_t mem, int dma_length,
+		unsigned int dmamode)
+{
+	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
+
+	return imx_dma_setup_single(channel, mem,
+		     dma_length, imxdma->dev_addr,
+		     dmamode);
+}
+
+static int setup_sg(int channel, struct scatterlist *sg, unsigned int sgcount,
+			unsigned int dma_length, unsigned int dmamode)
+{
+	struct imx_dma_channel *imxdma = &imx_dma_channels[channel];
+
+	if (imxdma->resbytes == IMX_DMA_LENGTH_LOOP)
+		dma_length = IMX_DMA_LENGTH_LOOP;
+
+	return imx_dma_setup_sg(channel, sg, sgcount, dma_length,
+			imxdma->dev_addr,
+			dmamode);
+}
+
+static int request_channel(enum imx_dma_prio prio)
+{
+	return imx_dma_request_by_prio("imxdma", prio);
+}
+
+static struct imx_dma_operations imxdma_ops = {
+	.config_channel = config_channel,
+	.setup_single = setup_single,
+	.setup_sg = setup_sg,
+	.enable = imx_dma_enable,
+	.disable = imx_dma_disable,
+	.request = request_channel,
+	.free = imx_dma_free,
+};
+
 static int __init imx_dma_init(void)
 {
 	int ret = 0;
@@ -856,6 +966,8 @@ static int __init imx_dma_init(void)
 		imx_dma_channels[i].dma_num = i;
 	}
 
+	imx_dma_ops_register(&imxdma_ops);
+
 	return ret;
 }
 
diff --git a/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h b/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
index df5f522..90b7971 100644
--- a/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
+++ b/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
@@ -2,7 +2,7 @@
 #define __MACH_DMA_MX1_MX2_H__
 /*
  * Don't use this header in new code, it will go away when all users are
- * converted to mach/dma-v1.h
+ * converted to mach/dma.h
  */
 
 #include <mach/dma-v1.h>
-- 
1.7.1
