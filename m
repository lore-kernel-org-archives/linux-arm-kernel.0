From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Oct 2013 10:50:49 +0200
Subject: [PATCH v2] ASoC: kirkwood: add S/PDIF support
Message-ID: <20131021105049.58721da9@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds S/PDIF input/output for mvebu DT boards.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v3: (Mark Brown)
- giving a name to the DAI's impacts the Openrd and HP t5325 clients
- test i2s or spdif from the DAI's ID instead of its name
v2: declare 2 DAI's (Mark Brown)
---
 sound/soc/kirkwood/kirkwood-i2s.c    | 99 ++++++++++++++++++----
 sound/soc/kirkwood/kirkwood-openrd.c |  2 +-
 sound/soc/kirkwood/kirkwood-t5325.c  |  2 +-
 3 file changed, 84 insertions(+), 19 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index c2433ea..f3e1547 100644
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
+			  KIRKWOOD_RECCTL_SPDIF_EN;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_32;
@@ -240,6 +244,11 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				   ctl);
 	}
 
+	if (dai->id == 0)
+		ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
+	else
+		ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
@@ -258,7 +267,8 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
-		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
@@ -272,13 +282,15 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
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
 
@@ -301,7 +313,13 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
 		ctl = priv->ctl_rec;
-		value = ctl & ~KIRKWOOD_RECCTL_I2S_EN;
+		if (dai->id == 0)
+			ctl &= ~KIRKWOOD_RECCTL_SPDIF_EN;	/* i2s */
+		else
+			ctl &= ~KIRKWOOD_RECCTL_I2S_EN;		/* spdif */
+
+		value = ctl & ~(KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN);
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 
 		/* enable interrupts */
@@ -361,9 +379,8 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
+static int kirkwood_i2s_init(struct kirkwood_dma_data *priv)
 {
-	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
 
@@ -404,9 +421,29 @@ static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
-
-static struct snd_soc_dai_driver kirkwood_i2s_dai = {
-	.probe = kirkwood_i2s_probe,
+static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
+    {
+	.name = "i2s",
+	.id = 0,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_96000,
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				SNDRV_PCM_RATE_96000,
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
+	.ops = &kirkwood_i2s_dai_ops,
+    },
+    {
+	.name = "spdif",
+	.id = 1,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -422,10 +459,34 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
+    },
 };
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
-	.probe = kirkwood_i2s_probe,
+static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
+    {
+	.name = "i2s",
+	.id = 0,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_I2S_FORMATS,
+	},
+	.ops = &kirkwood_i2s_dai_ops,
+    },
+    {
+	.name = "spdif",
+	.id = 1,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -443,6 +504,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
+    },
 };
 
 static const struct snd_soc_component_driver kirkwood_i2s_component = {
@@ -452,7 +514,7 @@ static const struct snd_soc_component_driver kirkwood_i2s_component = {
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
+	struct snd_soc_dai_driver *soc_dai = kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
@@ -521,7 +583,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	}
 
 	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
-					 soc_dai, 1);
+					 soc_dai, 2);
 	if (err) {
 		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 		goto err_component;
@@ -532,6 +594,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "snd_soc_register_platform failed\n");
 		goto err_platform;
 	}
+
+	kirkwood_i2s_init(priv);
+
 	return 0;
  err_platform:
 	snd_soc_unregister_component(&pdev->dev);
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 025be0e..65f2a5b 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -52,7 +52,7 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 {
 	.name = "CS42L51",
 	.stream_name = "CS42L51 HiFi",
-	.cpu_dai_name = "mvebu-audio",
+	.cpu_dai_name = "i2s",
 	.platform_name = "mvebu-audio",
 	.codec_dai_name = "cs42l51-hifi",
 	.codec_name = "cs42l51-codec.0-004a",
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 27545b0..d213832 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -68,7 +68,7 @@ static struct snd_soc_dai_link t5325_dai[] = {
 {
 	.name = "ALC5621",
 	.stream_name = "ALC5621 HiFi",
-	.cpu_dai_name = "mvebu-audio",
+	.cpu_dai_name = "i2s",
 	.platform_name = "mvebu-audio",
 	.codec_dai_name = "alc5621-hifi",
 	.codec_name = "alc562x-codec.0-001a",

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
