From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  1 Feb 2010 14:53:19 +0100
Subject: [PATCH] Modify PL031 for Nomadik and U8500
Message-ID: <1265032400-28558-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extends the existing PrimeCell PL031 driver with support for
the ST Microelectronics and ST-Ericsson derivatives, in a first
and second version as used on the Nomadik and U8500 platforms.
It also rids the old ioctl() alarm on/off functions in favor of
the new .alarm_irq_enable field of the RTC class ops.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Note: I cannot find any in-kernel users of this driver, no
platforms have it in their defconfig. But for mach-nomadik and
mach-u8500 we will certainly use this driver. Patches to make use
of it will follow.
---
 drivers/rtc/rtc-pl031.c |  361 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 323 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 0264b11..c81f14f 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -7,6 +7,13 @@
  *
  * Copyright 2006 (c) MontaVista Software, Inc.
  *
+ * Changes by Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
+ *	-Added support for ST Micros variants of PL031 IP.
+ *		IP v1 added a periodic timer.
+ *		IP v2 further changed the time and alarm data format.
+ *	 Even with these differences these variants identify themselves as
+ *		PL031.
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -18,6 +25,9 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/io.h>
+#include <linux/bcd.h>
+#include <linux/delay.h>
+#include <linux/version.h>
 
 /*
  * Register definitions
@@ -30,35 +40,212 @@
 #define	RTC_RIS		0x14	/* Raw interrupt status register */
 #define	RTC_MIS		0x18	/* Masked interrupt status register */
 #define	RTC_ICR		0x1c	/* Interrupt clear register */
+/* ST variants have additional timer functionality */
+#define RTC_TDR		0x20	/* Timer data read register */
+#define RTC_TLR		0x24	/* Timer data load register */
+#define RTC_TCR		0x28	/* Timer control register */
+#define RTC_YDR		0x30	/* Year data read register */
+#define RTC_YMR		0x34	/* Year match register */
+#define RTC_YLR		0x38	/* Year data load register */
+
+#define RTC_CR_CWEN	(1 << 26)	/* Clockwatch enable bit */
+
+#define RTC_TCR_EN	(1 << 1) /* Periodic timer enable bit */
+
+/* Common bit definitions for Interrupt status and control registers */
+#define RTC_BIT_AI	(1 << 0) /* Alarm interrupt bit */
+#define RTC_BIT_PI	(1 << 1) /* Periodic interrupt bit. ST variants only. */
+
+/* Common bit definations for ST v2 for reading/writing time */
+#define RTC_SEC_SHIFT 0
+#define RTC_SEC_MASK (0x3F << RTC_SEC_SHIFT) /* Second [0-59] */
+#define RTC_MIN_SHIFT 6
+#define RTC_MIN_MASK (0x3F << RTC_MIN_SHIFT) /* Minute [0-59] */
+#define RTC_HOUR_SHIFT 12
+#define RTC_HOUR_MASK (0x1F << RTC_HOUR_SHIFT) /* Hour [0-23] */
+#define RTC_WDAY_SHIFT 17
+#define RTC_WDAY_MASK (0x7 << RTC_WDAY_SHIFT) /* Day of Week [1-7] 1=Sunday */
+#define RTC_MDAY_SHIFT 20
+#define RTC_MDAY_MASK (0x1F << RTC_MDAY_SHIFT) /* Day of Month [1-31] */
+#define RTC_MON_SHIFT 25
+#define RTC_MON_MASK (0xF << RTC_MON_SHIFT) /* Month [1-12] 1=January */
+
+#define RTC_TIMER_FREQ 32768
 
 struct pl031_local {
 	struct rtc_device *rtc;
 	void __iomem *base;
+	struct rtc_class_ops ops;
+	u8 hw_designer;
+	u8 hw_revision:4;
 };
 
