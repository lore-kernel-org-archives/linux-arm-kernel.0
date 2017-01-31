From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Jan 2017 21:17:26 +0000
Subject: Applied "ASoC: mt8173-max98090: remove the call to
 snd_soc_jack_add_pins." to the asoc tree
In-Reply-To: <20170127152042.7631-1-enric.balletbo@collabora.com>
Message-ID: <E1cYfnq-0000t3-J0@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mt8173-max98090: remove the call to snd_soc_jack_add_pins.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b1b9e0d3d98ebb1a228d9994b4c9dbac7215e2b9 Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 27 Jan 2017 16:20:42 +0100
Subject: [PATCH] ASoC: mt8173-max98090: remove the call to
 snd_soc_jack_add_pins.

The snd_soc_card_jack_new function can call snd_soc_jack_add_pins for
you, so pass directly the pins struct when you create the new jack.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173/mt8173-max98090.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 5524a2c727ec..46c8e6ae00b4 100644
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
2.11.0
