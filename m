From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jun 2018 13:00:09 +0100
Subject: Applied "ASoC: audio-graph-card: add hp and mic detect gpios same as
 simple-card" to the asoc tree
In-Reply-To: <20180611051559.18082-3-suzuki.katsuhiro@socionext.com>
Message-ID: <E1fUspN-00008A-PJ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: audio-graph-card: add hp and mic detect gpios same as simple-card

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f6de35cc145fb55d842db94e74841ecd8382e012 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Mon, 11 Jun 2018 17:32:14 +0900
Subject: [PATCH] ASoC: audio-graph-card: add hp and mic detect gpios same as
 simple-card

This patch adds headphone and microphone jack detection gpios as same
as simple-card driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index d93bacacbd5b..a2a3e630f11c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -21,7 +21,6 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
-#include <sound/jack.h>
 #include <sound/simple_card_utils.h>
 
 struct graph_card_data {
@@ -32,6 +31,8 @@ struct graph_card_data {
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
+	struct asoc_simple_jack hp_jack;
+	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
 	struct gpio_desc *pa_gpio;
 };
@@ -278,6 +279,22 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	return count;
 }
 
+static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
+{
+	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int asoc_graph_card_probe(struct platform_device *pdev)
 {
 	struct graph_card_data *priv;
@@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->num_links	= num;
 	card->dapm_widgets = asoc_graph_card_dapm_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
+	card->probe	= asoc_graph_soc_card_probe;
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.17.1
