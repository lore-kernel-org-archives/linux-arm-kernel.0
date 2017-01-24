From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jan 2017 18:39:24 +0000
Subject: Applied "ASoC: simple-card: use devm_get_clk_from_child()" to the
 asoc tree
In-Reply-To: <871sxnvtkp.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <E1cW604-0006bZ-7m@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: simple-card: use devm_get_clk_from_child()

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

>From e984fd61e860ce3c45e79d69cf214b8cc6cae7d9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jan 2017 07:29:42 +0000
Subject: [PATCH] ASoC: simple-card: use devm_get_clk_from_child()

Current simple-card-utils is getting clk by of_clk_get(), but didn't call
clk_free(). Now we can use devm_get_clk_from_child() for this purpose.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 11 ++++++-----
 sound/soc/generic/simple-card-utils.c |  8 ++++----
 sound/soc/generic/simple-card.c       |  4 ++--
 sound/soc/generic/simple-scu-card.c   |  4 ++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 64e90ca9ad32..af58d2362975 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -34,11 +34,12 @@ int asoc_simple_card_set_dailink_name(struct device *dev,
 int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 				     char *prefix);
 
-#define asoc_simple_card_parse_clk_cpu(node, dai_link, simple_dai)		\
-	asoc_simple_card_parse_clk(node, dai_link->cpu_of_node, simple_dai)
-#define asoc_simple_card_parse_clk_codec(node, dai_link, simple_dai)		\
-	asoc_simple_card_parse_clk(node, dai_link->codec_of_node, simple_dai)
-int asoc_simple_card_parse_clk(struct device_node *node,
+#define asoc_simple_card_parse_clk_cpu(dev, node, dai_link, simple_dai)		\
+	asoc_simple_card_parse_clk(dev, node, dai_link->cpu_of_node, simple_dai)
+#define asoc_simple_card_parse_clk_codec(dev, node, dai_link, simple_dai)	\
+	asoc_simple_card_parse_clk(dev, node, dai_link->codec_of_node, simple_dai)
+int asoc_simple_card_parse_clk(struct device *dev,
+			       struct device_node *node,
 			       struct device_node *dai_of_node,
 			       struct asoc_simple_dai *simple_dai);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index cf026252cd4a..4924575d2e95 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -98,7 +98,8 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
-int asoc_simple_card_parse_clk(struct device_node *node,
+int asoc_simple_card_parse_clk(struct device *dev,
+			       struct device_node *node,
 			       struct device_node *dai_of_node,
 			       struct asoc_simple_dai *simple_dai)
 {
@@ -111,14 +112,13 @@ int asoc_simple_card_parse_clk(struct device_node *node,
 	 *  or "system-clock-frequency = <xxx>"
 	 *  or device's module clock.
 	 */
-	clk = of_clk_get(node, 0);
+	clk = devm_get_clk_from_child(dev, node, NULL);
 	if (!IS_ERR(clk)) {
 		simple_dai->sysclk = clk_get_rate(clk);
-		simple_dai->clk = clk;
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
 		simple_dai->sysclk = val;
 	} else {
-		clk = of_clk_get(dai_of_node, 0);
+		clk = devm_get_clk_from_child(dev, dai_of_node, NULL);
 		if (!IS_ERR(clk))
 			simple_dai->sysclk = clk_get_rate(clk);
 	}
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a385ff6bfa4b..85b4f1806514 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -278,11 +278,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_clk_cpu(cpu, dai_link, cpu_dai);
+	ret = asoc_simple_card_parse_clk_cpu(dev, cpu, dai_link, cpu_dai);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_card_parse_clk_codec(codec, dai_link, codec_dai);
+	ret = asoc_simple_card_parse_clk_codec(dev, codec, dai_link, codec_dai);
 	if (ret < 0)
 		goto dai_link_of_err;
 
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index bb86ee042490..308ff4c11a8d 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -128,7 +128,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_cpu(np, dai_link, dai_props);
+		ret = asoc_simple_card_parse_clk_cpu(dev, np, dai_link, dai_props);
 		if (ret < 0)
 			return ret;
 
@@ -153,7 +153,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 		if (ret < 0)
 			return ret;
 
-		ret = asoc_simple_card_parse_clk_codec(np, dai_link, dai_props);
+		ret = asoc_simple_card_parse_clk_codec(dev, np, dai_link, dai_props);
 		if (ret < 0)
 			return ret;
 
-- 
2.11.0
