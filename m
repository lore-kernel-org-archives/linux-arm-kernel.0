From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 22:05:18 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <5222562B.8010001@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
Message-ID: <20130831210518.GK6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 10:46:35PM +0200, Lars-Peter Clausen wrote:
> On 08/31/2013 09:19 PM, Russell King - ARM Linux wrote:
> > On Sat, Aug 31, 2013 at 06:28:53PM +0100, Mark Brown wrote:
> >> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
> >>
> >>> Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
> >>> widgets to the I2S streams. In your machine driver setup the link config to
> >>> use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
> >>> framework will then create the necessary routes all by itself. Of course
> >>> this won't work on a platform where both the SPDIF and I2S controller are
> >>> used at the same time, but neither does your current solution.
> >>
> >> This is the either/or approach I've been suggesting.
> > 
> > Ah, here we go again.  This is precisely why I can't work with you.
> > Nothing I say seems to stick in your mind.  I've been telling you for the
> > last four weeks that it doesn't work - and I've shown you the oopses and
> > warnings I get from trying it.  Your response to date: nothing of any
> > real use.
> > 
> > If you're not going to provide any useful responses on bug reports, it is
> > totally unreasonable that you even suggest that _that_ is how it should
> > be done when I've already proved that it's impossible at present.
> 
> Russell, please stop being such a bitch. You seem to be the only one who has
> any problems working with Mark, which maybe should make you wonder if the
> problem is not on your side. Insulting and screaming at people all the time
> won't exactly motivate them to help you with your problems. Please try to be
> constructive, it will makes things much easier for everyone.

Consider that Mark's been saying the same old stuff for the last four
weeks, and I've been showing that it doesn't work, and the only thing
that Mark says is the same old same old - maybe in the hope that if he
says it enough times the bugs will mysteriously vanish.  Unfortunately,
that isn't happening.

It's also not constructive or helpful, and it's extremely frustrating.
I have very little patience left with ASoC at this point, having spent
a month trying to get this stuff working.

I'm not the only one: I've heard other people complain about the _exact_
same issue with ASoC: ASoC is difficult to work with, and many people
just seem to give up with it - or keep their stuff in their own trees
locally.  I can very well see why that happens.

As for "This is the either/or approach I've been suggesting."  No, that's
another false statement from Mark.  What Mark has been suggesting all
along is to use DPCM - and that's something which I tried for ages to
get working, and it just doesn't work (as evidenced by the oopses and
warnings that get spat out of the kernel.)

Mark suggested it _before_ he suggested DPCM, and I tried that approach.
The problem is that it doesn't fit the hardware.  They aren't two
separate streams - they're a single stream with two output paths, and
there's restrictions in the hardware to do with how they're controlled.

There are two choices in how the hardware is used: either one output
only is used, or if both outputs are used, they must be used "as one" -
both outputs must be simultaneously enabled and disabled.  As far as
I know, that's not possible with two DAIs.

And here's the patch I tried.

See - I've been down this route before.  I've tried it, and I know
what it's problems are.  I'm not making up _anything_ here - I really
have tried all these "suggestions" and I'm just going round in circles
because Mark isn't listening to what I've been reporting back.

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index cc733d1..8ef4241 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -35,9 +35,7 @@
 #define KIRKWOOD_I2S_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
-	 SNDRV_PCM_FMTBIT_S32_LE | \
-	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE | \
-	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE)
+	 SNDRV_PCM_FMTBIT_S32_LE)
 
 static void kirkwood_i2s_dump_spdif(struct device *dev,
 	struct kirkwood_dma_data *priv)
@@ -258,10 +256,22 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
-	uint32_t ctl_play, ctl_rec;
+	uint32_t ctl_play, ctl_rec, ctl_play_mask, ctl_rec_mask;
 	unsigned int i2s_reg;
 	unsigned long i2s_value;
 
