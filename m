From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 11:11:40 +0800
Subject: [PATCH v4 2/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Message-ID: <20170818031147.16810-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is no longer used.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../bindings/sound/rockchip,rk3399-gru-sound.txt           |  7 -------
 sound/soc/rockchip/rk3399_gru_sound.c                      | 14 --------------
 2 files changed, 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index eac91db07178..f19b6c830a34 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -6,17 +6,10 @@ Required properties:
   connected to the codecs
 - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
 
-Optional properties:
-- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
-  If this option is specified, which means it's required dmic need
-  delay for DMIC to ready so that rt5514 can avoid recording before
-  DMIC send valid data
-
 Example:
 
 sound {
 	compatible = "rockchip,rk3399-gru-sound";
 	rockchip,cpu = <&i2s0>;
 	rockchip,codec = <&max98357a &rt5514 &da7219>;
-	dmic-wakeup-delay-ms = <20>;
 };
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3475c61a5fa0..70876d3c34e6 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,8 +38,6 @@
 
 #define SOUND_FS	256
 
-static unsigned int rt5514_dmic_delay;
-
 static struct snd_soc_jack rockchip_sound_jack;
 
 static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
@@ -125,9 +123,6 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* Wait for DMIC stable */
-	msleep(rt5514_dmic_delay);
-
 	return 0;
 }
 
@@ -348,15 +343,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Set DMIC delay */
-	ret = device_property_read_u32(&pdev->dev, "dmic-delay",
-					&rt5514_dmic_delay);
-	if (ret) {
-		rt5514_dmic_delay = 0;
-		dev_dbg(&pdev->dev,
-			"no optional property 'dmic-delay' found, default: no delay\n");
-	}
-
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-- 
2.11.0
