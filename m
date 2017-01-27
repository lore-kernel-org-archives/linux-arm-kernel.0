From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri, 27 Jan 2017 16:20:42 +0100
Subject: [PATCH] ASoC: mt8173-max98090: remove the call to
 snd_soc_jack_add_pins.
Message-ID: <20170127152042.7631-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The snd_soc_card_jack_new function can call snd_soc_jack_add_pins for
you, so pass directly the pins struct when you create the new jack.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 sound/soc/mediatek/mt8173/mt8173-max98090.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 5524a2c..46c8e6a 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -79,17 +79,11 @@ static int mt8173_max98090_init(struct snd_soc_pcm_runtime *runtime)
 
 	/* enable jack detection */
 	ret = snd_soc_card_jack_new(card, "Headphone", SND_JACK_HEADPHONE,
-				    &mt8173_max98090_jack, NULL, 0);
+				    &mt8173_max98090_jack,
+				    mt8173_max98090_jack_pins,
+				    ARRAY_SIZE(mt8173_max98090_jack_pins));
 	if (ret) {
-		dev_err(card->dev, "Can't snd_soc_jack_new %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_jack_add_pins(&mt8173_max98090_jack,
-				    ARRAY_SIZE(mt8173_max98090_jack_pins),
-				    mt8173_max98090_jack_pins);
-	if (ret) {
-		dev_err(card->dev, "Can't snd_soc_jack_add_pins %d\n", ret);
+		dev_err(card->dev, "Can't create a new Jack %d\n", ret);
 		return ret;
 	}
 
-- 
2.9.3
