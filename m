From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:30 +0200
Subject: [RFC 6/8] ASoC: dt: Allow the platform name to be set for a DAI
In-Reply-To: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
References: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
Message-ID: <1407287912-19447-7-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use DPCM, we need to be able to set the platform name per
DAI. In particular, we need to use the "snd-soc-dummy" platform for
DPCM backends.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/sound/soc.h             | 2 ++
 sound/soc/generic/simple-card.c | 5 +++--
 sound/soc/soc-core.c            | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 060e2f955292..3e4fd6eb5f32 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1380,6 +1380,8 @@ void snd_soc_of_parse_dynamic(struct device_node *np,
 			      struct snd_soc_dai_link *dai_link);
 void snd_soc_of_parse_no_pcm(struct device_node *np,
 			     struct snd_soc_dai_link *dai_link);
+void snd_soc_of_parse_platform_name(struct device_node *np,
+				    struct snd_soc_dai_link *dai_link);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c3235923b12f..a99aad16d8f9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -237,6 +237,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 	snd_soc_of_parse_dpcm(node, dai_link);
 	snd_soc_of_parse_dynamic(node, dai_link);
 	snd_soc_of_parse_no_pcm(node, dai_link);
+	snd_soc_of_parse_platform_name(node, dai_link);
 
 	/* Factor to mclk, used in hw_params() */
 	of_property_read_u32(node, "mclk-fs",
@@ -295,8 +296,8 @@ static int simple_card_dai_link_of(struct device_node *node,
 		goto dai_link_of_err;
 	}
 
-	/* simple-card assumes platform == cpu */
-	dai_link->platform_of_node = dai_link->cpu_of_node;
+	if (!dai_link->platform_name)
+		dai_link->platform_of_node = dai_link->cpu_of_node;
 
 	/* Link name is created from CPU/CODEC dai name */
 	name = devm_kzalloc(dev,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8aa3a21d37af..667129078e44 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4767,6 +4767,13 @@ void snd_soc_of_parse_no_pcm(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_no_pcm);
 
+void snd_soc_of_parse_platform_name(struct device_node *np,
+				    struct snd_soc_dai_link *dai_link)
+{
+	of_property_read_string(np, "platform_name", &dai_link->platform_name);
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_platform_name);
+
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name)
 {
-- 
2.0.1
