From: jtzhou@marvell.com (Jett.Zhou)
Date: Mon, 28 Nov 2011 10:04:52 +0800
Subject: [V2 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
Message-ID: <1322445892-22620-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
almost the same, so re-arch the rtc-sa1100 to support them.

Change-Id: I006271045a21d0e42a8e52c1e43c98c559d76909
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 arch/arm/mach-pxa/devices.c    |   20 +++
 arch/arm/mach-sa1100/generic.c |   20 +++
 drivers/rtc/Kconfig            |    2 +-
 drivers/rtc/rtc-sa1100.c       |  273 ++++++++++++++++++++++++++++------------
 4 files changed, 236 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 2e04254..8b134c3 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -415,9 +415,29 @@ static struct resource pxa_rtc_resources[] = {
 	},
 };
 
+static struct resource sa1100_rtc_resources[] = {
+	[0] = {
+		.start  = 0x40900000,
+		.end	= 0x409000ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = IRQ_RTC1Hz,
+		.end    = IRQ_RTC1Hz,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start  = IRQ_RTCAlrm,
+		.end    = IRQ_RTCAlrm,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
 struct platform_device sa1100_device_rtc = {
 	.name		= "sa1100-rtc",
 	.id		= -1,
+	.num_resources  = ARRAY_SIZE(sa1100_rtc_resources),
+	.resource       = sa1100_rtc_resources,
 };
 
 struct platform_device pxa_device_rtc = {
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 5fa5ae1..3eff179 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -334,9 +334,29 @@ void sa11x0_register_irda(struct irda_platform_data *irda)
 	sa11x0_register_device(&sa11x0ir_device, irda);
 }
 
+static struct resource sa11x0rtc_resources[] = {
+	[0] = {
+		.start	= 0x90010000,
+		.end	= 0x900100ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_RTC1Hz,
+		.end	= IRQ_RTC1Hz,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_RTCAlrm,
+		.end	= IRQ_RTCAlrm,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device sa11x0rtc_device = {
 	.name		= "sa1100-rtc",
 	.id		= -1,
+	.resource	= sa11x0rtc_resources,
+	.num_resources	= ARRAY_SIZE(sa11x0rtc_resources),
 };
 
 static struct platform_device *sa11x0_devices[] __initdata = {
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5a538fc..f671328 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -774,7 +774,7 @@ config RTC_DRV_EP93XX
 
 config RTC_DRV_SA1100
 	tristate "SA11x0/PXA2xx"
-	depends on ARCH_SA1100 || ARCH_PXA
+	depends on ARCH_SA1100 || ARCH_PXA || ARCH_MMP
 	help
 	  If you say Y here you will get access to the real time clock
 	  built into your SA11x0 or PXA2xx CPU.
diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index d268cf1..9c9bfe4 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -27,24 +27,55 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
-#include <linux/string.h>
 #include <linux/pm.h>
-#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
-#ifdef CONFIG_ARCH_PXA
-#include <mach/regs-rtc.h>
-#endif
+enum rtc_id {
+	RTC_SA1100,
+	RTC_MMP,
+};
+
+static const struct platform_device_id rtc_id_table[] = {
+	{ "sa1100-rtc",	RTC_SA1100 },
+	{ "mmp-rtc",	RTC_MMP },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, rtc_id_table);
 
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
-
-static const unsigned long RTC_FREQ = 1024;
-static struct rtc_time rtc_alarm;
-static DEFINE_SPINLOCK(sa1100_rtc_lock);
-
+#define RTC_FREQ		1024
+
+#define RCNR		0x00	/* RTC Count Register */
+#define RTAR		0x04	/* RTC Alarm Register */
+#define RTSR		0x08	/* RTC Status Register */
+#define RTTR		0x0c	/* RTC Timer Trim Register */
+
+#define RTSR_HZE	(1 << 3)	/* HZ interrupt enable */
+#define RTSR_ALE	(1 << 2)	/* RTC alarm interrupt enable */
+#define RTSR_HZ		(1 << 1)	/* HZ rising-edge detected */
+#define RTSR_AL		(1 << 0)	/* RTC alarm detected */
+
+#define rtc_readl(sa1100_rtc, reg)	\
+	readl_relaxed((sa1100_rtc)->base + (reg))
+#define rtc_writel(sa1100_rtc, reg, value)	\
+	writel_relaxed((value), (sa1100_rtc)->base + (reg))
+
+struct sa1100_rtc {
+	struct resource		*ress;
+	void __iomem		*base;
+	struct clk		*clk;
+	int			irq_1Hz;
+	int			irq_Alrm;
+	struct rtc_device	*rtc;
+	spinlock_t		lock;		/* Protects this structure */
+	enum rtc_id		id;
+};
 /*
  * Calculate the next alarm time given the requested alarm time mask
  * and the current time.
@@ -75,22 +106,23 @@ static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
 static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = to_platform_device(dev_id);
-	struct rtc_device *rtc = platform_get_drvdata(pdev);
+	struct sa1100_rtc *sa1100_rtc = platform_get_drvdata(pdev);
 	unsigned int rtsr;
 	unsigned long events = 0;
 
-	spin_lock(&sa1100_rtc_lock);
+	spin_lock(&sa1100_rtc->lock);
 
-	rtsr = RTSR;
 	/* clear interrupt sources */
-	RTSR = 0;
+	rtsr = rtc_readl(sa1100_rtc, RTSR);
+	rtc_writel(sa1100_rtc, RTSR, 0);
+
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_probe(). */
 	if (rtsr & (RTSR_ALE | RTSR_HZE)) {
 		/* This is the original code, before there was the if test
 		 * above. This code does not clear interrupts that were not
 		 * enabled. */
-		RTSR = (RTSR_AL | RTSR_HZ) & (rtsr >> 2);
+		rtc_writel(sa1100_rtc, RTSR, (RTSR_AL | RTSR_HZ) & (rtsr >> 2));
 	} else {
 		/* For some reason, it is possible to enter this routine
 		 * without interruptions enabled, it has been tested with
@@ -99,13 +131,13 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 		 * This situation leads to an infinite "loop" of interrupt
 		 * routine calling and as a result the processor seems to
 		 * lock on its first call to open(). */
-		RTSR = RTSR_AL | RTSR_HZ;
+		rtc_writel(sa1100_rtc, RTSR, (RTSR_AL | RTSR_HZ));
 	}
 
 	/* clear alarm interrupt if it has occurred */
 	if (rtsr & RTSR_AL)
 		rtsr &= ~RTSR_ALE;
-	RTSR = rtsr & (RTSR_ALE | RTSR_HZE);
+	rtc_writel(sa1100_rtc, RTSR, rtsr & (RTSR_ALE | RTSR_HZE));
 
 	/* update irq data & counter */
 	if (rtsr & RTSR_AL)
@@ -113,86 +145,100 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 	if (rtsr & RTSR_HZ)
 		events |= RTC_UF | RTC_IRQF;
 
-	rtc_update_irq(rtc, 1, events);
+	rtc_update_irq(sa1100_rtc->rtc, 1, events);
 
-	spin_unlock(&sa1100_rtc_lock);
+	spin_unlock(&sa1100_rtc->lock);
 
 	return IRQ_HANDLED;
 }
 
 static int sa1100_rtc_open(struct device *dev)
 {
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
 	int ret;
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
 
-	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, IRQF_DISABLED,
-		"rtc 1Hz", dev);
+	ret = request_irq(sa1100_rtc->irq_1Hz, sa1100_rtc_interrupt,
+				IRQF_DISABLED, "rtc 1Hz", dev);
 	if (ret) {
-		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTC1Hz);
+		dev_err(dev, "IRQ %d already in use.\n", sa1100_rtc->irq_1Hz);
 		goto fail_ui;
 	}
-	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, IRQF_DISABLED,
-		"rtc Alrm", dev);
+	ret = request_irq(sa1100_rtc->irq_Alrm, sa1100_rtc_interrupt,
+				IRQF_DISABLED, "rtc Alrm", dev);
 	if (ret) {
-		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTCAlrm);
+		dev_err(dev, "IRQ %d already in use.\n", sa1100_rtc->irq_Alrm);
 		goto fail_ai;
 	}
-	rtc->max_user_freq = RTC_FREQ;
-	rtc_irq_set_freq(rtc, NULL, RTC_FREQ);
+	sa1100_rtc->rtc->max_user_freq = RTC_FREQ;
+	rtc_irq_set_freq(sa1100_rtc->rtc, NULL, RTC_FREQ);
 
 	return 0;
 
  fail_ai:
-	free_irq(IRQ_RTC1Hz, dev);
+	free_irq(sa1100_rtc->irq_1Hz, dev);
  fail_ui:
 	return ret;
 }
 
 static void sa1100_rtc_release(struct device *dev)
 {
-	spin_lock_irq(&sa1100_rtc_lock);
-	RTSR = 0;
-	spin_unlock_irq(&sa1100_rtc_lock);
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
+
+	spin_lock_irq(&sa1100_rtc->lock);
+	rtc_writel(sa1100_rtc, RTSR, 0);
+	spin_unlock_irq(&sa1100_rtc->lock);
 
-	free_irq(IRQ_RTCAlrm, dev);
-	free_irq(IRQ_RTC1Hz, dev);
+	free_irq(sa1100_rtc->irq_Alrm, dev);
+	free_irq(sa1100_rtc->irq_1Hz, dev);
 }
 
 static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	spin_lock_irq(&sa1100_rtc_lock);
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
+	unsigned int rtsr;
+
+	spin_lock_irq(&sa1100_rtc->lock);
+
+	rtsr = rtc_readl(sa1100_rtc, RTSR);
 	if (enabled)
