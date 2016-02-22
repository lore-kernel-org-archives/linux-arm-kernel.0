From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:31 +0530
Subject: [PATCH 42/61] gpio: sx150x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-43-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-sx150x.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-sx150x.c b/drivers/gpio/gpio-sx150x.c
index e6cff1c..d387eb5 100644
--- a/drivers/gpio/gpio-sx150x.c
+++ b/drivers/gpio/gpio-sx150x.c
@@ -687,7 +687,7 @@ static int sx150x_probe(struct i2c_client *client,
 	if (rc < 0)
 		return rc;
 
-	rc = gpiochip_add_data(&chip->gpio_chip, chip);
+	rc = devm_gpiochip_add_data(&client->dev, &chip->gpio_chip, chip);
 	if (rc)
 		return rc;
 
@@ -696,25 +696,12 @@ static int sx150x_probe(struct i2c_client *client,
 					pdata->irq_summary,
 					pdata->irq_base);
 		if (rc < 0)
-			goto probe_fail_post_gpiochip_add;
+			return rc;
 	}
 
 	i2c_set_clientdata(client, chip);
 
 	return 0;
-probe_fail_post_gpiochip_add:
-	gpiochip_remove(&chip->gpio_chip);
-	return rc;
-}
-
-static int sx150x_remove(struct i2c_client *client)
-{
-	struct sx150x_chip *chip;
-
-	chip = i2c_get_clientdata(client);
-	gpiochip_remove(&chip->gpio_chip);
-
-	return 0;
 }
 
 static struct i2c_driver sx150x_driver = {
@@ -723,7 +710,6 @@ static struct i2c_driver sx150x_driver = {
 		.of_match_table = of_match_ptr(sx150x_of_match),
 	},
 	.probe    = sx150x_probe,
-	.remove   = sx150x_remove,
 	.id_table = sx150x_id,
 };
 
-- 
2.1.4
