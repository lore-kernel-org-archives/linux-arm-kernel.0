From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:14 +0530
Subject: [PATCH 25/61] gpio: lp3943: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-26-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-lp3943.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index 1c8e2ae..6dc6725 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -204,15 +204,8 @@ static int lp3943_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lp3943_gpio);
 
-	return gpiochip_add_data(&lp3943_gpio->chip, lp3943_gpio);
-}
-
-static int lp3943_gpio_remove(struct platform_device *pdev)
-{
-	struct lp3943_gpio *lp3943_gpio = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&lp3943_gpio->chip);
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &lp3943_gpio->chip,
+				      lp3943_gpio);
 }
 
 static const struct of_device_id lp3943_gpio_of_match[] = {
@@ -223,7 +216,6 @@ MODULE_DEVICE_TABLE(of, lp3943_gpio_of_match);
 
 static struct platform_driver lp3943_gpio_driver = {
 	.probe = lp3943_gpio_probe,
-	.remove = lp3943_gpio_remove,
 	.driver = {
 		.name = "lp3943-gpio",
 		.of_match_table = lp3943_gpio_of_match,
-- 
2.1.4
