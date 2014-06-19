From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 19 Jun 2014 20:20:28 +0200
Subject: [PATCH v3 02/14] mfd: max77686: Allow the max77686 rtc to wakeup the
 system
In-Reply-To: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1403202040-12641-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

The max77686 includes an RTC that keeps power during suspend.  It's
convenient to be able to use it as a wakeup source.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/rtc/rtc-max77686.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index d20a7f0..c1c6055 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -583,6 +583,33 @@ static void max77686_rtc_shutdown(struct platform_device *pdev)
 #endif /* MAX77686_RTC_WTSR_SMPL */
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int max77686_rtc_suspend(struct device *dev)
+{
+	if (device_may_wakeup(dev)) {
+		struct max77686_rtc_info *info = dev_get_drvdata(dev);
+
+		return enable_irq_wake(info->virq);
+	}
+
+	return 0;
+}
+
+static int max77686_rtc_resume(struct device *dev)
+{
+	if (device_may_wakeup(dev)) {
+		struct max77686_rtc_info *info = dev_get_drvdata(dev);
+
+		return disable_irq_wake(info->virq);
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(max77686_rtc_pm_ops,
+			 max77686_rtc_suspend, max77686_rtc_resume);
+
 static const struct platform_device_id rtc_id[] = {
 	{ "max77686-rtc", 0 },
 	{},
@@ -592,6 +619,7 @@ static struct platform_driver max77686_rtc_driver = {
 	.driver		= {
 		.name	= "max77686-rtc",
 		.owner	= THIS_MODULE,
+		.pm	= &max77686_rtc_pm_ops,
 	},
 	.probe		= max77686_rtc_probe,
 	.shutdown	= max77686_rtc_shutdown,
-- 
2.0.0.rc2
