From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jun 2018 13:00:11 +0100
Subject: Applied "ASoC: simple-card: move hp and mic detection to soc_card
 probe" to the asoc tree
In-Reply-To: <20180611083214.16858-2-suzuki.katsuhiro@socionext.com>
Message-ID: <E1fUspP-00009M-T8@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: simple-card: move hp and mic detection to soc_card probe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8d1bd113a194407f9ad083403ea1cf92108edf5c Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Mon, 11 Jun 2018 17:32:13 +0900
Subject: [PATCH] ASoC: simple-card: move hp and mic detection to soc_card
 probe

This patch moves headphone and microphone detection to probe() of
snd_soc_card from init() of snd_soc_dai_link. This is because init()
is called (and an input device /dev/input/eventX is created too)
twice or above if simple card has two or more DAI links.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a6477a022156..c5b6e04cd926 100644
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
