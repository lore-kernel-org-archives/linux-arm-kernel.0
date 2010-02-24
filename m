From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:07:57 +0100
Subject: [PATCH 02/39] arm/mx2: use cpp magic to create imx_gpt devices
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the source shorter and easier to verify.  While at it switch
to use the SoC-prefixed constants.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |  118 +++++++++----------------------------------
 arch/arm/mach-mx2/devices.h |    2 +
 2 files changed, 26 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index ce164a3..6efd862 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -78,104 +78,34 @@ DEFINE_IMX_SPI_DEVICE(2, MX27_CSPI3_BASE_ADDR, MX27_INT_CSPI3);
  * - i.MX21: 3 timers
  * - i.MX27: 6 timers
  */
-
-/* We use gpt0 as system timer, so do not add a device for this one */
-
-static struct resource timer1_resources[] = {
-	{
-		.start	= GPT2_BASE_ADDR,
-		.end	= GPT2_BASE_ADDR + 0x17,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = MXC_INT_GPT2,
-		.end     = MXC_INT_GPT2,
-		.flags   = IORESOURCE_IRQ,
+#define DEFINE_IMX_GPT_DEVICE(n, baseaddr, irq)				\
+	static struct resource timer ## n ##_resources[] = {		\
+		{							\
+			.start = baseaddr,				\
+			.end = baseaddr + SZ_4K - 1,			\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = irq,					\
+			.end = irq,					\
+			.flags = IORESOURCE_IRQ,			\
+		}							\
+	};								\
+									\
+	struct platform_device mxc_gpt ## n = {				\
+		.name = "imx_gpt",					\
+		.id = n,						\
+		.num_resources = ARRAY_SIZE(timer ## n ## _resources),	\
+		.resource = timer ## n ## _resources,			\
 	}
-};
 
-struct platform_device mxc_gpt1 = {
-	.name = "imx_gpt",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(timer1_resources),
-	.resource = timer1_resources,
-};
-
-static struct resource timer2_resources[] = {
-	{
-		.start	= GPT3_BASE_ADDR,
-		.end	= GPT3_BASE_ADDR + 0x17,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = MXC_INT_GPT3,
-		.end     = MXC_INT_GPT3,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_gpt2 = {
-	.name = "imx_gpt",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(timer2_resources),
-	.resource = timer2_resources,
-};
+/* We use gpt1 as system timer, so do not add a device for this one */
+DEFINE_IMX_GPT_DEVICE(1, MX2x_GPT2_BASE_ADDR, MX2x_INT_GPT2);
+DEFINE_IMX_GPT_DEVICE(2, MX2x_GPT3_BASE_ADDR, MX2x_INT_GPT3);
 
 #ifdef CONFIG_MACH_MX27
-static struct resource timer3_resources[] = {
-	{
-		.start	= GPT4_BASE_ADDR,
-		.end	= GPT4_BASE_ADDR + 0x17,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = MXC_INT_GPT4,
-		.end     = MXC_INT_GPT4,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_gpt3 = {
-	.name = "imx_gpt",
-	.id = 3,
-	.num_resources = ARRAY_SIZE(timer3_resources),
-	.resource = timer3_resources,
-};
-
-static struct resource timer4_resources[] = {
-	{
-		.start	= GPT5_BASE_ADDR,
-		.end	= GPT5_BASE_ADDR + 0x17,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = MXC_INT_GPT5,
-		.end     = MXC_INT_GPT5,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_gpt4 = {
-	.name = "imx_gpt",
-	.id = 4,
-	.num_resources = ARRAY_SIZE(timer4_resources),
-	.resource = timer4_resources,
-};
-
-static struct resource timer5_resources[] = {
-	{
-		.start	= GPT6_BASE_ADDR,
-		.end	= GPT6_BASE_ADDR + 0x17,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = MXC_INT_GPT6,
-		.end     = MXC_INT_GPT6,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_gpt5 = {
-	.name = "imx_gpt",
-	.id = 5,
-	.num_resources = ARRAY_SIZE(timer5_resources),
-	.resource = timer5_resources,
-};
+DEFINE_IMX_GPT_DEVICE(3, MX27_GPT4_BASE_ADDR, MX27_INT_GPT4);
+DEFINE_IMX_GPT_DEVICE(4, MX27_GPT5_BASE_ADDR, MX27_INT_GPT5);
+DEFINE_IMX_GPT_DEVICE(5, MX27_GPT6_BASE_ADDR, MX27_INT_GPT6);
 #endif
 
 /*
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index e13a352..a0c6e1a 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -1,8 +1,10 @@
 extern struct platform_device mxc_gpt1;
 extern struct platform_device mxc_gpt2;
+#ifdef CONFIG_MACH_MX27
 extern struct platform_device mxc_gpt3;
 extern struct platform_device mxc_gpt4;
 extern struct platform_device mxc_gpt5;
+#endif
 extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_uart_device0;
 extern struct platform_device mxc_uart_device1;
-- 
1.6.6.2
