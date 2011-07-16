From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 15:44:14 +0900
Subject: [PATCH V3 01/13] DMA: PL330: Add support runtime PM for PL330 DMAC
In-Reply-To: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
References: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1310798666-7659-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6abe1ec..39e9ffd 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl330.h>
+#include <linux/pm_runtime.h>
 
 #define NR_DEFAULT_DESC	16
 
@@ -83,6 +84,8 @@ struct dma_pl330_dmac {
 
 	/* Peripheral channels connected to this DMAC */
 	struct dma_pl330_chan peripherals[0]; /* keep at end */
+
+	struct clk *clk;
 };
 
 struct dma_pl330_desc {
@@ -688,7 +691,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pi->mcbufsz = pdat->mcbuf_sz;
 
 	res = &adev->res;
-	request_mem_region(res->start, resource_size(res), "dma-pl330");
+	request_mem_region(res->start,
+		resource_size(res), dev_name(&adev->dev));
 
 	pi->base = ioremap(res->start, resource_size(res));
 	if (!pi->base) {
@@ -696,6 +700,30 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		goto probe_err1;
 	}
 
+	pdmac->clk = clk_get(&adev->dev, "dma");
+	if (IS_ERR(pdmac->clk)) {
+		dev_err(&adev->dev, "Cannot get operation clock.\n");
+		ret = -EINVAL;
+		goto probe_err1;
+	}
+
+	amba_set_drvdata(adev, pdmac);
+
+#ifdef CONFIG_PM_RUNTIME
+	/* to use the runtime PM helper functions */
+	pm_runtime_enable(&adev->dev);
+
+	/* enable the power domain */
+	if (pm_runtime_get_sync(&adev->dev)) {
+		dev_err(&adev->dev, "failed to get runtime pm\n");
+		ret = -ENODEV;
+		goto probe_err1;
+	}
+#else
+	/* enable dma clk */
+	clk_enable(pdmac->clk);
+#endif
+
 	irq = adev->irq[0];
 	ret = request_irq(irq, pl330_irq_handler, 0,
 			dev_name(&adev->dev), pi);
@@ -763,8 +791,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		goto probe_err4;
 	}
 
-	amba_set_drvdata(adev, pdmac);
-
 	dev_info(&adev->dev,
 		"Loaded driver for PL330 DMAC-%d\n", adev->periphid);
 	dev_info(&adev->dev,
@@ -825,6 +851,13 @@ static int __devexit pl330_remove(struct amba_device *adev)
 	res = &adev->res;
 	release_mem_region(res->start, resource_size(res));
 
+#ifdef CONFIG_PM_RUNTIME
+	pm_runtime_put(&adev->dev);
+	pm_runtime_disable(&adev->dev);
+#else
+	clk_disable(pdmac->clk);
+#endif
+
 	kfree(pdmac);
 
 	return 0;
@@ -838,10 +871,49 @@ static struct amba_id pl330_ids[] = {
 	{ 0, 0 },
 };
 
+#ifdef CONFIG_PM_RUNTIME
+static int pl330_runtime_suspend(struct device *dev)
+{
+	struct dma_pl330_dmac *pdmac = dev_get_drvdata(dev);
+
+	if (!pdmac) {
+		dev_err(dev, "failed to get dmac\n");
+		return -ENODEV;
+	}
+
+	clk_disable(pdmac->clk);
+
+	return 0;
+}
+
+static int pl330_runtime_resume(struct device *dev)
+{
+	struct dma_pl330_dmac *pdmac = dev_get_drvdata(dev);
+
+	if (!pdmac) {
+		dev_err(dev, "failed to get dmac\n");
+		return -ENODEV;
+	}
+
+	clk_enable(pdmac->clk);
+
+	return 0;
+}
+#else
+#define pl330_runtime_suspend	NULL
+#define pl330_runtime_resume	NULL
+#endif /* CONFIG_PM_RUNTIME */
+
+static const struct dev_pm_ops pl330_pm_ops = {
+	.runtime_suspend = pl330_runtime_suspend,
+	.runtime_resume = pl330_runtime_resume,
+};
+
 static struct amba_driver pl330_driver = {
 	.drv = {
 		.owner = THIS_MODULE,
 		.name = "dma-pl330",
+		.pm = &pl330_pm_ops,
 	},
 	.id_table = pl330_ids,
 	.probe = pl330_probe,
-- 
1.7.1