+	/*
+	 * Select the playback/record enable masks according to which
+	 * DAI is being used.
+	 */
+	if (dai->id == 0) {
+		ctl_play_mask = KIRKWOOD_PLAYCTL_I2S_EN;
+		ctl_rec_mask = KIRKWOOD_RECCTL_I2S_EN;
+	} else {
+		ctl_play_mask = KIRKWOOD_PLAYCTL_SPDIF_EN;
+		ctl_rec_mask = KIRKWOOD_RECCTL_SPDIF_EN;
+	}
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		i2s_reg = KIRKWOOD_I2S_PLAYCTL;
 	} else {
@@ -279,48 +289,30 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	 */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE:
+	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
-		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C |
-			   KIRKWOOD_PLAYCTL_I2S_EN |
-			   KIRKWOOD_PLAYCTL_SPDIF_EN;
-		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C |
-			  KIRKWOOD_RECCTL_I2S_EN;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C | ctl_play_mask;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C | ctl_rec_mask;
 		break;
 	/*
 	 * doesn't work... S20_3LE != kirkwood 20bit format ?
 	 *
 	case SNDRV_PCM_FORMAT_S20_3LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_20;
-		ctl_play = KIRKWOOD_PLAYCTL_SIZE_20 |
-			   KIRKWOOD_PLAYCTL_I2S_EN |
-			   KIRKWOOD_PLAYCTL_SPDIF_EN;
-		ctl_rec = KIRKWOOD_RECCTL_SIZE_20 |
-			  KIRKWOOD_RECCTL_I2S_EN;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_20 | ctl_play_mask;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_20 | ctl_rec_mask;
 		break;
 	*/
 	case SNDRV_PCM_FORMAT_S24_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_24;
-		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 |
-			   KIRKWOOD_PLAYCTL_I2S_EN |
-			   KIRKWOOD_PLAYCTL_SPDIF_EN;
-		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 |
-			  KIRKWOOD_RECCTL_I2S_EN;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 | ctl_play_mask;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 | ctl_rec_mask;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_32;
-		ctl_play = KIRKWOOD_PLAYCTL_SIZE_32 |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
-		ctl_rec = KIRKWOOD_RECCTL_SIZE_32 |
-			  KIRKWOOD_RECCTL_I2S_EN;
-		break;
-	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE:
-	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE:
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			return -EINVAL;
-		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
-		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C |
-			   KIRKWOOD_PLAYCTL_SPDIF_EN;
-		ctl_rec = 0;
+		ctl_play = KIRKWOOD_PLAYCTL_SIZE_32 | ctl_play_mask;
+		ctl_rec = KIRKWOOD_RECCTL_SIZE_32 | ctl_rec_mask;
 		break;
 	default:
 		return -EINVAL;
@@ -333,12 +325,12 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 			ctl_play |= KIRKWOOD_PLAYCTL_MONO_OFF;
 
 		priv->ctl_play &= ~(KIRKWOOD_PLAYCTL_MONO_MASK |
-				    KIRKWOOD_PLAYCTL_I2S_EN |
-				    KIRKWOOD_PLAYCTL_SPDIF_EN |
+				    ctl_play_mask |
 				    KIRKWOOD_PLAYCTL_SIZE_MASK);
 		priv->ctl_play |= ctl_play;
 	} else {
-		priv->ctl_rec &= ~KIRKWOOD_RECCTL_SIZE_MASK;
+		priv->ctl_rec &= ~(KIRKWOOD_RECCTL_SIZE_MASK |
+				   ctl_rec_mask);
 		priv->ctl_rec |= ctl_rec;
 	}
 
