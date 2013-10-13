From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 13 Oct 2013 18:17:50 +0200
Subject: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for setting the default pins.

Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/soc/atmel/atmel_wm8904.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index 7222380..b4e3690 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/pinctrl/consumer.h>
 
 #include <sound/soc.h>
 
@@ -155,15 +154,8 @@ static int atmel_asoc_wm8904_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
 	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
 	struct clk *clk_src;
-	struct pinctrl *pinctrl;
 	int id, ret;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "failed to request pinctrl\n");
-		return PTR_ERR(pinctrl);
-	}
-
 	card->dev = &pdev->dev;
 	ret = atmel_asoc_wm8904_dt_init(pdev);
 	if (ret) {
-- 
1.8.4.rc3
