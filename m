From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:21 -0700
Subject: [PATCH 13/17] ASoC: Tegra TrimSlice machine: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-14-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

module_platform_drive saves some boiler-plate code.

The devm_ APIs remove the need to manually clean up allocations,
thus removing some code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/trimslice.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 2699a6f..d564b40 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -170,15 +170,17 @@ static __devinit int tegra_snd_trimslice_probe(struct platform_device *pdev)
 	struct tegra_trimslice *trimslice;
 	int ret;
 
-	trimslice = kzalloc(sizeof(struct tegra_trimslice), GFP_KERNEL);
+	trimslice = devm_kzalloc(&pdev->dev, sizeof(struct tegra_trimslice),
+				 GFP_KERNEL);
 	if (!trimslice) {
 		dev_err(&pdev->dev, "Can't allocate tegra_trimslice\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	ret = tegra_asoc_utils_init(&trimslice->util_data, &pdev->dev);
 	if (ret)
-		goto err_free_trimslice;
+		goto err;
 
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
@@ -195,8 +197,7 @@ static __devinit int tegra_snd_trimslice_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&trimslice->util_data);
-err_free_trimslice:
-	kfree(trimslice);
+err:
 	return ret;
 }
 
@@ -209,8 +210,6 @@ static int __devexit tegra_snd_trimslice_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&trimslice->util_data);
 
-	kfree(trimslice);
-
 	return 0;
 }
 
@@ -222,18 +221,7 @@ static struct platform_driver tegra_snd_trimslice_driver = {
 	.probe = tegra_snd_trimslice_probe,
 	.remove = __devexit_p(tegra_snd_trimslice_remove),
 };
-
-static int __init snd_tegra_trimslice_init(void)
-{
-	return platform_driver_register(&tegra_snd_trimslice_driver);
-}
-module_init(snd_tegra_trimslice_init);
-
-static void __exit snd_tegra_trimslice_exit(void)
-{
-	platform_driver_unregister(&tegra_snd_trimslice_driver);
-}
-module_exit(snd_tegra_trimslice_exit);
+module_platform_driver(tegra_snd_trimslice_driver);
 
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
 MODULE_DESCRIPTION("Trimslice machine ASoC driver");
-- 
1.7.0.4
