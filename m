From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 14 Aug 2012 11:19:22 +0200
Subject: [PATCH v2 2/2] ARM: at91: fix rtc-at91sam9 irq issue due to sparse
 irq support
In-Reply-To: <1344935962-18871-1-git-send-email-ludovic.desroches@atmel.com>
References: <1344935962-18871-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1344935962-18871-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

AT91_ID_SYS as virq is incorrect because of spare irq support which
introduces NR_IRQS_LEGACY offset. It modifies rtc-at91sam9 driver in
order to get irq from resources.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |  6 +++++-
 arch/arm/mach-at91/at91sam9261_devices.c |  6 +++++-
 arch/arm/mach-at91/at91sam9263_devices.c | 10 ++++++++--
 arch/arm/mach-at91/at91sam9g45_devices.c |  6 +++++-
 arch/arm/mach-at91/at91sam9rl_devices.c  |  6 +++++-
 drivers/rtc/rtc-at91sam9.c               | 22 +++++++++++++++-------
 6 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 7b9c2ba..bce572a 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -726,6 +726,8 @@ static struct resource rtt_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags  = IORESOURCE_IRQ,
 	},
 };
 
@@ -744,10 +746,12 @@ static void __init at91_add_device_rtt_rtc(void)
 	 * The second resource is needed:
 	 * GPBR will serve as the storage for RTC time offset
 	 */
-	at91sam9260_rtt_device.num_resources = 2;
+	at91sam9260_rtt_device.num_resources = 3;
 	rtt_resources[1].start = AT91SAM9260_BASE_GPBR +
 				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
 	rtt_resources[1].end = rtt_resources[1].start + 3;
+	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
+	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
 }
 #else
 static void __init at91_add_device_rtt_rtc(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 8df5c1b..bc2590d 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -609,6 +609,8 @@ static struct resource rtt_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags  = IORESOURCE_IRQ,
 	}
 };
 
@@ -626,10 +628,12 @@ static void __init at91_add_device_rtt_rtc(void)
 	 * The second resource is needed:
 	 * GPBR will serve as the storage for RTC time offset
 	 */
-	at91sam9261_rtt_device.num_resources = 2;
+	at91sam9261_rtt_device.num_resources = 3;
 	rtt_resources[1].start = AT91SAM9261_BASE_GPBR +
 				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
 	rtt_resources[1].end = rtt_resources[1].start + 3;
+	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
+	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
 }
 #else
 static void __init at91_add_device_rtt_rtc(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index eb6bbf8..9b6ca73 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -990,6 +990,8 @@ static struct resource rtt0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags  = IORESOURCE_IRQ,
 	}
 };
 
@@ -1006,6 +1008,8 @@ static struct resource rtt1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags  = IORESOURCE_IRQ,
 	}
 };
 
@@ -1027,14 +1031,14 @@ static void __init at91_add_device_rtt_rtc(void)
 		 * The second resource is needed only for the chosen RTT:
 		 * GPBR will serve as the storage for RTC time offset
 		 */
-		at91sam9263_rtt0_device.num_resources = 2;
+		at91sam9263_rtt0_device.num_resources = 3;
 		at91sam9263_rtt1_device.num_resources = 1;
 		pdev = &at91sam9263_rtt0_device;
 		r = rtt0_resources;
 		break;
 	case 1:
 		at91sam9263_rtt0_device.num_resources = 1;
-		at91sam9263_rtt1_device.num_resources = 2;
+		at91sam9263_rtt1_device.num_resources = 3;
 		pdev = &at91sam9263_rtt1_device;
 		r = rtt1_resources;
 		break;
@@ -1047,6 +1051,8 @@ static void __init at91_add_device_rtt_rtc(void)
 	pdev->name = "rtc-at91sam9";
 	r[1].start = AT91SAM9263_BASE_GPBR + 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
 	r[1].end = r[1].start + 3;
+	r[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
+	r[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
 }
 #else
 static void __init at91_add_device_rtt_rtc(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 0607399..1b47319 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1293,6 +1293,8 @@ static struct resource rtt_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags  = IORESOURCE_IRQ,
 	}
 };
 