-static irqreturn_t pl031_interrupt(int irq, void *dev_id)
+static int pl031_alarm_irq_enable(struct device *dev,
+	unsigned int enabled)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+	unsigned long imsc;
+
+	/* Clear any pending alarm interrupts. */
+	writel(RTC_BIT_AI, ldata->base + RTC_ICR);
+
+	imsc = readl(ldata->base + RTC_IMSC);
+
+	if (enabled == 1)
+		writel(imsc | RTC_BIT_AI, ldata->base + RTC_IMSC);
+	else
+		writel(imsc & ~RTC_BIT_AI, ldata->base + RTC_IMSC);
+
+	return 0;
+}
+
+/*
+ * Convert Gregorian date to ST v2 RTC format.
+ */
+static int pl031_stv2_tm_to_time(struct rtc_time *tm, unsigned long *st_time,
+	unsigned long *bcd_year)
+{
+	int year = tm->tm_year + 1900;
+	int wday = tm->tm_wday;
+
+	/* wday masking is not working in hardware so wday must be valid */
+	if (wday < -1 || wday > 6) {
+
+		printk(KERN_ERR"rtc-pl031: Invalid wday value %d\n",
+			tm->tm_wday);
+		return -EINVAL;
+
+	} else if (wday == -1) {
+
+		/* wday is not provided, calculate it here */
+		unsigned long time;
+		struct rtc_time calc_tm;
+
+		rtc_tm_to_time(tm, &time);
+		rtc_time_to_tm(time, &calc_tm);
+		wday = calc_tm.tm_wday;
+	}
+
+	*bcd_year = (bin2bcd(year % 100) | bin2bcd(year / 100) << 8);
+
+	*st_time = ((tm->tm_mon + 1) << RTC_MON_SHIFT)
+			|	(tm->tm_mday << RTC_MDAY_SHIFT)
+			|	((wday + 1) << RTC_WDAY_SHIFT)
+			|	(tm->tm_hour << RTC_HOUR_SHIFT)
+			|	(tm->tm_min << RTC_MIN_SHIFT)
+			|	(tm->tm_sec << RTC_SEC_SHIFT);
+
+	return 0;
+}
+
+/*
+ * Convert ST v2 RTC format to Gregorian date.
+ */
+static int pl031_stv2_time_to_tm(unsigned long st_time, unsigned long bcd_year,
+	struct rtc_time *tm)
+{
+	tm->tm_year = bcd2bin(bcd_year) + (bcd2bin(bcd_year >> 8) * 100);
+	tm->tm_mon  = ((st_time & RTC_MON_MASK) >> RTC_MON_SHIFT) - 1;
+	tm->tm_mday = ((st_time & RTC_MDAY_MASK) >> RTC_MDAY_SHIFT);
+	tm->tm_wday = ((st_time & RTC_WDAY_MASK) >> RTC_WDAY_SHIFT) - 1;
+	tm->tm_hour = ((st_time & RTC_HOUR_MASK) >> RTC_HOUR_SHIFT);
+	tm->tm_min  = ((st_time & RTC_MIN_MASK) >> RTC_MIN_SHIFT);
+	tm->tm_sec  = ((st_time & RTC_SEC_MASK) >> RTC_SEC_SHIFT);
+
+	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+	tm->tm_year -= 1900;
+
+	return 0;
+}
+
+static int pl031_stv2_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	pl031_stv2_time_to_tm(readl(ldata->base + RTC_DR),
+			readl(ldata->base + RTC_YDR), tm);
+
+	return 0;
+}
+
+static int pl031_stv2_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct rtc_device *rtc = dev_id;
+	unsigned long time;
+	unsigned long bcd_year;
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pl031_stv2_tm_to_time(tm, &time, &bcd_year);
 
-	rtc_update_irq(rtc, 1, RTC_AF);
+	if (ret == 0) {
+		writel(bcd_year, ldata->base + RTC_YLR);
+		writel(time, ldata->base + RTC_LR);
+	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
-static int pl031_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+static int pl031_stv2_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pl031_stv2_time_to_tm(readl(ldata->base + RTC_MR),
+			readl(ldata->base + RTC_YMR), &alarm->time);
+
+	alarm->pending = readl(ldata->base + RTC_RIS) & RTC_BIT_AI;
+	alarm->enabled = readl(ldata->base + RTC_IMSC) & RTC_BIT_AI;
+
+	return ret;
+}
+
+static int pl031_stv2_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+	unsigned long time;
+	unsigned long bcd_year;
+	int ret;
+
+	/* At the moment, we can only deal with non-wildcarded alarm times. */
+	ret = rtc_valid_tm(&alarm->time);
+
+	if (ret == 0) {
+		ret = pl031_stv2_tm_to_time(&alarm->time, &time, &bcd_year);
+		if (ret == 0) {
+			writel(bcd_year, ldata->base + RTC_YMR);
+			writel(time, ldata->base + RTC_MR);
+
+			pl031_alarm_irq_enable(dev, alarm->enabled);
+		}
+	}
 
