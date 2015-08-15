From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Sat, 15 Aug 2015 07:21:00 +0530
Subject: [PATCH] ASoC: rockchip: i2s: Adjust devm usage
Message-ID: <20150815015059.GA31009@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove use of snd_soc_unregister_component in remove function
as devm_snd_soc_register_component in probe function automatically
handles it.

Also, convert call of snd_dmaengine_pcm_register to managed resource
function devm_snd_dmaengine_pcm_register and remove usage of
snd_dmaengine_pcm_unregister in probe and remove functions.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index acb5be5..b936102 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -483,16 +483,14 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		goto err_pcm_register;
+		return ret;
 	}
 
 	return 0;
 
-err_pcm_register:
-	snd_dmaengine_pcm_unregister(&pdev->dev);
 err_suspend:
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
@@ -512,8 +510,6 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
1.9.1
