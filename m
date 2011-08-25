From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 25 Aug 2011 11:13:31 +0900
Subject: [PATCH v7 01/15] DMA: PL330: Add support runtime PM for PL330 DMAC
In-Reply-To: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314238425-6480-2-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 00eee59..0b99af1 100644
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
 	struct dma_pl330_chan *peripherals; /* keep at end */
+
+	struct clk *clk;
 };
 
 struct dma_pl330_desc {
@@ -696,6 +699,30 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -771,8 +798,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		goto probe_err4;
 	}
 
-	amba_set_drvdata(adev, pdmac);
-
 	dev_info(&adev->dev,
 		"Loaded driver for PL330 DMAC-%d\n", adev->periphid);
 	dev_info(&adev->dev,
@@ -833,6 +858,13 @@ static int __devexit pl330_remove(struct amba_device *adev)
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
@@ -846,10 +878,49 @@ static struct amba_id pl330_ids[] = {
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
