From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 11 Jun 2018 17:32:13 +0900
Subject: [PATCH v3 2/3] ASoC: simple-card: move hp and mic detection to
 soc_card probe
In-Reply-To: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
References: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180611083214.16858-2-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves headphone and microphone detection to probe() of
snd_soc_card from init() of snd_soc_dai_link. This is because init()
is called (and an input device /dev/input/eventX is created too)
twice or above if simple card has two or more DAI links.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v2:
  - Keep PREFIX of hp/mic detection properties

Changes from v1:
  - Newly added
---
 sound/soc/generic/simple-card.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1bbd9e46bf2a..da34016652c9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -149,14 +149,6 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_hp(rtd->card, &priv->hp_jack, PREFIX);
-	if (ret < 0)
-		return ret;
-
-	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -350,6 +342,22 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	return ret;
 }
 
+static int asoc_simple_soc_card_probe(struct snd_soc_card *card)
+{
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, PREFIX);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, PREFIX);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
@@ -385,6 +393,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
 	card->num_links		= num;
+	card->probe		= asoc_simple_soc_card_probe;
 
 	if (np && of_device_is_available(np)) {
 
-- 
2.17.1
