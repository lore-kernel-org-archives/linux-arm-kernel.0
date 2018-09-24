From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 24 Sep 2018 16:49:00 +0200
Subject: [PATCH 1/3] rtc: ab8500: use rtc_add_group
Message-ID: <20180924144902.607-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use rtc_add_group to add the sysfs group in a race free manner.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab8500.c | 41 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index e28f4401fd35..e97015e5c63e 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -360,15 +360,14 @@ static DEVICE_ATTR(rtc_calibration, S_IRUGO | S_IWUSR,
 		   ab8500_sysfs_show_rtc_calibration,
 		   ab8500_sysfs_store_rtc_calibration);
 
-static int ab8500_sysfs_rtc_register(struct device *dev)
-{
-	return device_create_file(dev, &dev_attr_rtc_calibration);
-}
+static struct attribute *ab8500_rtc_attrs[] = {
+	&dev_attr_rtc_calibration.attr,
+	NULL
+};
 
-static void ab8500_sysfs_rtc_unregister(struct device *dev)
-{
-	device_remove_file(dev, &dev_attr_rtc_calibration);
-}
+static const struct attribute_group ab8500_rtc_sysfs_files = {
+	.attrs	= ab8500_rtc_attrs,
+};
 
 static irqreturn_t rtc_alarm_handler(int irq, void *data)
 {
@@ -429,14 +428,11 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, true);
 
-	rtc = devm_rtc_device_register(&pdev->dev, "ab8500-rtc",
-				(struct rtc_class_ops *)platid->driver_data,
-				THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		dev_err(&pdev->dev, "Registration failed\n");
-		err = PTR_ERR(rtc);
-		return err;
-	}
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->ops = (struct rtc_class_ops *)platid->driver_data;
 
 	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 			rtc_alarm_handler, IRQF_ONESHOT,
@@ -447,22 +443,19 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	dev_pm_set_wake_irq(&pdev->dev, irq);
 	platform_set_drvdata(pdev, rtc);
 
-	err = ab8500_sysfs_rtc_register(&pdev->dev);
-	if (err) {
-		dev_err(&pdev->dev, "sysfs RTC failed to register\n");
-		return err;
-	}
-
 	rtc->uie_unsupported = 1;
 
-	return 0;
+	err = rtc_add_group(rtc, &ab8500_rtc_sysfs_files);
+	if (err)
+		return err;
+
+	return rtc_register_device(rtc);
 }
 
 static int ab8500_rtc_remove(struct platform_device *pdev)
 {
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	ab8500_sysfs_rtc_unregister(&pdev->dev);
 
 	return 0;
 }
-- 
2.19.0
