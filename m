From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 6 Jul 2014 23:22:44 +0530
Subject: [PATCH 5/5] ASoC: pxa/hx4700: Introduce the use of
 devm_gpio_request_array
In-Reply-To: <cover.1404665589.git.himangi774@gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>
Message-ID: <4001147a17bf23a80be799234ebb5ef3ad985a5f.1404665589.git.himangi774@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the resources allocated using gpio_request_array to the
managed interface and removes the calls to gpio_free_array in the probe
and remove functions.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 sound/soc/pxa/hx4700.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 05559a7..b624526 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -198,18 +198,13 @@ static int hx4700_audio_probe(struct platform_device *pdev)
 	if (!machine_is_h4700())
 		return -ENODEV;
 
-	ret = gpio_request_array(hx4700_audio_gpios,
-				ARRAY_SIZE(hx4700_audio_gpios));
+	ret = devm_gpio_request_array(&pdev->dev, hx4700_audio_gpios,
+				      ARRAY_SIZE(hx4700_audio_gpios));
 	if (ret)
 		return ret;
 
 	snd_soc_card_hx4700.dev = &pdev->dev;
-	ret = snd_soc_register_card(&snd_soc_card_hx4700);
-	if (ret)
-		gpio_free_array(hx4700_audio_gpios,
-				ARRAY_SIZE(hx4700_audio_gpios));
-
-	return ret;
+	return snd_soc_register_card(&snd_soc_card_hx4700);
 }
 
 static int hx4700_audio_remove(struct platform_device *pdev)
@@ -219,7 +214,6 @@ static int hx4700_audio_remove(struct platform_device *pdev)
 	gpio_set_value(GPIO92_HX4700_HP_DRIVER, 0);
 	gpio_set_value(GPIO107_HX4700_SPK_nSD, 0);
 
-	gpio_free_array(hx4700_audio_gpios, ARRAY_SIZE(hx4700_audio_gpios));
 	return 0;
 }
 
-- 
1.9.1
