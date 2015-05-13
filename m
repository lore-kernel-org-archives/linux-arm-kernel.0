From: robh@kernel.org (Rob Herring)
Date: Wed, 13 May 2015 10:02:28 -0500
Subject: [PATCH v4 4/6] rtc: sa1100/pxa: convert to run-time register mapping
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Message-ID: <1431529350-4597-5-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA1100 and PXA differ only in register offsets which are currently
hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
have this RTC block as well (and not the PXA270 variant).

Convert the driver to use ioremap and set the register offsets dynamically.
Since we are touching all the register accesses, convert them all to
readl_relaxed/writel_relaxed.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-pxa.c    |  4 +++
 drivers/rtc/rtc-sa1100.c | 82 ++++++++++++++++++++++++++++++++----------------
 drivers/rtc/rtc-sa1100.h |  4 +++
 3 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index fb9b3a7..fe4985b 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -356,6 +356,10 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sa1100_rtc->rcnr = pxa_rtc->base + 0x0;
+	sa1100_rtc->rtsr = pxa_rtc->base + 0x8;
+	sa1100_rtc->rtar = pxa_rtc->base + 0x4;
+	sa1100_rtc->rttr = pxa_rtc->base + 0xc;
 	ret = sa1100_rtc_init(pdev, sa1100_rtc);
 	if (!ret) {
 		dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index abc19ab..c2187bf 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -35,12 +35,10 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-
-#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
-#include <mach/regs-rtc.h>
-#endif
+#define RTSR_HZE		BIT(3)	/* HZ interrupt enable */
+#define RTSR_ALE		BIT(2)	/* RTC alarm interrupt enable */
+#define RTSR_HZ			BIT(1)	/* HZ rising-edge detected */
+#define RTSR_AL			BIT(0)	/* RTC alarm detected */
 
 #include "rtc-sa1100.h"
 
@@ -58,16 +56,16 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 
 	spin_lock(&info->lock);
 
-	rtsr = RTSR;
+	rtsr = readl_relaxed(info->rtsr);
 	/* clear interrupt sources */
-	RTSR = 0;
+	writel_relaxed(0, info->rtsr);
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_probe(). */
 	if (rtsr & (RTSR_ALE | RTSR_HZE)) {
 		/* This is the original code, before there was the if test
 		 * above. This code does not clear interrupts that were not
 		 * enabled. */
-		RTSR = (RTSR_AL | RTSR_HZ) & (rtsr >> 2);
+		writel_relaxed((RTSR_AL | RTSR_HZ) & (rtsr >> 2), info->rtsr);
 	} else {
 		/* For some reason, it is possible to enter this routine
 		 * without interruptions enabled, it has been tested with
@@ -76,13 +74,13 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 		 * This situation leads to an infinite "loop" of interrupt
 		 * routine calling and as a result the processor seems to
 		 * lock on its first call to open(). */
-		RTSR = RTSR_AL | RTSR_HZ;
+		writel_relaxed(RTSR_AL | RTSR_HZ, info->rtsr);
 	}
 
 	/* clear alarm interrupt if it has occurred */
 	if (rtsr & RTSR_AL)
 		rtsr &= ~RTSR_ALE;
-	RTSR = rtsr & (RTSR_ALE | RTSR_HZE);
+	writel_relaxed(rtsr & (RTSR_ALE | RTSR_HZE), info->rtsr);
 
 	/* update irq data & counter */
 	if (rtsr & RTSR_AL)
@@ -130,7 +128,7 @@ static void sa1100_rtc_release(struct device *dev)
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
 
 	spin_lock_irq(&info->lock);
-	RTSR = 0;
+	writel_relaxed(0, info->rtsr);
 	spin_unlock_irq(&info->lock);
 
 	free_irq(info->irq_alarm, dev);
@@ -139,39 +137,46 @@ static void sa1100_rtc_release(struct device *dev)
 
 static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
+	u32 rtsr;
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
 
 	spin_lock_irq(&info->lock);
+	rtsr = readl_relaxed(info->rtsr);
 	if (enabled)
-		RTSR |= RTSR_ALE;
+		rtsr |= RTSR_ALE;
 	else
-		RTSR &= ~RTSR_ALE;
+		rtsr &= ~RTSR_ALE;
+	writel_relaxed(rtsr, info->rtsr);
 	spin_unlock_irq(&info->lock);
 	return 0;
 }
 
 static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(RCNR, tm);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+
