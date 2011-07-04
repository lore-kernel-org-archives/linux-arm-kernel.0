From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  4 Jul 2011 21:18:29 +0900
Subject: [PATCH 1/7] DMA: PL330: Add support runtime PM for PL330 DMAC
In-Reply-To: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309781915-31549-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6abe1ec..7bd72e9 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl330.h>
+#include <linux/pm_runtime.h>
 
 #define NR_DEFAULT_DESC	16
 
@@ -666,6 +667,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	struct dma_device *pd;
 	struct resource *res;
 	int i, ret, irq;
+	struct clk* clk;
 
 	pdat = adev->dev.platform_data;
 
@@ -696,6 +698,28 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		goto probe_err1;
 	}
 
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
+	clk = clk_get(&adev->dev, "dma");
+
+	if (IS_ERR(clk)) {
+		dev_err(&adev->dev, "Cannot get operation clock.\n");
+		ret = -EINVAL;
+		goto probe_err1;
+	}
+	clk_enable(clk);
+#endif
+
 	irq = adev->irq[0];
 	ret = request_irq(irq, pl330_irq_handler, 0,
 			dev_name(&adev->dev), pi);
@@ -838,10 +862,47 @@ static struct amba_id pl330_ids[] = {
 	{ 0, 0 },
 };
 
+#ifdef CONFIG_PM_RUNTIME
+static int pl330_runtime_suspend(struct device *dev)
+{
+	struct clk *dmaclk = clk_get(dev, "dma");
+
+	if (dmaclk == NULL) {
+		dev_err(dev, "failed to find dma clock source\n");
+		return -ENODEV;
+	}
+
+	clk_disable(dmaclk);
+	return 0;
+}
+
+static int pl330_runtime_resume(struct device *dev)
+{
+	struct clk *dmaclk = clk_get(dev, "dma");
+
+	if (dmaclk == NULL) {
+		dev_err(dev, "failed to find dma clock source\n");
+		return -ENODEV;
+	}
+
+	clk_enable(dmaclk);
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
