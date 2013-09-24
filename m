From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 24 Sep 2013 12:41:22 +0200
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
Message-ID: <20130924124122.64834b2a@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds S/PDIF input/output for mvebu DT boards.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/sound/mvebu-audio.txt |  23 +++++
 sound/soc/kirkwood/kirkwood-i2s.c                       | 128 ++++++++++++++++----------
 sound/soc/kirkwood/kirkwood.h                           |   2 +
 3 files changed, 102 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
index f0062c5..c19a5d3 100644
--- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -22,6 +22,27 @@ Required properties:
 	"internal" for the internal clock
 	"extclk" for the external clock
 
+Optional properties:
+
+- i2s-out: This is a boolean property. If present, the transmitting
+  function of I2S will be enabled, indicating the I2S is connected
+  to some IP block, such as an HDMI encoder/display-controller.
+
+- i2s-in: This is a boolean property. If present, the receiving
+  function of I2S will be enabled, indicating the I2S is connected
+  to some IP block, such as an HDMI encoder/display-controller.
+
+- spdif-out: This is a boolean property. If present, the transmitting
+  function of S/PDIF will be enabled, indicating there's a physical
+  S/PDIF out connector/jack on the board or it's connecting to some
+  other IP block, such as an HDMI encoder/display-controller.
+
+- spdif-in: This is a boolean property. If present, the receiving
+  function of S/PDIF will be enabled, indicating there's a physical
+  S/PDIF in connector/jack on the board.
+
+* Note: At least one of these four properties should be set in the DT binding.
+
 Example:
 
 i2s1: audio-controller at b4000 {
@@ -30,4 +51,6 @@ i2s1: audio-controller at b4000 {
 	interrupts = <21>, <22>;
 	clocks = <&gate_clk 13>;
 	clock-names = "internal";
+	i2s-out;
+	spdif-out;
 };
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0f3d73d..c62c7fa 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -160,9 +160,11 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
 		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C |
-			  KIRKWOOD_RECCTL_I2S_EN;
+			  KIRKWOOD_RECCTL_I2S_EN |
+			  KIRKWOOD_RECCTL_SPDIF_EN;
 		break;
 	/*
 	 * doesn't work... S20_3LE != kirkwood 20bit format ?
@@ -178,9 +180,11 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_24;
 		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 |
-			  KIRKWOOD_RECCTL_I2S_EN;
+			  KIRKWOOD_RECCTL_I2S_EN |
+			  KIRKWOOD_PLAYCTL_I2S_EN;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_32;
@@ -253,12 +257,14 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
 		/* enable playback */
+		ctl &= priv->ctl_play_mask;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
-		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
@@ -272,13 +278,15 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
+		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE);
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
@@ -301,7 +309,8 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
 		ctl = priv->ctl_rec;
-		value = ctl & ~KIRKWOOD_RECCTL_I2S_EN;
+		value = ctl & ~(KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN);
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 
 		/* enable interrupts */
@@ -310,6 +319,7 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
 
 		/* enable record */
+		ctl &= priv->ctl_rec_mask;
 		writel(ctl, priv->io + KIRKWOOD_RECCTL);
 		break;
 
@@ -404,55 +414,75 @@ static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
+static const struct snd_soc_component_driver kirkwood_i2s_component = {
+	.name		= DRV_NAME,
+};
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai = {
-	.probe = kirkwood_i2s_probe,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.capture = {
+static int kirkwood_register_component(struct device *dev,
+					struct kirkwood_dma_data *priv)
+{
+	struct device_node *np = dev->of_node;
+	uint32_t ctl_play_mask = ~(KIRKWOOD_PLAYCTL_I2S_EN |
+				KIRKWOOD_PLAYCTL_SPDIF_EN);
+	uint32_t ctl_rec_mask = ~(KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN);
+	int ret;
+
+	static const struct snd_soc_pcm_stream stream = {
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
 		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-};
+	};
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
-	.probe = kirkwood_i2s_probe,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-};
+	if (np) {
+		if (of_property_read_bool(np, "i2s-in"))
+			ctl_rec_mask |= KIRKWOOD_RECCTL_I2S_EN;
+		if (of_property_read_bool(np, "i2s-out"))
+			ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
+		if (of_property_read_bool(np, "spdif-in"))
+			ctl_rec_mask |= KIRKWOOD_RECCTL_SPDIF_EN;
+		if (of_property_read_bool(np, "spdif-out"))
+			ctl_play_mask |= KIRKWOOD_PLAYCTL_SPDIF_EN;
+	} else {
+		ctl_rec_mask |= KIRKWOOD_RECCTL_I2S_EN;
+		ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
+	}
+	priv->ctl_play_mask = ctl_play_mask;
+	priv->ctl_rec_mask = ctl_rec_mask;
+
+	priv->soc_dai.probe = kirkwood_i2s_probe;
+	priv->soc_dai.ops = &kirkwood_i2s_dai_ops;
+	if (ctl_play_mask & (KIRKWOOD_PLAYCTL_I2S_EN |
+				KIRKWOOD_PLAYCTL_SPDIF_EN)) {
+		memcpy(&priv->soc_dai.playback, &stream,
+			sizeof priv->soc_dai.playback);
+		if (!IS_ERR(priv->extclk))
+			priv->soc_dai.playback.rates = SNDRV_PCM_RATE_8000_192000 |
+						SNDRV_PCM_RATE_CONTINUOUS |
+						SNDRV_PCM_RATE_KNOT;
+	}
+	if (ctl_rec_mask & (KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN)) {
+		memcpy(&priv->soc_dai.capture, &stream,
+			sizeof priv->soc_dai.capture);
+		if (!IS_ERR(priv->extclk))
+			priv->soc_dai.capture.rates = SNDRV_PCM_RATE_8000_192000 |
+						SNDRV_PCM_RATE_CONTINUOUS |
+						SNDRV_PCM_RATE_KNOT;
+	}
 
-static const struct snd_soc_component_driver kirkwood_i2s_component = {
-	.name		= DRV_NAME,
-};
+	ret = snd_soc_register_component(dev, &kirkwood_i2s_component,
+					 &priv->soc_dai, 1);
+	if (ret)
+		dev_err(dev, "snd_soc_register_component failed\n");
+	return ret;
+}
 
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
@@ -503,7 +533,6 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
 			clk_prepare_enable(priv->extclk);
-			soc_dai = &kirkwood_i2s_dai_extclk;
 		}
 	}
 
@@ -520,12 +549,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_128;
 	}
 
-	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
-					 soc_dai, 1);
-	if (err) {
-		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
+	err = kirkwood_register_component(&pdev->dev, priv);
+	if (err)
 		goto err_component;
-	}
 
 	err = snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
 	if (err) {
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index f8e1ccc..8f11e03 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -134,6 +134,8 @@ struct kirkwood_dma_data {
 	struct clk *extclk;
 	uint32_t ctl_play;
 	uint32_t ctl_rec;
+	uint32_t ctl_play_mask, ctl_rec_mask;
+	struct snd_soc_dai_driver soc_dai;
 	struct snd_pcm_substream *substream_play;
 	struct snd_pcm_substream *substream_rec;
 	int irq;


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