-	switch (cmd) {
-	case RTC_AIE_OFF:
-		writel(1, ldata->base + RTC_MIS);
-		return 0;
-	case RTC_AIE_ON:
-		writel(0, ldata->base + RTC_MIS);
-		return 0;
+	return ret;
+}
+
+static irqreturn_t pl031_interrupt(int irq, void *dev_id)
+{
+	struct pl031_local *ldata = dev_id;
+	unsigned long rtcmis;
+	unsigned long events = 0;
+
+	rtcmis = readl(ldata->base + RTC_MIS);
+	if (rtcmis) {
+		writel(rtcmis, ldata->base + RTC_ICR);
+
+		if (rtcmis & RTC_BIT_AI)
+			events |= (RTC_AF | RTC_IRQF);
+
+		/* Timer interrupt is only available in ST variants */
+		if ((rtcmis & RTC_BIT_PI) &&
+			(ldata->hw_designer == AMBA_VENDOR_ST))
+			events |= (RTC_PF | RTC_IRQF);
+
+		rtc_update_irq(ldata->rtc, 1, events);
+
+		return IRQ_HANDLED;
 	}
 
-	return -ENOIOCTLCMD;
+	return IRQ_NONE;
 }
 
 static int pl031_read_time(struct device *dev, struct rtc_time *tm)
@@ -74,11 +261,14 @@ static int pl031_set_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long time;
 	struct pl031_local *ldata = dev_get_drvdata(dev);
+	int ret;
 
-	rtc_tm_to_time(tm, &time);
-	writel(time, ldata->base + RTC_LR);
+	ret = rtc_tm_to_time(tm, &time);
 
-	return 0;
+	if (ret == 0)
+		writel(time, ldata->base + RTC_LR);
+
+	return ret;
 }
 
 static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
@@ -86,8 +276,9 @@ static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
 	rtc_time_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
-	alarm->pending = readl(ldata->base + RTC_RIS);
-	alarm->enabled = readl(ldata->base + RTC_IMSC);
+
+	alarm->pending = readl(ldata->base + RTC_RIS) & RTC_BIT_AI;
+	alarm->enabled = readl(ldata->base + RTC_IMSC) & RTC_BIT_AI;
 
 	return 0;
 }
@@ -96,22 +287,73 @@ static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 	unsigned long time;
+	int ret;
 
-	rtc_tm_to_time(&alarm->time, &time);
+	/* At the moment, we can only deal with non-wildcarded alarm times. */
+	ret = rtc_valid_tm(&alarm->time);
 
-	writel(time, ldata->base + RTC_MR);
-	writel(!alarm->enabled, ldata->base + RTC_MIS);
+	if (ret == 0) {
+		ret = rtc_tm_to_time(&alarm->time, &time);
+		if (ret == 0) {
+			writel(time, ldata->base + RTC_MR);
+			pl031_alarm_irq_enable(dev, alarm->enabled);
+		}
+	}
+
+	return ret;
+}
+
+/* Periodic interrupt is only available in ST variants. */
+static int pl031_irq_set_state(struct device *dev, int enabled)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	if (enabled == 1) {
+		/* Clear any pending timer interrupt. */
+		writel(RTC_BIT_PI, ldata->base + RTC_ICR);
+
+		writel(readl(ldata->base + RTC_IMSC) | RTC_BIT_PI,
+			ldata->base + RTC_IMSC);
+
+		/* Now start the timer */
+		writel(readl(ldata->base + RTC_TCR) | RTC_TCR_EN,
+			ldata->base + RTC_TCR);
+
+	} else {
+
+		writel(readl(ldata->base + RTC_IMSC) & (~RTC_BIT_PI),
+			ldata->base + RTC_IMSC);
+
+		/* Also stop the timer */
+		writel(readl(ldata->base + RTC_TCR) & (~RTC_TCR_EN),
+			ldata->base + RTC_TCR);
+	}
+	/* Wait at least 1 RTC32 clock cycle to ensure next access
+	 * to RTC_TCR will succeed.
+	 */
+	udelay(40);
 
 	return 0;
 }
 
