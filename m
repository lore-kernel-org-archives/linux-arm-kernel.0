From: stefan@agner.ch (Stefan Agner)
Date: Mon,  4 Apr 2016 22:28:35 -0700
Subject: [PATCH v3 3/9] drm/fsl-dcu: disable clock on initialization failure
 and remove
In-Reply-To: <1459834121-25997-1-git-send-email-stefan@agner.ch>
References: <1459834121-25997-1-git-send-email-stefan@agner.ch>
Message-ID: <1459834121-25997-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix error handling during probe by reordering initialization and
adding a error path which disables clock again. Also disable the
clock on remove.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 44 +++++++++++++++----------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index e8d9337..f2a9c1b 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -290,6 +290,11 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	if (!fsl_dev)
 		return -ENOMEM;
 
+	id = of_match_node(fsl_dcu_of_match, pdev->dev.of_node);
+	if (!id)
+		return -ENODEV;
+	fsl_dev->soc = id->data;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "could not get memory IO resource\n");
@@ -308,39 +313,29 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
+			&fsl_dcu_regmap_config);
+	if (IS_ERR(fsl_dev->regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(fsl_dev->regmap);
+	}
+
 	fsl_dev->clk = devm_clk_get(dev, "dcu");
 	if (IS_ERR(fsl_dev->clk)) {
-		ret = PTR_ERR(fsl_dev->clk);
 		dev_err(dev, "failed to get dcu clock\n");
-		return ret;
-	}
-	ret = clk_prepare(fsl_dev->clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to prepare dcu clk\n");
-		return ret;
+		return PTR_ERR(fsl_dev->clk);
 	}
-	ret = clk_enable(fsl_dev->clk);
+	ret = clk_prepare_enable(fsl_dev->clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable dcu clk\n");
-		clk_unprepare(fsl_dev->clk);
 		return ret;
 	}
 
-	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
-			&fsl_dcu_regmap_config);
-	if (IS_ERR(fsl_dev->regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(fsl_dev->regmap);
-	}
-
-	id = of_match_node(fsl_dcu_of_match, pdev->dev.of_node);
-	if (!id)
-		return -ENODEV;
-	fsl_dev->soc = id->data;
-
 	drm = drm_dev_alloc(driver, dev);
-	if (!drm)
-		return -ENOMEM;
+	if (!drm) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
 
 	fsl_dev->dev = dev;
 	fsl_dev->drm = drm;
@@ -360,6 +355,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 
 unref:
 	drm_dev_unref(drm);
+disable_clk:
+	clk_disable_unprepare(fsl_dev->clk);
 	return ret;
 }
 
@@ -367,6 +364,7 @@ static int fsl_dcu_drm_remove(struct platform_device *pdev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(fsl_dev->clk);
 	drm_put_dev(fsl_dev->drm);
 
 	return 0;
-- 
2.7.4
