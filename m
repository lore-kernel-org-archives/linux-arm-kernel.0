From: robh@kernel.org (Rob Herring)
Date: Wed, 13 May 2015 10:02:25 -0500
Subject: [PATCH v4 1/6] rtc: sa1100: prepare to share sa1100_rtc_ops
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Message-ID: <1431529350-4597-2-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the RTC initialization from the platform device specific
parts in order to share the RTC device ops with other drivers.
Specifically, it will be shared with rtc-pxa driver.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-sa1100.c | 59 ++++++++++++++++++++++++------------------------
 drivers/rtc/rtc-sa1100.h | 19 ++++++++++++++++
 2 files changed, 49 insertions(+), 29 deletions(-)
 create mode 100644 drivers/rtc/rtc-sa1100.h

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index b6e1ca0..abc19ab 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -42,17 +42,12 @@
 #include <mach/regs-rtc.h>
 #endif
 
+#include "rtc-sa1100.h"
+
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
 #define RTC_FREQ		1024
 
-struct sa1100_rtc {
-	spinlock_t		lock;
-	int			irq_1hz;
-	int			irq_alarm;
-	struct rtc_device	*rtc;
-	struct clk		*clk;
-};
 
 static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 {
@@ -223,29 +218,18 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 	.alarm_irq_enable = sa1100_rtc_alarm_irq_enable,
 };
 
-static int sa1100_rtc_probe(struct platform_device *pdev)
+int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 {
 	struct rtc_device *rtc;
-	struct sa1100_rtc *info;
-	int irq_1hz, irq_alarm, ret = 0;
+	int ret;
 
-	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
-	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
-	if (irq_1hz < 0 || irq_alarm < 0)
-		return -ENODEV;
+	spin_lock_init(&info->lock);
 
-	info = devm_kzalloc(&pdev->dev, sizeof(struct sa1100_rtc), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 	info->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed to find rtc clock source\n");
 		return PTR_ERR(info->clk);
 	}
-	info->irq_1hz = irq_1hz;
-	info->irq_alarm = irq_alarm;
-	spin_lock_init(&info->lock);
-	platform_set_drvdata(pdev, info);
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret)
@@ -265,14 +249,11 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 		RCNR = 0;
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
-
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name, &sa1100_rtc_ops,
 					THIS_MODULE);
-
 	if (IS_ERR(rtc)) {
-		ret = PTR_ERR(rtc);
-		goto err_dev;
+		clk_disable_unprepare(info->clk);
+		return PTR_ERR(rtc);
 	}
 	info->rtc = rtc;
 
@@ -301,9 +282,29 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	RTSR = RTSR_AL | RTSR_HZ;
 
 	return 0;
-err_dev:
-	clk_disable_unprepare(info->clk);
-	return ret;
+}
+EXPORT_SYMBOL_GPL(sa1100_rtc_init);
+
+static int sa1100_rtc_probe(struct platform_device *pdev)
+{
+	struct sa1100_rtc *info;
+	int irq_1hz, irq_alarm;
+
+	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
+	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
+	if (irq_1hz < 0 || irq_alarm < 0)
+		return -ENODEV;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(struct sa1100_rtc), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->irq_1hz = irq_1hz;
+	info->irq_alarm = irq_alarm;
+
+	platform_set_drvdata(pdev, info);
+	device_init_wakeup(&pdev->dev, 1);
+
+	return sa1100_rtc_init(pdev, info);
 }
 
 static int sa1100_rtc_remove(struct platform_device *pdev)
diff --git a/drivers/rtc/rtc-sa1100.h b/drivers/rtc/rtc-sa1100.h
new file mode 100644
index 0000000..665d054
--- /dev/null
+++ b/drivers/rtc/rtc-sa1100.h
@@ -0,0 +1,19 @@
+#ifndef __RTC_SA1100_H__
+#define __RTC_SA1100_H__
+
+#include <linux/kernel.h>
+
+struct clk;
+struct platform_device;
+
+struct sa1100_rtc {
+	spinlock_t		lock;
+	int			irq_1hz;
+	int			irq_alarm;
+	struct rtc_device	*rtc;
+	struct clk		*clk;
+};
+
+int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info);
+
+#endif
-- 
2.1.0
