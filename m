From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Aug 2017 20:29:24 +0100 (BST)
Subject: Applied "ASoC: rockchip: Use codec of_node and dai_name for rt5514
 dsp" to the asoc tree
In-Reply-To: <20170824045227.15504-2-jeffy.chen@rock-chips.com>
Message-ID: <20170829192924.CC5144400E7@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp

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

>From 72cfb0f20c75c1e580597c164b9d74426e583f37 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Thu, 24 Aug 2017 12:52:21 +0800
Subject: [PATCH] ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp

Currently we are using codec name for rt5514 dsp dai link, use codec
of_node instead.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 566ccb39fb31..cd2fdba922f1 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -247,8 +247,6 @@ enum {
 	DAILINK_RT5514_DSP,
 };
 
-#define DAILINK_ENTITIES	(DAILINK_DA7219 + 1)
-
 static struct snd_soc_dai_link rockchip_dailinks[] = {
 	[DAILINK_MAX98357A] = {
 		.name = "MAX98357A",
@@ -282,8 +280,7 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_dai_name = "rt5514-dsp-cpu-dai",
 	},
 };
 
@@ -300,17 +297,10 @@ static struct snd_soc_card rockchip_sound_card = {
 	.num_controls = ARRAY_SIZE(rockchip_controls),
 };
 
-static int rockchip_sound_match_stub(struct device *dev, void *data)
-{
-	return 1;
-}
-
 static int rockchip_sound_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &rockchip_sound_card;
 	struct device_node *cpu_node;
-	struct device *dev;
-	struct device_driver *drv;
 	int i, ret;
 
 	cpu_node = of_parse_phandle(pdev->dev.of_node, "rockchip,cpu", 0);
@@ -319,7 +309,7 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < DAILINK_ENTITIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(rockchip_dailinks); i++) {
 		rockchip_dailinks[i].platform_of_node = cpu_node;
 		rockchip_dailinks[i].cpu_of_node = cpu_node;
 
@@ -332,22 +322,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		}
 	}
 
-	/**
-	 * To acquire the spi driver of the rt5514 and set the dai-links names
-	 * for soc_bind_dai_link
-	 */
-	drv = driver_find("rt5514", &spi_bus_type);
-	if (!drv) {
-		dev_err(&pdev->dev, "Can not find the rt5514 driver at the spi bus\n");
-		return -EINVAL;
-	}
-
-	dev = driver_find_device(drv, NULL, NULL, rockchip_sound_match_stub);
-	if (!dev) {
-		dev_err(&pdev->dev, "Can not find the rt5514 device\n");
-		return -ENODEV;
-	}
-
 	/* Set DMIC wakeup delay */
 	ret = device_property_read_u32(&pdev->dev, "dmic-wakeup-delay-ms",
 					&dmic_wakeup_delay);
@@ -357,10 +331,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 			"no optional property 'dmic-wakeup-delay-ms' found, default: no delay\n");
 	}
 
-	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-
 	card->dev = &pdev->dev;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-- 
2.13.2
