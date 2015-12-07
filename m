From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:24 +0000
Subject: [PATCH 11/19] mfd: as3711: Repair OOM and 'line over 80 chars'
 formatting warnings
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Possible unnecessary 'out of memory' message
+               if (!pdata) {
+                       dev_err(&client->dev, "Failed to allocate pdata\n");

WARNING: Possible unnecessary 'out of memory' message
+       if (!as3711) {
+               dev_err(&client->dev, "Memory allocation failed\n");

WARNING: line over 80 characters
+               dev_err(&client->dev, "regmap initialization failed: %d\n", ret);

WARNING: line over 80 characters
+       /* We can reuse as3711_subdevs[], it will be copied in mfd_add_devices() */

WARNING: line over 80 characters
+               as3711_subdevs[AS3711_REGULATOR].platform_data = &pdata->regulator;

WARNING: line over 80 characters
+               as3711_subdevs[AS3711_REGULATOR].pdata_size = sizeof(pdata->regulator);

WARNING: line over 80 characters
+               as3711_subdevs[AS3711_BACKLIGHT].platform_data = &pdata->backlight;

WARNING: line over 80 characters
+               as3711_subdevs[AS3711_BACKLIGHT].pdata_size = sizeof(pdata->backlight);

total: 0 errors, 8 warnings, 236 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/as3711.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index d001f7e2..94d67a6 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -136,17 +136,13 @@ static int as3711_i2c_probe(struct i2c_client *client,
 	} else {
 		pdata = devm_kzalloc(&client->dev,
 				     sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&client->dev, "Failed to allocate pdata\n");
+		if (!pdata)
 			return -ENOMEM;
-		}
 	}
 
 	as3711 = devm_kzalloc(&client->dev, sizeof(struct as3711), GFP_KERNEL);
-	if (!as3711) {
-		dev_err(&client->dev, "Memory allocation failed\n");
+	if (!as3711)
 		return -ENOMEM;
-	}
 
 	as3711->dev = &client->dev;
 	i2c_set_clientdata(client, as3711);
@@ -157,7 +153,8 @@ static int as3711_i2c_probe(struct i2c_client *client,
 	as3711->regmap = devm_regmap_init_i2c(client, &as3711_regmap_config);
 	if (IS_ERR(as3711->regmap)) {
 		ret = PTR_ERR(as3711->regmap);
-		dev_err(&client->dev, "regmap initialization failed: %d\n", ret);
+		dev_err(&client->dev,
+			"regmap initialization failed: %d\n", ret);
 		return ret;
 	}
 
@@ -172,12 +169,19 @@ static int as3711_i2c_probe(struct i2c_client *client,
 		return -ENODEV;
 	dev_info(as3711->dev, "AS3711 detected: %x:%x\n", id1, id2);
 
-	/* We can reuse as3711_subdevs[], it will be copied in mfd_add_devices() */
+	/*
+	 * We can reuse as3711_subdevs[],
+	 * it will be copied in mfd_add_devices()
+	 */
 	if (pdata) {
-		as3711_subdevs[AS3711_REGULATOR].platform_data = &pdata->regulator;
-		as3711_subdevs[AS3711_REGULATOR].pdata_size = sizeof(pdata->regulator);
-		as3711_subdevs[AS3711_BACKLIGHT].platform_data = &pdata->backlight;
-		as3711_subdevs[AS3711_BACKLIGHT].pdata_size = sizeof(pdata->backlight);
+		as3711_subdevs[AS3711_REGULATOR].platform_data =
+			&pdata->regulator;
+		as3711_subdevs[AS3711_REGULATOR].pdata_size =
+			sizeof(pdata->regulator);
+		as3711_subdevs[AS3711_BACKLIGHT].platform_data =
+			&pdata->backlight;
+		as3711_subdevs[AS3711_BACKLIGHT].pdata_size =
+			sizeof(pdata->backlight);
 	} else {
 		as3711_subdevs[AS3711_REGULATOR].platform_data = NULL;
 		as3711_subdevs[AS3711_REGULATOR].pdata_size = 0;
-- 
1.9.1
