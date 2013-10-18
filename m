From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Oct 2013 20:37:50 +0200
Subject: [PATCH v2] ASoC: kirkwood: add S/PDIF support
Message-ID: <20131018203750.7b981d62@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds S/PDIF input/output for mvebu DT boards.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v2: declare 2 DAI's (Mark Brown)
---
 sound/soc/kirkwood/kirkwood-i2s.c | 95 ++++++++++++++++++----
 1 file changed, 78 insertions(+), 17 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 2bbbab5..20c56c8 100644
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
 
+	if (dai->name[0] == 'i')
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
+		if (dai->name[0] == 'i')
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
 
@@ -404,9 +421,27 @@ static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
-
-static struct snd_soc_dai_driver kirkwood_i2s_dai = {
-	.probe = kirkwood_i2s_probe,
+static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
+    {
+	.name = "i2s",
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
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -422,10 +457,32 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
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
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -443,6 +500,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.ops = &kirkwood_i2s_dai_ops,
+    },
 };
 
 static const struct snd_soc_component_driver kirkwood_i2s_component = {
@@ -452,7 +510,7 @@ static const struct snd_soc_component_driver kirkwood_i2s_component = {
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
+	struct snd_soc_dai_driver *soc_dai = kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
@@ -519,7 +577,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	}
 
 	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
-					 soc_dai, 1);
+					 soc_dai, 2);
 	if (err) {
 		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 		goto err_component;
@@ -530,6 +588,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "snd_soc_register_platform failed\n");
 		goto err_platform;
 	}
+
+	kirkwood_i2s_init(priv);
+
 	return 0;
  err_platform:
 	snd_soc_unregister_component(&pdev->dev);


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
