From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:40:46 +0100
Subject: [PATCH 13/13] ARM: at91: make rm9200 rtc drivers soc independent
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321389646-24112-15-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

switch the rtc drivers to resource and pass it via platform_device

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: rtc-linux at googlegroups.com
---
Hi Alessandro,

	Can I apply this one via at91
	it's part of a big cleanup

Best Regards,
J.
 arch/arm/mach-at91/at91rm9200_devices.c       |   16 ++++-
 arch/arm/mach-at91/at91sam9g45_devices.c      |   16 ++++-
 arch/arm/mach-at91/include/mach/at91_rtc.h    |   24 +++---
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 drivers/rtc/rtc-at91rm9200.c                  |  101 +++++++++++++++---------
 6 files changed, 107 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 1007ba8..ba4fefe 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -665,10 +665,24 @@ static void __init at91_add_device_tc(void) { }
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= AT91RM9200_BASE_RTC,
+		.end	= AT91RM9200_BASE_RTC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91_ID_SYS,
+		.end	= AT91_ID_SYS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device at91rm9200_rtc_device = {
 	.name		= "at91_rtc",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= rtc_resources,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
 };
 
 static void __init at91_add_device_rtc(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 153dad0..2c64e01 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1009,10 +1009,24 @@ static void __init at91_add_device_tc(void) { }
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_RTC_DRV_AT91RM9200) || defined(CONFIG_RTC_DRV_AT91RM9200_MODULE)
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9G45_BASE_RTC,
+		.end	= AT91SAM9G45_BASE_RTC + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91_ID_SYS,
+		.end	= AT91_ID_SYS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device at91sam9g45_rtc_device = {
 	.name		= "at91_rtc",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= rtc_resources,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
 };
 
 static void __init at91_add_device_rtc(void)
diff --git a/arch/arm/mach-at91/include/mach/at91_rtc.h b/arch/arm/mach-at91/include/mach/at91_rtc.h
index e56f470..da1945e 100644
--- a/arch/arm/mach-at91/include/mach/at91_rtc.h
+++ b/arch/arm/mach-at91/include/mach/at91_rtc.h
@@ -16,7 +16,7 @@
 #ifndef AT91_RTC_H
 #define AT91_RTC_H
 
-#define	AT91_RTC_CR		(AT91_RTC + 0x00)	/* Control Register */
+#define	AT91_RTC_CR		0x00			/* Control Register */
 #define		AT91_RTC_UPDTIM		(1 <<  0)		/* Update Request Time Register */
 #define		AT91_RTC_UPDCAL		(1 <<  1)		/* Update Request Calendar Register */
 #define		AT91_RTC_TIMEVSEL	(3 <<  8)		/* Time Event Selection */
@@ -29,44 +29,44 @@
 #define			AT91_RTC_CALEVSEL_MONTH		(1 << 16)
 #define			AT91_RTC_CALEVSEL_YEAR		(2 << 16)
 
-#define	AT91_RTC_MR		(AT91_RTC + 0x04)	/* Mode Register */
+#define	AT91_RTC_MR		0x04			/* Mode Register */
 #define			AT91_RTC_HRMOD		(1 <<  0)		/* 12/24 Hour Mode */
 
-#define	AT91_RTC_TIMR		(AT91_RTC + 0x08)	/* Time Register */
+#define	AT91_RTC_TIMR		0x08			/* Time Register */
 #define		AT91_RTC_SEC		(0x7f <<  0)		/* Current Second */
 #define		AT91_RTC_MIN		(0x7f <<  8)		/* Current Minute */
 #define		AT91_RTC_HOUR		(0x3f << 16)		/* Current Hour */
 #define		AT91_RTC_AMPM		(1    << 22)		/* Ante Meridiem Post Meridiem Indicator */
 
