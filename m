From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 2 Dec 2016 15:09:56 +0100
Subject: [PATCH 3/8] rtc: add STM32 RTC driver
In-Reply-To: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <1480687801-19525-5-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the STM32 RTC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/Kconfig     |  10 +
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-stm32.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 788 insertions(+)
 create mode 100644 drivers/rtc/rtc-stm32.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d14..dd8b218 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1706,6 +1706,16 @@ config RTC_DRV_PIC32
 	   This driver can also be built as a module. If so, the module
 	   will be called rtc-pic32
 
+config RTC_DRV_STM32
+	tristate "STM32 On-Chip RTC"
+	depends on ARCH_STM32
+	help
+	   If you say yes here you get support for the STM32 On-Chip
+	   Real Time Clock.
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-stm32".
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 1ac694a..87bd9cc 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -144,6 +144,7 @@ obj-$(CONFIG_RTC_DRV_SNVS)	+= rtc-snvs.o
 obj-$(CONFIG_RTC_DRV_SPEAR)	+= rtc-spear.o
 obj-$(CONFIG_RTC_DRV_STARFIRE)	+= rtc-starfire.o
 obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
+obj-$(CONFIG_RTC_DRV_STM32) 	+= rtc-stm32.o
 obj-$(CONFIG_RTC_DRV_STMP)	+= rtc-stmp3xxx.o
 obj-$(CONFIG_RTC_DRV_ST_LPC)	+= rtc-st-lpc.o
 obj-$(CONFIG_RTC_DRV_SUN4V)	+= rtc-sun4v.o
diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
new file mode 100644
index 0000000..9e710ff
--- /dev/null
+++ b/drivers/rtc/rtc-stm32.c
@@ -0,0 +1,777 @@
+/*
+ * Copyright (C) Amelie Delaunay 2015
+ * Author:  Amelie Delaunay <adelaunay.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/bcd.h>
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/spinlock.h>
+
+#define DRIVER_NAME "stm32_rtc"
+
+/* STM32 RTC registers */
+#define STM32_RTC_TR		0x00
+#define STM32_RTC_DR		0x04
+#define STM32_RTC_CR		0x08
+#define STM32_RTC_ISR		0x0C
+#define STM32_RTC_PRER		0x10
+#define STM32_RTC_ALRMAR	0x1C
+#define STM32_RTC_WPR		0x24
+
+/* STM32_RTC_TR bit fields  */
+#define STM32_RTC_TR_SEC_SHIFT		0
+#define STM32_RTC_TR_SEC		GENMASK(6, 0)
+#define STM32_RTC_TR_MIN_SHIFT		8
+#define STM32_RTC_TR_MIN		GENMASK(14, 8)
+#define STM32_RTC_TR_HOUR_SHIFT		16
+#define STM32_RTC_TR_HOUR		GENMASK(21, 16)
+
+/* STM32_RTC_DR bit fields */
+#define STM32_RTC_DR_DATE_SHIFT		0
+#define STM32_RTC_DR_DATE		GENMASK(5, 0)
+#define STM32_RTC_DR_MONTH_SHIFT	8
+#define STM32_RTC_DR_MONTH		GENMASK(11, 8)
+#define STM32_RTC_DR_WDAY_SHIFT		13
+#define STM32_RTC_DR_WDAY		GENMASK(15, 13)
+#define STM32_RTC_DR_YEAR_SHIFT		16
+#define STM32_RTC_DR_YEAR		GENMASK(23, 16)
+
+/* STM32_RTC_CR bit fields */
+#define STM32_RTC_CR_FMT		BIT(6)
+#define STM32_RTC_CR_ALRAE		BIT(8)
+#define STM32_RTC_CR_ALRAIE		BIT(12)
+
+/* STM32_RTC_ISR bit fields */
+#define STM32_RTC_ISR_ALRAWF		BIT(0)
+#define STM32_RTC_ISR_INITS		BIT(4)
+#define STM32_RTC_ISR_RSF		BIT(5)
+#define STM32_RTC_ISR_INITF		BIT(6)
+#define STM32_RTC_ISR_INIT		BIT(7)
+#define STM32_RTC_ISR_ALRAF		BIT(8)
+
+/* STM32_RTC_PRER bit fields */
+#define STM32_RTC_PRER_PRED_S_SHIFT	0
+#define STM32_RTC_PRER_PRED_S		GENMASK(14, 0)
+#define STM32_RTC_PRER_PRED_A_SHIFT	16
+#define STM32_RTC_PRER_PRED_A		GENMASK(22, 16)
+
+/* STM32_RTC_ALRMAR and STM32_RTC_ALRMBR bit fields */
+#define STM32_RTC_ALRMXR_SEC_SHIFT	0
+#define STM32_RTC_ALRMXR_SEC		GENMASK(6, 0)
+#define STM32_RTC_ALRMXR_SEC_MASK	BIT(7)
+#define STM32_RTC_ALRMXR_MIN_SHIFT	8
+#define STM32_RTC_ALRMXR_MIN		GENMASK(14, 8)
+#define STM32_RTC_ALRMXR_MIN_MASK	BIT(15)
+#define STM32_RTC_ALRMXR_HOUR_SHIFT	16
+#define STM32_RTC_ALRMXR_HOUR		GENMASK(21, 16)
+#define STM32_RTC_ALRMXR_PM		BIT(22)
+#define STM32_RTC_ALRMXR_HOUR_MASK	BIT(23)
+#define STM32_RTC_ALRMXR_DATE_SHIFT	24
+#define STM32_RTC_ALRMXR_DATE		GENMASK(29, 24)
+#define STM32_RTC_ALRMXR_WDSEL		BIT(30)
+#define STM32_RTC_ALRMXR_WDAY_SHIFT	24
+#define STM32_RTC_ALRMXR_WDAY		GENMASK(27, 24)
+#define STM32_RTC_ALRMXR_DATE_MASK	BIT(31)
+
+/* STM32_RTC_WPR key constants */
+#define RTC_WPR_1ST_KEY			0xCA
+#define RTC_WPR_2ND_KEY			0x53
+#define RTC_WPR_WRONG_KEY		0xFF
+
+/*
+ * RTC registers are protected agains parasitic write access.
+ * PWR_CR_DBP bit must be set to enable write access to RTC registers.
+ */
+/* STM32_PWR_CR */
+#define PWR_CR				0x00
+/* STM32_PWR_CR bit field */
+#define PWR_CR_DBP			BIT(8)
+
+static struct regmap *dbp;
+
+struct stm32_rtc {
+	struct rtc_device *rtc_dev;
+	void __iomem *base;
+	struct clk *pclk;
+	struct clk *ck_rtc;
+	unsigned int clksrc;
+	spinlock_t lock; /* Protects registers accesses */
+	int irq_alarm;
+	struct regmap *pwrcr;
+};
+
+static inline unsigned int stm32_rtc_readl(struct stm32_rtc *rtc,
+					   unsigned int offset)
+{
+	return readl_relaxed(rtc->base + offset);
+}
+
+static inline void stm32_rtc_writel(struct stm32_rtc *rtc,
+				    unsigned int offset, unsigned int value)
+{
+	writel_relaxed(value, rtc->base + offset);
+}
+
+static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
+{
+//	if (dbp)
+//		regmap_update_bits(dbp, PWR_CR, PWR_CR_DBP, PWR_CR_DBP);
+
+	stm32_rtc_writel(rtc, STM32_RTC_WPR, RTC_WPR_1ST_KEY);
+	stm32_rtc_writel(rtc, STM32_RTC_WPR, RTC_WPR_2ND_KEY);
+}
+
+static void stm32_rtc_wpr_lock(struct stm32_rtc *rtc)
+{
+	stm32_rtc_writel(rtc, STM32_RTC_WPR, RTC_WPR_WRONG_KEY);
+
+//	if (dbp)
+//		regmap_update_bits(dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+}
+
+static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
+{
+	unsigned int isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
+
+	if (!(isr & STM32_RTC_ISR_INITF)) {
+		isr |= STM32_RTC_ISR_INIT;
+		stm32_rtc_writel(rtc, STM32_RTC_ISR, isr);
+
+		return readl_relaxed_poll_timeout_atomic(
+					rtc->base + STM32_RTC_ISR,
+					isr, (isr & STM32_RTC_ISR_INITF),
+					10, 100000);
+	}
+
+	return 0;
+}
+
+static void stm32_rtc_exit_init_mode(struct stm32_rtc *rtc)
+{
+	unsigned int isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
+
+	isr &= ~STM32_RTC_ISR_INIT;
+	stm32_rtc_writel(rtc, STM32_RTC_ISR, isr);
+}
+
+static int stm32_rtc_wait_sync(struct stm32_rtc *rtc)
+{
+	unsigned int isr;
+
+	isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
+
+	isr &= ~STM32_RTC_ISR_RSF;
+	stm32_rtc_writel(rtc, STM32_RTC_ISR, isr);
+
+	/* Wait the registers to be synchronised */
+	return readl_relaxed_poll_timeout_atomic(rtc->base + STM32_RTC_ISR,
+						 isr,
+						 (isr & STM32_RTC_ISR_RSF),
+						 10, 100000);
+}
+
+static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
+{
+	struct stm32_rtc *rtc = (struct stm32_rtc *)dev_id;
+	unsigned long irqflags, events = 0;
+	unsigned int isr, cr;
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
+	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
+
+	if ((isr & STM32_RTC_ISR_ALRAF) &&
+	    (cr & STM32_RTC_CR_ALRAIE)) {
+		/* Alarm A flag - Alarm interrupt */
+		events |= RTC_IRQF | RTC_AF;
+		isr &= ~STM32_RTC_ISR_ALRAF;
+	}
+
+	/* Clear event irqflags, otherwise new events won't be received */
+	stm32_rtc_writel(rtc, STM32_RTC_ISR, isr);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	if (events) {
+		dev_info(&rtc->rtc_dev->dev, "Alarm occurred\n");
+
+		/* Pass event to the kernel */
+		rtc_update_irq(rtc->rtc_dev, 1, events);
+		return IRQ_HANDLED;
+	} else {
+		return IRQ_NONE;
+	}
+}
+
+/* Convert rtc_time structure from bin to bcd format */
+static void tm2bcd(struct rtc_time *tm)
+{
+	tm->tm_sec = bin2bcd(tm->tm_sec);
+	tm->tm_min = bin2bcd(tm->tm_min);
+	tm->tm_hour = bin2bcd(tm->tm_hour);
+
+	tm->tm_mday = bin2bcd(tm->tm_mday);
+	tm->tm_mon = bin2bcd(tm->tm_mon + 1);
+	tm->tm_year = bin2bcd(tm->tm_year - 100);
+	/*
+	 * Number of days since Sunday
+	 * - on kernel side, 0=Sunday...6=Saturday
+	 * - on rtc side, 0=invalid,1=Monday...7=Sunday
+	 */
+	tm->tm_wday = (!tm->tm_wday) ? 7 : tm->tm_wday;
+}
+
+/* Convert rtc_time structure from bcd to bin format */
+static void bcd2tm(struct rtc_time *tm)
+{
+	tm->tm_sec = bcd2bin(tm->tm_sec);
+	tm->tm_min = bcd2bin(tm->tm_min);
+	tm->tm_hour = bcd2bin(tm->tm_hour);
+
+	tm->tm_mday = bcd2bin(tm->tm_mday);
+	tm->tm_mon = bcd2bin(tm->tm_mon) - 1;
+	tm->tm_year = bcd2bin(tm->tm_year) + 100;
+	/*
+	 * Number of days since Sunday
+	 * - on kernel side, 0=Sunday...6=Saturday
+	 * - on rtc side, 0=invalid,1=Monday...7=Sunday
+	 */
+	tm->tm_wday %= 7;
+}
+
+static int stm32_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int tr, dr;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	/* Time and Date in BCD format */
+	tr = stm32_rtc_readl(rtc, STM32_RTC_TR);
+	dr = stm32_rtc_readl(rtc, STM32_RTC_DR);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	tm->tm_sec = (tr & STM32_RTC_TR_SEC) >> STM32_RTC_TR_SEC_SHIFT;
+	tm->tm_min = (tr & STM32_RTC_TR_MIN) >> STM32_RTC_TR_MIN_SHIFT;
+	tm->tm_hour = (tr & STM32_RTC_TR_HOUR) >> STM32_RTC_TR_HOUR_SHIFT;
+
+	tm->tm_mday = (dr & STM32_RTC_DR_DATE) >> STM32_RTC_DR_DATE_SHIFT;
+	tm->tm_mon = (dr & STM32_RTC_DR_MONTH) >> STM32_RTC_DR_MONTH_SHIFT;
+	tm->tm_year = (dr & STM32_RTC_DR_YEAR) >> STM32_RTC_DR_YEAR_SHIFT;
+	tm->tm_wday = (dr & STM32_RTC_DR_WDAY) >> STM32_RTC_DR_WDAY_SHIFT;
+
+	/* We don't report tm_yday and tm_isdst */
+
+	bcd2tm(tm);
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "%s: rtc_time is not valid.\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int stm32_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int tr, dr;
+	unsigned long irqflags;
+	int ret = 0;
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "%s: rtc_time is not valid.\n", __func__);
+		return -EINVAL;
+	}
+
+	tm2bcd(tm);
+
+	/* Time in BCD format */
+	tr = ((tm->tm_sec << STM32_RTC_TR_SEC_SHIFT) & STM32_RTC_TR_SEC) |
+	     ((tm->tm_min << STM32_RTC_TR_MIN_SHIFT) & STM32_RTC_TR_MIN) |
+	     ((tm->tm_hour << STM32_RTC_TR_HOUR_SHIFT) & STM32_RTC_TR_HOUR);
+
+	/* Date in BCD format */
+	dr = ((tm->tm_mday << STM32_RTC_DR_DATE_SHIFT) & STM32_RTC_DR_DATE) |
+	     ((tm->tm_mon << STM32_RTC_DR_MONTH_SHIFT) & STM32_RTC_DR_MONTH) |
+	     ((tm->tm_year << STM32_RTC_DR_YEAR_SHIFT) & STM32_RTC_DR_YEAR) |
+	     ((tm->tm_wday << STM32_RTC_DR_WDAY_SHIFT) & STM32_RTC_DR_WDAY);
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	stm32_rtc_wpr_unlock(rtc);
+
+	ret = stm32_rtc_enter_init_mode(rtc);
+	if (ret) {
+		dev_err(dev, "Can't enter in init mode. Set time aborted.\n");
+		goto end;
+	}
+
+	stm32_rtc_writel(rtc, STM32_RTC_TR, tr);
+	stm32_rtc_writel(rtc, STM32_RTC_DR, dr);
+
+	stm32_rtc_exit_init_mode(rtc);
+
+	ret = stm32_rtc_wait_sync(rtc);
+end:
+	stm32_rtc_wpr_lock(rtc);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	return ret;
+}
+
+static int stm32_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	unsigned int alrmar, cr, isr;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	alrmar = stm32_rtc_readl(rtc, STM32_RTC_ALRMAR);
+	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
+	isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	if (alrmar & STM32_RTC_ALRMXR_DATE_MASK) {
+		/*
+		 * Date/day don't care in Alarm comparison so alarm triggers
+		 * every day
+		 */
+		tm->tm_mday = -1;
+		tm->tm_wday = -1;
+	} else {
+		if (alrmar & STM32_RTC_ALRMXR_WDSEL) {
+			/* Alarm is set to a day of week */
+			tm->tm_mday = -1;
+			tm->tm_wday = (alrmar & STM32_RTC_ALRMXR_WDAY) >>
+				      STM32_RTC_ALRMXR_WDAY_SHIFT;
+			tm->tm_wday %= 7;
+		} else {
+			/* Alarm is set to a day of month */
+			tm->tm_wday = -1;
+			tm->tm_mday = (alrmar & STM32_RTC_ALRMXR_DATE) >>
+				       STM32_RTC_ALRMXR_DATE_SHIFT;
+		}
+	}
+
+	if (alrmar & STM32_RTC_ALRMXR_HOUR_MASK) {
+		/* Hours don't care in Alarm comparison */
+		tm->tm_hour = -1;
+	} else {
+		tm->tm_hour = (alrmar & STM32_RTC_ALRMXR_HOUR) >>
+			       STM32_RTC_ALRMXR_HOUR_SHIFT;
+		if (alrmar & STM32_RTC_ALRMXR_PM)
+			tm->tm_hour += 12;
+	}
+
+	if (alrmar & STM32_RTC_ALRMXR_MIN_MASK) {
+		/* Minutes don't care in Alarm comparison */
+		tm->tm_min = -1;
+	} else {
+		tm->tm_min = (alrmar & STM32_RTC_ALRMXR_MIN) >>
+			      STM32_RTC_ALRMXR_MIN_SHIFT;
+	}
+
+	if (alrmar & STM32_RTC_ALRMXR_SEC_MASK) {
+		/* Seconds don't care in Alarm comparison */
+		tm->tm_sec = -1;
+	} else {
+		tm->tm_sec = (alrmar & STM32_RTC_ALRMXR_SEC) >>
+			      STM32_RTC_ALRMXR_SEC_SHIFT;
+	}
+
+	bcd2tm(tm);
+
+	alrm->enabled = (cr & STM32_RTC_CR_ALRAE) ? 1 : 0;
+	alrm->pending = (isr & STM32_RTC_ISR_ALRAF) ? 1 : 0;
+
+	return 0;
+}
+
+static int stm32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long irqflags;
+	unsigned int isr, cr;
+
+	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	stm32_rtc_wpr_unlock(rtc);
+
+	/* We expose Alarm A to the kernel */
+	if (enabled)
+		cr |= (STM32_RTC_CR_ALRAIE | STM32_RTC_CR_ALRAE);
+	else
+		cr &= ~(STM32_RTC_CR_ALRAIE | STM32_RTC_CR_ALRAE);
+	stm32_rtc_writel(rtc, STM32_RTC_CR, cr);
+
+	/* Clear event irqflags, otherwise new events won't be received */
+	isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
+	isr &= ~STM32_RTC_ISR_ALRAF;
+	stm32_rtc_writel(rtc, STM32_RTC_ISR, isr);
+
+	stm32_rtc_wpr_lock(rtc);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	return 0;
+}
+
+static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	unsigned long irqflags;
+	unsigned int cr, isr, alrmar;
+	int ret = 0;
+
+	if (rtc_valid_tm(tm)) {
+		dev_err(dev, "Alarm time not valid.\n");
+		return -EINVAL;
+	}
+
+	tm2bcd(tm);
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	stm32_rtc_wpr_unlock(rtc);
+
+	/* Disable Alarm */
+	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
+	cr &= ~STM32_RTC_CR_ALRAE;
+	stm32_rtc_writel(rtc, STM32_RTC_CR, cr);
+
+	/* Poll Alarm write flag to be sure that Alarm update is allowed */
+	ret = readl_relaxed_poll_timeout_atomic(rtc->base + STM32_RTC_ISR,
+						isr,
+						(isr & STM32_RTC_ISR_ALRAWF),
+						10, 100);
+
+	if (ret) {
+		dev_err(dev, "Alarm update not allowed\n");
+		goto end;
+	}
+
+	alrmar = 0;
+
+	if (tm->tm_mday < 0 && tm->tm_wday < 0) {
+		/*
+		 * Date/day don't care in Alarm comparison so alarm triggers
+		 * every day
+		 */
+		alrmar |= STM32_RTC_ALRMXR_DATE_MASK;
+	} else {
+		if (tm->tm_mday > 0) {
+			/* Date is selected (ignoring wday) */
+			alrmar |= (tm->tm_mday << STM32_RTC_ALRMXR_DATE_SHIFT) &
+				  STM32_RTC_ALRMXR_DATE;
+		} else {
+			/* Day of week is selected */
+			int wday = (tm->tm_wday == 0) ? 7 : tm->tm_wday;
+
+			alrmar |= STM32_RTC_ALRMXR_WDSEL;
+			alrmar |= (wday << STM32_RTC_ALRMXR_WDAY_SHIFT) &
+				  STM32_RTC_ALRMXR_WDAY;
+		}
+	}
+
+	if (tm->tm_hour < 0) {
+		/* Hours don't care in Alarm comparison */
+		alrmar |= STM32_RTC_ALRMXR_HOUR_MASK;
+	} else {
+		/* 24-hour format */
+		alrmar &= ~STM32_RTC_ALRMXR_PM;
+		alrmar |= (tm->tm_hour << STM32_RTC_ALRMXR_HOUR_SHIFT) &
+			  STM32_RTC_ALRMXR_HOUR;
+	}
+
+	if (tm->tm_min < 0) {
+		/* Minutes don't care in Alarm comparison */
+		alrmar |= STM32_RTC_ALRMXR_MIN_MASK;
+	} else {
+		alrmar |= (tm->tm_min << STM32_RTC_ALRMXR_MIN_SHIFT) &
+			  STM32_RTC_ALRMXR_MIN;
+	}
+
+	if (tm->tm_sec < 0) {
+		/* Seconds don't care in Alarm comparison */
+		alrmar |= STM32_RTC_ALRMXR_SEC_MASK;
+	} else {
+		alrmar |= (tm->tm_sec << STM32_RTC_ALRMXR_SEC_SHIFT) &
+			  STM32_RTC_ALRMXR_SEC;
+	}
+
+	/* Write to Alarm register */
+	stm32_rtc_writel(rtc, STM32_RTC_ALRMAR, alrmar);
+
+	if (alrm->enabled)
+		stm32_rtc_alarm_irq_enable(dev, 1);
+	else
+		stm32_rtc_alarm_irq_enable(dev, 0);
+
+end:
+	stm32_rtc_wpr_lock(rtc);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	return ret;
+}
+
+static const struct rtc_class_ops stm32_rtc_ops = {
+	.read_time	= stm32_rtc_read_time,
+	.set_time	= stm32_rtc_set_time,
+	.read_alarm	= stm32_rtc_read_alarm,
+	.set_alarm	= stm32_rtc_set_alarm,
+	.alarm_irq_enable = stm32_rtc_alarm_irq_enable,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id stm32_rtc_of_match[] = {
+	{ .compatible = "st,stm32-rtc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_rtc_of_match);
+#endif
+
+static int stm32_rtc_init(struct platform_device *pdev,
+			  struct stm32_rtc *rtc)
+{
+	unsigned int prer, pred_a, pred_s, pred_a_max, pred_s_max, cr;
+	unsigned int rate;
+	unsigned long irqflags;
+	int ret = 0;
+
+	rate = clk_get_rate(rtc->ck_rtc);
+
+	/* Find prediv_a and prediv_s to obtain the 1Hz calendar clock */
+	pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
+	pred_s_max = STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
+
+	for (pred_a = pred_a_max; pred_a >= 0; pred_a--) {
+		pred_s = (rate / (pred_a + 1)) - 1;
+
+		if (((pred_s + 1) * (pred_a + 1)) == rate)
+			break;
+	}
+
+	/*
+	 * Can't find a 1Hz, so give priority to RTC power consumption
+	 * by choosing the higher possible value for prediv_a
+	 */
+	if ((pred_s > pred_s_max) || (pred_a > pred_a_max)) {
+		pred_a = pred_a_max;
+		pred_s = (rate / (pred_a + 1)) - 1;
+
+		dev_warn(&pdev->dev, "ck_rtc is %s\n",
+			 (rate - ((pred_a + 1) * (pred_s + 1)) < 0) ?
+			 "fast" : "slow");
+	}
+
+	spin_lock_irqsave(&rtc->lock, irqflags);
+
+	stm32_rtc_wpr_unlock(rtc);
+
+	ret = stm32_rtc_enter_init_mode(rtc);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Can't enter in init mode. Prescaler config failed.\n");
+		goto end;
+	}
+
+	prer = (pred_s << STM32_RTC_PRER_PRED_S_SHIFT) & STM32_RTC_PRER_PRED_S;
+	stm32_rtc_writel(rtc, STM32_RTC_PRER, prer);
+	prer |= (pred_a << STM32_RTC_PRER_PRED_A_SHIFT) & STM32_RTC_PRER_PRED_A;
+	stm32_rtc_writel(rtc, STM32_RTC_PRER, prer);
+
+	/* Force 24h time format */
+	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
+	cr &= ~STM32_RTC_CR_FMT;
+	stm32_rtc_writel(rtc, STM32_RTC_CR, cr);
+
+	stm32_rtc_exit_init_mode(rtc);
+
+	ret = stm32_rtc_wait_sync(rtc);
+
+	if (stm32_rtc_readl(rtc, STM32_RTC_ISR) & STM32_RTC_ISR_INITS)
+		dev_warn(&pdev->dev, "Date/Time must be initialized\n");
+end:
+	stm32_rtc_wpr_lock(rtc);
+
+	spin_unlock_irqrestore(&rtc->lock, irqflags);
+
+	return ret;
+}
+
+static int stm32_rtc_probe(struct platform_device *pdev)
+{
+	struct stm32_rtc *rtc;
+	struct resource *res;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rtc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rtc->base))
+		return PTR_ERR(rtc->base);
+
+	dbp = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "st,syscfg");
+	if (IS_ERR(dbp)) {
+		dev_err(&pdev->dev, "no st,syscfg\n");
+		return PTR_ERR(dbp);
+	}
+
+	spin_lock_init(&rtc->lock);
+
+	rtc->ck_rtc = devm_clk_get(&pdev->dev, "ck_rtc");
+	if (IS_ERR(rtc->ck_rtc)) {
+		dev_err(&pdev->dev, "no ck_rtc clock");
+		return PTR_ERR(rtc->ck_rtc);
+	}
+
+	ret = clk_prepare_enable(rtc->ck_rtc);
+	if (ret)
+		return ret;
+
+	if (dbp)
+		regmap_update_bits(dbp, PWR_CR, PWR_CR_DBP, PWR_CR_DBP);
+
+	ret = stm32_rtc_init(pdev, rtc);
+	if (ret)
+		goto err;
+
+	rtc->irq_alarm = platform_get_irq_byname(pdev, "alarm");
+	if (rtc->irq_alarm <= 0) {
+		dev_err(&pdev->dev, "no alarm irq\n");
+		ret = -ENOENT;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	device_init_wakeup(&pdev->dev, true);
+
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
+			&stm32_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc_dev)) {
+		ret = PTR_ERR(rtc->rtc_dev);
+		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
+			ret);
+		goto err;
+	}
+
+	/* Handle RTC alarm interrupts */
+	ret = devm_request_irq(&pdev->dev, rtc->irq_alarm,
+			       stm32_rtc_alarm_irq, IRQF_TRIGGER_RISING,
+			       dev_name(&rtc->rtc_dev->dev), rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ%d (alarm interrupt) already claimed\n",
+			rtc->irq_alarm);
+		goto err;
+	}
+
+	return 0;
+err:
+	clk_disable_unprepare(rtc->ck_rtc);
+
+	if (dbp)
+		regmap_update_bits(dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+
+	device_init_wakeup(&pdev->dev, false);
+
+	return ret;
+}
+
+static int __exit stm32_rtc_remove(struct platform_device *pdev)
+{
+	struct stm32_rtc *rtc = platform_get_drvdata(pdev);
+	unsigned int cr;
+
+	/* Disable interrupts */
+	stm32_rtc_wpr_unlock(rtc);
+	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
+	cr &= ~STM32_RTC_CR_ALRAIE;
+	stm32_rtc_writel(rtc, STM32_RTC_CR, cr);
+	stm32_rtc_wpr_lock(rtc);
+
+	clk_disable_unprepare(rtc->ck_rtc);
+
+	/* Enable backup domain write protection */
+	if (dbp)
+		regmap_update_bits(dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
+
+	device_init_wakeup(&pdev->dev, false);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int stm32_rtc_suspend(struct device *dev)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(rtc->irq_alarm);
+
+	return 0;
+}
+
+static int stm32_rtc_resume(struct device *dev)
+{
+	struct stm32_rtc *rtc = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = stm32_rtc_wait_sync(rtc);
+	if (ret < 0)
+		return ret;
+
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(rtc->irq_alarm);
+
+	return ret;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_rtc_pm_ops,
+			 stm32_rtc_suspend, stm32_rtc_resume);
+
+static struct platform_driver stm32_rtc_driver = {
+	.probe		= stm32_rtc_probe,
+	.remove		= stm32_rtc_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.pm	= &stm32_rtc_pm_ops,
+		.of_match_table = stm32_rtc_of_match,
+	},
+};
+
+module_platform_driver(stm32_rtc_driver);
+
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 Real Time Clock driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
