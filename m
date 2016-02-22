From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:27 +0530
Subject: [PATCH 38/61] gpio: sch: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-39-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-sch.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 5314ee4..e85e753 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -215,15 +215,7 @@ static int sch_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sch);
 
-	return gpiochip_add_data(&sch->chip, sch);
-}
-
-static int sch_gpio_remove(struct platform_device *pdev)
-{
-	struct sch_gpio *sch = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&sch->chip);
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
 }
 
 static struct platform_driver sch_gpio_driver = {
@@ -231,7 +223,6 @@ static struct platform_driver sch_gpio_driver = {
 		.name = "sch_gpio",
 	},
 	.probe		= sch_gpio_probe,
-	.remove		= sch_gpio_remove,
 };
 
 module_platform_driver(sch_gpio_driver);
-- 
2.1.4
