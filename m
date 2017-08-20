From: dolinux.peng@gmail.com (Peng Donglin)
Date: Sun, 20 Aug 2017 13:25:46 +0800
Subject: [PATCH 06/12] ASoC: rockchip: Remove unnecessary function call
Message-ID: <1503206746-15555-1-git-send-email-dolinux.peng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First of all,the address of pdev->dev is assigned to card->dev,then
the function platform_set_drvdata copies the value the variable card
to pdev->dev.driver_data, but when calling snd_soc_register_card,the
function dev_set_drvdata(card->dev, card) will also do the same copy
operation,so i think that the former copy operation can be removed.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 2 --
 sound/soc/rockchip/rk3399_gru_sound.c   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index dbc53e4..37ef162 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -272,8 +272,6 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, card);
-
 	return ret;
 }
 
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3475c61..70c0908 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -362,7 +362,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 
 	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-- 
1.9.1
