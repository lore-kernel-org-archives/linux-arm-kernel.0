From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:58 +0100
Subject: [PATCH 30/51] ARM: mx25: dynamically allocate mxc_pwm devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-30-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c                    |   76 -----------------------
 arch/arm/mach-mx25/devices.h                    |    4 -
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c    |   29 +++++++--
 arch/arm/plat-mxc/include/mach/devices-common.h |    2 +
 arch/arm/plat-mxc/include/mach/mx25.h           |    8 +++
 5 files changed, 32 insertions(+), 87 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 27d07ce..13a3c280 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,63 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static struct resource mxc_pwm_resources0[] = {
-	{
-		.start	= 0x53fe0000,
-		.end	= 0x53fe3fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = 26,
-		.end     = 26,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_pwm_device0 = {
-	.name = "mxc_pwm",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_pwm_resources0),
-	.resource = mxc_pwm_resources0,
-};
-
-static struct resource mxc_pwm_resources1[] = {
-	{
-		.start	= 0x53fa0000,
-		.end	= 0x53fa3fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = 36,
-		.end     = 36,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_pwm_device1 = {
-	.name = "mxc_pwm",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_pwm_resources1),
-	.resource = mxc_pwm_resources1,
-};
-
-static struct resource mxc_pwm_resources2[] = {
-	{
-		.start	= 0x53fa8000,
-		.end	= 0x53fabfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = 41,
-		.end     = 41,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_pwm_device2 = {
-	.name = "mxc_pwm",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_pwm_resources2),
-	.resource = mxc_pwm_resources2,
-};
-
 static struct resource mxc_keypad_resources[] = {
 	{
 		.start	= 0x43fa8000,
@@ -98,25 +41,6 @@ struct platform_device mxc_keypad_device = {
 	.resource = mxc_keypad_resources,
 };
 
-static struct resource mxc_pwm_resources3[] = {
-	{
-		.start	= 0x53fc8000,
-		.end	= 0x53fcbfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = 42,
-		.end     = 42,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_pwm_device3 = {
-	.name = "mxc_pwm",
-	.id = 3,
-	.num_resources = ARRAY_SIZE(mxc_pwm_resources3),
-	.resource = mxc_pwm_resources3,
-};
-
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 266c305..afc60dd 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,7 +1,3 @@
-extern struct platform_device mxc_pwm_device0;
-extern struct platform_device mxc_pwm_device1;
-extern struct platform_device mxc_pwm_device2;
-extern struct platform_device mxc_pwm_device3;
 extern struct platform_device mxc_keypad_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index 3ebbc67..5a47d1e 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -9,20 +9,35 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_mxc_pwm_data_entry_single(soc)				\
+#define imx_mxc_pwm_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
-		.iobase = soc ## _PWM_BASE_ADDR,			\
-		.irq = soc ## _INT_PWM,					\
+		.id = _id,						\
+		.iobase = soc ## _PWM ## _hwid ## _BASE_ADDR,		\
+		.iosize = _size,					\
+		.irq = soc ## _INT_PWM ## _hwid,			\
 	}
+#define imx_mxc_pwm_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = imx_mxc_pwm_data_entry_single(soc, _id, _hwid, _size)
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_mxc_pwm_data imx21_mxc_pwm_data __initconst =
-	imx_mxc_pwm_data_entry_single(MX21);
+	imx_mxc_pwm_data_entry_single(MX21, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
+#ifdef CONFIG_ARCH_MX25
+const struct imx_mxc_pwm_data imx25_mxc_pwm_data[] __initconst = {
+#define imx25_mxc_pwm_data_entry(_id, _hwid)				\
+	imx_mxc_pwm_data_entry(MX25, _id, _hwid, SZ_16K)
+	imx25_mxc_pwm_data_entry(0, 1),
+	imx25_mxc_pwm_data_entry(1, 2),
+	imx25_mxc_pwm_data_entry(2, 3),
+	imx25_mxc_pwm_data_entry(3, 4),
+};
+#endif
+
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
-	imx_mxc_pwm_data_entry_single(MX27);
+	imx_mxc_pwm_data_entry_single(MX27, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 struct platform_device *__init imx_add_mxc_pwm(
@@ -31,7 +46,7 @@ struct platform_device *__init imx_add_mxc_pwm(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_4K - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
@@ -40,6 +55,6 @@ struct platform_device *__init imx_add_mxc_pwm(
 		},
 	};
 
-	return imx_add_platform_device("mxc_pwm", 0,
+	return imx_add_platform_device("mxc_pwm", data->id,
 			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index f5d0000..07223b2 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -217,7 +217,9 @@ struct platform_device *__init imx_add_mxc_nand(
 		const struct mxc_nand_platform_data *pdata);
 
 struct imx_mxc_pwm_data {
+	int id;
 	resource_size_t iobase;
+	resource_size_t iosize;
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_mxc_pwm(
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 0d31f82..cea851f 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -19,10 +19,14 @@
 #define MX25_CRM_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x80000)
 #define MX25_GPT1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x90000)
 #define MX25_GPIO4_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x9c000)
+#define MX25_PWM2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa0000)
 #define MX25_GPIO3_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa4000)
+#define MX25_PWM3_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa8000)
+#define MX25_PWM4_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xc8000)
 #define MX25_GPIO1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xcc000)
 #define MX25_GPIO2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xd0000)
 #define MX25_WDOG_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xdc000)
+#define MX25_PWM1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xe0000)
 
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
@@ -66,13 +70,17 @@
 #define MX25_INT_UART3		18
 #define MX25_INT_KPP		24
 #define MX25_INT_DRYICE		25
+#define MX25_INT_PWM1		26
 #define MX25_INT_UART2		32
 #define MX25_INT_NFC		33
 #define MX25_INT_SDMA		34
 #define MX25_INT_USB_HS		35
+#define MX25_INT_PWM2		36
 #define MX25_INT_USB_OTG	37
 #define MX25_INT_LCDC		39
 #define MX25_INT_UART5		40
+#define MX25_INT_PWM3		41
+#define MX25_INT_PWM4		42
 #define MX25_INT_CAN1		43
 #define MX25_INT_CAN2		44
 #define MX25_INT_UART1		45
-- 
1.7.2.3
