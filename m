From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:12 +0530
Subject: [PATCH 23/61] gpio: janz-ttl: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-24-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-janz-ttl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
index 482aa03..a8d0a6b 100644
--- a/drivers/gpio/gpio-janz-ttl.c
+++ b/drivers/gpio/gpio-janz-ttl.c
@@ -182,7 +182,7 @@ static int ttl_probe(struct platform_device *pdev)
 	gpio->base = -1;
 	gpio->ngpio = 20;
 
-	ret = gpiochip_add_data(gpio, NULL);
+	ret = devm_gpiochip_add_data(dev, gpio, NULL);
 	if (ret) {
 		dev_err(dev, "unable to add GPIO chip\n");
 		return ret;
@@ -191,21 +191,11 @@ static int ttl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ttl_remove(struct platform_device *pdev)
-{
-	struct ttl_module *mod = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&mod->gpio);
-
-	return 0;
-}
-
 static struct platform_driver ttl_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 	},
 	.probe		= ttl_probe,
-	.remove		= ttl_remove,
 };
 
 module_platform_driver(ttl_driver);
-- 
2.1.4
