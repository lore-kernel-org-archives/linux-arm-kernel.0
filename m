From: robh@kernel.org (Rob Herring)
Date: Wed, 13 May 2015 10:02:26 -0500
Subject: [PATCH v4 2/6] rtc: pxa: convert to use shared sa1100 functions
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Message-ID: <1431529350-4597-3-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the rtc-sa1100 and rtc-pxa drivers co-exist as rtc-pxa has a
superset of functionality. Having 2 drivers sharing the same memory
resource is not allowed by the driver model if resources are properly
declared. This problem was avoided by not adding memory resources to the
SA1100 RTC driver, but that prevents clean-up of the SA1100 driver.

This commit converts the PXA RTC to use the exported SA1100 RTC
functions. Now the sa1100-rtc and pxa-rtc devices are mutually
exclusive, so we must remove the sa1100-rtc from pxa27x and pxa3xx.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: rtc-linux at googlegroups.com
---
 arch/arm/mach-pxa/pxa27x.c |  1 -
 arch/arm/mach-pxa/pxa3xx.c |  1 -
 drivers/rtc/Kconfig        |  4 +++-
 drivers/rtc/rtc-pxa.c      | 51 ++++++++++++++++++++++------------------------
 4 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index af423a4..cd59959 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -449,7 +449,6 @@ static struct platform_device *devices[] __initdata = {
 	&pxa_device_asoc_ssp2,
 	&pxa_device_asoc_ssp3,
 	&pxa_device_asoc_platform,
-	&sa1100_device_rtc,
 	&pxa_device_rtc,
 	&pxa27x_device_ssp1,
 	&pxa27x_device_ssp2,
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index edcbd9c..ea2ebcf3 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -450,7 +450,6 @@ static struct platform_device *devices[] __initdata = {
 	&pxa_device_asoc_ssp3,
 	&pxa_device_asoc_ssp4,
 	&pxa_device_asoc_platform,
-	&sa1100_device_rtc,
 	&pxa_device_rtc,
 	&pxa3xx_device_ssp1,
 	&pxa3xx_device_ssp2,
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0fe4ad8..e77f18c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1301,9 +1301,11 @@ config RTC_DRV_GENERIC
 config RTC_DRV_PXA
        tristate "PXA27x/PXA3xx"
        depends on ARCH_PXA
+       select RTC_DRV_SA1100
        help
          If you say Y here you will get access to the real time clock
-         built into your PXA27x or PXA3xx CPU.
+         built into your PXA27x or PXA3xx CPU. This RTC is actually 2 RTCs
+         consisting of an SA1100 compatible RTC and the extended PXA RTC.
 
          This RTC driver uses PXA RTC registers available since pxa27x
          series (RDxR, RYxR) instead of legacy RCNR, RTAR.
diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 4561f37..fb9b3a7 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -32,6 +32,8 @@
 
 #include <mach/hardware.h>
 
+#include "rtc-sa1100.h"
+
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
 #define MAXFREQ_PERIODIC	1000
@@ -86,10 +88,9 @@
 	__raw_writel((value), (pxa_rtc)->base + (reg))
 
 struct pxa_rtc {
+	struct sa1100_rtc sa1100_rtc;
 	struct resource	*ress;
 	void __iomem		*base;
-	int			irq_1Hz;
-	int			irq_Alrm;
 	struct rtc_device	*rtc;
 	spinlock_t		lock;		/* Protects this structure */
 };
@@ -184,25 +185,25 @@ static int pxa_rtc_open(struct device *dev)
 	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev);
 	int ret;
 
-	ret = request_irq(pxa_rtc->irq_1Hz, pxa_rtc_irq, 0,
+	ret = request_irq(pxa_rtc->sa1100_rtc.irq_1hz, pxa_rtc_irq, 0,
 			  "rtc 1Hz", dev);
 	if (ret < 0) {
-		dev_err(dev, "can't get irq %i, err %d\n", pxa_rtc->irq_1Hz,
-			ret);
+		dev_err(dev, "can't get irq %i, err %d\n",
+			pxa_rtc->sa1100_rtc.irq_1hz, ret);
 		goto err_irq_1Hz;
 	}
-	ret = request_irq(pxa_rtc->irq_Alrm, pxa_rtc_irq, 0,
+	ret = request_irq(pxa_rtc->sa1100_rtc.irq_alarm, pxa_rtc_irq, 0,
 			  "rtc Alrm", dev);
 	if (ret < 0) {
-		dev_err(dev, "can't get irq %i, err %d\n", pxa_rtc->irq_Alrm,
-			ret);
+		dev_err(dev, "can't get irq %i, err %d\n",
+			pxa_rtc->sa1100_rtc.irq_alarm, ret);
 		goto err_irq_Alrm;
 	}
 
 	return 0;
 
 err_irq_Alrm:
-	free_irq(pxa_rtc->irq_1Hz, dev);
+	free_irq(pxa_rtc->sa1100_rtc.irq_1hz, dev);
 err_irq_1Hz:
 	return ret;
 }
@@ -215,8 +216,8 @@ static void pxa_rtc_release(struct device *dev)
 	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
 	spin_unlock_irq(&pxa_rtc->lock);
 
-	free_irq(pxa_rtc->irq_Alrm, dev);
-	free_irq(pxa_rtc->irq_1Hz, dev);
+	free_irq(pxa_rtc->sa1100_rtc.irq_1hz, dev);
+	free_irq(pxa_rtc->sa1100_rtc.irq_alarm, dev);
 }
 
 static int pxa_alarm_irq_enable(struct device *dev, unsigned int enabled)
@@ -320,12 +321,13 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa_rtc *pxa_rtc;
+	struct sa1100_rtc *sa1100_rtc;
 	int ret;
-	u32 rttr;
 
 	pxa_rtc = devm_kzalloc(dev, sizeof(*pxa_rtc), GFP_KERNEL);
 	if (!pxa_rtc)
 		return -ENOMEM;
+	sa1100_rtc = &pxa_rtc->sa1100_rtc;
 
 	spin_lock_init(&pxa_rtc->lock);
 	platform_set_drvdata(pdev, pxa_rtc);
@@ -336,13 +338,13 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pxa_rtc->irq_1Hz = platform_get_irq(pdev, 0);
-	if (pxa_rtc->irq_1Hz < 0) {
+	sa1100_rtc->irq_1hz = platform_get_irq(pdev, 0);
+	if (sa1100_rtc->irq_1hz < 0) {
 		dev_err(dev, "No 1Hz IRQ resource defined\n");
 		return -ENXIO;
 	}
-	pxa_rtc->irq_Alrm = platform_get_irq(pdev, 1);
-	if (pxa_rtc->irq_Alrm < 0) {
+	sa1100_rtc->irq_alarm = platform_get_irq(pdev, 1);
+	if (sa1100_rtc->irq_alarm < 0) {
 		dev_err(dev, "No alarm IRQ resource defined\n");
 		return -ENXIO;
 	}
@@ -354,15 +356,10 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
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
+	ret = sa1100_rtc_init(pdev, sa1100_rtc);
+	if (!ret) {
+		dev_err(dev, "Unable to init SA1100 RTC sub-device\n");
+		return ret;
 	}
 
 	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
@@ -402,7 +399,7 @@ static int pxa_rtc_suspend(struct device *dev)
 	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(pxa_rtc->irq_Alrm);
+		enable_irq_wake(pxa_rtc->sa1100_rtc.irq_alarm);
 	return 0;
 }
 
@@ -411,7 +408,7 @@ static int pxa_rtc_resume(struct device *dev)
 	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(pxa_rtc->irq_Alrm);
+		disable_irq_wake(pxa_rtc->sa1100_rtc.irq_alarm);
 	return 0;
 }
 #endif
-- 
2.1.0
