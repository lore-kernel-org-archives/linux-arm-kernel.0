From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 24 Feb 2012 00:00:50 +0800
Subject: [PATCH v3 6/7] rtc: sa1100: enable clk support
In-Reply-To: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330012851-13693-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable clock support on rtc-sa1100.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 0a36c7e..962510c 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -23,6 +23,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 #include <linux/rtc.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -48,6 +49,7 @@ struct sa1100_rtc {
 	int			irq_1hz;
 	int			irq_alarm;
 	struct rtc_device	*rtc;
+	struct clk		*clk;
 };
 
 static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
@@ -104,6 +106,9 @@ static int sa1100_rtc_open(struct device *dev)
 	struct rtc_device *rtc = info->rtc;
 	int ret;
 
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		goto fail_clk;
 	ret = request_irq(info->irq_1hz, sa1100_rtc_interrupt, IRQF_DISABLED,
 		"rtc 1Hz", dev);
 	if (ret) {
@@ -124,6 +129,8 @@ static int sa1100_rtc_open(struct device *dev)
  fail_ai:
 	free_irq(info->irq_1hz, dev);
  fail_ui:
+	clk_disable_unprepare(info->clk);
+ fail_clk:
 	return ret;
 }
 
@@ -137,6 +144,7 @@ static void sa1100_rtc_release(struct device *dev)
 
 	free_irq(info->irq_alarm, dev);
 	free_irq(info->irq_1hz, dev);
+	clk_disable_unprepare(info->clk);
 }
 
 static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
@@ -234,6 +242,12 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	info = kzalloc(sizeof(struct sa1100_rtc), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
+	info->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(info->clk)) {
+		dev_err(&pdev->dev, "failed to find rtc clock source\n");
+		ret = PTR_ERR(info->clk);
+		goto err_clk;
+	}
 	info->irq_1hz = irq_1hz;
 	info->irq_alarm = irq_alarm;
 	spin_lock_init(&info->lock);
@@ -292,6 +306,8 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	return 0;
 err_dev:
 	platform_set_drvdata(pdev, NULL);
+	clk_put(info->clk);
+err_clk:
 	kfree(info);
 	return ret;
 }
@@ -302,6 +318,7 @@ static int sa1100_rtc_remove(struct platform_device *pdev)
 
 	if (info) {
 		rtc_device_unregister(info->rtc);
+		clk_put(info->clk);
 		platform_set_drvdata(pdev, NULL);
 		kfree(info);
 	}
-- 
1.7.0.4
