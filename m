From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Wed, 22 Mar 2017 17:15:35 +0000
Subject: [PATCH v3 2/2] pinctrl: samsung: Use devres version of
 gpiochip_add_data
In-Reply-To: <1490202935-4708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490202935-4708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <1490202935-4708-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data to simplify the error path in
samsung_gpiolib_register.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

No changes since v2.

 drivers/pinctrl/samsung/pinctrl-samsung.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 5d53370..934fc3b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -936,20 +936,15 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 		gc->of_node = bank->of_node;
 		gc->label = bank->name;
 
-		ret = gpiochip_add_data(gc, bank);
+		ret = devm_gpiochip_add_data(&pdev->dev, gc, bank);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register gpio_chip %s, error code: %d\n",
 							gc->label, ret);
-			goto fail;
+			return ret;
 		}
 	}
 
 	return 0;
-
-fail:
-	for (--i, --bank; i >= 0; --i, --bank)
-		gpiochip_remove(&bank->gpio_chip);
-	return ret;
 }
 
 /* retrieve the soc specific data */
-- 
2.1.4
