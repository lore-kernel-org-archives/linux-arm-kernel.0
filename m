From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 24 Feb 2012 00:00:47 +0800
Subject: [PATCH v3 3/7] rtc: sa1100: declare irq in resource
In-Reply-To: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330012851-13693-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to hard coded irq in rtc-sa1100 driver since we could share
it among arch-sa1100/arch-pxa/arch-mmp.

We still keep hard coded register address since the requirement is
enabling both rtc-sa1100 and rtc-pxa driver. The register addresses
are conflict since they're only two wrappers on the same rtc device.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/devices.c    |   28 +++++++++--
 arch/arm/mach-sa1100/generic.c |    8 +++
 drivers/rtc/Kconfig            |    4 +-
 drivers/rtc/rtc-sa1100.c       |   98 +++++++++++++++++++++++++++-------------
 4 files changed, 100 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 5bc1312..84f2d70 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -406,20 +406,17 @@ static struct resource pxa_rtc_resources[] = {
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
 
-struct platform_device sa1100_device_rtc = {
-	.name		= "sa1100-rtc",
-	.id		= -1,
-};
-
 struct platform_device pxa_device_rtc = {
 	.name		= "pxa-rtc",
 	.id		= -1,
@@ -427,6 +424,27 @@ struct platform_device pxa_device_rtc = {
 	.resource       = pxa_rtc_resources,
 };
 
+static struct resource sa1100_rtc_resources[] = {
+	{
+		.start  = IRQ_RTC1Hz,
+		.end    = IRQ_RTC1Hz,
+		.name	= "rtc 1Hz",
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.start  = IRQ_RTCAlrm,
+		.end    = IRQ_RTCAlrm,
+		.name	= "rtc alarm",
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device sa1100_device_rtc = {
+	.name		= "sa1100-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(sa1100_rtc_resources),
+	.resource	= sa1100_rtc_resources,
+};
+
 static struct resource pxa_ac97_resources[] = {
 	[0] = {
 		.start  = 0x40500000,
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
index 91d58bd..0a36c7e 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
@@ -34,24 +35,29 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
-#ifdef CONFIG_ARCH_PXA
+#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
 #include <mach/regs-rtc.h>
 #endif
 
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
+#define RTC_FREQ		1024
 
-static const unsigned long RTC_FREQ = 1024;
-static DEFINE_SPINLOCK(sa1100_rtc_lock);
+struct sa1100_rtc {
+	spinlock_t		lock;
+	int			irq_1hz;
+	int			irq_alarm;
+	struct rtc_device	*rtc;
+};
 
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
 
 	rtsr = RTSR;
 	/* clear interrupt sources */
@@ -87,27 +93,27 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 
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
@@ -116,29 +122,33 @@ static int sa1100_rtc_open(struct device *dev)
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
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
+
+	spin_lock_irq(&info->lock);
 	RTSR = 0;
-	spin_unlock_irq(&sa1100_rtc_lock);
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
+
+	spin_lock_irq(&info->lock);
 	if (enabled)
 		RTSR |= RTSR_ALE;
 	else
 		RTSR &= ~RTSR_ALE;
-	spin_unlock_irq(&sa1100_rtc_lock);
+	spin_unlock_irq(&info->lock);
 	return 0;
 }
 
@@ -171,10 +181,11 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct sa1100_rtc *info = dev_get_drvdata(dev);
 	unsigned long time;
 	int ret;
 
-	spin_lock_irq(&sa1100_rtc_lock);
+	spin_lock_irq(&info->lock);
 	ret = rtc_tm_to_time(&alrm->time, &time);
 	if (ret != 0)
 		goto out;
@@ -185,7 +196,7 @@ static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	else
 		RTSR &= ~RTSR_ALE;
 out:
-	spin_unlock_irq(&sa1100_rtc_lock);
+	spin_unlock_irq(&info->lock);
 
 	return ret;
 }
@@ -212,6 +223,21 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 static int sa1100_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
+	struct sa1100_rtc *info;
+	int irq_1hz, irq_alarm, ret = 0;
+
+	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
+	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
+	if (irq_1hz < 0 || irq_alarm < 0)
+		return -ENODEV;
+
+	info = kzalloc(sizeof(struct sa1100_rtc), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->irq_1hz = irq_1hz;
+	info->irq_alarm = irq_alarm;
+	spin_lock_init(&info->lock);
+	platform_set_drvdata(pdev, info);
 
 	/*
 	 * According to the manual we should be able to let RTTR be zero
@@ -233,10 +259,11 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
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
@@ -263,14 +290,21 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	RTSR = RTSR_AL | RTSR_HZ;
 
 	return 0;
+err_dev:
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
+		kfree(info);
+	}
 
 	return 0;
 }
@@ -278,15 +312,17 @@ static int sa1100_rtc_remove(struct platform_device *pdev)
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
 
-- 
1.7.0.4
