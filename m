From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:29 +0100
Subject: [PATCH V3 02/15] ASoC: samsung: i2s: Add return value checks in
 probe()
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions may fail so let's properly report any errors.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e5473ee..aa52b41 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1173,11 +1173,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Unable to get drvdata\n");
 			return -EFAULT;
 		}
-		devm_snd_soc_register_component(&sec_dai->pdev->dev,
+		ret = devm_snd_soc_register_component(&sec_dai->pdev->dev,
 						&samsung_i2s_component,
 						&sec_dai->i2s_dai_drv, 1);
-		samsung_asoc_dma_platform_register(&pdev->dev);
-		return 0;
+		if (ret != 0)
+			return ret;
+
+		return samsung_asoc_dma_platform_register(&pdev->dev);
 	}
 
 	pri_dai = i2s_alloc_dai(pdev, false);
@@ -1290,7 +1292,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	if (ret != 0)
+		return ret;
 
 	return 0;
 err:
-- 
1.7.9.5
