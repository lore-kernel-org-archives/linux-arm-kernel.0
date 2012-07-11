From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 11 Jul 2012 13:36:48 +0200
Subject: [RFC internal PATCH] mfd/mc13xxx: drop modifying driver's id_table in
 probe
Message-ID: <1342006608-30550-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was introduced in commit

	876989d (mfd: Add device tree probe support for mc13xxx)

for spi and later while introducing support for i2c copied to the i2c
driver.

Modifying driver details is very strange, for example probing an
mc13892 device (instantiated via dt) removes the driver's ability to
handle (traditionally probed) mc13783 devices in this case.
I'm not aware of any problems that make this hack necessary and if
there were some, they'd have to be fixed in the spi/i2c core, not in
a driver.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello Samuel,

even though this qualifies as fix, I don't think it's necessary to annoy
Linus with it for 3.5. Usually there is only one pmic on each machine so
it's not grave when probing one device disables support for another.

Best regards
Uwe

 drivers/mfd/mc13xxx-i2c.c |    6 ------
 drivers/mfd/mc13xxx-spi.c |    6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index d22501d..e00e885 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -53,16 +53,10 @@ static struct regmap_config mc13xxx_regmap_i2c_config = {
 static int mc13xxx_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	const struct of_device_id *of_id;
-	struct i2c_driver *idrv = to_i2c_driver(client->dev.driver);
 	struct mc13xxx *mc13xxx;
 	struct mc13xxx_platform_data *pdata = dev_get_platdata(&client->dev);
 	int ret;
 
-	of_id = of_match_device(mc13xxx_dt_ids, &client->dev);
-	if (of_id)
-		idrv->id_table = (const struct i2c_device_id*) of_id->data;
-
 	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
 	if (!mc13xxx)
 		return -ENOMEM;
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 03df422..b99e728 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -119,16 +119,10 @@ static struct regmap_bus regmap_mc13xxx_bus = {
 
 static int mc13xxx_spi_probe(struct spi_device *spi)
 {
-	const struct of_device_id *of_id;
-	struct spi_driver *sdrv = to_spi_driver(spi->dev.driver);
 	struct mc13xxx *mc13xxx;
 	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
 	int ret;
 
-	of_id = of_match_device(mc13xxx_dt_ids, &spi->dev);
-	if (of_id)
-		sdrv->id_table = &mc13xxx_device_id[(enum mc13xxx_id) of_id->data];
-
 	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
 	if (!mc13xxx)
 		return -ENOMEM;
-- 
1.7.10.4
