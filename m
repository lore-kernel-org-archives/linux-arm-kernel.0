From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 9 Nov 2014 12:38:56 +0100
Subject: [PATCH 2/2] ASoC: Remove useless casts
In-Reply-To: <cover.1415557680.git.moinejf@free.fr>
References: <cover.1415557680.git.moinejf@free.fr>
Message-ID: <33e64705e81810201349a09ac22d5e1f66e035e0.1415557680.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to cast the cpu_of_node or codec_of_node of the
dai_links when calling of_put_node.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/generic/simple-card.c       | 7 ++-----
 sound/soc/samsung/odroidx2_max98090.c | 4 ++--
 sound/soc/ux500/mop500.c              | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index cd49d50..3e3fec4 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -457,16 +457,13 @@ static int asoc_simple_card_unref(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct snd_soc_dai_link *dai_link;
-	struct device_node *np;
 	int num_links;
 
 	for (num_links = 0, dai_link = card->dai_link;
 	     num_links < card->num_links;
 	     num_links++, dai_link++) {
-		np = (struct device_node *) dai_link->cpu_of_node;
-		of_node_put(np);
-		np = (struct device_node *) dai_link->codec_of_node;
-		of_node_put(np);
+		of_node_put(dai_link->cpu_of_node);
+		of_node_put(dai_link->codec_of_node);
 	}
 	return 0;
 }
diff --git a/sound/soc/samsung/odroidx2_max98090.c b/sound/soc/samsung/odroidx2_max98090.c
index 3c8f604..d7640e7 100644
--- a/sound/soc/samsung/odroidx2_max98090.c
+++ b/sound/soc/samsung/odroidx2_max98090.c
@@ -153,8 +153,8 @@ static int odroidx2_audio_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_card(card);
 
-	of_node_put((struct device_node *)odroidx2_dai[0].cpu_of_node);
-	of_node_put((struct device_node *)odroidx2_dai[0].codec_of_node);
+	of_node_put(odroidx2_dai[0].cpu_of_node);
+	of_node_put(odroidx2_dai[0].codec_of_node);
 
 	return 0;
 }
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index b3b66aa..ea9ba284 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -64,11 +64,9 @@ static void mop500_of_node_put(void)
 
 	for (i = 0; i < 2; i++) {
 		if (mop500_dai_links[i].cpu_of_node)
-			of_node_put((struct device_node *)
-				mop500_dai_links[i].cpu_of_node);
+			of_node_put(mop500_dai_links[i].cpu_of_node);
 		if (mop500_dai_links[i].codec_of_node)
-			of_node_put((struct device_node *)
-				mop500_dai_links[i].codec_of_node);
+			of_node_put(mop500_dai_links[i].codec_of_node);
 	}
 }
 
-- 
2.1.3
