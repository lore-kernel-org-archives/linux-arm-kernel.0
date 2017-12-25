From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 25 Dec 2017 16:28:45 +0800
Subject: [PATCH 1/4] ASoC: mediatek: fix error handling in
 mt2701_afe_pcm_dev_probe()
Message-ID: <18b7f0ec484300af795b1873efab96e51393459c.1514190169.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix unbalanced error handling path which will get incorrect counts
if probe failed. The .remove() should be adjusted accordingly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 8fda182..b3f6f73 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1591,8 +1591,12 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, afe);
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		goto err_pm_disable;
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = mt2701_afe_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
 	pm_runtime_get_sync(&pdev->dev);
 
 	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
@@ -1610,16 +1614,12 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_dai_component;
 	}
 
-	mt2701_afe_runtime_resume(&pdev->dev);
-
 	return 0;
 
 err_dai_component:
-	snd_soc_unregister_component(&pdev->dev);
-
-err_platform:
 	snd_soc_unregister_platform(&pdev->dev);
-
+err_platform:
+	pm_runtime_put_sync(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 
@@ -1628,17 +1628,14 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 
 static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
-
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
-	/* disable afe clock */
-	mt2701_afe_disable_clock(afe);
+
 	return 0;
 }
 
-- 
1.9.1
