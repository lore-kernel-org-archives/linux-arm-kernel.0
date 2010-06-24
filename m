From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:52 +0200
Subject: [PATCH 56/61] ARM: imx: dynamically register imx-uart devices (imx21)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-57-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/devices-imx21.h |    9 +++++++++
 arch/arm/mach-imx/devices.c       |    3 +--
 arch/arm/mach-imx/devices.h       |    2 +-
 arch/arm/mach-imx/mach-mx21ads.c  |   12 +++++-------
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 445ce10..0fa8acc 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,7 @@ comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX21ADS platform. This includes specific
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index de80ccd..42788e9 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -12,6 +12,15 @@
 #define imx21_add_i2c_imx(pdata)	\
 	imx_add_imx_i2c(0, MX2x_I2C_BASE_ADDR, SZ_4K, MX2x_INT_I2C, pdata)
 
+#define imx21_add_imx_uart0(pdata)	\
+	imx_add_imx_uart_1irq(0, MX21_UART1_BASE_ADDR, SZ_4K, MX21_INT_UART1, pdata)
+#define imx21_add_imx_uart1(pdata)	\
+	imx_add_imx_uart_1irq(1, MX21_UART2_BASE_ADDR, SZ_4K, MX21_INT_UART2, pdata)
+#define imx21_add_imx_uart2(pdata)	\
+	imx_add_imx_uart_1irq(2, MX21_UART3_BASE_ADDR, SZ_4K, MX21_INT_UART3, pdata)
+#define imx21_add_imx_uart3(pdata)	\
+	imx_add_imx_uart_1irq(3, MX21_UART4_BASE_ADDR, SZ_4K, MX21_INT_UART4, pdata)
+
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
 
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index b4bf8fc..9ea2ef1 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -483,6 +483,7 @@ struct platform_device mxc_usbh2 = {
 DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
+#ifdef CONFIG_MACH_MX27
 #define DEFINE_IMX2x_UART_DEVICE(n, baseaddr, irq)			\
 	static struct resource imx2x_uart_resources ## n[] = {		\
 		{							\
@@ -507,8 +508,6 @@ DEFINE_IMX2x_UART_DEVICE(0, MX2x_UART1_BASE_ADDR, MX2x_INT_UART1);
 DEFINE_IMX2x_UART_DEVICE(1, MX2x_UART2_BASE_ADDR, MX2x_INT_UART2);
 DEFINE_IMX2x_UART_DEVICE(2, MX2x_UART3_BASE_ADDR, MX2x_INT_UART3);
 DEFINE_IMX2x_UART_DEVICE(3, MX2x_UART4_BASE_ADDR, MX2x_INT_UART4);
-
-#ifdef CONFIG_MACH_MX27
 DEFINE_IMX2x_UART_DEVICE(4, MX27_UART5_BASE_ADDR, MX27_INT_UART5);
 DEFINE_IMX2x_UART_DEVICE(5, MX27_UART6_BASE_ADDR, MX27_INT_UART6);
 #endif
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index e56efbc..13790fb 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -14,11 +14,11 @@ extern struct platform_device mxc_gpt4;
 extern struct platform_device mxc_gpt5;
 #endif
 extern struct platform_device mxc_wdt;
+#ifdef CONFIG_MACH_MX27
 extern struct platform_device imx2x_uart_device0;
 extern struct platform_device imx2x_uart_device1;
 extern struct platform_device imx2x_uart_device2;
 extern struct platform_device imx2x_uart_device3;
-#ifdef CONFIG_MACH_MX27
 extern struct platform_device imx2x_uart_device4;
 extern struct platform_device imx2x_uart_device5;
 #endif
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index fde2a57..96d7f81 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -24,7 +24,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/imx-uart.h>
 #include <mach/imxfb.h>
 #include <mach/iomux-mx21.h>
 #include <mach/mxc_nand.h>
@@ -164,14 +163,13 @@ static struct platform_device mx21ads_nor_mtd_device = {
 	.resource = &mx21ads_flash_resource,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata_rts __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct imxuart_platform_data uart_norts_pdata = {
+static const struct imxuart_platform_data uart_pdata_norts __initconst = {
 };
 
-
 static int mx21ads_fb_init(struct platform_device *pdev)
 {
 	u16 tmp;
@@ -295,9 +293,9 @@ static void __init mx21ads_board_init(void)
 	mxc_gpio_setup_multiple_pins(mx21ads_pins, ARRAY_SIZE(mx21ads_pins),
 			"mx21ads");
 
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
-	mxc_register_device(&imx2x_uart_device2, &uart_norts_pdata);
-	mxc_register_device(&imx2x_uart_device3, &uart_pdata);
+	imx21_add_imx_uart0(&uart_pdata_rts);
+	imx21_add_imx_uart2(&uart_pdata_norts);
+	imx21_add_imx_uart3(&uart_pdata_rts);
 	mxc_register_device(&mxc_fb_device, &mx21ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
 	imx21_add_mxc_nand(&mx21ads_nand_board_info);
-- 
1.7.1