-		RTSR |= RTSR_ALE;
+		rtsr |= RTSR_ALE;
 	else
-		RTSR &= ~RTSR_ALE;
-	spin_unlock_irq(&sa1100_rtc_lock);
+		rtsr &= ~RTSR_ALE;
+	rtc_writel(sa1100_rtc, RTSR, rtsr);
+
+	spin_unlock_irq(&sa1100_rtc->lock);
 	return 0;
 }
 
 static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(RCNR, tm);
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
+
+	rtc_time_to_tm(rtc_readl(sa1100_rtc, RCNR), tm);
 	return 0;
 }
 
 static int sa1100_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
 	unsigned long time;
 	int ret;
 
 	ret = rtc_tm_to_time(tm, &time);
 	if (ret == 0)
-		RCNR = time;
+		rtc_writel(sa1100_rtc, RCNR, time);
 	return ret;
 }
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	u32	rtsr;
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
+	unsigned long time;
+	unsigned int rtsr;
 
-	memcpy(&alrm->time, &rtc_alarm, sizeof(struct rtc_time));
-	rtsr = RTSR;
+	time = rtc_readl(sa1100_rtc, RCNR);
+	rtc_time_to_tm(time, &alrm->time);
+	rtsr = rtc_readl(sa1100_rtc, RTSR);
 	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
 	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
 	return 0;
