From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 30 Jul 2013 17:44:34 +0800
Subject: [PATCH v2] dmaengine: sirf: add PM entries for sleep and runtime
Message-ID: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch adds PM ops entries in sirf-dma drivers, so that this
driver can support suspend/resume, hibernation and runtime PM.

while suspending, sirf-dma will lose all registers, so we save
them at suspend and restore in resume for active channels.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
---
 -v2: add comments for PM state machine;
 don't always put dma to suspended after resuming from sleep as it
 depends on the runtime pm status;

 drivers/dma/sirf-dma.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 716b23e..ff3cdd2 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -73,6 +74,11 @@ struct sirfsoc_dma_chan {
 	int				mode;
 };
 
+struct sirfsoc_dma_regs {
+	u32				ctrl[SIRFSOC_DMA_CHANNELS];
+	u32				interrupt_en;
+};
+
 struct sirfsoc_dma {
 	struct dma_device		dma;
 	struct tasklet_struct		tasklet;
@@ -81,10 +87,13 @@ struct sirfsoc_dma {
 	int				irq;
 	struct clk			*clk;
 	bool				is_marco;
+	struct sirfsoc_dma_regs		regs_save;
 };
 
 #define DRV_NAME	"sirfsoc_dma"
 
+static int sirfsoc_dma_runtime_suspend(struct device *dev);
+
 /* Convert struct dma_chan to struct sirfsoc_dma_chan */
 static inline
 struct sirfsoc_dma_chan *dma_chan_to_sirfsoc_dma_chan(struct dma_chan *c)
@@ -393,6 +402,8 @@ static int sirfsoc_dma_alloc_chan_resources(struct dma_chan *chan)
 	LIST_HEAD(descs);
 	int i;
 
+	pm_runtime_get_sync(sdma->dma.dev);
+
 	/* Alloc descriptors for this channel */
 	for (i = 0; i < SIRFSOC_DMA_DESCRIPTORS; i++) {
 		sdesc = kzalloc(sizeof(*sdesc), GFP_KERNEL);
@@ -425,6 +436,7 @@ static int sirfsoc_dma_alloc_chan_resources(struct dma_chan *chan)
 static void sirfsoc_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
+	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(chan);
 	struct sirfsoc_dma_desc *sdesc, *tmp;
 	unsigned long flags;
 	LIST_HEAD(descs);
@@ -445,6 +457,8 @@ static void sirfsoc_dma_free_chan_resources(struct dma_chan *chan)
 	/* Free descriptors */
 	list_for_each_entry_safe(sdesc, tmp, &descs, node)
 		kfree(sdesc);
+
+	pm_runtime_put(sdma->dma.dev);
 }
 
 /* Send pending descriptor to hardware */
@@ -723,14 +737,14 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 
 	tasklet_init(&sdma->tasklet, sirfsoc_dma_tasklet, (unsigned long)sdma);
 
-	clk_prepare_enable(sdma->clk);
-
 	/* Register DMA engine */
 	dev_set_drvdata(dev, sdma);
+
 	ret = dma_async_device_register(dma);
 	if (ret)
 		goto free_irq;
 
+	pm_runtime_enable(&op->dev);
 	dev_info(dev, "initialized SIRFSOC DMAC driver\n");
 
 	return 0;
@@ -747,13 +761,124 @@ static int sirfsoc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(sdma->clk);
 	dma_async_device_unregister(&sdma->dma);
 	free_irq(sdma->irq, sdma);
 	irq_dispose_mapping(sdma->irq);
+	pm_runtime_disable(&op->dev);
+	if (!pm_runtime_status_suspended(&op->dev))
+		sirfsoc_dma_runtime_suspend(&op->dev);
+
+	return 0;
+}
+
+static int sirfsoc_dma_runtime_suspend(struct device *dev)
+{
+	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(sdma->clk);
+	return 0;
+}
+
+static int sirfsoc_dma_runtime_resume(struct device *dev)
+{
+	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(sdma->clk);
+	if (ret < 0) {
+		dev_err(dev, "clk_enable failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int sirfsoc_dma_pm_suspend(struct device *dev)
+{
+	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
+	struct sirfsoc_dma_regs *save = &sdma->regs_save;
+	struct sirfsoc_dma_desc *sdesc;
+	struct sirfsoc_dma_chan *schan;
+	int ch;
+	int ret;
+
+	/*
+	 * if we were runtime-suspended before, resume to enable clock
+	 * before accessing register
+	 */
+	if (pm_runtime_status_suspended(dev)) {
+		ret = sirfsoc_dma_runtime_resume(dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * DMA controller will lose all registers while suspending
+	 * so we need to save registers for active channels
+	 */
+	for (ch = 0; ch < SIRFSOC_DMA_CHANNELS; ch++) {
+		schan = &sdma->channels[ch];
+		if (list_empty(&schan->active))
+			continue;
+		sdesc = list_first_entry(&schan->active,
+			struct sirfsoc_dma_desc,
+			node);
+		save->ctrl[ch] = readl_relaxed(sdma->base +
+			ch * 0x10 + SIRFSOC_DMA_CH_CTRL);
+	}
+	save->interrupt_en = readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN);
+
+	/* Disable clock */
+	sirfsoc_dma_runtime_suspend(dev);
+
+	return 0;
+}
+
+static int sirfsoc_dma_pm_resume(struct device *dev)
+{
+	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
+	struct sirfsoc_dma_regs *save = &sdma->regs_save;
+	struct sirfsoc_dma_desc *sdesc;
+	struct sirfsoc_dma_chan *schan;
+	int ch;
+	int ret;
+
+	/* Enable clock before accessing register */
+	ret = sirfsoc_dma_runtime_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	writel_relaxed(save->interrupt_en, sdma->base + SIRFSOC_DMA_INT_EN);
+	for (ch = 0; ch < SIRFSOC_DMA_CHANNELS; ch++) {
+		schan = &sdma->channels[ch];
+		if (list_empty(&schan->active))
+			continue;
+		sdesc = list_first_entry(&schan->active,
+			struct sirfsoc_dma_desc,
+			node);
+		writel_relaxed(sdesc->width,
+			sdma->base + SIRFSOC_DMA_WIDTH_0 + ch * 4);
+		writel_relaxed(sdesc->xlen,
+			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_XLEN);
+		writel_relaxed(sdesc->ylen,
+			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_YLEN);
+		writel_relaxed(save->ctrl[ch],
+			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_CTRL);
+		writel_relaxed(sdesc->addr >> 2,
+			sdma->base + ch * 0x10 + SIRFSOC_DMA_CH_ADDR);
+	}
+
+	/* if we were runtime-suspended before, suspend again */
+	if (pm_runtime_status_suspended(dev))
+		sirfsoc_dma_runtime_suspend(dev);
+
 	return 0;
 }
 
+static const struct dev_pm_ops sirfsoc_dma_pm_ops = {
+	SET_RUNTIME_PM_OPS(sirfsoc_dma_runtime_suspend, sirfsoc_dma_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_dma_pm_suspend, sirfsoc_dma_pm_resume)
+};
+
 static struct of_device_id sirfsoc_dma_match[] = {
 	{ .compatible = "sirf,prima2-dmac", },
 	{ .compatible = "sirf,marco-dmac", },
@@ -766,6 +891,7 @@ static struct platform_driver sirfsoc_dma_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
+		.pm = &sirfsoc_dma_pm_ops,
 		.of_match_table	= sirfsoc_dma_match,
 	},
 };
-- 
1.8.2.3
