From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed,  8 Jul 2015 17:56:27 +0530
Subject: [PATCH-v6 1/6] mfd: 88pm800: remove duplicate dev_err calls during
 probe
In-Reply-To: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436358392-15449-2-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During probe, inside fn device_800_init(), submodule init is
happening and the same error message is getting printed in both
the places, <subdev>_init() and inside device_800_init().

So this patch gets rid of dev_err from <subdev>_init() fns.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 841717a..0c5470e 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -308,59 +308,35 @@ static int device_gpadc_init(struct pm80x_chip *chip,
 	return 0;
 
 out:
-	dev_info(chip->dev, "pm800 device_gpadc_init: Failed!\n");
 	return ret;
 }
 
 static int device_onkey_init(struct pm80x_chip *chip,
 				struct pm80x_platform_data *pdata)
 {
-	int ret;
-
-	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
+	return mfd_add_devices(chip->dev, 0, &onkey_devs[0],
 			      ARRAY_SIZE(onkey_devs), &onkey_resources[0], 0,
 			      NULL);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add onkey subdev\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static int device_rtc_init(struct pm80x_chip *chip,
 				struct pm80x_platform_data *pdata)
 {
-	int ret;
-
 	if (pdata) {
 		rtc_devs[0].platform_data = pdata->rtc;
 		rtc_devs[0].pdata_size =
 				pdata->rtc ? sizeof(struct pm80x_rtc_pdata) : 0;
 	}
-	ret = mfd_add_devices(chip->dev, 0, &rtc_devs[0],
-			      ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add rtc subdev\n");
-		return ret;
-	}
 
-	return 0;
+	return mfd_add_devices(chip->dev, 0, &rtc_devs[0],
+			      ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
 }
 
 static int device_regulator_init(struct pm80x_chip *chip,
 					   struct pm80x_platform_data *pdata)
 {
-	int ret;
-
-	ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
+	return mfd_add_devices(chip->dev, 0, &regulator_devs[0],
 			      ARRAY_SIZE(regulator_devs), NULL, 0, NULL);
-	if (ret) {
-		dev_err(chip->dev, "Failed to add regulator subdev\n");
-		return ret;
-	}
-
-	return 0;
 }
 
 static int device_irq_init_800(struct pm80x_chip *chip)
-- 
1.9.1
