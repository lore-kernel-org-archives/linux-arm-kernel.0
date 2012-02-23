From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 23 Feb 2012 11:28:29 +0800
Subject: [PATCH v2 3/7] rtc: sa1100: use ioremap to map registers
In-Reply-To: <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1329967709-3786-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resource definition of sa1100 rtc. And use ioremap to map rtc
registers to avoid including address definition of rtc register.
So the same driver could be shared on sa1100/pxa/mmp series.

Since there's two RTC wrappers on RTC module among PXA27x/PXA3xx/PXA95x,
keep treating the two wrappers as two RTC devices will result issues
of registering platform device. So only keep one RTC wrapper in
these silicons.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/devices.c    |    6 +-
 arch/arm/mach-pxa/pxa27x.c     |    1 -
 arch/arm/mach-pxa/pxa3xx.c     |    1 -
 arch/arm/mach-pxa/pxa95x.c     |    1 -
 arch/arm/mach-sa1100/generic.c |    8 ++
 drivers/rtc/Kconfig            |    4 +-
 drivers/rtc/rtc-sa1100.c       |  243 ++++++++++++++++++++++++++++++----------
 7 files changed, 199 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 5bc1312..9fe7d6a 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -406,18 +406,22 @@ static struct resource pxa_rtc_resources[] = {
 	[1] = {
 		.start  = IRQ_RTC1Hz,
 		.end    = IRQ_RTC1Hz,
+		.name	= "rtc 1Hz",
 		.flags  = IORESOURCE_IRQ,
 	},
 	[2] = {
 		.start  = IRQ_RTCAlrm,
 		.end    = IRQ_RTCAlrm,
+		.name	= "rtc alarm",
 		.flags  = IORESOURCE_IRQ,
 	},
 };
 
 struct platform_device sa1100_device_rtc = {
-	.name		= "sa1100-rtc",
+	.name		= "pxa25x-rtc",
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa_rtc_resources),
+	.resource	= pxa_rtc_resources,
 };
 
 struct platform_device pxa_device_rtc = {
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index aed6cbc..345fa7b 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -431,7 +431,6 @@ static struct platform_device *devices[] __initdata = {
 	&pxa_device_asoc_ssp3,
 	&pxa_device_asoc_platform,
 	&sa1100_device_rtc,
-	&pxa_device_rtc,
 	&pxa27x_device_ssp1,
 	&pxa27x_device_ssp2,
 	&pxa27x_device_ssp3,
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4f402af..d2437a8 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -428,7 +428,6 @@ static struct platform_device *devices[] __initdata = {
 	&pxa_device_asoc_ssp4,
 	&pxa_device_asoc_platform,
 	&sa1100_device_rtc,
-	&pxa_device_rtc,
 	&pxa27x_device_ssp1,
 	&pxa27x_device_ssp2,
 	&pxa27x_device_ssp3,
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index d082a58..b41e9f3 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -249,7 +249,6 @@ void __init pxa95x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct platform_device *devices[] __initdata = {
 	&pxa_device_gpio,
-	&sa1100_device_rtc,
 	&pxa_device_rtc,
 	&pxa27x_device_ssp1,
 	&pxa27x_device_ssp2,
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index bb10ee2..7c1ebf4 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -345,9 +345,17 @@ void sa11x0_register_irda(struct irda_platform_data *irda)
 	sa11x0_register_device(&sa11x0ir_device, irda);
 }
 
+static struct resource sa1100_rtc_resources[] = {
+	DEFINE_RES_MEM(0x90010000, 0x9001003f),
+	DEFINE_RES_IRQ_NAMED(IRQ_RTC1Hz, "rtc 1Hz"),
+	DEFINE_RES_IRQ_NAMED(IRQ_RTCAlrm, "rtc alarm"),
+};
+
 static struct platform_device sa11x0rtc_device = {
 	.name		= "sa1100-rtc",
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(sa1100_rtc_resources),
+	.resource	= sa1100_rtc_resources,
 };
 
 static struct platform_device *sa11x0_devices[] __initdata = {
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3a125b8..59efc63 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -773,8 +773,8 @@ config RTC_DRV_EP93XX
 	  will be called rtc-ep93xx.
 
 config RTC_DRV_SA1100
-	tristate "SA11x0/PXA2xx"
-	depends on ARCH_SA1100 || ARCH_PXA
+	tristate "SA11x0/PXA2xx/PXA910"
+	depends on ARCH_SA1100 || ARCH_PXA || ARCH_MMP
 	help
 	  If you say Y here you will get access to the real time clock
 	  built into your SA11x0 or PXA2xx CPU.
diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 91d58bd..90425ce 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -25,44 +25,101 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
 
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#ifdef CONFIG_ARCH_PXA
-#include <mach/regs-rtc.h>
-#endif
-
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
+#define RTC_FREQ		1024
+
+#define RTSR_HZE		(1 << 3)	/* HZ interrupt enable */
+#define RTSR_ALE		(1 << 2)	/* RTC alarm interrupt enable */
+#define RTSR_HZ			(1 << 1)	/* HZ rising-edge detected */
+#define RTSR_AL			(1 << 0)	/* RTC alarm detected */
 
-static const unsigned long RTC_FREQ = 1024;
-static DEFINE_SPINLOCK(sa1100_rtc_lock);
+struct sa1100_reg_layout {
+	unsigned int	rcnr;			/* RTC Count Register */
+	unsigned int	rtar;			/* RTC Alarm Register */
+	unsigned int	rtsr;			/* RTC Status Register */
+	unsigned int	rttr;			/* RTC Timer Trim Register */
+
+};
+
+enum sa1100_rtc_types {
+	REGS_SA1100,
+	REGS_PXA25X,
+	REGS_PXA910,
+};
+
+struct sa1100_rtc {
+	spinlock_t		lock;
+	unsigned long		iobase;
+	unsigned long		iosize;
+	int			irq_1hz;
+	int			irq_alarm;
+	struct rtc_device	*rtc;
+
+	void __iomem		*reg_base;
+	void __iomem		*reg_rcnr;
+	void __iomem		*reg_rtar;
+	void __iomem		*reg_rtsr;
+	void __iomem		*reg_rttr;
+};
+
+static struct sa1100_reg_layout sa1100_layout[] = {
+	[REGS_SA1100] = {
+		.rcnr = 0x04,
+		.rtar = 0x00,
+		.rtsr = 0x10,
+		.rttr = 0x08,
+	},
+	[REGS_PXA25X] = {
+		.rcnr = 0x00,
+		.rtar = 0x04,
+		.rtsr = 0x08,
+		.rttr = 0x10,
+	},
+	[REGS_PXA910] = {
+		.rcnr = 0x00,
+		.rtar = 0x04,
+		.rtsr = 0x08,
+		.rttr = 0x0C,
+	},
+};
+
+static const struct platform_device_id sa1100_rtc_id_table[] = {
+	{ "sa1100-rtc",		REGS_SA1100 },
+	{ "pxa25x-rtc",		REGS_PXA25X },
+	{ "pxa910-rtc",		REGS_PXA910 },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sa1100_rtc_id_table);
 
 static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 {
-	struct platform_device *pdev = to_platform_device(dev_id);
-	struct rtc_device *rtc = platform_get_drvdata(pdev);
+	struct sa1100_rtc *info = dev_get_drvdata(dev_id);
+	struct rtc_device *rtc = info->rtc;
 	unsigned int rtsr;
 	unsigned long events = 0;
 
-	spin_lock(&sa1100_rtc_lock);
+	spin_lock(&info->lock);
 
-	rtsr = RTSR;
+	rtsr = readl_relaxed(info->reg_rtsr);
 	/* clear interrupt sources */
-	RTSR = 0;
+	writel_relaxed(0, info->reg_rtsr);
+
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_probe(). */
 	if (rtsr & (RTSR_ALE | RTSR_HZE)) {
 		/* This is the original code, before there was the if test
 		 * above. This code does not clear interrupts that were not
 		 * enabled. */
-		RTSR = (RTSR_AL | RTSR_HZ) & (rtsr >> 2);
+		writel_relaxed((RTSR_AL|RTSR_HZ) & (rtsr >> 2), info->reg_rtsr);
 	} else {
 		/* For some reason, it is possible to enter this routine
 		 * without interruptions enabled, it has been tested with
@@ -71,13 +128,13 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 		 * This situation leads to an infinite "loop" of interrupt
 		 * routine calling and as a result the processor seems to
 		 * lock on its first call to open(). */
-		RTSR = RTSR_AL | RTSR_HZ;
+		writel_relaxed(RTSR_AL | RTSR_HZ, info->reg_rtsr);
 	}
 
 	/* clear alarm interrupt if it has occurred */
 	if (rtsr & RTSR_AL)
 		rtsr &= ~RTSR_ALE;
-	RTSR = rtsr & (RTSR_ALE | RTSR_HZE);
+	writel_relaxed(rtsr & (RTSR_ALE | RTSR_HZE), info->reg_rtsr);
 
 	/* update irq data & counter */
 	if (rtsr & RTSR_AL)
@@ -87,27 +144,27 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 
 	rtc_update_irq(rtc, 1, events);
 
-	spin_unlock(&sa1100_rtc_lock);
+	spin_unlock(&info->lock);
 
 	return IRQ_HANDLED;
 }
 
 static int sa1100_rtc_open(struct device *dev)
 {
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+	struct rtc_device *rtc = info->rtc;
 	int ret;
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
 
-	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, IRQF_DISABLED,
+	ret = request_irq(info->irq_1hz, sa1100_rtc_interrupt, IRQF_DISABLED,
 		"rtc 1Hz", dev);
 	if (ret) {
-		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTC1Hz);
+		dev_err(dev, "IRQ %d already in use.\n", info->irq_1hz);
 		goto fail_ui;
 	}
-	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, IRQF_DISABLED,
+	ret = request_irq(info->irq_alarm, sa1100_rtc_interrupt, IRQF_DISABLED,
 		"rtc Alrm", dev);
 	if (ret) {
-		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTCAlrm);
+		dev_err(dev, "IRQ %d already in use.\n", info->irq_alarm);
 		goto fail_ai;
 	}
 	rtc->max_user_freq = RTC_FREQ;
@@ -116,54 +173,66 @@ static int sa1100_rtc_open(struct device *dev)
 	return 0;
 
  fail_ai:
-	free_irq(IRQ_RTC1Hz, dev);
+	free_irq(info->irq_1hz, dev);
  fail_ui:
 	return ret;
 }
 
 static void sa1100_rtc_release(struct device *dev)
 {
-	spin_lock_irq(&sa1100_rtc_lock);
-	RTSR = 0;
-	spin_unlock_irq(&sa1100_rtc_lock);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+
+	spin_lock_irq(&info->lock);
+	writel_relaxed(0, info->reg_rtsr);
+	spin_unlock_irq(&info->lock);
 
-	free_irq(IRQ_RTCAlrm, dev);
-	free_irq(IRQ_RTC1Hz, dev);
+	free_irq(info->irq_alarm, dev);
+	free_irq(info->irq_1hz, dev);
 }
 
 static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	spin_lock_irq(&sa1100_rtc_lock);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+	unsigned long rtsr;
+	spin_lock_irq(&info->lock);
+	rtsr = readl_relaxed(info->reg_rtsr);
 	if (enabled)
-		RTSR |= RTSR_ALE;
+		rtsr |= RTSR_ALE;
 	else
-		RTSR &= ~RTSR_ALE;
-	spin_unlock_irq(&sa1100_rtc_lock);
+		rtsr &= ~RTSR_ALE;
+	writel_relaxed(rtsr, info->reg_rtsr);
+	spin_unlock_irq(&info->lock);
 	return 0;
 }
 
 static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(RCNR, tm);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+	unsigned long rcnr;
+
+	rcnr = readl_relaxed(info->reg_rcnr);
+	rtc_time_to_tm(rcnr, tm);
 	return 0;
 }
 
 static int sa1100_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
 	unsigned long time;
 	int ret;
 
 	ret = rtc_tm_to_time(tm, &time);
 	if (ret == 0)