@@ -1310,10 +1312,12 @@ static void __init at91_add_device_rtt_rtc(void)
 	 * The second resource is needed:
 	 * GPBR will serve as the storage for RTC time offset
 	 */
-	at91sam9g45_rtt_device.num_resources = 2;
+	at91sam9g45_rtt_device.num_resources = 3;
 	rtt_resources[1].start = AT91SAM9G45_BASE_GPBR +
 				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
 	rtt_resources[1].end = rtt_resources[1].start + 3;
+	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
+	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
 }
 #else
 static void __init at91_add_device_rtt_rtc(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index f09fff9..b3d365d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -688,6 +688,8 @@ static struct resource rtt_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	}, {
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.flags  = IORESOURCE_IRQ,
 	}
 };
 
@@ -705,10 +707,12 @@ static void __init at91_add_device_rtt_rtc(void)
 	 * The second resource is needed:
 	 * GPBR will serve as the storage for RTC time offset
 	 */
-	at91sam9rl_rtt_device.num_resources = 2;
+	at91sam9rl_rtt_device.num_resources = 3;
 	rtt_resources[1].start = AT91SAM9RL_BASE_GPBR +
 				 4 * CONFIG_RTC_DRV_AT91SAM9_GPBR;
 	rtt_resources[1].end = rtt_resources[1].start + 3;
+	rtt_resources[2].start = NR_IRQS_LEGACY + AT91_ID_SYS;
+	rtt_resources[2].end = NR_IRQS_LEGACY + AT91_ID_SYS;
 }
 #else
 static void __init at91_add_device_rtt_rtc(void)
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 8318689..1dd61f4 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -58,6 +58,7 @@ struct sam9_rtc {
 	struct rtc_device	*rtcdev;
 	u32			imr;
 	void __iomem		*gpbr;
+	int 			irq;
 };
 
 #define rtt_readl(rtc, field) \
@@ -292,7 +293,7 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
 {
 	struct resource	*r, *r_gpbr;
 	struct sam9_rtc	*rtc;
-	int		ret;
+	int		ret, irq;
 	u32		mr;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -302,10 +303,18 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get interrupt resource\n");
+		return irq;
+	}
+
 	rtc = kzalloc(sizeof *rtc, GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
+	rtc->irq = irq;
+
 	/* platform setup code should have handled this; sigh */
 	if (!device_can_wakeup(&pdev->dev))
 		device_init_wakeup(&pdev->dev, 1);
@@ -345,11 +354,10 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* register irq handler after we know what name we'll use */
-	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
-				IRQF_SHARED,
+	ret = request_irq(rtc->irq, at91_rtc_interrupt, IRQF_SHARED,
 				dev_name(&rtc->rtcdev->dev), rtc);
 	if (ret) {
-		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", AT91_ID_SYS);
+		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
 		rtc_device_unregister(rtc->rtcdev);
 		goto fail_register;
 	}
@@ -386,7 +394,7 @@ static int __devexit at91_rtc_remove(struct platform_device *pdev)
 
 	/* disable all interrupts */
 	rtt_writel(rtc, MR, mr & ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
-	free_irq(AT91_ID_SYS, rtc);
+	free_irq(rtc->irq, rtc);
 
 	rtc_device_unregister(rtc->rtcdev);
 
@@ -423,7 +431,7 @@ static int at91_rtc_suspend(struct platform_device *pdev,
 	rtc->imr = mr & (AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN);
 	if (rtc->imr) {
 		if (device_may_wakeup(&pdev->dev) && (mr & AT91_RTT_ALMIEN)) {
-			enable_irq_wake(AT91_ID_SYS);
+			enable_irq_wake(rtc->irq);
 			/* don't let RTTINC cause wakeups */
 			if (mr & AT91_RTT_RTTINCIEN)
 				rtt_writel(rtc, MR, mr & ~AT91_RTT_RTTINCIEN);
@@ -441,7 +449,7 @@ static int at91_rtc_resume(struct platform_device *pdev)
 
 	if (rtc->imr) {
 		if (device_may_wakeup(&pdev->dev))
-			disable_irq_wake(AT91_ID_SYS);
+			disable_irq_wake(rtc->irq);
 		mr = rtt_readl(rtc, MR);
 		rtt_writel(rtc, MR, mr | rtc->imr);
 	}
-- 
1.7.11.3
