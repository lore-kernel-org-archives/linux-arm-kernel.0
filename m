From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 May 2015 15:29:08 -0500
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <87lhgumi4b.fsf@belgarion.home>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <1431384089-28367-2-git-send-email-robh@kernel.org>
 <20150511224934.GL2067@n2100.arm.linux.org.uk>
 <CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
 <87lhgumi4b.fsf@belgarion.home>
Message-ID: <55526294.6090809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 1:20 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>>> This really isn't a good idea - what do you think happens when
>>> the same struct resource gets passed into insert_resource()
>>> twice?
>>
>> Bad things. If you recall, we discussed this on v1[1]. See the commit
>> msg of patch 2 for the summary. There is not currently a problem
>> because the rtc-pxa driver does not request the resource.
>
> I think you're talking about resource claiming, while Russell is talking about
> resource declaration.
>
> The point Russell is raising is if you do a platform_add_device() twice with the
> same resource (which is done in pxa, once for sa1100-rtc, once for pxa-rtc), you
> call insert_resource() twice with the same resource structure.
>
> I had not thought of that before (that's in my reply noted "nasty consequences"
> in [1]), and I'll do my homework this week, and try this only patch, but if I
> follow Russell's thinking, then sa1100-rtc and pxa-rtc cannot be declared
> together anymore.

Oh yes, that is a problem. So looks like we have to make PXA a single driver. 
Please take a look at the patch below. It's on top of this series currently, so 
I've got to go back and re-order things. It is build tested only.

Technically, the locking is all wrong currently, and the spinlock should be 
shared, too. However, since this driver is always on a UP system everything 
is fine.

Rob

8<---------------------------------------------------------

Author: Rob Herring <robh@kernel.org>
Date:   Tue May 12 14:31:13 2015 -0500

    rtc rework
    
    Signed-off-by: Rob Herring <robh@kernel.org>

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 4561f37..70412c9c 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -32,6 +32,8 @@
 
 #include <mach/hardware.h>
 
+#include "rtc-sa1100.h"
+
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
 #define MAXFREQ_PERIODIC	1000
@@ -86,6 +88,7 @@
 	__raw_writel((value), (pxa_rtc)->base + (reg))
 
 struct pxa_rtc {
+	struct sa1100_rtc sa1100_rtc;
 	struct resource	*ress;
 	void __iomem		*base;
 	int			irq_1Hz;
@@ -321,7 +324,6 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pxa_rtc *pxa_rtc;
 	int ret;
-	u32 rttr;
 
 	pxa_rtc = devm_kzalloc(dev, sizeof(*pxa_rtc), GFP_KERNEL);
 	if (!pxa_rtc)
@@ -354,15 +356,16 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	/*
-	 * If the clock divider is uninitialized then reset it to the
-	 * default value to get the 1Hz clock.
-	 */
-	if (rtc_readl(pxa_rtc, RTTR) == 0) {
-		rttr = RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16);
-		rtc_writel(pxa_rtc, RTTR, rttr);
-		dev_warn(dev, "warning: initializing default clock"
-			 " divider/trim value\n");
+	pxa_rtc->sa1100_rtc.rcnr = pxa_rtc->base + 0x0;
+	pxa_rtc->sa1100_rtc.rtsr = pxa_rtc->base + 0x8;
+	pxa_rtc->sa1100_rtc.rtar = pxa_rtc->base + 0x4;
+	pxa_rtc->sa1100_rtc.rttr = pxa_rtc->base + 0xc;
+	pxa_rtc->sa1100_rtc.irq_1hz = pxa_rtc->irq_1Hz;
+	pxa_rtc->sa1100_rtc.irq_alarm = pxa_rtc->irq_Alrm;
+	ret = sa1100_rtc_init(pdev, &pxa_rtc->sa1100_rtc);
+	if (!ret) {
+		dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
+		return ret;
 	}
 
 	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 52d2a8a..6e3f63b 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -35,6 +35,8 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 
+#include "rtc-sa1100.h"
+
 #define RTSR_HZE		BIT(3)	/* HZ interrupt enable */
 #define RTSR_ALE		BIT(2)	/* RTC alarm interrupt enable */
 #define RTSR_HZ			BIT(1)	/* HZ rising-edge detected */
@@ -44,17 +46,6 @@
 #define RTC_DEF_TRIM		0
 #define RTC_FREQ		1024
 
-struct sa1100_rtc {
-	spinlock_t		lock;
-	void __iomem		*rcnr;
-	void __iomem		*rtar;
-	void __iomem		*rtsr;
-	void __iomem		*rttr;
-	int			irq_1hz;
-	int			irq_alarm;
-	struct rtc_device	*rtc;
-	struct clk		*clk;
-};
 
 static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 {
@@ -235,50 +226,18 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 	.alarm_irq_enable = sa1100_rtc_alarm_irq_enable,
 };
 
-static int sa1100_rtc_probe(struct platform_device *pdev)
+int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 {
 	struct rtc_device *rtc;
-	struct sa1100_rtc *info;
-	struct resource *iores;
-	void __iomem *base;
-	int irq_1hz, irq_alarm, ret = 0;
+	int ret;
 
-	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
-	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
-	if (irq_1hz < 0 || irq_alarm < 0)
-		return -ENODEV;
+	spin_lock_init(&info->lock);
 
-	info = devm_kzalloc(&pdev->dev, sizeof(struct sa1100_rtc), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 	info->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk)) {
 		dev_err(&pdev->dev, "failed to find rtc clock source\n");
 		return PTR_ERR(info->clk);
 	}
-	info->irq_1hz = irq_1hz;
-	info->irq_alarm = irq_alarm;
-
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, iores);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
-	    of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
-		info->rcnr = base + 0x04;
-		info->rtsr = base + 0x10;
-		info->rtar = base + 0x00;
-		info->rttr = base + 0x08;
-	} else {
-		info->rcnr = base + 0x0;
-		info->rtsr = base + 0x8;
-		info->rtar = base + 0x4;
-		info->rttr = base + 0xc;
-	}
-
-	spin_lock_init(&info->lock);
-	platform_set_drvdata(pdev, info);
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret)
@@ -298,14 +257,11 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 		writel_relaxed(0, info->rcnr);
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
-
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name, &sa1100_rtc_ops,
 					THIS_MODULE);
