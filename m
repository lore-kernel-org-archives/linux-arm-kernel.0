From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:25 +0200
Subject: [RFC 1/8] ASoC: kirkwood: add DPCM support
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Add DPCM support to kirkwood-i2s to support the I2S and SPDIF streams.
This consists of:
- a single front end DAI called "kirkwood-fe" with "dma-tx" and "dma-rx"
  streams.
- one backend DAI called "kirkwood-i2s" for I2S with streams named
  "i2s-tx" and "i2s-rx"
- one backend DAI called "kirkwood-spdif" for SPDIF with a single stream
  named "spdif-tx".

DAPM widgets are used to connect the backend i2s-tx/spdif-tx streams to
the dma-tx frontend stream, and similarly for the capture side.  SPDIF
capture is not supported by this patch.

We avoid the requirement that streams must not be started independently
by keeping a separate mask of which streams are enabled - and this mask
is only used in the playback trigger when we start playback.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-t5325.dts |   4 +-
 sound/soc/kirkwood/kirkwood-i2s.c    | 244 +++++++++++++++++++++++------------
 sound/soc/kirkwood/kirkwood.h        |  20 +++
 3 files changed, 187 insertions(+), 81 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 610ec0f95858..cc6cd0bdcfac 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -196,7 +196,9 @@
 			"Speaker", "SPKOUT",
 			"Speaker", "SPKOUTN",
 			"MIC1", "Mic Jack",
-			"MIC2", "Mic Jack";
+			"MIC2", "Mic Jack",
+			"i2s-tx", "dma-tx",
+			"dma-rx", "i2s-rx";
 		simple-audio-card,widgets =
 			"Headphone", "Headphone Jack",
 			"Speaker", "Speaker",
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0704cd6d2314..7e075d4da8c4 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -37,6 +37,18 @@
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE)
 
+/* Workaround ASoC not respecting backend restrictions */
+#define KIRKWOOD_FE_FORMATS (KIRKWOOD_I2S_FORMATS & KIRKWOOD_SPDIF_FORMATS)
+
+enum {
+	KW_DAI_FE,
+	KW_DAI_BE_I2S,
+	KW_DAI_BE_SPDIF,
+
+	KW_DAI_BE_SPDIF_PLAYBACK = BIT(0),
+	KW_DAI_BE_SPDIF_CAPTURE = BIT(1),
+};
+
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -261,13 +273,12 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		if (priv->ctl_play_mask == ~KIRKWOOD_PLAYCTL_ENABLE_MASK)
+			return -EINVAL;
+
 		/* configure */
-		ctl = priv->ctl_play;
-		if (dai->id == 0)
-			ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
-		else
-			ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
-		ctl = kirkwood_i2s_play_mute(ctl);
+		ctl = kirkwood_i2s_play_mute(priv->ctl_play &
+					     priv->ctl_play_mask);
 		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
@@ -329,13 +340,11 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		/* configure */
-		ctl = priv->ctl_rec;
-		if (dai->id == 0)
-			ctl &= ~KIRKWOOD_RECCTL_SPDIF_EN;	/* i2s */
-		else
-			ctl &= ~KIRKWOOD_RECCTL_I2S_EN;		/* spdif */
+		if (priv->ctl_rec_mask == ~KIRKWOOD_RECCTL_ENABLE_MASK)
+			return -EINVAL;
 
+		/* configure */
+		ctl = priv->ctl_rec & priv->ctl_rec_mask;
 		value = ctl & ~KIRKWOOD_RECCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 
@@ -396,8 +405,9 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int kirkwood_i2s_init(struct kirkwood_dma_data *priv)
+static int kirkwood_fe_probe(struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
 
@@ -431,97 +441,134 @@ static int kirkwood_i2s_init(struct kirkwood_dma_data *priv)
 
 }
 
