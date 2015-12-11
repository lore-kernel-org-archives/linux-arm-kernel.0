From: songjun.wu@atmel.com (Songjun Wu)
Date: Fri, 11 Dec 2015 11:07:37 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: unregister codec when error occurs
Message-ID: <1449803257-27255-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to unregister codec in probe function,
when the error occurs after the codec is registered.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

 sound/soc/atmel/atmel-classd.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index dca6141..6107de9 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -640,8 +640,10 @@ static int atmel_classd_probe(struct platform_device *pdev)
 
 	/* register sound card */
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
-	if (!card)
-		return -ENOMEM;
+	if (!card) {
+		ret = -ENOMEM;
+		goto unregister_codec;
+	}
 
 	snd_soc_card_set_drvdata(card, dd);
 	platform_set_drvdata(pdev, card);
@@ -649,16 +651,20 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	ret = atmel_classd_asoc_card_init(dev, card);
 	if (ret) {
 		dev_err(dev, "failed to init sound card\n");
-		return ret;
+		goto unregister_codec;
 	}
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret) {
 		dev_err(dev, "failed to register sound card: %d\n", ret);
-		return ret;
+		goto unregister_codec;
 	}
 
 	return 0;
+
+unregister_codec:
+	snd_soc_unregister_codec(dev);
+	return ret;
 }
 
 static int atmel_classd_remove(struct platform_device *pdev)
-- 
1.7.9.5
