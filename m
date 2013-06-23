From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 23 Jun 2013 12:32:27 +0400
Subject: [PATCH v2 1/3] rtc: mxc_rtc: Driver rework
Message-ID: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rework mxc_rtc driver.
Major changes have been made:
- Added second clock support (optional) which permit module functionality.
- Implemented support for periodic interrupts.
- Code have been optimized and cleaned.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/rtc/rtc-mxc.c | 382 +++++++++++++++++++++-----------------------------
 1 file changed, 159 insertions(+), 223 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index ab87bac..90b0222 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/rtc.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -21,54 +20,37 @@
 #define RTC_INPUT_CLK_32000HZ	(0x01 << 5)
 #define RTC_INPUT_CLK_38400HZ	(0x02 << 5)
 
-#define RTC_SW_BIT      (1 << 0)
-#define RTC_ALM_BIT     (1 << 2)
-#define RTC_1HZ_BIT     (1 << 4)
-#define RTC_2HZ_BIT     (1 << 7)
-#define RTC_SAM0_BIT    (1 << 8)
-#define RTC_SAM1_BIT    (1 << 9)
-#define RTC_SAM2_BIT    (1 << 10)
-#define RTC_SAM3_BIT    (1 << 11)
-#define RTC_SAM4_BIT    (1 << 12)
-#define RTC_SAM5_BIT    (1 << 13)
-#define RTC_SAM6_BIT    (1 << 14)
-#define RTC_SAM7_BIT    (1 << 15)
-#define PIT_ALL_ON      (RTC_2HZ_BIT | RTC_SAM0_BIT | RTC_SAM1_BIT | \
+#define RTC_SW_BIT	BIT(0)
+#define RTC_ALM_BIT	BIT(2)
+#define RTC_1HZ_BIT	BIT(4)
+#define RTC_2HZ_BIT	BIT(7)
+#define RTC_SAM0_BIT	BIT(8)
+#define RTC_SAM1_BIT	BIT(9)
+#define RTC_SAM2_BIT	BIT(10)
+#define RTC_SAM3_BIT	BIT(11)
+#define RTC_SAM4_BIT	BIT(12)
+#define RTC_SAM5_BIT	BIT(13)
+#define RTC_SAM6_BIT	BIT(14)
+#define RTC_SAM7_BIT	BIT(15)
+#define PIT_ALL_ON	(RTC_2HZ_BIT | RTC_SAM0_BIT | RTC_SAM1_BIT | \
 			 RTC_SAM2_BIT | RTC_SAM3_BIT | RTC_SAM4_BIT | \
 			 RTC_SAM5_BIT | RTC_SAM6_BIT | RTC_SAM7_BIT)
 
-#define RTC_ENABLE_BIT  (1 << 7)
-
-#define MAX_PIE_NUM     9
-#define MAX_PIE_FREQ    512
-static const u32 PIE_BIT_DEF[MAX_PIE_NUM][2] = {
-	{ 2,		RTC_2HZ_BIT },
-	{ 4,		RTC_SAM0_BIT },
-	{ 8,		RTC_SAM1_BIT },
-	{ 16,		RTC_SAM2_BIT },
-	{ 32,		RTC_SAM3_BIT },
-	{ 64,		RTC_SAM4_BIT },
-	{ 128,		RTC_SAM5_BIT },
-	{ 256,		RTC_SAM6_BIT },
-	{ MAX_PIE_FREQ,	RTC_SAM7_BIT },
-};
+#define RTC_ENABLE_BIT	BIT(7)
 
 #define MXC_RTC_TIME	0
 #define MXC_RTC_ALARM	1
 
