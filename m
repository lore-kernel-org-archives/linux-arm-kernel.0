From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 22 Dec 2011 16:54:11 +0800
Subject: [PATCH 3/3] rtc: max8925: add function to work as wakeup source
In-Reply-To: <1324544051-1494-1-git-send-email-haojian.zhuang@marvell.com>
References: <1324544051-1494-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1324544051-1494-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Liu <kliu5@marvell.com>

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/rtc/rtc-max8925.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index 8564749..721385c 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -272,6 +272,8 @@ static int __devinit max8925_rtc_probe(struct platform_device *pdev)
 	/* XXX - isn't this redundant? */
 	platform_set_drvdata(pdev, info);
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	info->rtc_dev = rtc_device_register("max8925-rtc", &pdev->dev,
 					&max8925_rtc_ops, THIS_MODULE);
 	ret = PTR_ERR(info->rtc_dev);
@@ -301,10 +303,38 @@ static int __devexit max8925_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int max8925_rtc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+
+	if (device_may_wakeup(dev))
+		chip->wakeup_flag |= 1 << MAX8925_IRQ_RTC_ALARM0;
+	return 0;
+}
+static int max8925_rtc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+
+	if (device_may_wakeup(dev))
+		chip->wakeup_flag &= ~(1 << MAX8925_IRQ_RTC_ALARM0);
+	return 0;
+}
+static struct dev_pm_ops max8925_rtc_pm_ops = {
+	.suspend        = max8925_rtc_suspend,
+	.resume         = max8925_rtc_resume,
+};
+#endif
+
 static struct platform_driver max8925_rtc_driver = {
 	.driver		= {
 		.name	= "max8925-rtc",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm     = &max8925_rtc_pm_ops,
+#endif
 	},
 	.probe		= max8925_rtc_probe,
 	.remove		= __devexit_p(max8925_rtc_remove),
-- 
1.7.0.4
