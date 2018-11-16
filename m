From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:48:40 +0100
Subject: [PATCH v1 2/3] dmaengine: stm32-dmamux: Add PM Runtime support
In-Reply-To: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542372521-18073-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1542372521-18073-3-git-send-email-pierre-yves.mordret@st.com>
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
 drivers/dma/stm32-dmamux.c | 58 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index b922db9..a671191 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -79,8 +80,7 @@ static void stm32_dmamux_free(struct device *dev, void *route_data)
 	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 
-	if (!IS_ERR(dmamux->clk))
-		clk_disable(dmamux->clk);
+	pm_runtime_put_sync(dev);
 
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -146,13 +146,10 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	/* Set dma request */
 	spin_lock_irqsave(&dmamux->lock, flags);
-	if (!IS_ERR(dmamux->clk)) {
-		ret = clk_enable(dmamux->clk);
-		if (ret < 0) {
-			spin_unlock_irqrestore(&dmamux->lock, flags);
-			dev_err(&pdev->dev, "clk_prep_enable issue: %d\n", ret);
-			goto error;
-		}
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
+		goto error;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -254,6 +251,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "DMAMUX defaulting on %u requests\n",
 			 stm32_dmamux->dmamux_requests);
 	}
+	pm_runtime_get_noresume(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iomem = devm_ioremap_resource(&pdev->dev, res);
@@ -282,6 +280,8 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	stm32_dmamux->dmarouter.route_free = stm32_dmamux_free;
 
 	platform_set_drvdata(pdev, stm32_dmamux);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	if (!IS_ERR(stm32_dmamux->clk)) {
 		ret = clk_prepare_enable(stm32_dmamux->clk);
@@ -291,17 +291,52 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+
 	/* Reset the dmamux */
 	for (i = 0; i < stm32_dmamux->dma_requests; i++)
 		stm32_dmamux_write(stm32_dmamux->iomem, STM32_DMAMUX_CCR(i), 0);
 
-	if (!IS_ERR(stm32_dmamux->clk))
-		clk_disable(stm32_dmamux->clk);
+	pm_runtime_put(&pdev->dev);
 
 	return of_dma_router_register(node, stm32_dmamux_route_allocate,
 				     &stm32_dmamux->dmarouter);
 }
 
+#ifdef CONFIG_PM
+static int stm32_dmamux_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(stm32_dmamux->clk);
+
+	return 0;
+}
+
+static int stm32_dmamux_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_prepare_enable(stm32_dmamux->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare_enable clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32_dmamux_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_dmamux_runtime_suspend,
+			   stm32_dmamux_runtime_resume, NULL)
+};
+
 static const struct of_device_id stm32_dmamux_match[] = {
 	{ .compatible = "st,stm32h7-dmamux" },
 	{},
@@ -312,6 +347,7 @@ static struct platform_driver stm32_dmamux_driver = {
 	.driver = {
 		.name = "stm32-dmamux",
 		.of_match_table = stm32_dmamux_match,
+		.pm = &stm32_dmamux_pm_ops,
 	},
 };
 
-- 
2.7.4
