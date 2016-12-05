From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 5 Dec 2016 05:23:37 +0000
Subject: [PATCH 2/3] ASoC: simple-card: use devm_get_clk_from_child()
In-Reply-To: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <871sxnvtkp.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current simple-card-utils is getting clk by of_clk_get(), but didn't call
clk_free(). Now we can use devm_get_clk_from_child() for this purpose.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/simple_card_utils.h     | 11 ++++++-----
 sound/soc/generic/simple-card-utils.c |  8 ++++----
 sound/soc/generic/simple-card.c       |  4 ++--
 sound/soc/generic/simple-scu-card.c   |  4 ++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 64e90ca..af58d23 100644
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
index cf02625..4924575 100644
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
index a385ff6..85b4f18 100644
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
index bb86ee0..308ff4c 100644
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
1.9.1
