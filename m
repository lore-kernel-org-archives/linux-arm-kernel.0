From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:48:39 +0100
Subject: [PATCH v1 1/3] dmaengine: stm32-dma: Add PM Runtime support
In-Reply-To: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1542372521-18073-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pm_runtime engine for clock management purpose.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 58 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 48f7c0f..ba239b5 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -1115,15 +1116,14 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
 	int ret;
 
 	chan->config_init = false;
-	ret = clk_prepare_enable(dmadev->clk);
-	if (ret < 0) {
-		dev_err(chan2dev(chan), "clk_prepare_enable failed: %d\n", ret);
+
+	ret = pm_runtime_get_sync(dmadev->ddev.dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32_dma_disable_chan(chan);
 	if (ret < 0)
-		clk_disable_unprepare(dmadev->clk);
+		pm_runtime_put(dmadev->ddev.dev);
 
 	return ret;
 }
@@ -1143,7 +1143,7 @@ static void stm32_dma_free_chan_resources(struct dma_chan *c)
 		spin_unlock_irqrestore(&chan->vchan.lock, flags);
 	}
 
-	clk_disable_unprepare(dmadev->clk);
+	pm_runtime_put(dmadev->ddev.dev);
 
 	vchan_free_chan_resources(to_virt_chan(c));
 }
@@ -1243,6 +1243,12 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(dmadev->clk);
 	}
 
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
+		return ret;
+	}
+
 	dmadev->mem2mem = of_property_read_bool(pdev->dev.of_node,
 						"st,mem2mem");
 
@@ -1292,7 +1298,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto clk_free;
 
 	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
 		chan = &dmadev->chan[i];
@@ -1324,20 +1330,58 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmadev);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
+
 	dev_info(&pdev->dev, "STM32 DMA driver registered\n");
 
 	return 0;
 
 err_unregister:
 	dma_async_device_unregister(dd);
+clk_free:
+	clk_disable_unprepare(dmadev->clk);
 
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int stm32_dma_runtime_suspend(struct device *dev)
+{
+	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(dmadev->clk);
+
+	return 0;
+}
+
+static int stm32_dma_runtime_resume(struct device *dev)
+{
+	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare_enable clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32_dma_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_dma_runtime_suspend,
+			   stm32_dma_runtime_resume, NULL)
+};
+
 static struct platform_driver stm32_dma_driver = {
 	.driver = {
 		.name = "stm32-dma",
 		.of_match_table = stm32_dma_of_match,
+		.pm = &stm32_dma_pm_ops,
 	},
 };
 
-- 
2.7.4
