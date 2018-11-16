From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:48:41 +0100
Subject: [PATCH v1 3/3] dmaengine: stm32-mdma: Add PM Runtime support
In-Reply-To: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1542372521-18073-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pm_runtime engine for clock management purpose

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-mdma.c | 52 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 390e4ca..ac0301b 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -37,6 +37,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -1456,15 +1457,13 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
 		return -ENOMEM;
 	}
 
-	ret = clk_prepare_enable(dmadev->clk);
-	if (ret < 0) {
-		dev_err(chan2dev(chan), "clk_prepare_enable failed: %d\n", ret);
+	ret = pm_runtime_get_sync(dmadev->ddev.dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32_mdma_disable_chan(chan);
 	if (ret < 0)
-		clk_disable_unprepare(dmadev->clk);
+		pm_runtime_put(dmadev->ddev.dev);
 
 	return ret;
 }
@@ -1484,7 +1483,7 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
 		spin_unlock_irqrestore(&chan->vchan.lock, flags);
 	}
 
-	clk_disable_unprepare(dmadev->clk);
+	pm_runtime_put(dmadev->ddev.dev);
 	vchan_free_chan_resources(to_virt_chan(c));
 	dmam_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
@@ -1597,6 +1596,12 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
+		return ret;
+	}
+
 	dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (!IS_ERR(dmadev->rst)) {
 		reset_control_assert(dmadev->rst);
@@ -1668,6 +1673,10 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dmadev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
 
 	dev_info(&pdev->dev, "STM32 MDMA driver registered\n");
 
@@ -1677,11 +1686,42 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int stm32_mdma_runtime_suspend(struct device *dev)
+{
+	struct stm32_mdma_device *dmadev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(dmadev->clk);
+
+	return 0;
+}
+
+static int stm32_mdma_runtime_resume(struct device *dev)
+{
+	struct stm32_mdma_device *dmadev = dev_get_drvdata(dev);
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
+static const struct dev_pm_ops stm32_mdma_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_mdma_runtime_suspend,
+			   stm32_mdma_runtime_resume, NULL)
+};
+
 static struct platform_driver stm32_mdma_driver = {
 	.probe = stm32_mdma_probe,
 	.driver = {
 		.name = "stm32-mdma",
 		.of_match_table = stm32_mdma_of_match,
+		.pm = &stm32_mdma_pm_ops,
 	},
 };
 
-- 
2.7.4
