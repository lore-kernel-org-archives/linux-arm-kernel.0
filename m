From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 15 Mar 2010 16:27:08 +0200
Subject: [PATCH] ARM: SAMSUNG: Add suspend/resume support for S3C PWM driver
Message-ID: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset period_ns and duty_ns values in suspend handler to avoid skip of
configuration if same values passed to pwm_config;
Restore invertion bit in resume handler.

Without this patch PWM works incorrectly after resume from suspend.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/plat-samsung/pwm.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index ef019f2..f2d1139 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -379,6 +379,39 @@ static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int s3c_pwm_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct pwm_device *pwm = platform_get_drvdata(pdev);
+
+	/* No one preserve these values during suspend so reset them
+	 * Otherwise driver leaves PWM unconfigured if same values
+	 * passed to pwm_config
+	 */
+	pwm->period_ns = 0;
+	pwm->duty_ns = 0;
+
+	return 0;
+}
+
+static int s3c_pwm_resume(struct platform_device *pdev)
+{
+	struct pwm_device *pwm = platform_get_drvdata(pdev);
+	unsigned long tcon;
+
+	/* Restore invertion */
+	tcon = __raw_readl(S3C2410_TCON);
+	tcon |= pwm_tcon_invert(pwm);
+	__raw_writel(tcon, S3C2410_TCON);
+
+	return 0;
+}
+
+#else
+#define s3c_pwm_suspend NULL
+#define s3c_pwm_resume NULL
+#endif
+
 static struct platform_driver s3c_pwm_driver = {
 	.driver		= {
 		.name	= "s3c24xx-pwm",
@@ -386,6 +419,8 @@ static struct platform_driver s3c_pwm_driver = {
 	},
 	.probe		= s3c_pwm_probe,
 	.remove		= __devexit_p(s3c_pwm_remove),
+	.suspend	= s3c_pwm_suspend,
+	.resume		= s3c_pwm_resume,
 };
 
 static int __init pwm_init(void)
-- 
1.7.0.2
