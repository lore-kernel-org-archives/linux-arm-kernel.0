From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 27 Jun 2011 20:43:26 +0900
Subject: [PATCH 3/3] rtc: rtc-s3c: allow multiple open / allow no-ioctl-open'ed
	rtc to have irq.
In-Reply-To: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309175006-9218-4-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous rtc-s3c had two issues related with its IRQ.
1. Users cannot open rtc multiple times because an open operation calls
request_irq on the same IRQ. (e.g., two user processes wants to open and
read RTC time from rtc-s3c at the same time)
2. If alarm is set and no one has the rtc opened with filesystem
(either the alarm is set by kernel/boot-loader or user set an alarm
and closed rtc dev file), the pending bit is not cleared and no further
interrupt is invoked. When the alarm is used by the system itself such
as a resume from suspend-to-RAM or other Low-power modes/idle, this is a
critical issue.

This patch mitigates these issue by calling request_irq at probe and
free_irq at remove.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/rtc/rtc-s3c.c |   63 ++++++++++++++----------------------------------
 1 files changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index be85ea5..8d2807f 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -320,50 +320,7 @@ static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
 	return 0;
 }
 
-static int s3c_rtc_open(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
-			  IRQF_DISABLED,  "s3c2410-rtc alarm", rtc_dev);
-
-	if (ret) {
-		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_alarmno, ret);
-		return ret;
-	}
-
-	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
-			  IRQF_DISABLED,  "s3c2410-rtc tick", rtc_dev);
-
-	if (ret) {
-		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_tickno, ret);
-		goto tick_err;
-	}
-
-	return ret;
-
- tick_err:
-	free_irq(s3c_rtc_alarmno, rtc_dev);
-	return ret;
-}
-
-static void s3c_rtc_release(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
-
-	/* do not clear AIE here, it may be needed for wake */
-
-	free_irq(s3c_rtc_alarmno, rtc_dev);
-	free_irq(s3c_rtc_tickno, rtc_dev);
-}
-
-
 static const struct rtc_class_ops s3c_rtcops = {
-	.open		= s3c_rtc_open,
-	.release	= s3c_rtc_release,
 	.read_time	= s3c_rtc_gettime,
 	.set_time	= s3c_rtc_settime,
 	.read_alarm	= s3c_rtc_getalarm,
@@ -427,6 +384,9 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(dev);
 
+	free_irq(s3c_rtc_alarmno, rtc);
+	free_irq(s3c_rtc_tickno, rtc);
+
 	platform_set_drvdata(dev, NULL);
 	rtc_device_unregister(rtc);
 
@@ -553,8 +513,23 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	clk_disable(rtc_clk);
 
-	return 0;
+	ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
+			  IRQF_DISABLED,  "s3c2410-rtc alarm", rtc);
 
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ%d error %d\n", s3c_rtc_alarmno, ret);
+		return ret;
+	}
+
+	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
+			  IRQF_DISABLED,  "s3c2410-rtc tick", rtc);
+
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ%d error %d\n", s3c_rtc_tickno, ret);
+		free_irq(s3c_rtc_alarmno, rtc);
+	}
+
+	return ret;
  err_nortc:
 	s3c_rtc_enable(pdev, 0);
 	clk_disable(rtc_clk);
-- 
1.7.4.1
