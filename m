From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 11:11:41 +0800
Subject: [PATCH v4 3/9] ASoC: rockchip: Use codec of_node and dai_name for
 rt5514 dsp
In-Reply-To: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
Message-ID: <20170818031147.16810-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are using codec name for rt5514 dsp dai link, use codec
of_node instead.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/rk3399_gru_sound.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 70876d3c34e6..9b7e28703bfb 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -242,8 +242,6 @@ enum {
 	DAILINK_RT5514_DSP,
 };
 
-#define DAILINK_ENTITIES	(DAILINK_DA7219 + 1)
-
 static struct snd_soc_dai_link rockchip_dailinks[] = {
 	[DAILINK_MAX98357A] = {
 		.name = "MAX98357A",
@@ -277,8 +275,7 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_dai_name = "rt5514-dsp-cpu-dai",
 	},
 };
 
@@ -295,17 +292,10 @@ static struct snd_soc_card rockchip_sound_card = {
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
@@ -314,7 +304,7 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < DAILINK_ENTITIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(rockchip_dailinks); i++) {
 		rockchip_dailinks[i].platform_of_node = cpu_node;
 		rockchip_dailinks[i].cpu_of_node = cpu_node;
 
@@ -327,26 +317,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
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
-	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.11.0