@@ -200,31 +246,39 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
 	struct rtc_time now_tm, alarm_tm;
-	int ret;
+	unsigned long time, alarm;
+	unsigned int rtsr;
+
+	spin_lock_irq(&sa1100_rtc->lock);
 
-	spin_lock_irq(&sa1100_rtc_lock);
+	time = rtc_readl(sa1100_rtc, RCNR);
+	rtc_time_to_tm(time, &now_tm);
+	rtc_next_alarm_time(&alarm_tm, &now_tm, &alrm->time);
+	rtc_tm_to_time(&alarm_tm, &alarm);
+	rtc_writel(sa1100_rtc, RTAR, alarm);
 
-	now = RCNR;
-	rtc_time_to_tm(now, &now_tm);
-	rtc_next_alarm_time(&alarm_tm, &now_tm, alrm->time);
-	rtc_tm_to_time(&alarm_tm, &time);
-	RTAR = time;
+	rtsr = rtc_readl(sa1100_rtc, RTSR);
 	if (alrm->enabled)
-		RTSR |= RTSR_ALE;
+		rtsr |= RTSR_ALE;
 	else
-		RTSR &= ~RTSR_ALE;
+		rtsr &= ~RTSR_ALE;
+	rtc_writel(sa1100_rtc, RTSR, rtsr);
 
-	spin_unlock_irq(&sa1100_rtc_lock);
+	spin_unlock_irq(&sa1100_rtc->lock);
 
-	return ret;
+	return 0;
 }
 
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32) RTTR);
-	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)RTSR);
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
 
+	seq_printf(seq, "trim/divider\t\t: 0x%08x\n",
+			rtc_readl(sa1100_rtc, RTTR));
+	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n",
+			rtc_readl(sa1100_rtc, RTSR));
 	return 0;
 }
 
