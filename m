From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 24 Aug 2017 00:00:24 +0200
Subject: [PATCH] rtc: mxc: avoid disabling interrupts on device close
Message-ID: <20170823220024.22861-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the IRQs are disabled when the rtc character device is closed.
This means that the device needs to stay open to get alarms while the usual
use case will open the device, set the alarm and close the device as is
done in rtcwake.

Keep the alarm functional on character device release so the platform can
actually wakeup

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-mxc.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 401f46d8f21b..bce427d202ee 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -238,26 +238,6 @@ static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Clear all interrupts and release the IRQ
- */
-static void mxc_rtc_release(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
-
-	spin_lock_irq(&pdata->rtc->irq_lock);
-
-	/* Disable all rtc interrupts */
-	writew(0, ioaddr + RTC_RTCIENR);
-
-	/* Clear all interrupt status */
-	writew(0xffffffff, ioaddr + RTC_RTCISR);
-
-	spin_unlock_irq(&pdata->rtc->irq_lock);
-}
-
 static int mxc_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	mxc_rtc_irq_enable(dev, RTC_ALM_BIT, enabled);
@@ -343,7 +323,6 @@ static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 /* RTC layer */
 static const struct rtc_class_ops mxc_rtc_ops = {
-	.release		= mxc_rtc_release,
 	.read_time		= mxc_rtc_read_time,
 	.set_mmss64		= mxc_rtc_set_mmss,
 	.read_alarm		= mxc_rtc_read_alarm,
-- 
2.14.1