@@ -351,7 +343,13 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
-	uint32_t ctl, value;
+	uint32_t ctl, value, mute_mask;
+
+	if (dai->id == 0) {
+		mute_mask = KIRKWOOD_PLAYCTL_I2S_MUTE;
+	} else {
+		mute_mask = KIRKWOOD_PLAYCTL_SPDIF_MUTE;
+	}
 
 	ctl = readl(priv->io + KIRKWOOD_PLAYCTL);
 	if (ctl & KIRKWOOD_PLAYCTL_PAUSE) {
@@ -396,7 +394,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
-		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | mute_mask;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 
 		value = readl(priv->io + KIRKWOOD_INT_MASK);
@@ -410,13 +408,13 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ctl |= KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |= KIRKWOOD_PLAYCTL_PAUSE | mute_mask;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
+		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | mute_mask);
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
@@ -499,56 +497,6 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
-{
-	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
-	unsigned long value;
-	unsigned int reg_data;
-	int ret;
-
-	ret = snd_soc_add_dai_controls(dai, kirkwood_i2s_iec958_controls,
-				ARRAY_SIZE(kirkwood_i2s_iec958_controls));
-	if (ret) {
-		dev_err(dai->dev, "unable to add soc card controls\n");
-		return ret;
-	}
-	/* put system in a "safe" state : */
-	/* disable audio interrupts */
-	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
-	writel(0, priv->io + KIRKWOOD_INT_MASK);
-
-	reg_data = readl(priv->io + 0x120c);
-	reg_data = readl(priv->io + 0x1200);
-	reg_data &= (~(0x333FF8));
-	reg_data |= 0x111D18;
-	writel(reg_data, priv->io + 0x1200);
-
-	msleep(500);
-
-	reg_data = readl(priv->io + 0x1200);
-	reg_data &= (~(0x333FF8));
-	reg_data |= 0x111D18;
-	msleep(500);
-	writel(reg_data, priv->io + 0x1200);
-
-	/* disable playback/record */
-	value = readl(priv->io + KIRKWOOD_PLAYCTL);
-	value &= ~(KIRKWOOD_PLAYCTL_I2S_EN|KIRKWOOD_PLAYCTL_SPDIF_EN);
-	writel(value, priv->io + KIRKWOOD_PLAYCTL);
-
-	value = readl(priv->io + KIRKWOOD_RECCTL);
-	value &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
-	writel(value, priv->io + KIRKWOOD_RECCTL);
-
-	return 0;
-
-}
-
-static int kirkwood_i2s_remove(struct snd_soc_dai *dai)
-{
-	return 0;
-}
-
 static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 	.startup	= kirkwood_i2s_startup,
 	.trigger	= kirkwood_i2s_trigger,
@@ -556,54 +504,57 @@ static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
+static int kirkwood_spdif_probe(struct snd_soc_dai *dai)
+{
+	int ret = snd_soc_add_dai_controls(dai, kirkwood_i2s_iec958_controls,
+				ARRAY_SIZE(kirkwood_i2s_iec958_controls));
+	if (ret)
+		dev_err(dai->dev, "unable to add soc card controls\n");
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai = {
-	.probe = kirkwood_i2s_probe,
-	.remove = kirkwood_i2s_remove,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = KIRKWOOD_I2S_RATES,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = KIRKWOOD_I2S_RATES,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-};
+	return ret;
+}
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
-	.probe = kirkwood_i2s_probe,
-	.remove = kirkwood_i2s_remove,
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
+static struct snd_soc_dai_driver kirkwood_dais[KIRKWOOD_NUM_DAIS] = {
+	{
+		.name = "kirkwood-i2s.%d",
+		.ops = &kirkwood_i2s_dai_ops,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = KIRKWOOD_I2S_RATES,
+			.formats = KIRKWOOD_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = KIRKWOOD_I2S_RATES,
+			.formats = KIRKWOOD_I2S_FORMATS,
+		},
+		.symmetric_rates = 1,
+	}, {
+		.name = "kirkwood-spdif.%d",
+		.probe = kirkwood_spdif_probe,
+		.ops = &kirkwood_i2s_dai_ops,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = KIRKWOOD_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE,
+		},
 	},
-	.ops = &kirkwood_i2s_dai_ops,
 };
 
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
-	int err;
+	int i, err;
+	u32 val;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -612,6 +563,24 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	}
 	dev_set_drvdata(&pdev->dev, priv);
 
+	memcpy(priv->dai_driver, kirkwood_dais, sizeof(priv->dai_driver));
+
+	/* format the DAI names according to the platform device ID */
+	for (i = 0; i < KIRKWOOD_NUM_DAIS; i++) {
+		const char *fmt = priv->dai_driver[i].name;
+		char *name, *p;
+
+		if (pdev->id < 0) {
+			name = kstrdup(fmt, GFP_KERNEL);
+			p = strchr(name, '.');
+			if (p)
+				*p = '\0';
+		} else {
+			name = kasprintf(GFP_KERNEL, fmt, pdev->id);
+		}
+		priv->dai_driver[i].name = name;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "platform_get_resource failed\n");
@@ -651,9 +620,23 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 			clk_put(priv->extclk);
 			priv->extclk = ERR_PTR(-EINVAL);
 		} else {
+			int i;
+
 			dev_info(&pdev->dev, "found external clock\n");
 			clk_prepare_enable(priv->extclk);
-			soc_dai = &kirkwood_i2s_dai_extclk;
+
+			for (i = 0; i < KIRKWOOD_NUM_DAIS; i++) {
+				if (priv->dai_driver[i].playback.rates)
+					priv->dai_driver[i].playback.rates =
+						SNDRV_PCM_RATE_8000_192000 |
+						SNDRV_PCM_RATE_CONTINUOUS |
+						SNDRV_PCM_RATE_KNOT;
+				if (priv->dai_driver[i].capture.rates)
+					priv->dai_driver[i].capture.rates =
+						SNDRV_PCM_RATE_8000_192000 |
+						SNDRV_PCM_RATE_CONTINUOUS |
+						SNDRV_PCM_RATE_KNOT;
+			}
 		}
 	}
 
