From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 20 Jul 2018 09:51:48 +0200
Subject: [PATCH] ASoC: wm9712: fix replace codec to component
Message-ID: <20180720075148.14648-1-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
"wm9712-codec" got renamed to "wm9712-component", however, this change
never got propagated down to the actual board/platform drivers. E.g. on
Colibri T20 this lead to the following spew upon boot with sound/touch
being broken:

[    2.214121] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.222137] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.344384] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.351885] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.668339] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.675811] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.208408] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.216312] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.235397] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.248938] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[   14.970443] ALSA device list:
[   14.996628]   No soundcards found.

This commit finally fixes this again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/mach-pxa/tosa.c             | 2 +-
 arch/mips/alchemy/devboards/db1300.c | 2 +-
 drivers/mfd/wm97xx-core.c            | 6 +++---
 sound/soc/au1x/db1200.c              | 4 ++--
 sound/soc/fsl/pcm030-audio-fabric.c  | 6 +++---
 sound/soc/fsl/phycore-ac97.c         | 6 +++---
 sound/soc/pxa/e800_wm9712.c          | 4 ++--
 sound/soc/pxa/em-x270.c              | 4 ++--
 sound/soc/pxa/palm27x.c              | 4 ++--
 sound/soc/pxa/tosa.c                 | 4 ++--
 sound/soc/tegra/tegra_wm9712.c       | 4 ++--
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index cb5cd8e78c94..32011e600496 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -848,7 +848,7 @@ static struct platform_device sharpsl_rom_device = {
 };
 
 static struct platform_device wm9712_device = {
-	.name	= "wm9712-codec",
+	.name	= "wm9712-component",
 	.id	= -1,
 };
 
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index efb318e03e0a..841a27736eb1 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -638,7 +638,7 @@ static struct platform_device db1300_sd0_dev = {
 /**********************************************************************/
 
 static struct platform_device db1300_wm9715_dev = {
-	.name		= "wm9712-codec",
+	.name		= "wm9712-component",
 	.id		= 1,	/* ID of PSC for AC97 audio, see asoc glue! */
 };
 
diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index f5a8347f837f..9fec11fc0410 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -109,7 +109,7 @@ static const struct regmap_config wm9705_regmap_config = {
 };
 
 static struct mfd_cell wm9705_cells[] = {
-	{ .name = "wm9705-codec", },
+	{ .name = "wm9705-component", },
 	{ .name = "wm97xx-ts", },
 };
 
@@ -177,7 +177,7 @@ static const struct regmap_config wm9712_regmap_config = {
 };
 
 static struct mfd_cell wm9712_cells[] = {
-	{ .name = "wm9712-codec", },
+	{ .name = "wm9712-component", },
 	{ .name = "wm97xx-ts", },
 };
 
@@ -248,7 +248,7 @@ static const struct regmap_config wm9713_regmap_config = {
 };
 
 static struct mfd_cell wm9713_cells[] = {
-	{ .name = "wm9713-codec", },
+	{ .name = "wm9713-component", },
 	{ .name = "wm97xx-ts", },
 };
 
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 301e1fc9a377..d452478d62b4 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -52,7 +52,7 @@ static struct snd_soc_dai_link db1200_ac97_dai = {
 	.codec_dai_name	= "ac97-hifi",
 	.cpu_dai_name	= "au1xpsc_ac97.1",
 	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "ac97-codec.1",
+	.codec_name	= "ac97-component.1",
 };
 
 static struct snd_soc_card db1200_ac97_machine = {
@@ -68,7 +68,7 @@ static struct snd_soc_dai_link db1300_ac97_dai = {
 	.codec_dai_name	= "wm9712-hifi",
 	.cpu_dai_name	= "au1xpsc_ac97.1",
 	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "wm9712-codec.1",
+	.codec_name	= "wm9712-component.1",
 };
 
 static struct snd_soc_card db1300_ac97_machine = {
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index ec731223cab3..869f4b226ccd 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -33,14 +33,14 @@ static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 	.stream_name = "AC97 Analog",
 	.codec_dai_name = "wm9712-hifi",
 	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 },
 {
 	.name = "AC97.1",
 	.stream_name = "AC97 IEC958",
 	.codec_dai_name = "wm9712-aux",
 	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 },
 };
 
@@ -85,7 +85,7 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	if (ret)
 		dev_err(&op->dev, "request_module returned: %d\n", ret);
 
-	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
+	pdata->codec_device = platform_device_alloc("wm9712-component", -1);
 	if (!pdata->codec_device)
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
 
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index 66fb6c4614d2..dbd81d3b7c2c 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -30,8 +30,8 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 	{
 		.name		= "HiFi",
 		.stream_name	= "HiFi",
-		.codec_dai_name		= "wm9712-hifi",
-		.codec_name	= "wm9712-codec",
+		.codec_dai_name	= "wm9712-hifi",
+		.codec_name	= "wm9712-component",
 		.cpu_dai_name	= "imx-ssi.0",
 		.platform_name	= "imx-ssi.0",
 		.ops		= &imx_phycore_hifi_ops,
@@ -88,7 +88,7 @@ static int __init imx_phycore_init(void)
 	if (ret)
 		goto fail1;
 
-	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
+	imx_phycore_snd_device = platform_device_alloc("wm9712-component", -1);
 	if (!imx_phycore_snd_device) {
 		ret = -ENOMEM;
 		goto fail2;
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 1ed8aa2348f1..937746d1e23e 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -75,7 +75,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 	{
 		.name = "AC97 Aux",
@@ -83,7 +83,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 };
 
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index e046770ce70e..e958c4c241f6 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -37,7 +37,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 	{
 		.name = "AC97 Aux",
@@ -45,7 +45,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 };
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 97167048572d..040db695270e 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -93,7 +93,7 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 	.stream_name = "AC97 HiFi",
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name =  "wm9712-hifi",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.platform_name = "pxa-pcm-audio",
 	.init = palm27x_ac97_init,
 },
@@ -102,7 +102,7 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 	.stream_name = "AC97 Aux",
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.platform_name = "pxa-pcm-audio",
 },
 };
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index ae9c12e1ea2a..af42417ccec5 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -189,7 +189,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name = "wm9712-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.ops = &tosa_ops,
 },
 {
@@ -198,7 +198,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.ops = &tosa_ops,
 },
 };
diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
index 864a3345972e..aa12be76d15a 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -53,7 +53,7 @@ static struct snd_soc_dai_link tegra_wm9712_dai = {
 	.name = "AC97 HiFi",
 	.stream_name = "AC97 HiFi",
 	.codec_dai_name = "wm9712-hifi",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.init = tegra_wm9712_init,
 };
 
@@ -83,7 +83,7 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, machine);
 
-	machine->codec = platform_device_alloc("wm9712-codec", -1);
+	machine->codec = platform_device_alloc("wm9712-component", -1);
 	if (!machine->codec) {
 		dev_err(&pdev->dev, "Can't allocate wm9712 platform device\n");
 		return -ENOMEM;
-- 
2.14.4