-#define	AT91_RTC_CALR		(AT91_RTC + 0x0c)	/* Calendar Register */
+#define	AT91_RTC_CALR		0x0c			/* Calendar Register */
 #define		AT91_RTC_CENT		(0x7f <<  0)		/* Current Century */
 #define		AT91_RTC_YEAR		(0xff <<  8)		/* Current Year */
 #define		AT91_RTC_MONTH		(0x1f << 16)		/* Current Month */
 #define		AT91_RTC_DAY		(7    << 21)		/* Current Day */
 #define		AT91_RTC_DATE		(0x3f << 24)		/* Current Date */
 
-#define	AT91_RTC_TIMALR		(AT91_RTC + 0x10)	/* Time Alarm Register */
+#define	AT91_RTC_TIMALR		0x10			/* Time Alarm Register */
 #define		AT91_RTC_SECEN		(1 <<  7)		/* Second Alarm Enable */
 #define		AT91_RTC_MINEN		(1 << 15)		/* Minute Alarm Enable */
 #define		AT91_RTC_HOUREN		(1 << 23)		/* Hour Alarm Enable */
 
-#define	AT91_RTC_CALALR		(AT91_RTC + 0x14)	/* Calendar Alarm Register */
+#define	AT91_RTC_CALALR		0x14			/* Calendar Alarm Register */
 #define		AT91_RTC_MTHEN		(1 << 23)		/* Month Alarm Enable */
 #define		AT91_RTC_DATEEN		(1 << 31)		/* Date Alarm Enable */
 
-#define	AT91_RTC_SR		(AT91_RTC + 0x18)	/* Status Register */
+#define	AT91_RTC_SR		0x18			/* Status Register */
 #define		AT91_RTC_ACKUPD		(1 <<  0)		/* Acknowledge for Update */
 #define		AT91_RTC_ALARM		(1 <<  1)		/* Alarm Flag */
 #define		AT91_RTC_SECEV		(1 <<  2)		/* Second Event */
 #define		AT91_RTC_TIMEV		(1 <<  3)		/* Time Event */
 #define		AT91_RTC_CALEV		(1 <<  4)		/* Calendar Event */
 
-#define	AT91_RTC_SCCR		(AT91_RTC + 0x1c)	/* Status Clear Command Register */
-#define	AT91_RTC_IER		(AT91_RTC + 0x20)	/* Interrupt Enable Register */
-#define	AT91_RTC_IDR		(AT91_RTC + 0x24)	/* Interrupt Disable Register */
-#define	AT91_RTC_IMR		(AT91_RTC + 0x28)	/* Interrupt Mask Register */
+#define	AT91_RTC_SCCR		0x1c			/* Status Clear Command Register */
+#define	AT91_RTC_IER		0x20			/* Interrupt Enable Register */
+#define	AT91_RTC_IDR		0x24			/* Interrupt Disable Register */
+#define	AT91_RTC_IMR		0x28			/* Interrupt Mask Register */
 
-#define	AT91_RTC_VER		(AT91_RTC + 0x2c)	/* Valid Entry Register */
+#define	AT91_RTC_VER		0x2c			/* Valid Entry Register */
 #define		AT91_RTC_NVTIM		(1 <<  0)		/* Non valid Time */
 #define		AT91_RTC_NVCAL		(1 <<  1)		/* Non valid Calendar */
 #define		AT91_RTC_NVTIMALR	(1 <<  2)		/* Non valid Time Alarm */
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200.h b/arch/arm/mach-at91/include/mach/at91rm9200.h
index 90e92a8..bacb511 100644
--- a/arch/arm/mach-at91/include/mach/at91rm9200.h
+++ b/arch/arm/mach-at91/include/mach/at91rm9200.h
@@ -81,7 +81,6 @@
  */
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)	/* Power Management Controller */
 #define AT91_ST		(0xfffffd00 - AT91_BASE_SYS)	/* System Timer */
