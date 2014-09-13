From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 21:52:59 +0800
Subject: [PATCH 1/3] dmaengine: sun6i: support parameterized compatible strings
In-Reply-To: <1410616381-30226-1-git-send-email-wens@csie.org>
References: <1410616381-30226-1-git-send-email-wens@csie.org>
Message-ID: <1410616381-30226-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for hardware parameters tied to compatible
strings, so similar hardware can reuse the driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/dma/sun6i-dma.c | 96 +++++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 3aa10b3..89ca0c4 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -26,24 +27,6 @@
 #include "virt-dma.h"
 
 /*
- * There's 16 physical channels that can work in parallel.
- *
- * However we have 30 different endpoints for our requests.
- *
- * Since the channels are able to handle only an unidirectional
- * transfer, we need to allocate more virtual channels so that
- * everyone can grab one channel.
- *
- * Some devices can't work in both direction (mostly because it
- * wouldn't make sense), so we have a bit fewer virtual channels than
- * 2 channels per endpoints.
- */
-
-#define NR_MAX_CHANNELS		16
-#define NR_MAX_REQUESTS		30
-#define NR_MAX_VCHANS		53
-
-/*
  * Common registers
  */
 #define DMA_IRQ_EN(x)		((x) * 0x04)
@@ -102,6 +85,19 @@
 #define DRQ_SDRAM	1
 
 /*
+ * Hardware channels / ports representation
+ *
+ * The hardware is used in several SoCs, with differing numbers
+ * of channels and endpoints. This structure ties those numbers
+ * to a certain compatible string.
+ */
+struct sun6i_dma_config {
+	u32 nr_max_channels;
+	u32 nr_max_requests;
+	u32 nr_max_vchans;
+};
+
+/*
  * Hardware representation of the LLI
  *
  * The hardware will be fed the physical address of this structure,
@@ -159,6 +155,7 @@ struct sun6i_dma_dev {
 	struct dma_pool		*pool;
 	struct sun6i_pchan	*pchans;
 	struct sun6i_vchan	*vchans;
+	const struct sun6i_dma_config *cfg;
 };
 
 static struct device *chan2dev(struct dma_chan *chan)
@@ -432,6 +429,7 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 static void sun6i_dma_tasklet(unsigned long data)
 {
 	struct sun6i_dma_dev *sdev = (struct sun6i_dma_dev *)data;
+	const struct sun6i_dma_config *cfg = sdev->cfg;
 	struct sun6i_vchan *vchan;
 	struct sun6i_pchan *pchan;
 	unsigned int pchan_alloc = 0;
@@ -459,7 +457,7 @@ static void sun6i_dma_tasklet(unsigned long data)
 	}
 
 	spin_lock_irq(&sdev->lock);
-	for (pchan_idx = 0; pchan_idx < NR_MAX_CHANNELS; pchan_idx++) {
+	for (pchan_idx = 0; pchan_idx < cfg->nr_max_channels; pchan_idx++) {
 		pchan = &sdev->pchans[pchan_idx];
 
 		if (pchan->vchan || list_empty(&sdev->pending))
@@ -480,7 +478,7 @@ static void sun6i_dma_tasklet(unsigned long data)
 	}
 	spin_unlock_irq(&sdev->lock);
 
-	for (pchan_idx = 0; pchan_idx < NR_MAX_CHANNELS; pchan_idx++) {
+	for (pchan_idx = 0; pchan_idx < cfg->nr_max_channels; pchan_idx++) {
 		if (!(pchan_alloc & BIT(pchan_idx)))
 			continue;
 
@@ -502,7 +500,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	int i, j, ret = IRQ_NONE;
 	u32 status;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < sdev->cfg->nr_max_channels / DMA_IRQ_CHAN_NR; i++) {
 		status = readl(sdev->base + DMA_IRQ_STAT(i));
 		if (!status)
 			continue;
@@ -512,7 +510,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 
 		writel(status, sdev->base + DMA_IRQ_STAT(i));
 
-		for (j = 0; (j < 8) && status; j++) {
+		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
 			if (status & DMA_IRQ_QUEUE) {
 				pchan = sdev->pchans + j;
 				vchan = pchan->vchan;
@@ -525,7 +523,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 				}
 			}
 
-			status = status >> 4;
+			status = status >> DMA_IRQ_CHAN_WIDTH;
 		}
 
 		if (!atomic_read(&sdev->tasklet_shutdown))
@@ -817,7 +815,7 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
 	struct dma_chan *chan;
 	u8 port = dma_spec->args[0];
 
-	if (port > NR_MAX_REQUESTS)
+	if (port > sdev->cfg->nr_max_requests)
 		return NULL;
 
 	chan = dma_get_any_slave_channel(&sdev->slave);
@@ -850,7 +848,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 {
 	int i;
 
-	for (i = 0; i < NR_MAX_VCHANS; i++) {
+	for (i = 0; i < sdev->cfg->nr_max_vchans; i++) {
 		struct sun6i_vchan *vchan = &sdev->vchans[i];
 
 		list_del(&vchan->vc.chan.device_node);
@@ -858,8 +856,36 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 	}
 }
 
+/*
+ * For A31:
+ *
+ * There's 16 physical channels that can work in parallel.
+ *
+ * However we have 30 different endpoints for our requests.
+ *
+ * Since the channels are able to handle only an unidirectional
+ * transfer, we need to allocate more virtual channels so that
+ * everyone can grab one channel.
+ *
+ * Some devices can't work in both direction (mostly because it
+ * wouldn't make sense), so we have a bit fewer virtual channels than
+ * 2 channels per endpoints.
+ */
+
+static struct sun6i_dma_config sun6i_a31_dma_cfg = {
+	.nr_max_channels = 16,
+	.nr_max_requests = 30,
+	.nr_max_vchans   = 53,
+};
+
+static struct of_device_id sun6i_dma_match[] = {
+	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
+	{ /* sentinel */ }
+};
+
 static int sun6i_dma_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *device;
 	struct sun6i_dma_dev *sdc;
 	struct resource *res;
 	int ret, i;