-		RCNR = time;
+		writel_relaxed(time, info->reg_rcnr);
 	return ret;
 }
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
 	u32	rtsr;
 
-	rtsr = RTSR;
+	rtsr = readl_relaxed(info->reg_rtsr);
 	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
 	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
 	return 0;
@@ -171,29 +240,38 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	unsigned long time;
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+	unsigned long time, rtsr;
 	int ret;
 
-	spin_lock_irq(&sa1100_rtc_lock);
+	spin_lock_irq(&info->lock);
 	ret = rtc_tm_to_time(&alrm->time, &time);
 	if (ret != 0)
 		goto out;
-	RTSR = RTSR & (RTSR_HZE|RTSR_ALE|RTSR_AL);
-	RTAR = time;
+	rtsr = readl_relaxed(info->reg_rtsr);
+	rtsr &= RTSR_HZE | RTSR_ALE | RTSR_AL;
+	writel_relaxed(rtsr, info->reg_rtsr);
+	writel_relaxed(time, info->reg_rtar);
 	if (alrm->enabled)
-		RTSR |= RTSR_ALE;
+		rtsr |= RTSR_ALE;
 	else
-		RTSR &= ~RTSR_ALE;
+		rtsr &= ~RTSR_ALE;
+	writel_relaxed(rtsr, info->reg_rtsr);
 out:
