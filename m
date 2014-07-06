From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 6 Jul 2014 23:19:48 +0530
Subject: [PATCH 3/5] ASoC: pxa: Use devm_gpio_request_array
In-Reply-To: <cover.1404665589.git.himangi774@gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>
Message-ID: <d9ef398f3ffe5abc9558c273c458a98befefed2f.1404665589.git.himangi774@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves data allocated using gpio_request_array to the managed
interface and removes the calls to gpio_free_array in the probe and
remove functions.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 sound/soc/pxa/e740_wm9705.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index c29feda..d462dc9 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -149,19 +149,17 @@ static int e740_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &e740;
 	int ret;
 
-	ret = gpio_request_array(e740_audio_gpios,
-				 ARRAY_SIZE(e740_audio_gpios));
+	ret = devm_gpio_request_array(&pdev->dev, e740_audio_gpios,
+				      ARRAY_SIZE(e740_audio_gpios));
 	if (ret)
 		return ret;
 
 	card->dev = &pdev->dev;
 
 	ret = snd_soc_register_card(card);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
-		gpio_free_array(e740_audio_gpios, ARRAY_SIZE(e740_audio_gpios));
-	}
 	return ret;
 }
 
@@ -169,7 +167,6 @@ static int e740_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-	gpio_free_array(e740_audio_gpios, ARRAY_SIZE(e740_audio_gpios));
 	snd_soc_unregister_card(card);
 	return 0;
 }
-- 
1.9.1
