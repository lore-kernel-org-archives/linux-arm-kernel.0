From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:28 +0200
Subject: [RFC 4/8] ASoC: dt: Parse DPCM properties
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to describe DPCM links in DT, we need some additional
properties. Is the DAI dynamic, i.e. a front end? Should no PCM be
created for the DAI?  Can it be used for DPCM playback and capture?
Add parsing of these properties to the core and make use of them in
simple card.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/sound/simple-card.txt      |  4 ++++
 include/sound/soc.h                                |  6 ++++++
 sound/soc/generic/simple-card.c                    |  4 ++++
 sound/soc/soc-core.c                               | 22 ++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 8b9f902cdfc7..cba8b8406bb0 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -51,6 +51,10 @@ Optional dai-link subnode properties:
 					  dai-link uses frame clock inversion.
 - mclk-fs                               : Multiplication factor between stream
                                           rate and codec mclk.
+- dynamic				: This DAI link can route to other DAI links at runtime
+- no_pcm				: Do not create a PCM for this DAI link
+- dpcm_capture				: DPCM capture supported for this DAI link
+- dpcm_playback				: DPCM playback supported for this DAI link
 
 For backward compatibility the frame-master and bitclock-master
 properties can be used as booleans in codec subnode to indicate if the
diff --git a/include/sound/soc.h b/include/sound/soc.h
index ed9e2d7e5fdc..060e2f955292 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1374,6 +1374,12 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
 				     struct device_node **bitclkmaster,
 				     struct device_node **framemaster);
+void snd_soc_of_parse_dpcm(struct device_node *np,
+			   struct snd_soc_dai_link *dai_link);
+void snd_soc_of_parse_dynamic(struct device_node *np,
+			      struct snd_soc_dai_link *dai_link);
+void snd_soc_of_parse_no_pcm(struct device_node *np,
+			     struct snd_soc_dai_link *dai_link);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 63f3d16d43ba..735a54099b8d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -188,6 +188,10 @@ static int simple_card_dai_link_of(struct device_node *node,
 					 &bitclkmaster, &framemaster);
 	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
 
+	snd_soc_of_parse_dpcm(node, dai_link);
+	snd_soc_of_parse_dynamic(node, dai_link);
+	snd_soc_of_parse_no_pcm(node, dai_link);
+
 	/* Factor to mclk, used in hw_params() */
 	of_property_read_u32(node, "mclk-fs",
 			     &dai_props->mclk_fs);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 91120b8e283e..8aa3a21d37af 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4745,6 +4745,28 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
+void snd_soc_of_parse_dpcm(struct device_node *np,
+			   struct snd_soc_dai_link *dai_link)
+{
+	dai_link->dpcm_playback = of_property_read_bool(np, "dpcm_playback");
+	dai_link->dpcm_capture = of_property_read_bool(np, "dpcm_capture");
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_dpcm);
+
+void snd_soc_of_parse_dynamic(struct device_node *np,
+			      struct snd_soc_dai_link *dai_link)
+{
+	dai_link->dynamic = of_property_read_bool(np, "dynamic");
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_dynamic);
+
+void snd_soc_of_parse_no_pcm(struct device_node *np,
+			     struct snd_soc_dai_link *dai_link)
+{
+	dai_link->no_pcm = of_property_read_bool(np, "no_pcm");
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_no_pcm);
+
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name)
 {
-- 
2.0.1
