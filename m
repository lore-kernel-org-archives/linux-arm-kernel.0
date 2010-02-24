From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:02 +0100
Subject: [PATCH 07/39] arm/mx2: define seperate imx_nand devices for imx21 and
	imx27
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the NFC controller has different addresses on imx21 and imx27 there
are two different devices needed if not relying on the overloaded cpp
macro NFC_BASE_ADDR.  So some cpp magic is added to minimize code
duplication.

As obviously these two defines need different names, the name of the old
device is #defined to the new one when building for only one of imx21 or
imx27.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |   43 ++++++++++++++++++++++++++-----------------
 arch/arm/mach-mx2/devices.h |   11 ++++++++++-
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 9bf49da..cda4ace 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -144,24 +144,33 @@ struct platform_device mxc_w1_master_device = {
 	.resource = mxc_w1_master_resources,
 };
 
-static struct resource mxc_nand_resources[] = {
-	{
-		.start = NFC_BASE_ADDR,
-		.end = NFC_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_NANDFC,
-		.end = MX2x_INT_NANDFC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
+#define DEFINE_MXC_NAND_DEVICE(pfx, baseaddr, irq)			\
+	static struct resource pfx ## _nand_resources[] = {		\
+		{							\
+			.start = baseaddr,				\
+			.end = baseaddr + SZ_4K - 1,			\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = irq,					\
+			.end = irq,					\
+			.flags = IORESOURCE_IRQ,			\
+		},							\
+	};								\
+									\
+	struct platform_device pfx ## _nand_device = {			\
+		.name = "mxc_nand",					\
+		.id = 0,						\
+		.num_resources = ARRAY_SIZE(pfx ## _nand_resources),	\
+		.resource = pfx ## _nand_resources,			\
+	}
 
-struct platform_device mxc_nand_device = {
-	.name = "mxc_nand",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_nand_resources),
-	.resource = mxc_nand_resources,
-};
+#ifdef CONFIG_MACH_MX21
+DEFINE_MXC_NAND_DEVICE(imx21, MX21_NFC_BASE_ADDR, MX21_INT_NANDFC);
+#endif
+
+#ifdef CONFIG_MACH_MX27
+DEFINE_MXC_NAND_DEVICE(imx27, MX27_NFC_BASE_ADDR, MX27_INT_NANDFC);
+#endif
 
 /*
  * lcdc:
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index 0dee0f5..02e5dd2 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -13,7 +13,16 @@ extern struct platform_device mxc_uart_device3;
 extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_uart_device5;
 extern struct platform_device mxc_w1_master_device;
-extern struct platform_device mxc_nand_device;
+#ifdef CONFIG_MACH_MX21
+extern struct platform_device imx21_nand_device;
+#define mxc_nand_device imx21_nand_device
+#endif
+#ifdef CONFIG_MACH_MX27
+extern struct platform_device imx27_nand_device;
+#ifndef CONFIG_MACH_MX21
+#define mxc_nand_device imx27_nand_device
+#endif
+#endif
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_pwm_device;
-- 
1.6.6.2