-
 	if (IS_ERR(rtc)) {
-		ret = PTR_ERR(rtc);
-		goto err_dev;
+		clk_disable_unprepare(info->clk);
+		return PTR_ERR(rtc);
 	}
 	info->rtc = rtc;
 
@@ -334,9 +290,49 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	writel_relaxed(RTSR_AL | RTSR_HZ, info->rtsr);
 
 	return 0;
-err_dev:
-	clk_disable_unprepare(info->clk);
-	return ret;
+}
+EXPORT_SYMBOL_GPL(sa1100_rtc_init);
+
+static int sa1100_rtc_probe(struct platform_device *pdev)
+{
+	struct sa1100_rtc *info;
+	struct resource *iores;
+	void __iomem *base;
+	int irq_1hz, irq_alarm;
+
+	irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
+	irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
+	if (irq_1hz < 0 || irq_alarm < 0)
+		return -ENODEV;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(struct sa1100_rtc), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->irq_1hz = irq_1hz;
+	info->irq_alarm = irq_alarm;
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
+	platform_set_drvdata(pdev, info);
+	device_init_wakeup(&pdev->dev, 1);
+
+	return sa1100_rtc_init(pdev, info);
 }
 
 static int sa1100_rtc_remove(struct platform_device *pdev)
diff --git a/drivers/rtc/rtc-sa1100.h b/drivers/rtc/rtc-sa1100.h
new file mode 100644
index 0000000..2c79c0c
--- /dev/null
+++ b/drivers/rtc/rtc-sa1100.h
@@ -0,0 +1,23 @@
+#ifndef __RTC_SA1100_H__
+#define __RTC_SA1100_H__
+
+#include <linux/kernel.h>
+
+struct clk;
+struct platform_device;
+
+struct sa1100_rtc {
+	spinlock_t		lock;
+	void __iomem		*rcnr;
+	void __iomem		*rtar;
+	void __iomem		*rtsr;
+	void __iomem		*rttr;
+	int			irq_1hz;
+	int			irq_alarm;
+	struct rtc_device	*rtc;
+	struct clk		*clk;
+};
+
+int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info);
+
+#endif
