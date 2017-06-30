From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jun 2017 12:58:52 +0100
Subject: Applied "ASoC: audio-graph-card: add widgets and routing for external
 amplifier support" to the asoc tree
In-Reply-To: <1498742798-3128-3-git-send-email-shawnguo@kernel.org>
Message-ID: <E1dQuZY-0007xM-6Q@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: audio-graph-card: add widgets and routing for external amplifier support

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

>From f986907c9225cf48e9a55233b086039152bb5b99 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 29 Jun 2017 21:26:38 +0800
Subject: [PATCH] ASoC: audio-graph-card: add widgets and routing for external
 amplifier support

It's very common that audio card has a machine level amplifier which is
controlled by GPIO.  The patch adds DAPM widgets and routing support
into audio-graph-card driver, and creates an output driver widget with
event to control the amplifier via GPIO.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 48 +++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index ee752f62d89d..105ec3a6e30d 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -30,6 +31,34 @@ struct graph_card_data {
 		struct asoc_simple_dai codec_dai;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
+	struct gpio_desc *pa_gpio;
+};
+
+static int asoc_graph_card_outdrv_event(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct graph_card_data *priv = snd_soc_card_get_drvdata(dapm->card);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		gpiod_set_value_cansleep(priv->pa_gpio, 1);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		gpiod_set_value_cansleep(priv->pa_gpio, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget asoc_graph_card_dapm_widgets[] = {
+	SND_SOC_DAPM_OUT_DRV_E("Amplifier", SND_SOC_NOPM,
+			       0, 0, NULL, 0, asoc_graph_card_outdrv_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 };
 
 #define graph_priv_to_card(priv) (&(priv)->snd_card)
@@ -180,8 +209,16 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	int rc, idx = 0;
 	int ret;
 
+	ret = asoc_simple_card_of_parse_widgets(card, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_of_parse_routing(card, NULL, 1);
+	if (ret < 0)
+		return ret;
+
 	/*
-	 * we need to consider "widgets", "routing", "mclk-fs" around here
+	 * we need to consider "mclk-fs" around here
 	 * see simple-card
 	 */
 
@@ -233,6 +270,13 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	if (!dai_props || !dai_link)
 		return -ENOMEM;
 
+	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->pa_gpio)) {
+		ret = PTR_ERR(priv->pa_gpio);
+		dev_err(dev, "failed to get amplifier gpio: %d\n", ret);
+		return ret;
+	}
+
 	priv->dai_props			= dai_props;
 	priv->dai_link			= dai_link;
 
@@ -242,6 +286,8 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->dev	= dev;
 	card->dai_link	= dai_link;
 	card->num_links	= num;
+	card->dapm_widgets = asoc_graph_card_dapm_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.13.2
