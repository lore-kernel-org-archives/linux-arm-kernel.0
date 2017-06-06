From: broonie@kernel.org (Mark Brown)
Date: Tue, 06 Jun 2017 20:06:11 +0100
Subject: Applied "ASoC: sun8i-codec-analog: add support for V3s SoC" to the
 asoc tree
In-Reply-To: <20170524100607.29790-4-icenowy@aosc.io>
Message-ID: <E1dIJnv-0007Et-Bs@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec-analog: add support for V3s SoC

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

>From 2cfeaec0ec896bc0b8aad2de28a3de4572c7e4a1 Mon Sep 17 00:00:00 2001
From: Icenowy Zheng <icenowy@aosc.xyz>
Date: Mon, 5 Jun 2017 21:27:21 +0800
Subject: [PATCH] ASoC: sun8i-codec-analog: add support for V3s SoC

The V3s SoC features an analog codec with headphone support but without
mic2 and linein.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt | 1 +
 sound/soc/sunxi/sun8i-codec-analog.c                           | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
index 779b735781ba..1b6e7c4e50ab 100644
--- a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: must be one of the following compatibles:
 		- "allwinner,sun8i-a23-codec-analog"
 		- "allwinner,sun8i-h3-codec-analog"
+		- "allwinner,sun8i-v3s-codec-analog"
 
 Required properties if not a sub-node of the PRCM node:
 - reg: must contain the registers location and length
diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 29c446068151..485e79f292c4 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -810,6 +810,11 @@ static int sun8i_codec_analog_add_mixer(struct snd_soc_component *cmpnt,
 	return 0;
 }
 
+static const struct sun8i_codec_analog_quirks sun8i_v3s_quirks = {
+	.has_headphone	= true,
+	.has_hmic	= true,
+};
+
 static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 {
 	struct device *dev = cmpnt->dev;
@@ -886,6 +891,10 @@ static const struct of_device_id sun8i_codec_analog_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-codec-analog",
 		.data = &sun8i_h3_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-v3s-codec-analog",
+		.data = &sun8i_v3s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun8i_codec_analog_of_match);
-- 
2.11.0
