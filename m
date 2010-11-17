From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:37 +0100
Subject: [PATCH 09/51] ARM: imx: remove unused devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

all these don't have a driver and are not added in any machine file.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c |   77 -------------------------------------------
 arch/arm/mach-imx/devices.h |    9 -----
 2 files changed, 0 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 6fbd624..cdc6f32 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -70,48 +70,6 @@ struct platform_device imx1_camera_device = {
 	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
 };
 
-static struct resource imx_rtc_resources[] = {
-	{
-		.start  = 0x00204000,
-		.end    = 0x00204024,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_RTC_INT,
-		.end    = MX1_RTC_INT,
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.start  = MX1_RTC_SAMINT,
-		.end    = MX1_RTC_SAMINT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_rtc_device = {
-	.name           = "rtc-imx",
-	.id             = 0,
-	.resource       = imx_rtc_resources,
-	.num_resources  = ARRAY_SIZE(imx_rtc_resources),
-};
-
-static struct resource imx_wdt_resources[] = {
-	{
-		.start  = 0x00201000,
-		.end    = 0x00201008,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_WDT_INT,
-		.end    = MX1_WDT_INT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_wdt_device = {
-	.name           = "imx-wdt",
-	.id             = 0,
-	.resource       = imx_wdt_resources,
-	.num_resources  = ARRAY_SIZE(imx_wdt_resources),
-};
-
 static struct resource imx_usb_resources[] = {
 	{
 		.start	= 0x00212000,
@@ -219,41 +177,6 @@ struct platform_device mx27_camera_device = {
 };
 #endif
 
-/*
- * General Purpose Timer
- * - i.MX21: 3 timers
- * - i.MX27: 6 timers
- */
-#define DEFINE_IMX_GPT_DEVICE(n, baseaddr, irq)				\
-	static struct resource timer ## n ##_resources[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + SZ_4K - 1,			\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irq,					\
-			.end = irq,					\
-			.flags = IORESOURCE_IRQ,			\
-		}							\
-	};								\
-									\
-	struct platform_device mxc_gpt ## n = {				\
-		.name = "imx_gpt",					\
-		.id = n,						\
-		.num_resources = ARRAY_SIZE(timer ## n ## _resources),	\
-		.resource = timer ## n ## _resources,			\
-	}
-
-/* We use gpt1 as system timer, so do not add a device for this one */
-DEFINE_IMX_GPT_DEVICE(1, MX2x_GPT2_BASE_ADDR, MX2x_INT_GPT2);
-DEFINE_IMX_GPT_DEVICE(2, MX2x_GPT3_BASE_ADDR, MX2x_INT_GPT3);
-
-#ifdef CONFIG_MACH_MX27
-DEFINE_IMX_GPT_DEVICE(3, MX27_GPT4_BASE_ADDR, MX27_INT_GPT4);
-DEFINE_IMX_GPT_DEVICE(4, MX27_GPT5_BASE_ADDR, MX27_INT_GPT5);
-DEFINE_IMX_GPT_DEVICE(5, MX27_GPT6_BASE_ADDR, MX27_INT_GPT6);
-#endif
-
 /* Watchdog: i.MX1 has seperate driver, i.MX21 and i.MX27 are equal */
 static struct resource mxc_wdt_resources[] = {
 	{
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 48d2c5b..a7e47f4 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,18 +1,9 @@
 #ifdef CONFIG_ARCH_MX1
 extern struct platform_device imx1_camera_device;
-extern struct platform_device imx_rtc_device;
-extern struct platform_device imx_wdt_device;
 extern struct platform_device imx_usb_device;
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mxc_gpt1;
-extern struct platform_device mxc_gpt2;
-#ifdef CONFIG_MACH_MX27
-extern struct platform_device mxc_gpt3;
-extern struct platform_device mxc_gpt4;
-extern struct platform_device mxc_gpt5;
-#endif
 extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_pwm_device;
-- 
1.7.2.3
