From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Sep 2016 09:15:42 -0700
Subject: Applied "ASoC: rk3399_gru_sound: fix recording pop at first attempt"
 to the asoc tree
In-Reply-To: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <E1boYZC-0005RL-8m@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rk3399_gru_sound: fix recording pop at first attempt

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3a6f9dce6116cc54e31dc10d176ceecb1a7e4e7f Mon Sep 17 00:00:00 2001
From: Wonjoon Lee <woojoo.lee@samsung.com>
Date: Thu, 22 Sep 2016 21:50:06 +0800
Subject: [PATCH] ASoC: rk3399_gru_sound: fix recording pop at first attempt

Pop happens when mclk applied but dmic's own boot-time
Specify dmic delay times in dt to make sure
clocks are ready earlier than dmic working

Signed-off-by: Wonjoon Lee <woojoo.lee@samsung.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/rockchip,rk3399-gru-sound.txt           |  7 +++++++
 sound/soc/rockchip/rk3399_gru_sound.c                      | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index f19b6c830a34..eac91db07178 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -6,10 +6,17 @@ Required properties:
   connected to the codecs
 - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
 
+Optional properties:
+- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
+  If this option is specified, which means it's required dmic need
+  delay for DMIC to ready so that rt5514 can avoid recording before
+  DMIC send valid data
+
 Example:
 
 sound {
 	compatible = "rockchip,rk3399-gru-sound";
 	rockchip,cpu = <&i2s0>;
 	rockchip,codec = <&max98357a &rt5514 &da7219>;
+	dmic-wakeup-delay-ms = <20>;
 };
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index ee0648927afc..9ed735a6cf49 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,6 +38,8 @@
 
 #define SOUND_FS	256
 
+unsigned int rt5514_dmic_delay;
+
 static struct snd_soc_jack rockchip_sound_jack;
 
 static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
@@ -123,6 +125,9 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Wait for DMIC stable */
+	msleep(rt5514_dmic_delay);
+
 	return 0;
 }
 
@@ -343,6 +348,15 @@ static int rockchip_sound_probe(struct platform_device *pdev)
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
2.9.3
