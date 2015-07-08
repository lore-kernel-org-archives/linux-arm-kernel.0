From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed,  8 Jul 2015 17:56:29 +0530
Subject: [PATCH-v6 3/6] mfd: 88pm800: Get pdata from 'device' rather than
 passing as a parameter
In-Reply-To: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436358392-15449-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the device_xxx_init() fns take pdata as an input parameter to
the fn, but the cleaner approach would be to use dev_get_platdata() to
get the pdata.
So this patch changes the code accordingly.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 95c418c..af8232f 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -254,11 +254,11 @@ static const struct regmap_irq pm800_irqs[] = {
 	},
 };
 
-static int device_gpadc_init(struct pm80x_chip *chip,
-				       struct pm80x_platform_data *pdata)
+static int device_gpadc_init(struct pm80x_chip *chip)
 {
 	struct pm80x_subchip *subchip = chip->subchip;
 	struct regmap *map = subchip->regmap_gpadc;
+	struct pm80x_platform_data *pdata = dev_get_platdata(chip->dev);
 	int data = 0, mask = 0, ret = 0;
 
 	if (!map) {
@@ -320,17 +320,17 @@ out:
 	return ret;
 }
 
-static int device_onkey_init(struct pm80x_chip *chip,
-				struct pm80x_platform_data *pdata)
+static int device_onkey_init(struct pm80x_chip *chip)
 {
 	return mfd_add_devices(chip->dev, 0, &onkey_devs[0],
 			      ARRAY_SIZE(onkey_devs), &onkey_resources[0], 0,
 			      NULL);
 }
 
-static int device_rtc_init(struct pm80x_chip *chip,
-				struct pm80x_platform_data *pdata)
+static int device_rtc_init(struct pm80x_chip *chip)
 {
+	struct pm80x_platform_data *pdata = dev_get_platdata(chip->dev);
+
 	if (pdata) {
 		rtc_devs[0].platform_data = pdata->rtc;
 		rtc_devs[0].pdata_size =
@@ -341,8 +341,7 @@ static int device_rtc_init(struct pm80x_chip *chip,
 			      ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
 }
 
-static int device_regulator_init(struct pm80x_chip *chip,
-					   struct pm80x_platform_data *pdata)
+static int device_regulator_init(struct pm80x_chip *chip)
 {
 	return mfd_add_devices(chip->dev, 0, &regulator_devs[0],
 			      ARRAY_SIZE(regulator_devs), NULL, 0, NULL);
@@ -463,11 +462,11 @@ static void pm800_pages_exit(struct pm80x_chip *chip)
 		i2c_unregister_device(subchip->gpadc_page);
 }
 
-static int device_800_init(struct pm80x_chip *chip,
-				     struct pm80x_platform_data *pdata)
+static int device_800_init(struct pm80x_chip *chip)
 {
 	int ret;
 	unsigned int val;
+	struct pm80x_platform_data *pdata = dev_get_platdata(chip->dev);
 
 	/*
 	 * alarm wake up bit will be clear in device_irq_init(),
@@ -483,7 +482,7 @@ static int device_800_init(struct pm80x_chip *chip,
 			pdata->rtc->rtc_wakeup = 1;
 	}
 
-	ret = device_gpadc_init(chip, pdata);
+	ret = device_gpadc_init(chip);
 	if (ret < 0) {
 		dev_err(chip->dev, "[%s]Failed to init gpadc\n", __func__);
 		goto out;
@@ -497,19 +496,19 @@ static int device_800_init(struct pm80x_chip *chip,
 		goto out;
 	}
 
-	ret = device_onkey_init(chip, pdata);
+	ret = device_onkey_init(chip);
 	if (ret) {
 		dev_err(chip->dev, "Failed to add onkey subdev\n");
 		goto out_dev;
 	}
 
-	ret = device_rtc_init(chip, pdata);
+	ret = device_rtc_init(chip);
 	if (ret) {
 		dev_err(chip->dev, "Failed to add rtc subdev\n");
 		goto out;
 	}
 
-	ret = device_regulator_init(chip, pdata);
+	ret = device_regulator_init(chip);
 	if (ret) {
 		dev_err(chip->dev, "Failed to add regulators subdev\n");
 		goto out;
@@ -575,7 +574,7 @@ static int pm800_probe(struct i2c_client *client,
 		goto err_device_init;
 	}
 
-	ret = device_800_init(chip, pdata);
+	ret = device_800_init(chip);
 	if (ret) {
 		dev_err(chip->dev, "Failed to initialize 88pm800 devices\n");
 		goto err_device_init;
-- 
1.9.1
