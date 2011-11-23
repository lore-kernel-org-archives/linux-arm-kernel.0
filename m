From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:16 -0700
Subject: [PATCH 08/17] ASoC: Tegra I2S: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-9-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

module_platform_drive saves some boiler-plate code.

The devm_ APIs remove the need to manually clean up allocations,
thus removing some code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_i2s.c |   45 +++++++++---------------------------------
 1 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
index 33e62fc..76014f0 100644
--- a/sound/soc/tegra/tegra_i2s.c
+++ b/sound/soc/tegra/tegra_i2s.c
@@ -362,11 +362,11 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	i2s = kzalloc(sizeof(struct tegra_i2s), GFP_KERNEL);
+	i2s = devm_kzalloc(&pdev->dev, sizeof(struct tegra_i2s), GFP_KERNEL);
 	if (!i2s) {
 		dev_err(&pdev->dev, "Can't allocate tegra_i2s\n");
 		ret = -ENOMEM;
-		goto exit;
+		goto err;
 	}
 	dev_set_drvdata(&pdev->dev, i2s);
 
@@ -374,7 +374,7 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(i2s->clk_i2s)) {
 		dev_err(&pdev->dev, "Can't retrieve i2s clock\n");
 		ret = PTR_ERR(i2s->clk_i2s);
-		goto err_free;
+		goto err;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -391,19 +391,19 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 		goto err_clk_put;
 	}
 
-	memregion = request_mem_region(mem->start, resource_size(mem),
-					DRV_NAME);
+	memregion = devm_request_mem_region(&pdev->dev, mem->start,
+					    resource_size(mem), DRV_NAME);
 	if (!memregion) {
 		dev_err(&pdev->dev, "Memory region already claimed\n");
 		ret = -EBUSY;
 		goto err_clk_put;
 	}
 
-	i2s->regs = ioremap(mem->start, resource_size(mem));
+	i2s->regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 	if (!i2s->regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err_release;
+		goto err_clk_put;
 	}
 
 	i2s->capture_dma_data.addr = mem->start + TEGRA_I2S_FIFO2;
@@ -422,43 +422,29 @@ static __devinit int tegra_i2s_platform_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
-		goto err_unmap;
+		goto err_clk_put;
 	}
 
 	tegra_i2s_debug_add(i2s, pdev->id);
 
 	return 0;
 
-err_unmap:
-	iounmap(i2s->regs);
-err_release:
-	release_mem_region(mem->start, resource_size(mem));
 err_clk_put:
 	clk_put(i2s->clk_i2s);
-err_free:
-	kfree(i2s);
-exit:
+err:
 	return ret;
 }
 
 static int __devexit tegra_i2s_platform_remove(struct platform_device *pdev)
 {
 	struct tegra_i2s *i2s = dev_get_drvdata(&pdev->dev);
-	struct resource *res;
 
 	snd_soc_unregister_dai(&pdev->dev);
 
 	tegra_i2s_debug_remove(i2s);
 
-	iounmap(i2s->regs);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	clk_put(i2s->clk_i2s);
 
-	kfree(i2s);
-
 	return 0;
 }
 
@@ -470,18 +456,7 @@ static struct platform_driver tegra_i2s_driver = {
 	.probe = tegra_i2s_platform_probe,
 	.remove = __devexit_p(tegra_i2s_platform_remove),
 };
-
-static int __init snd_tegra_i2s_init(void)
-{
-	return platform_driver_register(&tegra_i2s_driver);
-}
-module_init(snd_tegra_i2s_init);
-
-static void __exit snd_tegra_i2s_exit(void)
-{
-	platform_driver_unregister(&tegra_i2s_driver);
-}
-module_exit(snd_tegra_i2s_exit);
+module_platform_driver(tegra_i2s_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra I2S ASoC driver");
-- 
1.7.0.4