-#define RTC_HOURMIN	0x00	/*  32bit rtc hour/min counter reg */
-#define RTC_SECOND	0x04	/*  32bit rtc seconds counter reg */
-#define RTC_ALRM_HM	0x08	/*  32bit rtc alarm hour/min reg */
-#define RTC_ALRM_SEC	0x0C	/*  32bit rtc alarm seconds reg */
-#define RTC_RTCCTL	0x10	/*  32bit rtc control reg */
-#define RTC_RTCISR	0x14	/*  32bit rtc interrupt status reg */
-#define RTC_RTCIENR	0x18	/*  32bit rtc interrupt enable reg */
-#define RTC_STPWCH	0x1C	/*  32bit rtc stopwatch min reg */
-#define RTC_DAYR	0x20	/*  32bit rtc days counter reg */
-#define RTC_DAYALARM	0x24	/*  32bit rtc day alarm reg */
-#define RTC_TEST1	0x28	/*  32bit rtc test reg 1 */
-#define RTC_TEST2	0x2C	/*  32bit rtc test reg 2 */
-#define RTC_TEST3	0x30	/*  32bit rtc test reg 3 */
+#define RTC_HOURMIN	0x00	/*  rtc hour/min counter */
+#define RTC_SECOND	0x04	/*  rtc seconds counter */
+#define RTC_ALRM_HM	0x08	/*  rtc alarm hour/min */
+#define RTC_ALRM_SEC	0x0c	/*  rtc alarm seconds */
+#define RTC_RTCCTL	0x10	/*  rtc control */
+#define RTC_RTCISR	0x14	/*  rtc interrupt status */
+#define RTC_RTCIENR	0x18	/*  rtc interrupt enable */
+#define RTC_STPWCH	0x1c	/*  rtc stopwatch min */
+#define RTC_DAYR	0x20	/*  rtc days counter */
+#define RTC_DAYALARM	0x24	/*  rtc day alarm */
 
 enum imx_rtc_type {
 	IMX1_RTC,
@@ -76,54 +58,29 @@ enum imx_rtc_type {
 };
 
 struct rtc_plat_data {
-	struct rtc_device *rtc;
-	void __iomem *ioaddr;
-	int irq;
-	struct clk *clk;
-	struct rtc_time g_rtc_alarm;
-	enum imx_rtc_type devtype;
-};
-
-static struct platform_device_id imx_rtc_devtype[] = {
-	{
-		.name = "imx1-rtc",
-		.driver_data = IMX1_RTC,
-	}, {
-		.name = "imx21-rtc",
-		.driver_data = IMX21_RTC,
-	}, {
-		/* sentinel */
-	}
+	struct rtc_device	*rtc;
+	struct rtc_class_ops	rtc_ops;
+	void __iomem		*ioaddr;
+	int			irq;
+	struct clk		*clk_rtc;
+	struct clk		*clk_ipg;
+	enum imx_rtc_type	devtype;
 };
-MODULE_DEVICE_TABLE(platform, imx_rtc_devtype);
 
-static inline int is_imx1_rtc(struct rtc_plat_data *data)
-{
-	return data->devtype == IMX1_RTC;
-}
-
-/*
- * This function is used to obtain the RTC time or the alarm value in
- * second.
- */
 static u32 get_alarm_or_time(struct device *dev, int time_alarm)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
-	u32 day = 0, hr = 0, min = 0, sec = 0, hr_min = 0;
-
-	switch (time_alarm) {
-	case MXC_RTC_TIME:
-		day = readw(ioaddr + RTC_DAYR);
-		hr_min = readw(ioaddr + RTC_HOURMIN);
-		sec = readw(ioaddr + RTC_SECOND);
-		break;
-	case MXC_RTC_ALARM:
-		day = readw(ioaddr + RTC_DAYALARM);
-		hr_min = readw(ioaddr + RTC_ALRM_HM) & 0xffff;
-		sec = readw(ioaddr + RTC_ALRM_SEC);
-		break;
+	u32 day, hr, min, sec, hr_min;
+
+	if (time_alarm == MXC_RTC_TIME) {
+		day = readw(pdata->ioaddr + RTC_DAYR);
+		hr_min = readw(pdata->ioaddr + RTC_HOURMIN);
+		sec = readw(pdata->ioaddr + RTC_SECOND);
+	} else {
+		day = readw(pdata->ioaddr + RTC_DAYALARM);
+		hr_min = readw(pdata->ioaddr + RTC_ALRM_HM);
+		sec = readw(pdata->ioaddr + RTC_ALRM_SEC);
 	}
 
 	hr = hr_min >> 8;
@@ -132,15 +89,11 @@ static u32 get_alarm_or_time(struct device *dev, int time_alarm)
 	return (((day * 24 + hr) * 60) + min) * 60 + sec;
 }
 
-/*
- * This function sets the RTC alarm value or the time value.
- */
 static void set_alarm_or_time(struct device *dev, int time_alarm, u32 time)
 {
 	u32 day, hr, min, sec, temp;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
 
 	day = time / 86400;
 	time -= day * 86400;
@@ -155,31 +108,23 @@ static void set_alarm_or_time(struct device *dev, int time_alarm, u32 time)
 
 	temp = (hr << 8) + min;
 
-	switch (time_alarm) {
-	case MXC_RTC_TIME:
-		writew(day, ioaddr + RTC_DAYR);
-		writew(sec, ioaddr + RTC_SECOND);
-		writew(temp, ioaddr + RTC_HOURMIN);
-		break;
-	case MXC_RTC_ALARM:
-		writew(day, ioaddr + RTC_DAYALARM);
-		writew(sec, ioaddr + RTC_ALRM_SEC);
-		writew(temp, ioaddr + RTC_ALRM_HM);
-		break;
+	if (time_alarm == MXC_RTC_TIME) {
+		writew(day, pdata->ioaddr + RTC_DAYR);
+		writew(sec, pdata->ioaddr + RTC_SECOND);
+		writew(temp, pdata->ioaddr + RTC_HOURMIN);
+	} else {
+		writew(day, pdata->ioaddr + RTC_DAYALARM);
+		writew(sec, pdata->ioaddr + RTC_ALRM_SEC);
+		writew(temp, pdata->ioaddr + RTC_ALRM_HM);
 	}
 }
 
-/*
- * This function updates the RTC alarm registers and then clears all the
- * interrupt status bits.
- */
 static int rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
 {
-	struct rtc_time alarm_tm, now_tm;
-	unsigned long now, time;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
+	struct rtc_time alarm_tm, now_tm;
+	unsigned long now, time;
 
 	now = get_alarm_or_time(dev, MXC_RTC_TIME);
 	rtc_time_to_tm(now, &now_tm);
@@ -191,34 +136,35 @@ static int rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
 	alarm_tm.tm_sec = alrm->tm_sec;
 	rtc_tm_to_time(&alarm_tm, &time);
 
-	/* clear all the interrupt status bits */
-	writew(readw(ioaddr + RTC_RTCISR), ioaddr + RTC_RTCISR);
+	/* clear interrupt status bit */
+	writew(RTC_ALM_BIT, pdata->ioaddr + RTC_RTCISR);
+
 	set_alarm_or_time(dev, MXC_RTC_ALARM, time);
 
 	return 0;
 }
 
 static void mxc_rtc_irq_enable(struct device *dev, unsigned int bit,
-				unsigned int enabled)
+			       unsigned int enabled)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
 	u32 reg;
 
 	spin_lock_irq(&pdata->rtc->irq_lock);
-	reg = readw(ioaddr + RTC_RTCIENR);
 
-	if (enabled)
+	reg = readw(pdata->ioaddr + RTC_RTCIENR);
+	if (enabled) {
 		reg |= bit;
-	else
+		/* Clear interrupt status */
+		writew(reg, pdata->ioaddr + RTC_RTCISR);
+	} else
 		reg &= ~bit;
+	writew(reg, pdata->ioaddr + RTC_RTCIENR);
 
-	writew(reg, ioaddr + RTC_RTCIENR);
 	spin_unlock_irq(&pdata->rtc->irq_lock);
 }
 
