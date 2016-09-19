From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 19 Sep 2016 22:29:39 +0800
Subject: [PATCH] ASoC: rk3399_gru_sound: fix recording pop at first attempt
Message-ID: <1474295379-16936-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wonjoon Lee <woojoo.lee@samsung.com>

Pop happens when mclk applied but dmic's own boot-time
Specify dmic delay times in dt to make sure
clocks are ready earlier than dmic working

Signed-off-by: Wonjoon Lee <woojoo.lee@samsung.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |    6 ++++++
 sound/soc/rockchip/rk3399_gru_sound.c              |   14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index f19b6c8..b7dd3ab 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -6,6 +6,12 @@ Required properties:
   connected to the codecs
 - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
 
+Optional properties:
+- dmic-delay : specify delay time for DMIC ready.
+  If this option is specified, which means it's required dmic need
+  delay for DMIC to ready so that rt5514 can avoid recording before
+  DMIC send valid data
+
 Example:
 
 sound {
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 164b6da..6ab838b 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -37,6 +37,8 @@
 
 #define SOUND_FS	256
 
+unsigned int rt5514_dmic_delay;
+
 static struct snd_soc_jack rockchip_sound_jack;
 
 static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
@@ -122,6 +124,9 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Wait for DMIC stable */
+	msleep(rt5514_dmic_delay);
+
 	return 0;
 }
 
@@ -334,6 +339,15 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* Set DMIC delay */
+	ret = device_property_read_u32(&pdev->dev, "dmic-delay",
+					&rt5514_dmic_delay);
+	if (ret) {
+		rt5514_dmic_delay = 0;
+		dev_dbg(&pdev->dev,
+			"no optional property 'dmic-delay' found, default: no delay\n");
+	}
+
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-- 
1.7.9.5
