From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:15 +0200
Subject: [PATCH v2 5/9] ASoC: simple-card: Support setting mclk via a fixed
 factor
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms require that the codecs mclk is a fixed multiplication
factor of the audio stream rate. Add a optional property to the
binding to hold this factor and implement a hw_params() function to
make use of it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v1->v2:
s/factor/fs/g
---
 .../devicetree/bindings/sound/simple-card.txt      |  2 ++
 sound/soc/generic/simple-card.c                    | 28 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 131aa2ad7f1a..34d1b845edcc 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -18,6 +18,8 @@ Optional properties:
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
+- simple-audio-card,mclk-fs		: Multiplication factor between stream rate and codec
+					  mclk.
 - dai-tdm-slot-num			: Please refer to tdm-slot.txt.
 - dai-tdm-slot-width			: Please refer to tdm-slot.txt.
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 21f1ccbdf582..e5a3be97096c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -24,6 +24,7 @@ struct simple_card_data {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
 	} *dai_props;
+	unsigned int mclk_fs;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
@@ -151,6 +152,28 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	return 0;
 }
 
+static int simple_card_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned int mclk;
+	int ret = 0;
+
+	if (priv->mclk_fs) {
+		mclk = params_rate(params) * priv->mclk_fs;
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					     SND_SOC_CLOCK_IN);
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops simple_card_ops = {
+	.hw_params = simple_card_hw_params,
+};
+
 static int simple_card_cpu_codec_of(struct device_node *node,
 				int daifmt,
 				struct snd_soc_dai_link *dai_link,
@@ -255,6 +278,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		sprintf(name, "%s-%s", dai_link->cpu_dai_name,
 					dai_link->codec_dai_name);
 		dai_link->name = dai_link->stream_name = name;
+		dai_link->ops = &simple_card_ops;
 
 		if (!multi)
 			break;
@@ -263,6 +287,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		dai_props++;
 	}
 
+	/* Factor to mclk, used in hw_params() */
+	of_property_read_u32(node, "simple-audio-card,mclk-fs",
+			     &priv->mclk_fs);
+
 	/* card name is created from CPU/CODEC dai name */
 	dai_link = priv->snd_card.dai_link;
 	if (!priv->snd_card.name)
-- 
2.0.0.rc0