-/* This function is the RTC interrupt service routine. */
 static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
@@ -229,58 +175,69 @@ static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
 	u32 events = 0;
 
 	spin_lock_irqsave(&pdata->rtc->irq_lock, flags);
+
 	status = readw(ioaddr + RTC_RTCISR) & readw(ioaddr + RTC_RTCIENR);
 	/* clear interrupt sources */
 	writew(status, ioaddr + RTC_RTCISR);
 
 	/* update irq data & counter */
 	if (status & RTC_ALM_BIT) {
-		events |= (RTC_AF | RTC_IRQF);
+		events |= RTC_AF | RTC_IRQF;
 		/* RTC alarm should be one-shot */
 		mxc_rtc_irq_enable(&pdev->dev, RTC_ALM_BIT, 0);
 	}
 
 	if (status & RTC_1HZ_BIT)
-		events |= (RTC_UF | RTC_IRQF);
+		events |= RTC_UF | RTC_IRQF;
 
 	if (status & PIT_ALL_ON)
-		events |= (RTC_PF | RTC_IRQF);
+		events |= RTC_PF | RTC_IRQF;
 
 	rtc_update_irq(pdata->rtc, 1, events);
+
 	spin_unlock_irqrestore(&pdata->rtc->irq_lock, flags);
 
 	return IRQ_HANDLED;
 }
 
