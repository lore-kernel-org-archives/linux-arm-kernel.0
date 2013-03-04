From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  4 Mar 2013 15:05:47 +0100
Subject: [PATCH 8/9] rtc: stmp3xxx: Check copy controller state
In-Reply-To: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1362405948-12992-9-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stmp3xxx has a copy controller that needs some time to copy the
analog side to the digital shadow registers. This has implications for
a correct reset behaviour.

The datasheet states that one should not reset the rtc if NEW_REGS != 0 or
a possible loss of data is to be expected.
Accordingly, one should not access the registers while STALE_REGS != 0.

If an alarm is written to the shadow registers, the copy controller does not
persist the values to the analog in every case. This is no problem in the
running kernel, but leads to lost values in case of a reboot.
Always check if the rtc is in a clean state, before writing or continueing.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |   89 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index f31ac76..be4fd78 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -43,8 +43,18 @@
 
 #define STMP3XXX_RTC_STAT			0x10
 #define STMP3XXX_RTC_STAT_STALE_SHIFT		16
+#define STMP3XXX_RTC_STAT_NEW_SHIFT		8
 #define STMP3XXX_RTC_STAT_RTC_PRESENT		0x80000000
 
+#define STMP3XXX_RTC_STAT_PERS0_MASK		(1 << 0)
+#define STMP3XXX_RTC_STAT_PERS1_MASK		(1 << 1)
+#define STMP3XXX_RTC_STAT_PERS2_MASK		(1 << 2)
+#define STMP3XXX_RTC_STAT_PERS3_MASK		(1 << 3)
+#define STMP3XXX_RTC_STAT_PERS4_MASK		(1 << 4)
+#define STMP3XXX_RTC_STAT_PERS5_MASK		(1 << 5)
+#define STMP3XXX_RTC_STAT_ALARM_MASK		(1 << 6)
+#define STMP3XXX_RTC_STAT_SEC_MASK		(1 << 7)
+
 #define STMP3XXX_RTC_SECONDS			0x30
 
 #define STMP3XXX_RTC_ALARM			0x40
@@ -135,6 +145,33 @@ static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 }
 #endif /* CONFIG_STMP3XXX_RTC_WATCHDOG */
 
+static inline void stmp3xxx_wait_copy_ctrl(const struct stmp3xxx_rtc_data *rtc_data,
+					   const unsigned int shift,
+					   unsigned int mask)
+{
+	/*
+	 * totally random number, as the datasheet is very unclear
+	 * about the timings
+	 */
+	int timeout = 0x8000;
+
+	while ((readl(rtc_data->io + STMP3XXX_RTC_STAT) &
+			(mask << shift)) && --timeout)
+		cpu_relax();
+
+	if (unlikely(!timeout))
+		if (&rtc_data->rtc->dev)
+			dev_warn(&rtc_data->rtc->dev,
+				"possible data loss of shadow registers\n");
+		else
+			/*
+			 * When this function is called for the mxs_reset in
+			 * the probe function, rtc->dev is not yet set
+			 * FIXME: find a better/correct way to do this
+			 */
+			pr_warn("possible data loss of rtc shadow registers\n");
+}
+
 static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
 {
 	/*
@@ -188,6 +225,9 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
  */
 static void stmp3xxx_alarm_keep_oscillator(const struct stmp3xxx_rtc_data *rtc_data)
 {
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_STALE_SHIFT,
+				STMP3XXX_RTC_STAT_PERS0_MASK);
+
 	switch (rtc_data->clk_src) {
 	case MXS_OSC_24M:
 		/* keep the 24 MHz oscillator running even in power down */
@@ -220,6 +260,9 @@ static void stmp3xxx_alarm_keep_oscillator(const struct stmp3xxx_rtc_data *rtc_d
 	default:
 		break;
 	}
+
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_NEW_SHIFT,
+				STMP3XXX_RTC_STAT_PERS0_MASK);
 }
 
 static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
