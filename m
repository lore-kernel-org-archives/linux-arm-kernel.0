From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 18 Jun 2015 00:28:06 +0530
Subject: [PATCH-v2] rtc: 88pm80x: add device tree support
In-Reply-To: <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Along with DT support, this patch also cleans up the unnecessary
code around 'rtc_wakeup' initialization.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
Link to V1: https://lkml.org/lkml/2015/5/29/757

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
