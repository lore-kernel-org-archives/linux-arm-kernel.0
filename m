From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 11:55:05 +0200
Subject: [PATCH v6 06/23] mfd: max77686: Make error checking consistent
In-Reply-To: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404467722-26687-7-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Error checking across the driver is mostly consistent besides
a few exceptions, so change these exceptions for consistency.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/max77686.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index ada4976..87fe52e 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -134,7 +134,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 
 	max77686 = devm_kzalloc(&i2c->dev,
 				sizeof(struct max77686_dev), GFP_KERNEL);
-	if (max77686 == NULL)
+	if (!max77686)
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, max77686);
@@ -153,8 +153,8 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (regmap_read(max77686->regmap,
-			 MAX77686_REG_DEVICE_ID, &data) < 0) {
+	ret = regmap_read(max77686->regmap, MAX77686_REG_DEVICE_ID, &data);
+	if (ret < 0) {
 		dev_err(max77686->dev,
 			"device not found on this channel (this is not an error)\n");
 		return -ENODEV;
@@ -180,7 +180,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
 				  IRQF_SHARED, 0, &max77686_irq_chip,
 				  &max77686->irq_data);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
 		goto err_unregister_i2c;
 	}
@@ -188,7 +188,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
 				  IRQF_SHARED, 0, &max77686_rtc_irq_chip,
 				  &max77686->rtc_irq_data);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(&i2c->dev, "failed to add RTC irq chip: %d\n", ret);
 		goto err_del_irqc;
 	}
-- 
2.0.0.rc2
