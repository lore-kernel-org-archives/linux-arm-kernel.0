From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 22:24:06 +0200
Subject: [PATCH v7 03/24] mfd: max77686: Don't define dummy function if OF
 isn't enabled
In-Reply-To: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404505467-26526-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CONFIG_OF option was not enabled, a dummy function
max77686_i2c_parse_dt_pdata() was defined since this is called
unconditionally on probe(). Just always define the real function
and conditionally call it if CONFIG_OF is enabled instead.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/max77686.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index a38e9ee..d1f9d04 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -96,7 +96,6 @@ static const struct regmap_irq_chip max77686_rtc_irq_chip = {
 	.num_irqs		= ARRAY_SIZE(max77686_rtc_irqs),
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id max77686_pmic_dt_match[] = {
 	{.compatible = "maxim,max77686", .data = NULL},
 	{},
@@ -116,13 +115,6 @@ static struct max77686_platform_data *max77686_i2c_parse_dt_pdata(struct device
 	dev->platform_data = pd;
 	return pd;
 }
-#else
-static struct max77686_platform_data *max77686_i2c_parse_dt_pdata(struct device
-								  *dev)
-{
-	return 0;
-}
-#endif
 
 static int max77686_i2c_probe(struct i2c_client *i2c,
 			      const struct i2c_device_id *id)
@@ -132,7 +124,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 	unsigned int data;
 	int ret = 0;
 
-	if (i2c->dev.of_node)
+	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node)
 		pdata = max77686_i2c_parse_dt_pdata(&i2c->dev);
 
 	if (!pdata) {
-- 
2.0.0.rc2
