From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 31 Aug 2013 12:44:36 +0200
Subject: [PATCH 1/3] ASoC: generic: simple card, use private data
In-Reply-To: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
References: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1377945878-13322-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move snd_link and snd_card from platform data to private data.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/simple_card.h     |  4 ----
 sound/soc/generic/simple-card.c | 44 ++++++++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index 6c74527..e1ac996 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -29,10 +29,6 @@ struct asoc_simple_card_info {
 	unsigned int daifmt;
 	struct asoc_simple_dai cpu_dai;
 	struct asoc_simple_dai codec_dai;
-
-	/* used in simple-card.c */
-	struct snd_soc_dai_link snd_link;
-	struct snd_soc_card snd_card;
 };
 
 #endif /* __SIMPLE_CARD_H */
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6cf8355..63cbf3e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -15,6 +15,10 @@
 
 #define asoc_simple_get_card_info(p) \
 	container_of(p->dai_link, struct asoc_simple_card_info, snd_link)
+struct asoc_simple_card_data {
+	struct snd_soc_dai_link snd_link;
+	struct snd_soc_card snd_card;
+};
 
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set,
@@ -35,7 +39,8 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct asoc_simple_card_info *info = asoc_simple_get_card_info(rtd);
+	struct device *dev = rtd->card->dev;
+	struct asoc_simple_card_info *info = dev->platform_data;
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
 	unsigned int daifmt = info->daifmt;
@@ -55,6 +60,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct asoc_simple_card_info *cinfo = pdev->dev.platform_data;
+	struct asoc_simple_card_data *priv;
 	struct device *dev = &pdev->dev;
 
 	if (!cinfo) {
@@ -62,6 +68,10 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	if (!cinfo->name	||
 	    !cinfo->card	||
 	    !cinfo->codec	||
@@ -75,31 +85,33 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	/*
 	 * init snd_soc_dai_link
 	 */
-	cinfo->snd_link.name		= cinfo->name;
-	cinfo->snd_link.stream_name	= cinfo->name;
-	cinfo->snd_link.cpu_dai_name	= cinfo->cpu_dai.name;
-	cinfo->snd_link.platform_name	= cinfo->platform;
-	cinfo->snd_link.codec_name	= cinfo->codec;
-	cinfo->snd_link.codec_dai_name	= cinfo->codec_dai.name;
-	cinfo->snd_link.init		= asoc_simple_card_dai_init;
+	priv->snd_link.name		= cinfo->name;
+	priv->snd_link.stream_name	= cinfo->name;
+	priv->snd_link.cpu_dai_name	= cinfo->cpu_dai.name;
+	priv->snd_link.platform_name	= cinfo->platform;
+	priv->snd_link.codec_name	= cinfo->codec;
+	priv->snd_link.codec_dai_name	= cinfo->codec_dai.name;
+	priv->snd_link.init		= asoc_simple_card_dai_init;
 
 	/*
 	 * init snd_soc_card
 	 */
-	cinfo->snd_card.name		= cinfo->card;
-	cinfo->snd_card.owner		= THIS_MODULE;
-	cinfo->snd_card.dai_link	= &cinfo->snd_link;
-	cinfo->snd_card.num_links	= 1;
-	cinfo->snd_card.dev		= &pdev->dev;
+	priv->snd_card.name		= cinfo->card;
+	priv->snd_card.owner		= THIS_MODULE;
+	priv->snd_card.dai_link		= &priv->snd_link;
+	priv->snd_card.num_links	= 1;
+	priv->snd_card.dev		= &pdev->dev;
 
-	return snd_soc_register_card(&cinfo->snd_card);
+	dev_set_drvdata(&pdev->dev, priv);
+
+	return snd_soc_register_card(&priv->snd_card);
 }
 
 static int asoc_simple_card_remove(struct platform_device *pdev)
 {
-	struct asoc_simple_card_info *cinfo = pdev->dev.platform_data;
+	struct asoc_simple_card_data *priv = dev_get_drvdata(&pdev->dev);
 
-	return snd_soc_unregister_card(&cinfo->snd_card);
+	return snd_soc_unregister_card(&priv->snd_card);
 }
 
 static struct platform_driver asoc_simple_card = {
-- 
1.8.4.rc3
