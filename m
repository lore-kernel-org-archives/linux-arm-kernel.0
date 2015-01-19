From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 19 Jan 2015 10:54:57 +0100
Subject: [PATCH 3/3] ASoC: simple-card: Remove support for setting differing
 DAI formats
In-Reply-To: <1421661297-19654-1-git-send-email-lars@metafoo.de>
References: <1421661297-19654-1-git-send-email-lars@metafoo.de>
Message-ID: <1421661297-19654-3-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having to set different formats on the CPU side and the CODEC side of a DAI
link is usually indication that something is terribly wrong and in most
cases is a result of a broken driver that implements a set_fmt() callback
which does not follow the specification. In the past this feature has been
used to work around broken drivers, rather than fixing them. We don't really
want to encourage this, so remove support for setting different formats on
both ends of the link.

Along the way switch to static DAI format setup by setting the the dai_fmt
field of the snd_soc_dai_link rather than calling snd_soc_dai_fmt().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/simple_card.h     |  1 -
 sound/soc/generic/simple-card.c | 29 +++++++----------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 1255ddb..b9b4f28 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -16,7 +16,6 @@
 
 struct asoc_simple_dai {
 	const char *name;
-	unsigned int fmt;
 	unsigned int sysclk;
 	int slots;
 	int slot_width;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index f7c6734..d90a22e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -125,14 +125,6 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 {
 	int ret;
 
-	if (set->fmt) {
-		ret = snd_soc_dai_set_fmt(dai, set->fmt);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dai->dev, "simple-card: set_fmt error\n");
-			goto err;
-		}
-	}
-
 	if (set->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
 		if (ret && ret != -ENOTSUPP) {
@@ -269,12 +261,10 @@ static int asoc_simple_card_parse_daifmt(struct device_node *node,
 					 struct device_node *codec,
 					 char *prefix, int idx)
 {
+	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, idx);
 	struct device *dev = simple_priv_to_dev(priv);
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
-	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
-	struct asoc_simple_dai *cpu_dai = &dai_props->cpu_dai;
-	struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
 	unsigned int daifmt;
 
 	daifmt = snd_soc_of_parse_daifmt(node, prefix,
@@ -289,8 +279,7 @@ static int asoc_simple_card_parse_daifmt(struct device_node *node,
 		 */
 		dev_dbg(dev, "Revert to legacy daifmt parsing\n");
 
-		cpu_dai->fmt = codec_dai->fmt =
-			snd_soc_of_parse_daifmt(codec, NULL, NULL, NULL) |
+		daifmt = snd_soc_of_parse_daifmt(codec, NULL, NULL, NULL) |
 			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
 	} else {
 		if (codec == bitclkmaster)
@@ -299,11 +288,10 @@ static int asoc_simple_card_parse_daifmt(struct device_node *node,
 		else
 			daifmt |= (codec == framemaster) ?
 				SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
-
-		cpu_dai->fmt	= daifmt;
-		codec_dai->fmt	= daifmt;
 	}
 
+	dai_link->dai_fmt = daifmt;
+
 	of_node_put(bitclkmaster);
 	of_node_put(framemaster);
 
@@ -379,13 +367,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	dai_link->init = asoc_simple_card_dai_init;
 
 	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
-	dev_dbg(dev, "\tcpu : %s / %04x / %d\n",
+	dev_dbg(dev, "\tcpu : %s / %d\n",
 		dai_link->cpu_dai_name,
-		dai_props->cpu_dai.fmt,
 		dai_props->cpu_dai.sysclk);
-	dev_dbg(dev, "\tcodec : %s / %04x / %d\n",
+	dev_dbg(dev, "\tcodec : %s / %d\n",
 		dai_link->codec_dai_name,
-		dai_props->codec_dai.fmt,
 		dai_props->codec_dai.sysclk);
 
 	/*
@@ -572,14 +558,13 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		dai_link->codec_name	= cinfo->codec;
 		dai_link->cpu_dai_name	= cinfo->cpu_dai.name;
 		dai_link->codec_dai_name = cinfo->codec_dai.name;
+		dai_link->dai_fmt	= cinfo->daifmt;
 		dai_link->init		= asoc_simple_card_dai_init;
 		memcpy(&priv->dai_props->cpu_dai, &cinfo->cpu_dai,
 					sizeof(priv->dai_props->cpu_dai));
 		memcpy(&priv->dai_props->codec_dai, &cinfo->codec_dai,
 					sizeof(priv->dai_props->codec_dai));
 
-		priv->dai_props->cpu_dai.fmt	|= cinfo->daifmt;
-		priv->dai_props->codec_dai.fmt	|= cinfo->daifmt;
 	}
 
 	snd_soc_card_set_drvdata(&priv->snd_card, priv);
-- 
1.8.0
