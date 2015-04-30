From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Apr 2015 15:37:11 -0500
Subject: [PATCH v2 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <1430426233-7461-1-git-send-email-robh@kernel.org>
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
Message-ID: <1430426233-7461-3-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA1100 and PXA differ only in register offsets which are currently
hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
have this RTC block as well (and not the PXA270 variant).

Convert the driver to use ioremap and set the register offsets dynamically.
Since we are touching all the register accesses, convert them all to
readl_relaxed/writel_relaxed.

Currently, the rtc-sa1100 and rtc-pxa drivers co-exist as rtc-pxa has a
superset of functionality. This commit makes the drivers one step closer
to being mutually exclusive by using devm_ioremap_resource and claiming
the resource. The sharing of overlapping resources does not work if both
drivers claim the resource. That is not done currently, but will be done
as the drivers are converted to DT and follow proper driver rules.
Likely, the common portion of the 2 drivers will be made into library
functions for the SA1100 and PXA drivers to shared.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
---
v2:
- Rebase to v4.1-rc1
- Use _relaxed accessors
- Summarize discussion about supporting both SA1100 and PXA RTC drivers

 drivers/rtc/rtc-sa1100.c | 86 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index b6e1ca0..a21ead5 100644
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
+#define RTSR_HZE	(1 << 3)	/* HZ interrupt enable */
+#define RTSR_ALE	(1 << 2)	/* RTC alarm interrupt enable */
+#define RTSR_HZ		(1 << 1)	/* HZ rising-edge detected */
+#define RTSR_AL		(1 << 0)	/* RTC alarm detected */

 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
@@ -48,6 +46,10 @@

 struct sa1100_rtc {
 	spinlock_t		lock;
+	void __iomem		*rcnr;
+	void __iomem		*rtar;
+	void __iomem		*rtsr;
+	void __iomem		*rttr;
 	int			irq_1hz;
 	int			irq_alarm;
 	struct rtc_device	*rtc;
@@ -63,16 +65,16 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)

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
@@ -81,13 +83,13 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
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
@@ -135,7 +137,7 @@ static void sa1100_rtc_release(struct device *dev)
 	struct sa1100_rtc *info = dev_get_drvdata(dev);

 	spin_lock_irq(&info->lock);
-	RTSR = 0;
+	writel_relaxed(0, info->rtsr);
 	spin_unlock_irq(&info->lock);

 	free_irq(info->irq_alarm, dev);
@@ -144,39 +146,45 @@ static void sa1100_rtc_release(struct device *dev)

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
@@ -192,12 +200,13 @@ static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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

@@ -206,8 +215,9 @@ out:

 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32) RTTR);
-	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)RTSR);
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", readl_relaxed(info->rttr));
+	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", readl_relaxed(info->rtsr));

 	return 0;
 }
@@ -227,6 +237,8 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct sa1100_rtc *info;
+	struct resource *iores;
+	void __iomem *base;
 	int irq_1hz, irq_alarm, ret = 0;

 	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
@@ -244,6 +256,26 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	}
 	info->irq_1hz = irq_1hz;
 	info->irq_alarm = irq_alarm;
+
+
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
 	spin_lock_init(&info->lock);
 	platform_set_drvdata(pdev, info);

@@ -257,12 +289,12 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
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

 	device_init_wakeup(&pdev->dev, 1);
@@ -298,7 +330,7 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	 *
 	 * Notice that clearing bit 1 and 0 is accomplished by writting ONES to
 	 * the corresponding bits in RTSR. */
-	RTSR = RTSR_AL | RTSR_HZ;
+	writel_relaxed(RTSR_AL | RTSR_HZ, info->rtsr);

 	return 0;
 err_dev:
--
2.1.0