@@ -228,6 +271,10 @@ static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 	stmp3xxx_alarm_keep_oscillator(rtc_data);
 
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_STALE_SHIFT,
+				STMP3XXX_RTC_STAT_PERS0_MASK |
+				STMP3XXX_RTC_STAT_ALARM_MASK);
+
 	if (enabled) {
 		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE, /* to be able to sleep */
 			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
@@ -244,6 +291,10 @@ static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 		writel(0, rtc_data->io + STMP3XXX_RTC_ALARM);
 	}
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_NEW_SHIFT,
+				STMP3XXX_RTC_STAT_PERS0_MASK |
+				STMP3XXX_RTC_STAT_ALARM_MASK);
+
 	return 0;
 }
 
@@ -253,10 +304,16 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
 	rtc_tm_to_time(&alm->time, &t);
+
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_STALE_SHIFT,
+				STMP3XXX_RTC_STAT_ALARM_MASK);
+
 	writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
 
-	stmp3xxx_alarm_irq_enable(dev, alm->enabled);
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_NEW_SHIFT,
+				STMP3XXX_RTC_STAT_ALARM_MASK);
 
+	stmp3xxx_alarm_irq_enable(dev, alm->enabled);
 	return 0;
 }
 
@@ -291,6 +348,13 @@ static ssize_t stmp3xxx_rtc_persist_read(struct file *filep,
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 	ssize_t count;
 
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_STALE_SHIFT,
+				STMP3XXX_RTC_STAT_PERS1_MASK |
+				STMP3XXX_RTC_STAT_PERS2_MASK |
+				STMP3XXX_RTC_STAT_PERS3_MASK |
+				STMP3XXX_RTC_STAT_PERS4_MASK |
+				STMP3XXX_RTC_STAT_PERS5_MASK);
+
 	for (count = 0; size; size--, off++, count++)
 		*buf++ = readl(rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + off);
 
@@ -311,6 +375,13 @@ static ssize_t stmp3xxx_rtc_persist_write(struct file *filep,
 	for (count = 0; size; size--, off++, count++)
 		writel(*buf++, rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + off);
 
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_NEW_SHIFT,
+				STMP3XXX_RTC_STAT_PERS1_MASK |
+				STMP3XXX_RTC_STAT_PERS2_MASK |
+				STMP3XXX_RTC_STAT_PERS3_MASK |
+				STMP3XXX_RTC_STAT_PERS4_MASK |
+				STMP3XXX_RTC_STAT_PERS5_MASK);
+
 	return count;
 }
 #endif
@@ -384,7 +455,23 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc_data);
 
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_NEW_SHIFT,
+				STMP3XXX_RTC_STAT_PERS1_MASK |
+				STMP3XXX_RTC_STAT_PERS2_MASK |
+				STMP3XXX_RTC_STAT_PERS3_MASK |
+				STMP3XXX_RTC_STAT_PERS4_MASK |
+				STMP3XXX_RTC_STAT_PERS5_MASK |
+				STMP3XXX_RTC_STAT_ALARM_MASK |
+				STMP3XXX_RTC_STAT_SEC_MASK);
 	mxs_reset_block(rtc_data->io);
+	stmp3xxx_wait_copy_ctrl(rtc_data, STMP3XXX_RTC_STAT_STALE_SHIFT,
+				STMP3XXX_RTC_STAT_PERS1_MASK |
+				STMP3XXX_RTC_STAT_PERS2_MASK |
+				STMP3XXX_RTC_STAT_PERS3_MASK |
+				STMP3XXX_RTC_STAT_PERS4_MASK |
+				STMP3XXX_RTC_STAT_PERS5_MASK |
+				STMP3XXX_RTC_STAT_ALARM_MASK |
+				STMP3XXX_RTC_STAT_SEC_MASK);
 
 	/*
 	 * configure the RTC to provide the correct time
-- 
1.7.10.4
