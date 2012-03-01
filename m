From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:23 +0800
Subject: [PATCH 3/8] rtc: sa1100: add OF support
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There're two interrupts are used in rtc-sa1100 devices. The RTC-alarm
interrupt is specified as default interrupt. The RTC-1Hz interrupt is
specified as "mrvl,rtc-irqhz" property in DTS file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |   54 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 962510c..09f05d5 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
 
@@ -228,28 +229,64 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 	.alarm_irq_enable = sa1100_rtc_alarm_irq_enable,
 };
 
+static struct of_device_id sa1100_rtc_dt_ids[] = {
+	{ .compatible = "mrvl,sa1100-rtc", },
+	{ .compatible = "mrvl,mmp-rtc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sa1100_rtc_dt_ids);
+
+#ifdef CONFIG_OF
+static int sa1100_rtc_probe_dt(struct platform_device *pdev,
+			       struct sa1100_rtc *info)
+{
+	info->irq_alarm = platform_get_irq(pdev, 0);
+	info->irq_1hz = platform_get_irq(pdev, 1);
+	if (info->irq_1hz < 0 || info->irq_alarm < 0)
+		return -ENODEV;
+	return 0;
+}
+#else
+static int sa1100_rtc_probe_dt(struct platform_device *pdev,
+			       struct sa1100_rtc *info)
+{
+	return 1;
+}
+#endif
+
+static int sa1100_rtc_probe_irq(struct platform_device *pdev,
+				struct sa1100_rtc *info)
+{
+	info->irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
+	info->irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
+	if (info->irq_1hz < 0 || info->irq_alarm < 0)
+		return -ENODEV;
+	return 0;
+}
+
 static int sa1100_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct sa1100_rtc *info;
-	int irq_1hz, irq_alarm, ret = 0;
-
-	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
-	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
-	if (irq_1hz < 0 || irq_alarm < 0)
-		return -ENODEV;
+	int ret = 0;
 
 	info = kzalloc(sizeof(struct sa1100_rtc), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
+	ret = sa1100_rtc_probe_dt(pdev, info);
+	if (ret > 0)
+		ret = sa1100_rtc_probe_irq(pdev, info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get rtc irq\n");
+		goto err_clk;
+	}
+
 	info->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed to find rtc clock source\n");
 		ret = PTR_ERR(info->clk);
 		goto err_clk;
 	}
-	info->irq_1hz = irq_1hz;
-	info->irq_alarm = irq_alarm;
 	spin_lock_init(&info->lock);
 	platform_set_drvdata(pdev, info);
 
@@ -357,6 +394,7 @@ static struct platform_driver sa1100_rtc_driver = {
 #ifdef CONFIG_PM
 		.pm	= &sa1100_rtc_pm_ops,
 #endif
+		.of_match_table = sa1100_rtc_dt_ids,
 	},
 };
 
-- 
1.7.0.4
