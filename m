From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:29 +0200
Subject: [RFC 5/8] ASoC: simple-card: Don't set DAI format for dynamic DAIs
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dynamic DAIs, i.e. frontend's should not have a fmt. Skip setting it
when the dynamic property has been found in DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 sound/soc/generic/simple-card.c | 88 +++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 33 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 735a54099b8d..c3235923b12f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -166,6 +166,52 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	return 0;
 }
 
+static void simple_card_cpu_dia_fmt(int daifmt,
+				    struct simple_dai_props *dai_props,
+				    struct device_node *np,
+				    struct device_node *bitclkmaster,
+				    struct device_node *framemaster)
+{
+	dai_props->cpu_dai.fmt = daifmt;
+	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
+	case 0x11:
+		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	case 0x10:
+		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		break;
+	case 0x01:
+		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
+		break;
+	default:
+		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	}
+}
+
+static void simple_card_codec_dia_fmt(int daifmt,
+				      struct simple_dai_props *dai_props,
+				      struct device_node *np,
+				      struct device_node *bitclkmaster,
+				      struct device_node *framemaster)
+{
+	dai_props->codec_dai.fmt = daifmt;
+	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
+	case 0x11:
+		dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	case 0x10:
+		dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
+		break;
+	case 0x01:
+		dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		break;
+	default:
+		dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
+		break;
+	}
+}
+
 static int simple_card_dai_link_of(struct device_node *node,
 				   struct device *dev,
 				   struct snd_soc_dai_link *dai_link,
@@ -210,21 +256,9 @@ static int simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	dai_props->cpu_dai.fmt = daifmt;
-	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
-	case 0x11:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
-		break;
-	case 0x10:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
-		break;
-	case 0x01:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
-		break;
-	default:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
-		break;
-	}
+	if (!dai_link->dynamic)
+		simple_card_cpu_dia_fmt(daifmt, dai_props, np,
+					bitclkmaster, framemaster);
 
 	of_node_put(np);
 	snprintf(prop, sizeof(prop), "%scodec", prefix);
@@ -242,30 +276,18 @@ static int simple_card_dai_link_of(struct device_node *node,
 		goto dai_link_of_err;
 
 	if (strlen(prefix) && !bitclkmaster && !framemaster) {
-		/* No dai-link level and master setting was not found from
-		   sound node level, revert back to legacy DT parsing and
-		   take the settings from codec node. */
+		/* No dai-link level and master setting was not found
+		   from sound node level, revert back to legacy DT
+		   parsing and take the settings from codec node. */
 		dev_dbg(dev, "%s: Revert to legacy daifmt parsing\n",
 			__func__);
 		dai_props->cpu_dai.fmt = dai_props->codec_dai.fmt =
 			snd_soc_of_parse_daifmt(np, NULL, NULL, NULL) |
 			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
 	} else {
-		dai_props->codec_dai.fmt = daifmt;
-		switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
-		case 0x11:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
-			break;
-		case 0x10:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
-			break;
-		case 0x01:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
-			break;
-		default:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
-			break;
-		}
+		if (!dai_link->dynamic)
+			simple_card_codec_dia_fmt(daifmt, dai_props, np,
+						bitclkmaster, framemaster);
 	}
 
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
-- 
2.0.1