-/*
- * Clear all interrupts and release the IRQ
- */
-static void mxc_rtc_release(struct device *dev)
+static int mxc_rtc_open(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
 
-	spin_lock_irq(&pdata->rtc->irq_lock);
+	if (pdata->irq >= 0) {
+		unsigned long rate = clk_get_rate(pdata->clk_rtc);
 
-	/* Disable all rtc interrupts */
-	writew(0, ioaddr + RTC_RTCIENR);
+		pdata->rtc->max_user_freq = rate / 64;
+		rtc_irq_set_freq(pdata->rtc, NULL, rate / 64);
+		mxc_rtc_irq_enable(&pdev->dev, RTC_1HZ_BIT | RTC_SAM7_BIT, 1);
+	}
 
-	/* Clear all interrupt status */
-	writew(0xffffffff, ioaddr + RTC_RTCISR);
+	return 0;
+}
 
-	spin_unlock_irq(&pdata->rtc->irq_lock);
+static void mxc_rtc_release(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	if (pdata->irq >= 0)
+		mxc_rtc_irq_enable(&pdev->dev, RTC_1HZ_BIT | RTC_SAM7_BIT, 0);
 }
 
 static int mxc_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	mxc_rtc_irq_enable(dev, RTC_ALM_BIT, enabled);
-	return 0;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	if (pdata->irq >= 0) {
+		mxc_rtc_irq_enable(dev, RTC_ALM_BIT, enabled);
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
-/*
- * This function reads the current RTC time into tm in Gregorian date.
- */
 static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	u32 val;
@@ -295,9 +252,6 @@ static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-/*
- * This function sets the internal RTC time based on tm in Gregorian date.
- */
 static int mxc_rtc_set_mmss(struct device *dev, unsigned long time)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -306,7 +260,7 @@ static int mxc_rtc_set_mmss(struct device *dev, unsigned long time)
 	/*
 	 * TTC_DAYR register is 9-bit in MX1 SoC, save time and day of year only
 	 */
-	if (is_imx1_rtc(pdata)) {
+	if (pdata->devtype == IMX1_RTC) {
 		struct rtc_time tm;
 
 		rtc_time_to_tm(time, &tm);
@@ -322,26 +276,17 @@ static int mxc_rtc_set_mmss(struct device *dev, unsigned long time)
 	return 0;
 }
 
-/*
- * This function reads the current alarm value into the passed in 'alrm'
- * argument. It updates the alrm's pending field value based on the whether
- * an alarm interrupt occurs or not.
- */
 static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
 
 	rtc_time_to_tm(get_alarm_or_time(dev, MXC_RTC_ALARM), &alrm->time);
-	alrm->pending = ((readw(ioaddr + RTC_RTCISR) & RTC_ALM_BIT)) ? 1 : 0;
+	alrm->pending = !!(readw(pdata->ioaddr + RTC_RTCISR) & RTC_ALM_BIT);
 
 	return 0;
 }
 
-/*
- * This function sets the RTC alarm based on passed in alrm.
- */
 static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -349,61 +294,41 @@ static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int ret;
 
 	ret = rtc_update_alarm(dev, &alrm->time);
-	if (ret)
-		return ret;
-
-	memcpy(&pdata->g_rtc_alarm, &alrm->time, sizeof(struct rtc_time));
-	mxc_rtc_irq_enable(dev, RTC_ALM_BIT, alrm->enabled);
+	if ((pdata->irq >= 0) && !ret)
+		mxc_rtc_irq_enable(dev, RTC_ALM_BIT, alrm->enabled);
 
-	return 0;
+	return ret;
 }
 
