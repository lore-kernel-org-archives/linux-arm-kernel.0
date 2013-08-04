From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:29:04 +0100
Subject: [PATCH RFC 08/13] ASoC: kirkwood: add DAPM widgets for input and
 output routing
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V63zE-0004li-4f@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DAPM widgets for the audio unit inputs and outputs.  The SPDIF
output route must only be used if the hardware actually supports it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   36 +++++++++++++++++++++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h     |    1 +
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 84dd9b0..3d039c3 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -242,7 +242,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
-		ctl = priv->ctl_play;
+		ctl = priv->ctl_play & priv->ctl_play_mask;
 		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
@@ -360,12 +360,39 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
+static int kirkwood_i2s_play_i2s(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *ctl, int event)
+{
+	/* This works because the platform and cpu dai are the same dev */
+	struct kirkwood_dma_data *priv = snd_soc_platform_get_drvdata(w->platform);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
+	else
+		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_I2S_EN;
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget widgets[] = {
+	/* These widget names come from the names from the functional spec */
+	SND_SOC_DAPM_AIF_OUT_E("i2sdo", "dma-tx",
+		0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_i2s,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_AIF_IN("i2sdi", "dma-rx",
+		0, SND_SOC_NOPM, 0, 0),
+};
+
 static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 {
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
 
+	/* It appears that these can't be attached to the CPU DAI */
+	snd_soc_dapm_new_controls(&dai->platform->dapm,
+				  widgets, ARRAY_SIZE(widgets));
+
 	/* put system in a "safe" state : */
 	/* disable audio interrupts */
 	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
@@ -383,6 +410,8 @@ static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 	reg_data |= 0x111D18;
 	writel(reg_data, priv->io + 0x1200);
 
+	priv->ctl_play_mask = ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
+
 	/* disable playback/record */
 	value = readl(priv->io + KIRKWOOD_PLAYCTL);
 	value &= ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
@@ -413,12 +442,14 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 	.probe = kirkwood_i2s_probe,
 	.remove = kirkwood_i2s_remove,
 	.playback = {
+		.stream_name = "dma-tx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = KIRKWOOD_I2S_RATES,
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.capture = {
+		.stream_name = "dma-rx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = KIRKWOOD_I2S_RATES,
@@ -431,6 +462,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
 	.probe = kirkwood_i2s_probe,
 	.remove = kirkwood_i2s_remove,
 	.playback = {
+		.stream_name = "dma-tx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000 |
@@ -439,6 +471,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk = {
 		.formats = KIRKWOOD_I2S_FORMATS,
 	},
 	.capture = {
+		.stream_name = "dma-rx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000 |
@@ -534,6 +567,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		goto err_platform;
 	}
 	return 0;
+
  err_platform:
 	snd_soc_unregister_component(&pdev->dev);
  err_component:
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index f8e1ccc..3b70876 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -132,6 +132,7 @@ struct kirkwood_dma_data {
 	void __iomem *io;
 	struct clk *clk;
 	struct clk *extclk;
+	uint32_t ctl_play_mask;
 	uint32_t ctl_play;
 	uint32_t ctl_rec;
 	struct snd_pcm_substream *substream_play;
-- 
1.7.4.4