@@ -868,6 +894,11 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	if (!sdc)
 		return -ENOMEM;
 
+	device = of_match_device(sun6i_dma_match, &pdev->dev);
+	if (!device)
+		return -ENODEV;
+	sdc->cfg = device->data;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sdc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(sdc->base))
@@ -914,30 +945,30 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.device_prep_slave_sg		= sun6i_dma_prep_slave_sg;
 	sdc->slave.device_prep_dma_memcpy	= sun6i_dma_prep_dma_memcpy;
 	sdc->slave.device_control		= sun6i_dma_control;
-	sdc->slave.chancnt			= NR_MAX_VCHANS;
+	sdc->slave.chancnt			= sdc->cfg->nr_max_vchans;
 
 	sdc->slave.dev = &pdev->dev;
 
-	sdc->pchans = devm_kcalloc(&pdev->dev, NR_MAX_CHANNELS,
+	sdc->pchans = devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels,
 				   sizeof(struct sun6i_pchan), GFP_KERNEL);
 	if (!sdc->pchans)
 		return -ENOMEM;
 
-	sdc->vchans = devm_kcalloc(&pdev->dev, NR_MAX_VCHANS,
+	sdc->vchans = devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_vchans,
 				   sizeof(struct sun6i_vchan), GFP_KERNEL);
 	if (!sdc->vchans)
 		return -ENOMEM;
 
 	tasklet_init(&sdc->task, sun6i_dma_tasklet, (unsigned long)sdc);
 
-	for (i = 0; i < NR_MAX_CHANNELS; i++) {
+	for (i = 0; i < sdc->cfg->nr_max_channels; i++) {
 		struct sun6i_pchan *pchan = &sdc->pchans[i];
 
 		pchan->idx = i;
 		pchan->base = sdc->base + 0x100 + i * 0x40;
 	}
 
-	for (i = 0; i < NR_MAX_VCHANS; i++) {
+	for (i = 0; i < sdc->cfg->nr_max_vchans; i++) {
 		struct sun6i_vchan *vchan = &sdc->vchans[i];
 
 		INIT_LIST_HEAD(&vchan->node);
@@ -1009,11 +1040,6 @@ static int sun6i_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id sun6i_dma_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-dma" },
-	{ /* sentinel */ }
-};
-
 static struct platform_driver sun6i_dma_driver = {
 	.probe		= sun6i_dma_probe,
 	.remove		= sun6i_dma_remove,
-- 
2.1.0
