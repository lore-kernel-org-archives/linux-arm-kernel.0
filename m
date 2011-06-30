From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 16:49:32 +0900
Subject: [PATCH v3 3/6] Samsung SoC ADC: Revise PM for 12-bit ADC operations
In-Reply-To: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309420175-10301-4-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Fixed: 12bit precision is lost at suspend/resume
- Updated: use pm_dev_ops

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/adc.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 45cc7e6..ee8deef 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -437,8 +437,10 @@ static int __devexit s3c_adc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
+static int s3c_adc_suspend(struct device *dev)
 {
+	struct platform_device *pdev = container_of(dev,
+			struct platform_device, dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
 	unsigned long flags;
 	u32 con;
@@ -457,10 +459,13 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int s3c_adc_resume(struct platform_device *pdev)
+static int s3c_adc_resume(struct device *dev)
 {
+	struct platform_device *pdev = container_of(dev,
+			struct platform_device, dev);
 	struct adc_device *adc = platform_get_drvdata(pdev);
 	int ret;
+	unsigned long tmp;
 
 	ret = regulator_enable(adc->vdd);
 	if (ret)
@@ -468,8 +473,11 @@ static int s3c_adc_resume(struct platform_device *pdev)
 	clk_enable(adc->clk);
 	enable_irq(adc->irq);
 
-	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
-	       adc->regs + S3C2410_ADCCON);
+	tmp = adc->prescale | S3C2410_ADCCON_PRSCEN;
+	/* Enable 12-bit ADC resolution */
+	if (platform_get_device_id(pdev)->driver_data != TYPE_ADCV1)
+		tmp |= S3C64XX_ADCCON_RESSEL;
+	writel(tmp, adc->regs + S3C2410_ADCCON);
 
 	return 0;
 }
@@ -494,16 +502,20 @@ static struct platform_device_id s3c_adc_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c_adc_driver_ids);
 
+static const struct dev_pm_ops adc_pm_ops = {
+	.suspend	= s3c_adc_suspend,
+	.resume		= s3c_adc_resume,
+};
+
 static struct platform_driver s3c_adc_driver = {
 	.id_table	= s3c_adc_driver_ids,
 	.driver		= {
 		.name	= "s3c-adc",
 		.owner	= THIS_MODULE,
+		.pm	= &adc_pm_ops,
 	},
 	.probe		= s3c_adc_probe,
 	.remove		= __devexit_p(s3c_adc_remove),
-	.suspend	= s3c_adc_suspend,
-	.resume		= s3c_adc_resume,
 };
 
 static int __init adc_init(void)
-- 
1.7.4.1
