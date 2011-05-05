From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  5 May 2011 12:22:21 +0200
Subject: [PATCH 6/6] rtc: stmp3xxx: remove UIE handlers
In-Reply-To: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1304590941-11813-7-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC core handles it since 6610e08 (RTC: Rework RTC code to use
timerqueue for events). To make it work, check if interrupts need to be
enabled in set_alarm. Add my copyright after all these changes.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |   53 ++++++++++++-------------------------------
 1 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index b4dd78b..362d025 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -6,6 +6,7 @@
  *
  * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ * Copyright 2011 Wolfram Sang, Pengutronix e.K.
  */
 
 /*
@@ -33,7 +34,6 @@
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
-#define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ		0x00000008
 
 #define STMP3XXX_RTC_STAT		0x10
 #define STMP3XXX_RTC_STAT_STALE_SHIFT		16
@@ -52,9 +52,8 @@
 
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
-	unsigned irq_count;
 	void __iomem *io;
-	int irq_alarm, irq_1msec;
+	int irq_alarm;
 };
 
 static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
@@ -92,31 +91,16 @@ static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
 static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev_id);
-	u32 status;
-	u32 events = 0;
-
-	status = readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
-			(STMP3XXX_RTC_CTRL_ALARM_IRQ | STMP3XXX_RTC_CTRL_ONEMSEC_IRQ);
+	u32 status = readl(rtc_data->io + STMP3XXX_RTC_CTRL);
 
 	if (status & STMP3XXX_RTC_CTRL_ALARM_IRQ) {
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ,
 				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
-		events |= RTC_AF | RTC_IRQF;
+		rtc_update_irq(rtc_data->rtc, 1, RTC_AF | RTC_IRQF);
+		return IRQ_HANDLED;
 	}
 
-	if (status & STMP3XXX_RTC_CTRL_ONEMSEC_IRQ) {
-		writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ,
-				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
-		if (++rtc_data->irq_count % 1000 == 0) {
-			events |= RTC_UF | RTC_IRQF;
-			rtc_data->irq_count = 0;
-		}
-	}
-
-	if (events)
-		rtc_update_irq(rtc_data->rtc, 1, events);
-
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
@@ -154,6 +138,9 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	rtc_tm_to_time(&alm->time, &t);
 	writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
+
+	stmp3xxx_alarm_irq_enable(dev, alm->enabled);
+
 	return 0;
 }
 
@@ -173,10 +160,9 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 	if (!rtc_data)
 		return 0;
 
-	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+	writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
 			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
-	free_irq(rtc_data->irq_1msec, &pdev->dev);
 	rtc_device_unregister(rtc_data->rtc);
 	platform_set_drvdata(pdev, NULL);
 	iounmap(rtc_data->io);
@@ -210,7 +196,6 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc_data->irq_alarm = platform_get_irq(pdev, 0);
-	rtc_data->irq_1msec = platform_get_irq(pdev, 1);
 
 	if (!(readl(STMP3XXX_RTC_STAT + rtc_data->io) &
 			STMP3XXX_RTC_STAT_RTC_PRESENT)) {
@@ -227,6 +212,9 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
 			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
 
+	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+
 	rtc_data->rtc = rtc_device_register(pdev->name, &pdev->dev,
 				&stmp3xxx_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc_data->rtc)) {
@@ -234,7 +222,6 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		goto out_remap;
 	}
 
-	rtc_data->irq_count = 0;
 	err = request_irq(rtc_data->irq_alarm, stmp3xxx_rtc_interrupt,
 			0, "RTC alarm", &pdev->dev);
 	if (err) {
@@ -242,21 +229,10 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 			rtc_data->irq_alarm);
 		goto out_irq_alarm;
 	}
-	err = request_irq(rtc_data->irq_1msec, stmp3xxx_rtc_interrupt,
-			0, "RTC tick", &pdev->dev);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
-			rtc_data->irq_1msec);
-		goto out_irq1;
-	}
 
 	return 0;
 
-out_irq1:
-	free_irq(rtc_data->irq_alarm, &pdev->dev);
 out_irq_alarm:
-	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 	rtc_device_unregister(rtc_data->rtc);
 out_remap:
 	platform_set_drvdata(pdev, NULL);
@@ -313,5 +289,6 @@ module_init(stmp3xxx_rtc_init);
 module_exit(stmp3xxx_rtc_exit);
 
 MODULE_DESCRIPTION("STMP3xxx RTC Driver");
-MODULE_AUTHOR("dmitry pervushin <dpervushin@embeddedalley.com>");
+MODULE_AUTHOR("dmitry pervushin <dpervushin@embeddedalley.com> and "
+		"Wolfram Sang <w.sang@pengutronix.de>");
 MODULE_LICENSE("GPL");
-- 
1.7.2.5