-#define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)	/* Real-Time Clock */
 #define AT91_MC		(0xffffff00 - AT91_BASE_SYS)	/* Memory Controllers */
 
 #define AT91RM9200_BASE_DBGU	AT91_BASE_DBGU0	/* Debug Unit */
@@ -89,6 +88,7 @@
 #define AT91RM9200_BASE_PIOB	0xfffff600	/* PIO Controller B */
 #define AT91RM9200_BASE_PIOC	0xfffff800	/* PIO Controller C */
 #define AT91RM9200_BASE_PIOD	0xfffffa00	/* PIO Controller D */
+#define AT91RM9200_BASE_RTC	0xfffffe00	/* Real-Time Clock */
 
 #define AT91_USART0	AT91RM9200_BASE_US0
 #define AT91_USART1	AT91RM9200_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index ac5c471..f0c23c9 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -92,7 +92,6 @@
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
-#define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
 
 #define AT91SAM9G45_BASE_ECC	0xffffe200
 #define AT91SAM9G45_BASE_DMA	0xffffec00
@@ -107,6 +106,7 @@
 #define AT91SAM9G45_BASE_RTT	0xfffffd20
 #define AT91SAM9G45_BASE_PIT	0xfffffd30
 #define AT91SAM9G45_BASE_WDT	0xfffffd40
+#define AT91SAM9G45_BASE_RTC	0xfffffdb0
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index e39b77a..dc474bc 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -32,11 +32,17 @@
 
 #include <mach/at91_rtc.h>
 
+#define at91_rtc_read(field) \
+	__raw_readl(at91_rtc_regs + field)
+#define at91_rtc_write(field, val) \
+	__raw_writel((val), at91_rtc_regs + field)
 
 #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
 
 static DECLARE_COMPLETION(at91_rtc_updated);
 static unsigned int at91_alarm_year = AT91_RTC_EPOCH;
+static void __iomem *at91_rtc_regs;
+static int irq;
 
 /*
  * Decode time/date into rtc_time structure
@@ -48,10 +54,10 @@ static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
 
 	/* must read twice in case it changes */
 	do {
-		time = at91_sys_read(timereg);
-		date = at91_sys_read(calreg);
-	} while ((time != at91_sys_read(timereg)) ||
-			(date != at91_sys_read(calreg)));
+		time = at91_rtc_read(timereg);
+		date = at91_rtc_read(calreg);
+	} while ((time != at91_rtc_read(timereg)) ||
+			(date != at91_rtc_read(calreg)));
 
 	tm->tm_sec  = bcd2bin((time & AT91_RTC_SEC) >> 0);
 	tm->tm_min  = bcd2bin((time & AT91_RTC_MIN) >> 8);
@@ -98,19 +104,19 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	/* Stop Time/Calendar from counting */
-	cr = at91_sys_read(AT91_RTC_CR);
-	at91_sys_write(AT91_RTC_CR, cr | AT91_RTC_UPDCAL | AT91_RTC_UPDTIM);
+	cr = at91_rtc_read(AT91_RTC_CR);
+	at91_rtc_write(AT91_RTC_CR, cr | AT91_RTC_UPDCAL | AT91_RTC_UPDTIM);
 
-	at91_sys_write(AT91_RTC_IER, AT91_RTC_ACKUPD);
+	at91_rtc_write(AT91_RTC_IER, AT91_RTC_ACKUPD);
 	wait_for_completion(&at91_rtc_updated);	/* wait for ACKUPD interrupt */
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ACKUPD);
+	at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ACKUPD);
 
