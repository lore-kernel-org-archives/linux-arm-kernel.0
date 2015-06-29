From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 29 Jun 2015 21:01:15 +0530
Subject: [PATCH-V5 2/4] mfd: 88pm800: Remove unnecessary protection around
 pdata
In-Reply-To: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1435591877-18214-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of proper checks in place in pm800_probe function,
which makes sure that pdata would never become NULL.
So remove all unnecessary protection around pdata in whole
driver code.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 40fd014..d495737 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -302,7 +302,7 @@ static int device_gpadc_init(struct pm80x_chip *chip,
 	mask = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
 		PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
 
-	if (pdata && (pdata->batt_det == 0))
+	if (pdata->batt_det == 0)
 		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
 			PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
 	else
@@ -342,11 +342,9 @@ static int device_rtc_init(struct pm80x_chip *chip,
 {
 	int ret;
 
-	if (pdata) {
-		rtc_devs[0].platform_data = pdata->rtc;
-		rtc_devs[0].pdata_size =
-				pdata->rtc ? sizeof(struct pm80x_rtc_pdata) : 0;
-	}
+	rtc_devs[0].platform_data = pdata->rtc;
+	rtc_devs[0].pdata_size = pdata->rtc ? sizeof(struct pm80x_rtc_pdata) : 0;
+
 	ret = mfd_add_devices(chip->dev, 0, &rtc_devs[0],
 			      ARRAY_SIZE(rtc_devs), NULL, 0, NULL);
 	if (ret) {
@@ -503,7 +501,7 @@ static int device_800_init(struct pm80x_chip *chip,
 		goto out;
 	}
 	if (val & PM800_ALARM_WAKEUP) {
-		if (pdata && pdata->rtc)
+		if (pdata->rtc)
 			pdata->rtc->rtc_wakeup = 1;
 	}
 
@@ -602,7 +600,7 @@ static int pm800_probe(struct i2c_client *client,
 		goto err_device_init;
 	}
 
-	if (pdata && pdata->plat_config)
+	if (pdata->plat_config)
 		pdata->plat_config(chip, pdata);
 
 	return 0;
-- 
1.9.1
