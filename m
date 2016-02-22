From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:08 +0530
Subject: [PATCH 19/61] gpio: f7188x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-20-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-f7188x.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 0417798..daac2d4 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -350,37 +350,16 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 		bank->chip.parent = &pdev->dev;
 		bank->data = data;
 
-		err = gpiochip_add_data(&bank->chip, bank);
+		err = devm_gpiochip_add_data(&pdev->dev, &bank->chip, bank);
 		if (err) {
 			dev_err(&pdev->dev,
 				"Failed to register gpiochip %d: %d\n",
 				i, err);
-			goto err_gpiochip;
+			return err;
 		}
 	}
 
 	return 0;
-
-err_gpiochip:
-	for (i = i - 1; i >= 0; i--) {
-		struct f7188x_gpio_bank *bank = &data->bank[i];
-		gpiochip_remove(&bank->chip);
-	}
-
-	return err;
-}
-
-static int f7188x_gpio_remove(struct platform_device *pdev)
-{
-	int i;
-	struct f7188x_gpio_data *data = platform_get_drvdata(pdev);
-
-	for (i = 0; i < data->nr_bank; i++) {
-		struct f7188x_gpio_bank *bank = &data->bank[i];
-		gpiochip_remove(&bank->chip);
-	}
-
-	return 0;
 }
 
 static int __init f7188x_find(int addr, struct f7188x_sio *sio)
@@ -476,7 +455,6 @@ static struct platform_driver f7188x_gpio_driver = {
 		.name	= DRVNAME,
 	},
 	.probe		= f7188x_gpio_probe,
-	.remove		= f7188x_gpio_remove,
 };
 
 static int __init f7188x_gpio_init(void)
-- 
2.1.4