-	spin_unlock_irq(&sa1100_rtc_lock);
+	spin_unlock_irq(&info->lock);
 
 	return ret;
 }
 
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32) RTTR);
-	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)RTSR);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+	unsigned long rttr, rtsr;
+
+	rttr = readl_relaxed(info->reg_rttr);
+	rtsr = readl_relaxed(info->reg_rtsr);
+	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32)rttr);
+	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)rtsr);
 
 	return 0;
 }
@@ -211,7 +289,39 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 
 static int sa1100_rtc_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	enum sa1100_rtc_types rtc_type = id->driver_data;
 	struct rtc_device *rtc;
+	struct resource *res;
+	struct sa1100_rtc *info;
+	int irq_1hz, irq_alarm, ret = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
+	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
+	if (res == NULL || irq_1hz < 0 || irq_alarm < 0)
+		return -ENODEV;
+
+	info = kzalloc(sizeof(struct sa1100_rtc), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->iobase = res->start;
+	info->iosize = resource_size(res);
+	info->irq_1hz = irq_1hz;
+	info->irq_alarm = irq_alarm;
+	spin_lock_init(&info->lock);
+	platform_set_drvdata(pdev, info);
+
+	info->reg_base = ioremap(info->iobase, info->iosize);
+	if (!info->reg_base) {
+		ret = -EIO;
+		goto err_map;
+	}
+	info->reg_rcnr = info->reg_base + sa1100_layout[rtc_type].rcnr;
+	info->reg_rtar = info->reg_base + sa1100_layout[rtc_type].rtar;
+	info->reg_rtsr = info->reg_base + sa1100_layout[rtc_type].rtsr;
+	info->reg_rttr = info->reg_base + sa1100_layout[rtc_type].rttr;
 
 	/*
 	 * According to the manual we should be able to let RTTR be zero
@@ -220,12 +330,13 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	 * If the clock divider is uninitialized then reset it to the
 	 * default value to get the 1Hz clock.
 	 */
-	if (RTTR == 0) {
-		RTTR = RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16);
+	if (readl_relaxed(info->reg_rttr) == 0) {
+		writel_relaxed(RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16),
+				info->reg_rttr);
 		dev_warn(&pdev->dev, "warning: "
 			"initializing default clock divider/trim value\n");
 		/* The current RTC value probably doesn't make sense either */
-		RCNR = 0;
+		writel_relaxed(0, info->reg_rcnr);
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
@@ -233,10 +344,11 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	rtc = rtc_device_register(pdev->name, &pdev->dev, &sa1100_rtc_ops,
 		THIS_MODULE);
 
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	platform_set_drvdata(pdev, rtc);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto err_dev;
+	}
+	info->rtc = rtc;
 
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_interrupt().
@@ -260,17 +372,27 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	 *
 	 * Notice that clearing bit 1 and 0 is accomplished by writting ONES to
 	 * the corresponding bits in RTSR. */
