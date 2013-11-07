From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Nov 2013 13:26:55 +0100
Subject: [RFC 3/4] ASoC: Allow Aux Codecs to be specified using DT
In-Reply-To: <20131106142559.GC15551@amd.pavel.ucw.cz>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-4-git-send-email-sre@debian.org>
 <20131106142559.GC15551@amd.pavel.ucw.cz>
Message-ID: <20131107122655.GA7110@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> So in (error) case of ! aux_dev->codec_of_node && ! aux_dev->codec_name 
> we match first possible codec?
> 
> Given code similarity between this and the one above, should there be
> helper function that does the comparison (or even walks the list)?

Something like this? soc_probe_aux_dev now looks better... (Only
compile tested).

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 392f479..3097e17 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1526,69 +1526,65 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
 }
 #endif
 
-static int soc_check_aux_dev(struct snd_soc_card *card, int num)
+struct snd_soc_codec *soc_find_matching_codec(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	const char *codecname = aux_dev->codec_name;
 	struct snd_soc_codec *codec;
 
-	/* find CODEC from registered CODECs*/
+	/* find CODEC from registered CODECs */
 	list_for_each_entry(codec, &codec_list, list) {
-		if (aux_dev->codec_of_node &&
-				codec->dev->of_node == aux_dev->codec_of_node)
-			return 0;
-		if (aux_dev->codec_name &&
-				!strcmp(codec->name, aux_dev->codec_name))
-			return 0;
+		if (aux_dev->codec_of_node && 
+		    (codec->dev->of_node != aux_dev->codec_of_node))
+			continue;
+		if (aux_dev->codec_name && strcmp(codec->name, aux_dev->codec_name))
+			continue;
+		return codec;
 	}
+	return NULL;
+}
 
+static int soc_check_aux_dev(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	const char *codecname = aux_dev->codec_name;
+	struct snd_soc_codec *codec = soc_find_matching_codec(card, num);
+
+	if (codec)
+		return 0;
 	if (aux_dev->codec_of_node)
 		codecname = of_node_full_name(aux_dev->codec_of_node);
 
 	dev_err(card->dev, "ASoC: %s not registered\n", codecname);
-
 	return -EPROBE_DEFER;
 }
 
+
 static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	struct snd_soc_codec *codec;
 	const char *codecname = aux_dev->codec_name;
 	int ret = -ENODEV;
+	struct snd_soc_codec *codec = soc_find_matching_codec(card, num);
 
-	/* find CODEC from registered CODECs*/
-	list_for_each_entry(codec, &codec_list, list) {
-		if (aux_dev->codec_of_node &&
-				codec->dev->of_node != aux_dev->codec_of_node)
-			continue;
-		if (aux_dev->codec_name &&
-				strcmp(codec->name, aux_dev->codec_name))
-			continue;
+	if (!codec) {
+		if (aux_dev->codec_of_node)
+			codecname = of_node_full_name(aux_dev->codec_of_node);
 
-		if (codec->probed) {
-			dev_err(codec->dev, "ASoC: codec already probed");
-			ret = -EBUSY;
-			goto out;
-		}
-		goto found;
+		/* codec not found */
+		dev_err(card->dev, "ASoC: codec %s not found", codecname);
+		return -EPROBE_DEFER;
 	}
 
-	if (aux_dev->codec_of_node)
-		codecname = of_node_full_name(aux_dev->codec_of_node);
-
-	/* codec not found */
-	dev_err(card->dev, "ASoC: codec %s not found", codecname);
-	return -EPROBE_DEFER;
+	if (codec->probed) {
+		dev_err(codec->dev, "ASoC: codec already probed");
+		return -EBUSY;
+	}
 
-found:
 	ret = soc_probe_codec(card, codec);
 	if (ret < 0)
 		return ret;
 
 	ret = soc_post_component_init(card, codec, num, 1);
-
-out:
 	return ret;
 }
 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