-static const struct rtc_class_ops pl031_ops = {
-	.ioctl = pl031_ioctl,
-	.read_time = pl031_read_time,
-	.set_time = pl031_set_time,
-	.read_alarm = pl031_read_alarm,
-	.set_alarm = pl031_set_alarm,
-};
+static int pl031_irq_set_freq(struct device *dev, int freq)
+{
+	struct pl031_local *ldata = dev_get_drvdata(dev);
+
+	/* Cant set timer if it is already enabled */
+	if (readl(ldata->base + RTC_TCR) & RTC_TCR_EN) {
+		printk(KERN_ERR"rtc-pl031: Cant change frequency while timer enabled\n");
+		return -EINVAL;
+	}
+
+	/* If self start bit in RTC_TCR is set timer will start here,
+	 * but we never set that bit. Instead we start the timer when
+	 * set_state is called with enabled == 1.
+	 */
+	writel(RTC_TIMER_FREQ / freq, ldata->base + RTC_TLR);
+
+	return 0;
+}
 
 static int pl031_remove(struct amba_device *adev)
 {
@@ -136,13 +378,14 @@ static int pl031_probe(struct amba_device *adev, struct amba_id *id)
 	if (ret)
 		goto err_req;
 
-	ldata = kmalloc(sizeof(struct pl031_local), GFP_KERNEL);
+	ldata = kzalloc(sizeof(struct pl031_local), GFP_KERNEL);
 	if (!ldata) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	ldata->base = ioremap(adev->res.start, resource_size(&adev->res));
+
 	if (!ldata->base) {
 		ret = -ENOMEM;
 		goto out_no_remap;
@@ -150,24 +393,56 @@ static int pl031_probe(struct amba_device *adev, struct amba_id *id)
 
 	amba_set_drvdata(adev, ldata);
 
-	if (request_irq(adev->irq[0], pl031_interrupt, IRQF_DISABLED,
-			"rtc-pl031", ldata->rtc)) {
-		ret = -EIO;
-		goto out_no_irq;
+	ldata->hw_designer = amba_manf(adev);
+	ldata->hw_revision = amba_rev(adev);
+
+	dev_dbg(&adev->dev, "designer ID = 0x%02x\n", ldata->hw_designer);
+	dev_dbg(&adev->dev, "revision = 0x%01x\n", ldata->hw_revision);
+
+	/* Fill in Class Ops based on the variant */
+	if ((ldata->hw_designer == AMBA_VENDOR_ST) &&
+		(ldata->hw_revision > 1)) {
+
+		ldata->ops.read_time = pl031_stv2_read_time;
+		ldata->ops.set_time = pl031_stv2_set_time;
+		ldata->ops.read_alarm = pl031_stv2_read_alarm;
+		ldata->ops.set_alarm = pl031_stv2_set_alarm;
+
+		writel(readl(ldata->base + RTC_CR) | RTC_CR_CWEN,
+		       ldata->base + RTC_CR);
+	} else {
+
+		ldata->ops.read_time = pl031_read_time;
+		ldata->ops.set_time = pl031_set_time;
+		ldata->ops.read_alarm = pl031_read_alarm;
+		ldata->ops.set_alarm = pl031_set_alarm;
 	}
 
-	ldata->rtc = rtc_device_register("pl031", &adev->dev, &pl031_ops,
-					 THIS_MODULE);
+	/* Timer is not available in ARMs variant */
+	if (ldata->hw_designer == AMBA_VENDOR_ST) {
+		ldata->ops.irq_set_state = pl031_irq_set_state;
+		ldata->ops.irq_set_freq = pl031_irq_set_freq;
+	}
+
+	ldata->ops.alarm_irq_enable = pl031_alarm_irq_enable;
+	ldata->rtc = rtc_device_register("pl031", &adev->dev, &ldata->ops,
+					THIS_MODULE);
 	if (IS_ERR(ldata->rtc)) {
 		ret = PTR_ERR(ldata->rtc);
 		goto out_no_rtc;
 	}
 
+	if (request_irq(adev->irq[0], pl031_interrupt,
+			IRQF_DISABLED | IRQF_SHARED, "rtc-pl031", ldata)) {
+		ret = -EIO;
+		goto out_no_irq;
+	}
+
 	return 0;
 
-out_no_rtc:
-	free_irq(adev->irq[0], ldata->rtc);
 out_no_irq:
+	rtc_device_unregister(ldata->rtc);
+out_no_rtc:
 	iounmap(ldata->base);
 	amba_set_drvdata(adev, NULL);
 out_no_remap:
@@ -175,13 +450,23 @@ out_no_remap:
 out:
 	amba_release_regions(adev);
 err_req:
+
 	return ret;
 }
 
 static struct amba_id pl031_ids[] __initdata = {
 	{
 		.id = 0x00041031,
-		.mask = 0x000fffff,
+		.mask = 0x00ffffff,
+	},
+	/* ST Micro variants */
+	{
+		.id = 0x00180031,
+		.mask = 0x00ffffff,
+	},
+	{
+		.id = 0x00280031,
+		.mask = 0x00ffffff,
 	},
 	{0, 0},
 };
-- 
1.6.2.5