-static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
+static const struct snd_soc_dai_ops kirkwood_dai_fe_ops = {
 	.startup	= kirkwood_i2s_startup,
 	.trigger	= kirkwood_i2s_trigger,
 	.hw_params      = kirkwood_i2s_hw_params,
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
-    {
-	.name = "i2s",
-	.id = 0,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
-    {
-	.name = "spdif",
-	.id = 1,
+static int kirkwood_i2s_be_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (dai->id) {
+	case KW_DAI_BE_I2S:
+		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
+		priv->ctl_rec_mask |= KIRKWOOD_RECCTL_I2S_EN;
+		break;
+
+	case KW_DAI_BE_SPDIF:
+		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_SPDIF_EN;
+		priv->ctl_rec_mask |= KIRKWOOD_RECCTL_SPDIF_EN;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void kirkwood_i2s_be_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (dai->id) {
+	case KW_DAI_BE_I2S:
+		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_I2S_EN;
+		priv->ctl_rec_mask &= ~KIRKWOOD_RECCTL_I2S_EN;
+		break;
+
+	case KW_DAI_BE_SPDIF:
+		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;
+		priv->ctl_rec_mask &= ~KIRKWOOD_RECCTL_SPDIF_EN;
+		break;
+	}
+}
+
+static const struct snd_soc_dai_ops kirkwood_i2s_be_dai_ops = {
+	.startup	= kirkwood_i2s_be_startup,
+	.shutdown	= kirkwood_i2s_be_shutdown,
+};
+
+
+static const struct snd_soc_dai_driver kirkwood_dai_fe = {
+	.name = "kirkwood-fe",
+	.id = KW_DAI_FE,
+	.probe = kirkwood_fe_probe,
 	.playback = {
+		.stream_name = "dma-tx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
 	.capture = {
+		.stream_name = "dma-rx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
+	.ops = &kirkwood_dai_fe_ops,
 };
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
-    {
-	.name = "i2s",
-	.id = 0,
+static const struct snd_soc_dai_driver kirkwood_dai_fe_extclk = {
+	.name = "kirkwood-fe",
+	.id = KW_DAI_FE,
+	.probe = kirkwood_fe_probe,
 	.playback = {
+		.stream_name = "dma-tx",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_I2S_FORMATS,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
 	.capture = {
+		.stream_name = "dma-rx",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
-    {
-	.name = "spdif",
-	.id = 1,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+	.ops = &kirkwood_dai_fe_ops,
+};
+
+static const struct snd_soc_dai_driver kirkwood_dai_be[] = {
+	{
+		.name = "kirkwood-i2s",
+		.id = KW_DAI_BE_I2S,
+		.ops = &kirkwood_i2s_be_dai_ops,
+		.playback = {
+			.stream_name = "i2s-tx",
+			.formats = KIRKWOOD_I2S_FORMATS,
+		},
+		.capture = {
+			.stream_name = "i2s-rx",
+			.formats = KIRKWOOD_I2S_FORMATS,
+		},
+	}, {
+		.name = "kirkwood-spdif",
+		.id = KW_DAI_BE_SPDIF,
+		.ops = &kirkwood_i2s_be_dai_ops,
+		.playback = {
+			.stream_name = "spdif-tx",
+			.formats = KIRKWOOD_SPDIF_FORMATS,
+		},
+		.capture = {
+			.stream_name = "spdif-rx",
+			.formats = KIRKWOOD_SPDIF_FORMATS,
+		},
 	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
 };
 
 static const struct snd_soc_component_driver kirkwood_i2s_component = {
@@ -531,10 +578,12 @@ static const struct snd_soc_component_driver kirkwood_i2s_component = {
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai = kirkwood_i2s_dai;
+	const struct snd_soc_dai_driver *soc_dai = &kirkwood_dai_fe;
+	struct snd_soc_dai_driver *dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
+	unsigned i;
 	int err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -555,6 +604,13 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	/*
+	 * We currently have no way to determine whether SPDIF playback
+	 * or capture is currently supported; take the middle ground
+	 * for the time being until DT/platform data passes this detail.
+	 */
+	priv->have_spdif = KW_DAI_BE_SPDIF_PLAYBACK;
+
 	if (np) {
 		priv->burst = 128;		/* might be 32 or 128 */
 	} else if (data) {
@@ -585,13 +641,15 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
 			clk_prepare_enable(priv->extclk);
-			soc_dai = kirkwood_i2s_dai_extclk;
+			soc_dai = &kirkwood_dai_fe_extclk;
 		}
 	}
 
 	/* Some sensible defaults - this reflects the powerup values */
 	priv->ctl_play = KIRKWOOD_PLAYCTL_SIZE_24;
 	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
+	priv->ctl_play_mask = ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
+	priv->ctl_rec_mask = ~KIRKWOOD_RECCTL_ENABLE_MASK;
 
 	/* Select the burst size */
 	if (priv->burst == 32) {
@@ -602,8 +660,35 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_128;
 	}
 
+	dai = priv->dai_driver;
+	memcpy(dai, soc_dai, sizeof(*dai));
+
+	/* Copy the frontend channels and rates to the backends */
+	for (i = 1; i < ARRAY_SIZE(priv->dai_driver); i++) {
+		memcpy(&dai[i], &kirkwood_dai_be[i - 1], sizeof(*dai));
+		dai[i].playback.channels_min = dai[0].playback.channels_min;
+		dai[i].playback.channels_max = dai[0].playback.channels_max;
+		dai[i].playback.rates        = dai[0].playback.rates;
+		dai[i].playback.rate_min     = dai[0].playback.rate_min;
+		dai[i].playback.rate_max     = dai[0].playback.rate_max;
+		dai[i].capture.channels_min  = dai[0].capture.channels_min;
+		dai[i].capture.channels_max  = dai[0].capture.channels_max;
+		dai[i].capture.rates         = dai[0].capture.rates;
+		dai[i].capture.rate_min      = dai[0].capture.rate_min;
+		dai[i].capture.rate_max      = dai[0].capture.rate_max;
+	}
+
+	/*
+	 * Kill the SPDIF stream information according to
+	 * the capabilities we have on this device.
+	 */
+	if (!(priv->have_spdif & KW_DAI_BE_SPDIF_PLAYBACK))
+		memset(&dai[2].playback, 0, sizeof(dai[2].playback));
+	if (!(priv->have_spdif & KW_DAI_BE_SPDIF_CAPTURE))
+		memset(&dai[2].capture, 0, sizeof(dai[2].capture));
+
 	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
-					 soc_dai, 2);
+					 dai, 2 + !!priv->have_spdif);
 	if (err) {
 		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 		goto err_component;
@@ -615,9 +700,8 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		goto err_platform;
 	}
 
-	kirkwood_i2s_init(priv);
-
 	return 0;
+
  err_platform:
 	snd_soc_unregister_component(&pdev->dev);
  err_component:
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 90e32a781424..5a5a48944976 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -131,12 +131,19 @@
 #define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
 						 * KIRKWOOD_SND_MAX_PERIODS)
 
+#define KIRKWOOD_NUM_DAIS 3
+
 struct kirkwood_dma_data {
 	void __iomem *io;
 	struct clk *clk;
 	struct clk *extclk;
+	unsigned have_spdif;
+	uint32_t ctl_play_mask;
 	uint32_t ctl_play;
+	uint32_t ctl_rec_mask;
 	uint32_t ctl_rec;
+	struct snd_soc_dai *active_dai;
+	struct snd_soc_dai_driver dai_driver[KIRKWOOD_NUM_DAIS];
 	struct snd_pcm_substream *substream_play;
 	struct snd_pcm_substream *substream_rec;
 	int irq;
@@ -145,4 +152,17 @@ struct kirkwood_dma_data {
 
 extern struct snd_soc_platform_driver kirkwood_soc_platform;
 
+#define KIRKWOOD_FE_DAI_LINK(id, play, capt) {	\
+	.name = "Kirkwood-FE",			\
+	.stream_name = "FE PCM Playback",	\
+	.cpu_name = "mvebu-audio" id,		\
+	.cpu_dai_name = "kirkwood-fe",		\
+	.codec_name = "snd-soc-dummy",		\
+	.codec_dai_name = "snd-soc-dummy-dai",	\
+	.platform_name = "mvebu-audio" id,	\
+	.dynamic = 1,				\
+	.dpcm_capture = capt,			\
+	.dpcm_playback = play,			\
+}
+
 #endif
-- 
2.0.1