@@ -673,7 +656,35 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	writel(KIRKWOOD_MCLK_SOURCE_DCO, 
 	       priv->io+KIRKWOOD_CLOCKS_CTRL);
 
-	err = snd_soc_register_dai(&pdev->dev, soc_dai);
+	/* put system in a "safe" state : disable audio interrupts */
+	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
+	writel(0, priv->io + KIRKWOOD_INT_MASK);
+
+	val = readl(priv->io + 0x120c);
+	val = readl(priv->io + 0x1200);
+	val &= (~(0x333FF8));
+	val |= 0x111D18;
+	writel(val, priv->io + 0x1200);
+
+	msleep(500);
+
+	val = readl(priv->io + 0x1200);
+	val &= (~(0x333FF8));
+	val |= 0x111D18;
+	msleep(500);
+	writel(val, priv->io + 0x1200);
+
+	/* disable playback/record */
+	val = readl(priv->io + KIRKWOOD_PLAYCTL);
+	val &= ~(KIRKWOOD_PLAYCTL_I2S_EN|KIRKWOOD_PLAYCTL_SPDIF_EN);
+	writel(val, priv->io + KIRKWOOD_PLAYCTL);
+
+	val = readl(priv->io + KIRKWOOD_RECCTL);
+	val &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
+	writel(val, priv->io + KIRKWOOD_RECCTL);
+
+	err = snd_soc_register_dais(&pdev->dev, priv->dai_driver,
+				    KIRKWOOD_NUM_DAIS);
 	if (!err)
 		return 0;
 	dev_err(&pdev->dev, "snd_soc_register_dai failed\n");
diff --git a/sound/soc/kirkwood/kirkwood-spdif.c b/sound/soc/kirkwood/kirkwood-spdif.c
index 2c459c1..62e5b62 100644
--- a/sound/soc/kirkwood/kirkwood-spdif.c
+++ b/sound/soc/kirkwood/kirkwood-spdif.c
@@ -61,7 +61,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
 		.name = "S/PDIF0",
 		.stream_name = "S/PDIF0 PCM Playback",
 		.platform_name = "kirkwood-pcm-audio.0",
-		.cpu_dai_name = "kirkwood-i2s.0",
+		.cpu_dai_name = "kirkwood-spdif.0",
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif-dit",
 		.ops = &kirkwood_spdif_ops,
@@ -73,7 +73,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
 		.name = "S/PDIF1",
 		.stream_name = "IEC958 Playback",
 		.platform_name = "kirkwood-pcm-audio.1",
-		.cpu_dai_name = "kirkwood-i2s.1",
+		.cpu_dai_name = "kirkwood-spdif.1",
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif-dit",
 		.ops = &kirkwood_spdif_ops,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index b7cf25c..c7ca27e 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -157,12 +157,15 @@
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x800000
 #define KIRKWOOD_SND_MAX_BUFFER_BYTES		0x100000
 
+#define KIRKWOOD_NUM_DAIS 2
+
 struct kirkwood_dma_data {
 	void __iomem *io;
 	struct clk *clk;
 	struct clk *extclk;
 	uint32_t ctl_play;
 	uint32_t ctl_rec;
+	struct snd_soc_dai_driver dai_driver[KIRKWOOD_NUM_DAIS];
 	struct snd_pcm_substream *substream_play;
 	struct snd_pcm_substream *substream_rec;
 	int irq;
