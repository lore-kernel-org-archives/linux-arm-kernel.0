From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:07:56 +0100
Subject: [PATCH 01/39] arm/mx2: use cpp magic to create spi_imx devices
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the source shorter and easier to verify.  While at it switch
to use the SoC-prefixed constants.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |   78 ++++++++++++-------------------------------
 arch/arm/mach-mx2/devices.h |    2 +
 2 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 3d398ce..ce164a3 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -46,65 +46,31 @@
  * - i.MX21: 2 channel
  * - i.MX27: 3 channel
  */
-static struct resource mxc_spi_resources0[] = {
-	{
-	       .start = CSPI1_BASE_ADDR,
-	       .end = CSPI1_BASE_ADDR + SZ_4K - 1,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = MXC_INT_CSPI1,
-	       .end = MXC_INT_CSPI1,
-	       .flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource mxc_spi_resources1[] = {
-	{
-		.start = CSPI2_BASE_ADDR,
-		.end = CSPI2_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_CSPI2,
-		.end = MXC_INT_CSPI2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-#ifdef CONFIG_MACH_MX27
-static struct resource mxc_spi_resources2[] = {
-	{
-		.start = CSPI3_BASE_ADDR,
-		.end = CSPI3_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_CSPI3,
-		.end = MXC_INT_CSPI3,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-#endif
-
-struct platform_device mxc_spi_device0 = {
-	.name = "spi_imx",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_spi_resources0),
-	.resource = mxc_spi_resources0,
-};
+#define DEFINE_IMX_SPI_DEVICE(n, baseaddr, irq)					\
+	static struct resource mxc_spi_resources ## n[] = {			\
+		{								\
+			.start = baseaddr,					\
+			.end = baseaddr + SZ_4K - 1,				\
+			.flags = IORESOURCE_MEM,				\
+		}, {								\
+			.start = irq,						\
+			.end = irq,						\
+			.flags = IORESOURCE_IRQ,				\
+		},								\
+	};									\
+										\
+	struct platform_device mxc_spi_device ## n = {				\
+		.name = "spi_imx",						\
+		.id = n,							\
+		.num_resources = ARRAY_SIZE(mxc_spi_resources ## n),		\
+		.resource = mxc_spi_resources ## n,				\
+	}
 
-struct platform_device mxc_spi_device1 = {
-	.name = "spi_imx",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_spi_resources1),
-	.resource = mxc_spi_resources1,
-};
+DEFINE_IMX_SPI_DEVICE(0, MX2x_CSPI1_BASE_ADDR, MX2x_INT_CSPI1);
+DEFINE_IMX_SPI_DEVICE(1, MX2x_CSPI2_BASE_ADDR, MX2x_INT_CSPI2);
 
 #ifdef CONFIG_MACH_MX27
-struct platform_device mxc_spi_device2 = {
-	.name = "spi_imx",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_spi_resources2),
-	.resource = mxc_spi_resources2,
-};
+DEFINE_IMX_SPI_DEVICE(2, MX27_CSPI3_BASE_ADDR, MX27_INT_CSPI3);
 #endif
 
 /*
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index 97306aa..e13a352 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -25,6 +25,8 @@ extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
 extern struct platform_device mxc_spi_device0;
 extern struct platform_device mxc_spi_device1;
+#ifdef CONFIG_MACH_MX27
 extern struct platform_device mxc_spi_device2;
+#endif
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
-- 
1.6.6.2
