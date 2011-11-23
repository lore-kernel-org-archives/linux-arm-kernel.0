From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:15 -0700
Subject: [PATCH 07/17] ASoC: Tegra DAS: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-8-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

module_platform_drive saves some boiler-plate code.

The devm_ APIs remove the need to manually clean up allocations,
thus removing some code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_das.c |   45 +++++++++---------------------------------
 1 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/sound/soc/tegra/tegra_das.c b/sound/soc/tegra/tegra_das.c
index 3b55a44..fa3a442 100644
--- a/sound/soc/tegra/tegra_das.c
+++ b/sound/soc/tegra/tegra_das.c
@@ -172,11 +172,11 @@ static int __devinit tegra_das_probe(struct platform_device *pdev)
 	if (das)
 		return -ENODEV;
 
-	das = kzalloc(sizeof(struct tegra_das), GFP_KERNEL);
+	das = devm_kzalloc(&pdev->dev, sizeof(struct tegra_das), GFP_KERNEL);
 	if (!das) {
 		dev_err(&pdev->dev, "Can't allocate tegra_das\n");
 		ret = -ENOMEM;
-		goto exit;
+		goto err;
 	}
 	das->dev = &pdev->dev;
 
@@ -184,22 +184,22 @@ static int __devinit tegra_das_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "No memory resource\n");
 		ret = -ENODEV;
-		goto err_free;
+		goto err;
 	}
 
-	region = request_mem_region(res->start, resource_size(res),
-					pdev->name);
+	region = devm_request_mem_region(&pdev->dev, res->start,
+					 resource_size(res), pdev->name);
 	if (!region) {
 		dev_err(&pdev->dev, "Memory region already claimed\n");
 		ret = -EBUSY;
-		goto err_free;
+		goto err;
 	}
 
-	das->regs = ioremap(res->start, resource_size(res));
+	das->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!das->regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err_release;
+		goto err;
 	}
 
 	tegra_das_debug_add(das);
@@ -208,32 +208,18 @@ static int __devinit tegra_das_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_release:
-	release_mem_region(res->start, resource_size(res));
-err_free:
-	kfree(das);
+err:
 	das = NULL;
-exit:
 	return ret;
 }
 
 static int __devexit tegra_das_remove(struct platform_device *pdev)
 {
-	struct resource *res;
-
 	if (!das)
 		return -ENODEV;
 
-	platform_set_drvdata(pdev, NULL);
-
 	tegra_das_debug_remove(das);
 
-	iounmap(das->regs);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	kfree(das);
 	das = NULL;
 
 	return 0;
@@ -246,18 +232,7 @@ static struct platform_driver tegra_das_driver = {
 		.name = DRV_NAME,
 	},
 };
-
-static int __init tegra_das_modinit(void)
-{
-	return platform_driver_register(&tegra_das_driver);
-}
-module_init(tegra_das_modinit);
-
-static void __exit tegra_das_modexit(void)
-{
-	platform_driver_unregister(&tegra_das_driver);
-}
-module_exit(tegra_das_modexit);
+module_platform_driver(tegra_das_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra DAS driver");
-- 
1.7.0.4