-	at91_sys_write(AT91_RTC_TIMR,
+	at91_rtc_write(AT91_RTC_TIMR,
 			  bin2bcd(tm->tm_sec) << 0
 			| bin2bcd(tm->tm_min) << 8
 			| bin2bcd(tm->tm_hour) << 16);
 
-	at91_sys_write(AT91_RTC_CALR,
+	at91_rtc_write(AT91_RTC_CALR,
 			  bin2bcd((tm->tm_year + 1900) / 100)	/* century */
 			| bin2bcd(tm->tm_year % 100) << 8	/* year */
 			| bin2bcd(tm->tm_mon + 1) << 16		/* tm_mon starts@zero */
@@ -118,8 +124,8 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 			| bin2bcd(tm->tm_mday) << 24);
 
 	/* Restart Time/Calendar */
-	cr = at91_sys_read(AT91_RTC_CR);
-	at91_sys_write(AT91_RTC_CR, cr & ~(AT91_RTC_UPDCAL | AT91_RTC_UPDTIM));
+	cr = at91_rtc_read(AT91_RTC_CR);
+	at91_rtc_write(AT91_RTC_CR, cr & ~(AT91_RTC_UPDCAL | AT91_RTC_UPDTIM));
 
 	return 0;
 }
@@ -135,7 +141,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	tm->tm_year = at91_alarm_year - 1900;
 
-	alrm->enabled = (at91_sys_read(AT91_RTC_IMR) & AT91_RTC_ALARM)
+	alrm->enabled = (at91_rtc_read(AT91_RTC_IMR) & AT91_RTC_ALARM)
 			? 1 : 0;
 
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
@@ -160,20 +166,20 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	tm.tm_min = alrm->time.tm_min;
 	tm.tm_sec = alrm->time.tm_sec;
 
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ALARM);
-	at91_sys_write(AT91_RTC_TIMALR,
+	at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ALARM);
+	at91_rtc_write(AT91_RTC_TIMALR,
 		  bin2bcd(tm.tm_sec) << 0
 		| bin2bcd(tm.tm_min) << 8
 		| bin2bcd(tm.tm_hour) << 16
 		| AT91_RTC_HOUREN | AT91_RTC_MINEN | AT91_RTC_SECEN);
-	at91_sys_write(AT91_RTC_CALALR,
+	at91_rtc_write(AT91_RTC_CALALR,
 		  bin2bcd(tm.tm_mon + 1) << 16		/* tm_mon starts@zero */
 		| bin2bcd(tm.tm_mday) << 24
 		| AT91_RTC_DATEEN | AT91_RTC_MTHEN);
 
 	if (alrm->enabled) {
-		at91_sys_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
-		at91_sys_write(AT91_RTC_IER, AT91_RTC_ALARM);
+		at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
+		at91_rtc_write(AT91_RTC_IER, AT91_RTC_ALARM);
 	}
 
 	pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
@@ -188,10 +194,10 @@ static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	pr_debug("%s(): cmd=%08x\n", __func__, enabled);
 
 	if (enabled) {
-		at91_sys_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
-		at91_sys_write(AT91_RTC_IER, AT91_RTC_ALARM);
+		at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
+		at91_rtc_write(AT91_RTC_IER, AT91_RTC_ALARM);
 	} else
-		at91_sys_write(AT91_RTC_IDR, AT91_RTC_ALARM);
+		at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ALARM);
 
 	return 0;
 }
@@ -200,7 +206,7 @@ static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
  */
 static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	unsigned long imr = at91_sys_read(AT91_RTC_IMR);
+	unsigned long imr = at91_rtc_read(AT91_RTC_IMR);
 
 	seq_printf(seq, "update_IRQ\t: %s\n",
 			(imr & AT91_RTC_ACKUPD) ? "yes" : "no");
@@ -220,7 +226,7 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 	unsigned int rtsr;
 	unsigned long events = 0;
 