-/* RTC layer */
-static struct rtc_class_ops mxc_rtc_ops = {
-	.release		= mxc_rtc_release,
-	.read_time		= mxc_rtc_read_time,
-	.set_mmss		= mxc_rtc_set_mmss,
-	.read_alarm		= mxc_rtc_read_alarm,
-	.set_alarm		= mxc_rtc_set_alarm,
-	.alarm_irq_enable	= mxc_rtc_alarm_irq_enable,
-};
-
 static int mxc_rtc_probe(struct platform_device *pdev)
 {
+	struct rtc_plat_data *pdata;
 	struct resource *res;
-	struct rtc_device *rtc;
-	struct rtc_plat_data *pdata = NULL;
-	u32 reg;
 	unsigned long rate;
+	u32 reg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->devtype = pdev->id_entry->driver_data;
-
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), pdev->name))
-		return -EBUSY;
-
-	pdata->ioaddr = devm_ioremap(&pdev->dev, res->start,
-				     resource_size(res));
-
-	pdata->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pdata->clk)) {
-		dev_err(&pdev->dev, "unable to get clock!\n");
-		ret = PTR_ERR(pdata->clk);
-		goto exit_free_pdata;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdata->ioaddr))
+		return PTR_ERR(pdata->ioaddr);
+
+	pdata->clk_rtc = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pdata->clk_rtc)) {
+		dev_err(&pdev->dev, "Unable to get clock!\n");
+		return PTR_ERR(pdata->clk_rtc);
 	}
 
-	clk_prepare_enable(pdata->clk);
-	rate = clk_get_rate(pdata->clk);
+	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (!IS_ERR(pdata->clk_ipg))
+		clk_prepare_enable(pdata->clk_ipg);
+	clk_prepare_enable(pdata->clk_rtc);
 
+	rate = clk_get_rate(pdata->clk_rtc);
 	if (rate == 32768)
 		reg = RTC_INPUT_CLK_32768HZ;
 	else if (rate == 32000)
@@ -411,49 +336,55 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	else if (rate == 38400)
 		reg = RTC_INPUT_CLK_38400HZ;
 	else {
-		dev_err(&pdev->dev, "rtc clock is not valid (%lu)\n", rate);
+		dev_err(&pdev->dev, "RTC clock is not valid (%lu)\n", rate);
 		ret = -EINVAL;
 		goto exit_put_clk;
 	}
 
