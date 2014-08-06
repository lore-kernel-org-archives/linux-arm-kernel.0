From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:31 +0200
Subject: [RFC 7/8] ASoC: simple-card: Allow use of snd-soc-dummy as codec
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DPCM front end does not have a codec attached. So use the Boolean
property 'snd-soc-dummy' to indicate that snd-soc-dummy should be
used, instead of a phandle to a real codec.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/sound/simple-card.txt      |  3 +++
 sound/soc/generic/simple-card.c                    | 27 ++++++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index cba8b8406bb0..79ba1138dfa8 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -65,7 +65,10 @@ properties should also be placed in the codec node if needed.
 
 Required CPU/CODEC subnodes properties:
 
+Either:
 - sound-dai				: phandle and port of CPU/CODEC
+Or:
+- snd-soc-dummy				: Boolean that dummy should be used
 
 Optional CPU/CODEC subnodes properties:
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a99aad16d8f9..e7fccd0940bb 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -114,6 +114,7 @@ static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      struct asoc_simple_dai *dai,
 			      const struct device_node **p_node,
+			      const char **dai_name,
 			      const char **name)
 {
 	struct device_node *node;
@@ -125,14 +126,20 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	 * it will be used as xxx_of_node on soc_bind_dai_link()
 	 */
 	node = of_parse_phandle(np, "sound-dai", 0);
-	if (!node)
-		return -ENODEV;
-	*p_node = node;
+	if (!node) {
+		if (!of_property_read_bool(np, "snd-soc-dummy"))
+			return -ENODEV;
+		*name = "snd-soc-dummy";
+		*dai_name = "snd-soc-dummy-dai";
+		p_node = NULL;
+	} else {
+		*p_node = node;
 
-	/* get dai->name */
-	ret = snd_soc_of_get_dai_name(np, name);
-	if (ret < 0)
-		return ret;
+		/* get dai->name */
+		ret = snd_soc_of_get_dai_name(np, dai_name);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* parse TDM slot */
 	ret = snd_soc_of_parse_tdm_slot(np, &dai->slots, &dai->slot_width);
@@ -253,7 +260,8 @@ static int simple_card_dai_link_of(struct device_node *node,
 
 	ret = asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai,
 					    &dai_link->cpu_of_node,
-					    &dai_link->cpu_dai_name);
+					    &dai_link->cpu_dai_name,
+					    &dai_link->cpu_name);
 	if (ret < 0)
 		goto dai_link_of_err;
 
@@ -272,7 +280,8 @@ static int simple_card_dai_link_of(struct device_node *node,
 
 	ret = asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai,
 					    &dai_link->codec_of_node,
-					    &dai_link->codec_dai_name);
+					    &dai_link->codec_dai_name,
+					    &dai_link->codec_name);
 	if (ret < 0)
 		goto dai_link_of_err;
 
-- 
2.0.1
