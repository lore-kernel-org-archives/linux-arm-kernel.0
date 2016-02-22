From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:56 +0530
Subject: [PATCH 07/61] gpio: adp5588: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-8-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
call for gpiochip_remove() from remove callback.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/gpio/gpio-adp5588.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 19a0eba..c0f718b 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -414,7 +414,7 @@ static int adp5588_gpio_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = gpiochip_add_data(&dev->gpio_chip, dev);
+	ret = devm_gpiochip_add_data(&client->dev, &dev->gpio_chip, dev);
 	if (ret)
 		goto err_irq;
 
@@ -457,8 +457,6 @@ static int adp5588_gpio_remove(struct i2c_client *client)
 	if (dev->irq_base)
 		free_irq(dev->client->irq, dev);
 
-	gpiochip_remove(&dev->gpio_chip);
-
 	return 0;
 }
 
-- 
2.1.4