@@ -241,7 +295,54 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 
 static int sa1100_rtc_probe(struct platform_device *pdev)
 {
-	struct rtc_device *rtc;
+	struct sa1100_rtc *sa1100_rtc;
+	unsigned int rttr;
+	int ret;
+
+	sa1100_rtc = kzalloc(sizeof(struct sa1100_rtc), GFP_KERNEL);
+	if (!sa1100_rtc)
+		return -ENOMEM;
+
+	sa1100_rtc->id = platform_get_device_id(pdev)->driver_data;
+	spin_lock_init(&sa1100_rtc->lock);
+	platform_set_drvdata(pdev, sa1100_rtc);
+
+	ret = -ENXIO;
+	sa1100_rtc->ress = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!sa1100_rtc->ress) {
+		dev_err(&pdev->dev, "No I/O memory resource defined\n");
+		goto err_ress;
+	}
+
+	sa1100_rtc->irq_1Hz = platform_get_irq(pdev, 0);
+	if (sa1100_rtc->irq_1Hz < 0) {
+		dev_err(&pdev->dev, "No 1Hz IRQ resource defined\n");
+		goto err_ress;
+	}
+	sa1100_rtc->irq_Alrm = platform_get_irq(pdev, 1);
+	if (sa1100_rtc->irq_Alrm < 0) {
+		dev_err(&pdev->dev, "No alarm IRQ resource defined\n");
+		goto err_ress;
+	}
+
+	ret = -ENOMEM;
+	sa1100_rtc->base = ioremap(sa1100_rtc->ress->start,
+				resource_size(sa1100_rtc->ress));
+	if (!sa1100_rtc->base) {
+		dev_err(&pdev->dev, "Unable to map pxa RTC I/O memory\n");
+		goto err_map;
+	}
+
+	if (sa1100_rtc->id == RTC_MMP) {
+		sa1100_rtc->clk = clk_get(&pdev->dev, "MMP-RTC");
+		if (IS_ERR(sa1100_rtc->clk)) {
+			dev_err(&pdev->dev, "failed to find rtc clock source\n");
+			ret = PTR_ERR(sa1100_rtc->clk);
+			goto err_clk;
+		}
+		clk_prepare(sa1100_rtc->clk);
+		clk_enable(sa1100_rtc->clk);
+	}
 
 	/*
 	 * According to the manual we should be able to let RTTR be zero
@@ -250,24 +351,24 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	 * If the clock divider is uninitialized then reset it to the
 	 * default value to get the 1Hz clock.
 	 */
-	if (RTTR == 0) {
-		RTTR = RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16);
-		dev_warn(&pdev->dev, "warning: "
-			"initializing default clock divider/trim value\n");
+	if (rtc_readl(sa1100_rtc, RTTR) == 0) {
+		rttr = RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16);
+		rtc_writel(sa1100_rtc, RTTR, rttr);
+		dev_warn(&pdev->dev, "warning: initializing default clock"
+			 " divider/trim value\n");
 		/* The current RTC value probably doesn't make sense either */
-		RCNR = 0;
+		rtc_writel(sa1100_rtc, RCNR, 0);
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rtc = rtc_device_register(pdev->name, &pdev->dev, &sa1100_rtc_ops,
-		THIS_MODULE);
-
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	platform_set_drvdata(pdev, rtc);
-
+	sa1100_rtc->rtc = rtc_device_register(pdev->name, &pdev->dev,
+						&sa1100_rtc_ops, THIS_MODULE);
+	if (IS_ERR(sa1100_rtc->rtc)) {
+		dev_err(&pdev->dev, "Failed to register RTC device -> %d\n",
+			ret);
+		goto err_rtc_reg;
+	}
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_interrupt().
 	 *
@@ -290,33 +391,48 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	 *
 	 * Notice that clearing bit 1 and 0 is accomplished by writting ONES to
 	 * the corresponding bits in RTSR. */
-	RTSR = RTSR_AL | RTSR_HZ;
+	rtc_writel(sa1100_rtc, RTSR, (RTSR_AL | RTSR_HZ));
 
 	return 0;
+
+err_rtc_reg:
+err_clk:
+	iounmap(sa1100_rtc->base);
+err_ress:
+err_map:
+	kfree(sa1100_rtc);
+	return ret;
 }
 
 static int sa1100_rtc_remove(struct platform_device *pdev)
 {
-	struct rtc_device *rtc = platform_get_drvdata(pdev);
-
-	if (rtc)
-		rtc_device_unregister(rtc);
+	struct sa1100_rtc *sa1100_rtc = platform_get_drvdata(pdev);
 
+	rtc_device_unregister(sa1100_rtc->rtc);
+	if (sa1100_rtc->id == RTC_MMP) {
+		clk_disable(sa1100_rtc->clk);
+		clk_unprepare(sa1100_rtc->clk);
+	}
+	iounmap(sa1100_rtc->base);
 	return 0;
 }
 
 #ifdef CONFIG_PM
 static int sa1100_rtc_suspend(struct device *dev)
 {
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
+
 	if (device_may_wakeup(dev))
-		enable_irq_wake(IRQ_RTCAlrm);
+		enable_irq_wake(sa1100_rtc->irq_Alrm);
 	return 0;
 }
 
 static int sa1100_rtc_resume(struct device *dev)
 {
+	struct sa1100_rtc *sa1100_rtc = dev_get_drvdata(dev);
+
 	if (device_may_wakeup(dev))
-		disable_irq_wake(IRQ_RTCAlrm);
+		disable_irq_wake(sa1100_rtc->irq_Alrm);
 	return 0;
 }
 
@@ -335,6 +451,7 @@ static struct platform_driver sa1100_rtc_driver = {
 		.pm	= &sa1100_rtc_pm_ops,
 #endif
 	},
+	.id_table	= rtc_id_table,
 };
 
 static int __init sa1100_rtc_init(void)
-- 
1.7.0.4