-	RTSR = RTSR_AL | RTSR_HZ;
+	writel_relaxed(RTSR_AL | RTSR_HZ, info->reg_rtsr);
 
 	return 0;
+err_dev:
+	iounmap(info->reg_base);
+err_map:
+	platform_set_drvdata(pdev, NULL);
+	kfree(info);
+	return ret;
 }
 
 static int sa1100_rtc_remove(struct platform_device *pdev)
 {
-	struct rtc_device *rtc = platform_get_drvdata(pdev);
+	struct sa1100_rtc *info = platform_get_drvdata(pdev);
 
-	if (rtc)
-		rtc_device_unregister(rtc);
+	if (info) {
+		rtc_device_unregister(info->rtc);
+		platform_set_drvdata(pdev, NULL);
+		iounmap(info->reg_base);
+		kfree(info);
+	}
 
 	return 0;
 }
@@ -278,15 +400,17 @@ static int sa1100_rtc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int sa1100_rtc_suspend(struct device *dev)
 {
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
 	if (device_may_wakeup(dev))
-		enable_irq_wake(IRQ_RTCAlrm);
+		enable_irq_wake(info->irq_alarm);
 	return 0;
 }
 
 static int sa1100_rtc_resume(struct device *dev)
 {
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
 	if (device_may_wakeup(dev))
-		disable_irq_wake(IRQ_RTCAlrm);
+		disable_irq_wake(info->irq_alarm);
 	return 0;
 }
 
@@ -305,6 +429,7 @@ static struct platform_driver sa1100_rtc_driver = {
 		.pm	= &sa1100_rtc_pm_ops,
 #endif
 	},
+	.id_table	= sa1100_rtc_id_table,
 };
 
 module_platform_driver(sa1100_rtc_driver);
-- 
1.7.0.4
