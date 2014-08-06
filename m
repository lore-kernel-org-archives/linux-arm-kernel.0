From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:26 +0200
Subject: [RFC 2/8] ASoC: simple-card: Make mclk setting a dai link property
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mclk factor between between stream rate and codec clk was wrongly
made a property of the whole card, when in fact it is a property of a
dai link. Correct this.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

The only users of this property are kirkwood devices, which are
updated in a later patch. There is an ABI break anyway, in order to
make use of DPCM, which is the right way to handle the kirkwood
hardware, rather than what we currently have.
---
 Documentation/devicetree/bindings/sound/simple-card.txt |  4 ++--
 sound/soc/generic/simple-card.c                         | 16 +++++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c2e9841dfce4..8b9f902cdfc7 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -15,8 +15,6 @@ Optional properties:
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
-- simple-audio-card,mclk-fs             : Multiplication factor between stream rate and codec
-  					  mclk.
 
 Optional subnodes:
 
@@ -51,6 +49,8 @@ Optional dai-link subnode properties:
 					  dai-link uses bit clock inversion.
 - frame-inversion			: bool property. Add this if the
 					  dai-link uses frame clock inversion.
+- mclk-fs                               : Multiplication factor between stream
+                                          rate and codec mclk.
 
 For backward compatibility the frame-master and bitclock-master
 properties can be used as booleans in codec subnode to indicate if the
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 03a7fdcdf114..63f3d16d43ba 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -23,8 +23,8 @@ struct simple_card_data {
 	struct simple_dai_props {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
+		unsigned int mclk_fs;
 	} *dai_props;
-	unsigned int mclk_fs;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
@@ -34,11 +34,13 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	int num = rtd - rtd->card->rtd;
+	struct simple_dai_props *dai_props = &priv->dai_props[num];
 	unsigned int mclk;
 	int ret = 0;
 
-	if (priv->mclk_fs) {
-		mclk = params_rate(params) * priv->mclk_fs;
+	if (dai_props->mclk_fs) {
+		mclk = params_rate(params) * dai_props->mclk_fs;
 		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 					     SND_SOC_CLOCK_IN);
 	}
@@ -186,6 +188,10 @@ static int simple_card_dai_link_of(struct device_node *node,
 					 &bitclkmaster, &framemaster);
 	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
 
+	/* Factor to mclk, used in hw_params() */
+	of_property_read_u32(node, "mclk-fs",
+			     &dai_props->mclk_fs);
+
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
 	np = of_get_child_by_name(node, prop);
 	if (!np) {
@@ -324,10 +330,6 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			return ret;
 	}
 
-	/* Factor to mclk, used in hw_params() */
-	of_property_read_u32(node, "simple-audio-card,mclk-fs",
-			     &priv->mclk_fs);
-
 	dev_dbg(dev, "New simple-card: %s\n", priv->snd_card.name ?
 		priv->snd_card.name : "");
 
-- 
2.0.1