+	rtc_time_to_tm(readl_relaxed(info->rcnr), tm);
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
+		writel_relaxed(time, info->rcnr);
 	return ret;
 }
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	u32	rtsr;
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
 
-	rtsr = RTSR;
+	rtsr = readl_relaxed(info->rtsr);
 	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
 	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
 	return 0;
@@ -187,12 +192,13 @@ static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ret = rtc_tm_to_time(&alrm->time, &time);
 	if (ret != 0)
 		goto out;
-	RTSR = RTSR & (RTSR_HZE|RTSR_ALE|RTSR_AL);
-	RTAR = time;
+	writel_relaxed(readl_relaxed(info->rtsr) &
+		(RTSR_HZE | RTSR_ALE | RTSR_AL), info->rtsr);
+	writel_relaxed(time, info->rtar);
 	if (alrm->enabled)
-		RTSR |= RTSR_ALE;
+		writel_relaxed(readl_relaxed(info->rtsr) | RTSR_ALE, info->rtsr);
 	else
-		RTSR &= ~RTSR_ALE;
+		writel_relaxed(readl_relaxed(info->rtsr) & ~RTSR_ALE, info->rtsr);
 out:
 	spin_unlock_irq(&info->lock);
 
@@ -201,8 +207,10 @@ out:
 
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32) RTTR);
-	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)RTSR);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+
+	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", readl_relaxed(info->rttr));
+	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", readl_relaxed(info->rtsr));
 
 	return 0;
 }
@@ -241,12 +249,12 @@ int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 	 * If the clock divider is uninitialized then reset it to the
 	 * default value to get the 1Hz clock.
 	 */
-	if (RTTR == 0) {
-		RTTR = RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16);
+	if (readl_relaxed(info->rttr) == 0) {
+		writel_relaxed(RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16), info->rttr);
 		dev_warn(&pdev->dev, "warning: "
 			"initializing default clock divider/trim value\n");
 		/* The current RTC value probably doesn't make sense either */
-		RCNR = 0;
+		writel_relaxed(0, info->rcnr);
 	}
 
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name, &sa1100_rtc_ops,
@@ -279,7 +287,7 @@ int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 	 *
 	 * Notice that clearing bit 1 and 0 is accomplished by writting ONES to
 	 * the corresponding bits in RTSR. */
-	RTSR = RTSR_AL | RTSR_HZ;
+	writel_relaxed(RTSR_AL | RTSR_HZ, info->rtsr);
 
 	return 0;
 }
@@ -288,6 +296,8 @@ EXPORT_SYMBOL_GPL(sa1100_rtc_init);
 static int sa1100_rtc_probe(struct platform_device *pdev)
 {
 	struct sa1100_rtc *info;
+	struct resource *iores;
+	void __iomem *base;
 	int irq_1hz, irq_alarm;
 
 	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
@@ -301,6 +311,24 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	info->irq_1hz = irq_1hz;
 	info->irq_alarm = irq_alarm;
 
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
+	    of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
+		info->rcnr = base + 0x04;
+		info->rtsr = base + 0x10;
+		info->rtar = base + 0x00;
+		info->rttr = base + 0x08;
+	} else {
+		info->rcnr = base + 0x0;
+		info->rtsr = base + 0x8;
+		info->rtar = base + 0x4;
+		info->rttr = base + 0xc;
+	}
+
 	platform_set_drvdata(pdev, info);
 	device_init_wakeup(&pdev->dev, 1);
 
diff --git a/drivers/rtc/rtc-sa1100.h b/drivers/rtc/rtc-sa1100.h
index 665d054..2c79c0c 100644
--- a/drivers/rtc/rtc-sa1100.h
+++ b/drivers/rtc/rtc-sa1100.h
@@ -8,6 +8,10 @@ struct platform_device;
 
 struct sa1100_rtc {
 	spinlock_t		lock;
+	void __iomem		*rcnr;
+	void __iomem		*rtar;
+	void __iomem		*rtsr;
+	void __iomem		*rttr;
 	int			irq_1hz;
 	int			irq_alarm;
 	struct rtc_device	*rtc;
-- 
2.1.0
