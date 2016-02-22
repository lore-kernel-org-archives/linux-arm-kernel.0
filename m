From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:17 +0530
Subject: [PATCH 28/61] gpio: mc9s08dz60: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-29-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and remove the
need of driver callback .remove.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-mc9s08dz60.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-mc9s08dz60.c b/drivers/gpio/gpio-mc9s08dz60.c
index ba22fb9..14f252f 100644
--- a/drivers/gpio/gpio-mc9s08dz60.c
+++ b/drivers/gpio/gpio-mc9s08dz60.c
@@ -103,17 +103,7 @@ static int mc9s08dz60_probe(struct i2c_client *client,
 	mc9s->client = client;
 	i2c_set_clientdata(client, mc9s);
 
-	return gpiochip_add_data(&mc9s->chip, mc9s);
-}
-
-static int mc9s08dz60_remove(struct i2c_client *client)
-{
-	struct mc9s08dz60 *mc9s;
-
-	mc9s = i2c_get_clientdata(client);
-
-	gpiochip_remove(&mc9s->chip);
-	return 0;
+	return devm_gpiochip_add_data(&client->dev, &mc9s->chip, mc9s);
 }
 
 static const struct i2c_device_id mc9s08dz60_id[] = {
@@ -128,7 +118,6 @@ static struct i2c_driver mc9s08dz60_i2c_driver = {
 		.name = "mc9s08dz60",
 	},
 	.probe = mc9s08dz60_probe,
-	.remove = mc9s08dz60_remove,
 	.id_table = mc9s08dz60_id,
 };
 
-- 
2.1.4
