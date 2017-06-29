From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Jun 2017 21:26:38 +0800
Subject: [PATCH 2/2] ASoC: audio-graph-card: add widgets and routing for
 external amplifier support
In-Reply-To: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
References: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1498742798-3128-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It's very common that audio card has a machine level amplifier which is
controlled by GPIO.  The patch adds DAPM widgets and routing support
into audio-graph-card driver, and creates an output driver widget with
event to control the amplifier via GPIO.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/generic/audio-graph-card.c | 48 +++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 885b405d7844..a0bcebc77e2a 100644
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
@@ -181,8 +210,16 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
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
 
@@ -234,6 +271,13 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
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
 
@@ -243,6 +287,8 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->dev	= dev;
 	card->dai_link	= dai_link;
 	card->num_links	= num;
+	card->dapm_widgets = asoc_graph_card_dapm_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
1.9.1
