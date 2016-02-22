From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:54 +0530
Subject: [PATCH 05/61] gpio: adnp: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-6-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
call for gpiochip_remove() from error path.

Also remove the need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/gpio/gpio-adnp.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index fb5b47b..8ff7b0d 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -265,7 +265,7 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios)
 	chip->of_node = chip->parent->of_node;
 	chip->owner = THIS_MODULE;
 
-	err = gpiochip_add_data(chip, adnp);
+	err = devm_gpiochip_add_data(&adnp->client->dev, chip, adnp);
 	if (err)
 		return err;
 
@@ -520,14 +520,6 @@ static int adnp_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int adnp_i2c_remove(struct i2c_client *client)
-{
-	struct adnp *adnp = i2c_get_clientdata(client);
-
-	gpiochip_remove(&adnp->gpio);
-	return 0;
-}
-
 static const struct i2c_device_id adnp_i2c_id[] = {
 	{ "gpio-adnp" },
 	{ },
@@ -546,7 +538,6 @@ static struct i2c_driver adnp_i2c_driver = {
 		.of_match_table = adnp_of_match,
 	},
 	.probe = adnp_i2c_probe,
-	.remove = adnp_i2c_remove,
 	.id_table = adnp_i2c_id,
 };
 module_i2c_driver(adnp_i2c_driver);
-- 
2.1.4