-	reg |= RTC_ENABLE_BIT;
-	writew(reg, (pdata->ioaddr + RTC_RTCCTL));
-	if (((readw(pdata->ioaddr + RTC_RTCCTL)) & RTC_ENABLE_BIT) == 0) {
-		dev_err(&pdev->dev, "hardware module can't be enabled!\n");
+	writew(reg | RTC_ENABLE_BIT, pdata->ioaddr + RTC_RTCCTL);
+	if (!(readw(pdata->ioaddr + RTC_RTCCTL) & RTC_ENABLE_BIT)) {
+		dev_err(&pdev->dev, "Hardware module can't be enabled!\n");
 		ret = -EIO;
 		goto exit_put_clk;
 	}
 
-	platform_set_drvdata(pdev, pdata);
+	/* Disable all interrupts */
+	writew(0, pdata->ioaddr + RTC_RTCIENR);
 
-	/* Configure and enable the RTC */
-	pdata->irq = platform_get_irq(pdev, 0);
+	pdata->devtype = pdev->id_entry->driver_data;
+	platform_set_drvdata(pdev, pdata);
 
-	if (pdata->irq >= 0 &&
-	    devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt,
-			     IRQF_SHARED, pdev->name, pdev) < 0) {
-		dev_warn(&pdev->dev, "interrupt not available.\n");
-		pdata->irq = -1;
+	pdata->rtc_ops.open		= mxc_rtc_open;
+	pdata->rtc_ops.release		= mxc_rtc_release;
+	pdata->rtc_ops.read_time	= mxc_rtc_read_time;
+	pdata->rtc_ops.set_mmss		= mxc_rtc_set_mmss;
+	pdata->rtc_ops.read_alarm	= mxc_rtc_read_alarm;
+	pdata->rtc_ops.set_alarm	= mxc_rtc_set_alarm;
+	pdata->rtc_ops.alarm_irq_enable	= mxc_rtc_alarm_irq_enable;
+
+	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+					      &pdata->rtc_ops, THIS_MODULE);
+	if (IS_ERR(pdata->rtc)) {
+		ret = PTR_ERR(pdata->rtc);
+		goto exit_put_clk;
 	}
 
+	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq >= 0)
-		device_init_wakeup(&pdev->dev, 1);
+		if (devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt,
+				     IRQF_SHARED, pdev->name, pdev) < 0) {
+			dev_warn(&pdev->dev, "Not using interrupt\n");
+			pdata->irq = -1;
+		}
 
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name, &mxc_rtc_ops,
-				  THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		ret = PTR_ERR(rtc);
-		goto exit_put_clk;
-	}
-
-	pdata->rtc = rtc;
+	device_init_wakeup(&pdev->dev, pdata->irq >= 0);
 
 	return 0;
 
 exit_put_clk:
-	clk_disable_unprepare(pdata->clk);
-
-exit_free_pdata:
+	clk_disable_unprepare(pdata->clk_rtc);
+	if (!IS_ERR(pdata->clk_ipg))
+		clk_disable_unprepare(pdata->clk_ipg);
 
 	return ret;
 }
@@ -462,13 +393,14 @@ static int mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(pdata->clk);
+	clk_disable_unprepare(pdata->clk_rtc);
+	if (!IS_ERR(pdata->clk_ipg))
+		clk_disable_unprepare(pdata->clk_ipg);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mxc_rtc_suspend(struct device *dev)
+static int __maybe_unused mxc_rtc_suspend(struct device *dev)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
@@ -478,7 +410,7 @@ static int mxc_rtc_suspend(struct device *dev)
 	return 0;
 }
 
-static int mxc_rtc_resume(struct device *dev)
+static int __maybe_unused mxc_rtc_resume(struct device *dev)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
@@ -487,24 +419,28 @@ static int mxc_rtc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mxc_rtc_pm_ops, mxc_rtc_suspend, mxc_rtc_resume);
 
+static const struct platform_device_id mxc_rtc_id_table[] = {
+	{ .name = "imx1-rtc", .driver_data = IMX1_RTC, },
+	{ .name = "imx21-rtc", .driver_data = IMX21_RTC, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mxc_rtc_id_table);
+
 static struct platform_driver mxc_rtc_driver = {
 	.driver = {
 		   .name	= "mxc_rtc",
-		   .pm		= &mxc_rtc_pm_ops,
 		   .owner	= THIS_MODULE,
+		   .pm		= &mxc_rtc_pm_ops,
 	},
-	.id_table = imx_rtc_devtype,
-	.probe = mxc_rtc_probe,
-	.remove = mxc_rtc_remove,
+	.probe		= mxc_rtc_probe,
+	.remove		= mxc_rtc_remove,
+	.id_table	= mxc_rtc_id_table,
 };
-
 module_platform_driver(mxc_rtc_driver)
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_DESCRIPTION("RTC driver for Freescale MXC");
 MODULE_LICENSE("GPL");
-
-- 
1.8.1.5