-	rtsr = at91_sys_read(AT91_RTC_SR) & at91_sys_read(AT91_RTC_IMR);
+	rtsr = at91_rtc_read(AT91_RTC_SR) & at91_rtc_read(AT91_RTC_IMR);
 	if (rtsr) {		/* this interrupt is shared!  Is it ours? */
 		if (rtsr & AT91_RTC_ALARM)
 			events |= (RTC_AF | RTC_IRQF);
@@ -229,7 +235,7 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 		if (rtsr & AT91_RTC_ACKUPD)
 			complete(&at91_rtc_updated);
 
-		at91_sys_write(AT91_RTC_SCCR, rtsr);	/* clear status reg */
+		at91_rtc_write(AT91_RTC_SCCR, rtsr);	/* clear status reg */
 
 		rtc_update_irq(rtc, 1, events);
 
@@ -256,22 +262,41 @@ static const struct rtc_class_ops at91_rtc_ops = {
 static int __init at91_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
-	int ret;
+	struct resource *regs;
+	int ret = 0;
 
-	at91_sys_write(AT91_RTC_CR, 0);
-	at91_sys_write(AT91_RTC_MR, 0);		/* 24 hour mode */
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "no mmio resource defined\n");
+		return -ENXIO;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq resource defined\n");
+		return -ENXIO;
+	}
+
+	at91_rtc_regs = ioremap(regs->start, resource_size(regs));
+	if (!at91_rtc_regs) {
+		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
+		return -ENOMEM;
+	}
+
+	at91_rtc_write(AT91_RTC_CR, 0);
+	at91_rtc_write(AT91_RTC_MR, 0);		/* 24 hour mode */
 
 	/* Disable all interrupts */
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
+	at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
 					AT91_RTC_SECEV | AT91_RTC_TIMEV |
 					AT91_RTC_CALEV);
 
-	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
+	ret = request_irq(irq, at91_rtc_interrupt,
 				IRQF_SHARED,
 				"at91_rtc", pdev);
 	if (ret) {
 		printk(KERN_ERR "at91_rtc: IRQ %d already in use.\n",
-				AT91_ID_SYS);
+				irq);
 		return ret;
 	}
 
@@ -284,7 +309,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	rtc = rtc_device_register(pdev->name, &pdev->dev,
 				&at91_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
-		free_irq(AT91_ID_SYS, pdev);
+		free_irq(irq, pdev);
 		return PTR_ERR(rtc);
 	}
 	platform_set_drvdata(pdev, rtc);
@@ -301,10 +326,10 @@ static int __exit at91_rtc_remove(struct platform_device *pdev)
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
 
 	/* Disable all interrupts */
-	at91_sys_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
+	at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
 					AT91_RTC_SECEV | AT91_RTC_TIMEV |
 					AT91_RTC_CALEV);
-	free_irq(AT91_ID_SYS, pdev);
+	free_irq(irq, pdev);
 
 	rtc_device_unregister(rtc);
 	platform_set_drvdata(pdev, NULL);
@@ -323,13 +348,13 @@ static int at91_rtc_suspend(struct device *dev)
 	/* this IRQ is shared with DBGU and other hardware which isn't
 	 * necessarily doing PM like we are...
 	 */
-	at91_rtc_imr = at91_sys_read(AT91_RTC_IMR)
+	at91_rtc_imr = at91_rtc_read(AT91_RTC_IMR)
 			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
 	if (at91_rtc_imr) {
 		if (device_may_wakeup(dev))
-			enable_irq_wake(AT91_ID_SYS);
+			enable_irq_wake(irq);
 		else
-			at91_sys_write(AT91_RTC_IDR, at91_rtc_imr);
+			at91_rtc_write(AT91_RTC_IDR, at91_rtc_imr);
 	}
 	return 0;
 }
@@ -338,9 +363,9 @@ static int at91_rtc_resume(struct device *dev)
 {
 	if (at91_rtc_imr) {
 		if (device_may_wakeup(dev))
-			disable_irq_wake(AT91_ID_SYS);
+			disable_irq_wake(irq);
 		else
-			at91_sys_write(AT91_RTC_IER, at91_rtc_imr);
+			at91_rtc_write(AT91_RTC_IER, at91_rtc_imr);
 	}
 	return 0;
 }
-- 
1.7.7
