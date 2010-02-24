From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:07:58 +0100
Subject: [PATCH 03/39] arm/mx2: use cpp magic to create imx-i2c devices
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the source shorter and easier to verify.  While at it switch
to use the SoC-prefixed constants.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |   54 ++++++++++++++++---------------------------
 arch/arm/mach-mx2/devices.h |    2 +
 2 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 6efd862..b32dfa0 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -213,44 +213,30 @@ struct platform_device mxc_fec_device = {
 };
 #endif
 
-static struct resource mxc_i2c_1_resources[] = {
-	{
-		.start	= I2C_BASE_ADDR,
-		.end	= I2C_BASE_ADDR + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MXC_INT_I2C,
-		.end	= MXC_INT_I2C,
-		.flags	= IORESOURCE_IRQ,
+#define DEFINE_IMX_I2C_DEVICE(n, baseaddr, irq)				\
+	static struct resource mxc_i2c_resources ## n[] = {		\
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
+	struct platform_device mxc_i2c_device ## n = {			\
+		.name = "imx-i2c",					\
+		.id = n,						\
+		.num_resources = ARRAY_SIZE(mxc_i2c_resources ## n),	\
+		.resource = mxc_i2c_resources ## n,			\
 	}
-};
 
-struct platform_device mxc_i2c_device0 = {
-	.name = "imx-i2c",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_i2c_1_resources),
-	.resource = mxc_i2c_1_resources,
-};
+DEFINE_IMX_I2C_DEVICE(0, MX2x_I2C_BASE_ADDR, MX2x_INT_I2C);
 
 #ifdef CONFIG_MACH_MX27
-static struct resource mxc_i2c_2_resources[] = {
-	{
-		.start	= I2C2_BASE_ADDR,
-		.end	= I2C2_BASE_ADDR + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MXC_INT_I2C2,
-		.end	= MXC_INT_I2C2,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_i2c_device1 = {
-	.name = "imx-i2c",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_i2c_2_resources),
-	.resource = mxc_i2c_2_resources,
-};
+DEFINE_IMX_I2C_DEVICE(1, MX27_I2C2_BASE_ADDR, MX27_INT_I2C2);
 #endif
 
 static struct resource mxc_pwm_resources[] = {
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index a0c6e1a..0dee0f5 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -18,7 +18,9 @@ extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_i2c_device0;
+#ifdef CONFIG_MACH_MX27
 extern struct platform_device mxc_i2c_device1;
+#endif
 extern struct platform_device mxc_sdhc_device0;
 extern struct platform_device mxc_sdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
-- 
1.6.6.2
