From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 12:25:51 +0530
Subject: [RESEND PATCH-v2] rtc: 88pm80x: add device tree support
Message-ID: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Along with DT support, this patch also cleans up the unnecessary
code around 'rtc_wakeup' initialization.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/rtc/rtc-88pm80x.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 7df0579..8f66519 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -251,17 +251,26 @@ static SIMPLE_DEV_PM_OPS(pm80x_rtc_pm_ops, pm80x_rtc_suspend, pm80x_rtc_resume);
 static int pm80x_rtc_probe(struct platform_device *pdev)
 {
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm80x_platform_data *pm80x_pdata =
-				dev_get_platdata(pdev->dev.parent);
-	struct pm80x_rtc_pdata *pdata = NULL;
+	struct pm80x_rtc_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct pm80x_rtc_info *info;
+	struct device_node *node = pdev->dev.of_node;
 	struct rtc_time tm;
 	unsigned long ticks = 0;
 	int ret;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata == NULL)
-		dev_warn(&pdev->dev, "No platform data!\n");
+	if (!pdata && !node) {
+		dev_err(&pdev->dev,
+			"pm80x-rtc requires platform data or of_node\n");
+		return -EINVAL;
+	}
+
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "failed to allocate memory\n");
+			return -ENOMEM;
+		}
+	}
 
 	info =
 	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_rtc_info), GFP_KERNEL);
@@ -327,11 +336,8 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_RTC1_USE_XO,
 			   PM800_RTC1_USE_XO);
 
-	if (pm80x_pdata) {
-		pdata = pm80x_pdata->rtc;
-		if (pdata)
-			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
-	}
+	/* remeber whether this power up is caused by PMIC RTC or not */
+	info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
 
 	device_init_wakeup(&pdev->dev, 1);
 
-- 
1.9.1
