From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:11 +0200
Subject: [PATCH 35/40] ARM: mx51: dynamically register imx-uart devices
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-35-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig                     |    3 +
 arch/arm/mach-mx5/board-cpuimx51.c            |    6 +-
 arch/arm/mach-mx5/board-mx51_3ds.c            |    9 ++--
 arch/arm/mach-mx5/board-mx51_babbage.c        |   10 ++--
 arch/arm/mach-mx5/devices-imx51.h             |    4 ++
 arch/arm/mach-mx5/devices.c                   |   57 -------------------------
 arch/arm/mach-mx5/devices.h                   |    3 -
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c  |    7 ++-
 arch/arm/plat-mxc/devices/platform-imx-uart.c |   10 ++++
 arch/arm/plat-mxc/include/mach/mx51.h         |    6 +-
 10 files changed, 36 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index e985d0d..791927a 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -10,6 +10,7 @@ comment "MX5 platforms:"
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
@@ -17,6 +18,7 @@ config MACH_MX51_BABBAGE
 
 config MACH_MX51_3DS
 	bool "Support MX51PDK (3DS)"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
 	help
@@ -26,6 +28,7 @@ config MACH_MX51_3DS
 config MACH_EUKREA_CPUIMX51
 	bool "Support Eukrea CPUIMX51 module"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for Eukrea CPUIMX51 platform. This includes
 	  specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index d52f252..a6c09c7 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -28,7 +28,6 @@
 #include <mach/eukrea-baseboards.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
 #include <mach/mxc_ehci.h>
 
@@ -38,6 +37,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
+#include "devices-imx51.h"
 #include "devices.h"
 
 #define CPUIMX51_USBH1_STP	(0*32 + 27)
@@ -147,7 +147,7 @@ static struct pad_desc eukrea_cpuimx51_pads[] = {
 	MX51_PAD_USBH1_STP__USBH1_STP,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -239,7 +239,7 @@ static void __init eukrea_cpuimx51_init(void)
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51_pads,
 					ARRAY_SIZE(eukrea_cpuimx51_pads));
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx51_add_imx_uart(0, &uart_pdata);
 	gpio_request(CPUIMX51_QUARTA_GPIO, "quarta_irq");
 	gpio_direction_input(CPUIMX51_QUARTA_GPIO);
 	gpio_free(CPUIMX51_QUARTA_GPIO);
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index b9d3331..ed08a23 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -22,7 +22,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx51.h>
-#include <mach/imx-uart.h>
 #include <mach/3ds_debugboard.h>
 
 #include "devices-imx51.h"
@@ -74,15 +73,15 @@ static struct pad_desc mx51_3ds_pads[] = {
 
 /* Serial ports */
 #if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static inline void mxc_init_imx_uart(void)
 {
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_imx_uart(1, &uart_pdata);
+	imx51_add_imx_uart(2, &uart_pdata);
 }
 #else /* !SERIAL_IMX */
 static inline void mxc_init_imx_uart(void)
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index caa8f68..5bb8528 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -21,7 +21,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
 #include <mach/i2c.h>
 #include <mach/mxc_ehci.h>
@@ -32,6 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
+#include "devices-imx51.h"
 #include "devices.h"
 
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
@@ -121,15 +121,15 @@ static struct pad_desc mx51babbage_pads[] = {
 
 /* Serial ports */
 #if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static inline void mxc_init_imx_uart(void)
 {
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_imx_uart(1, &uart_pdata);
+	imx51_add_imx_uart(2, &uart_pdata);
 }
 #else /* !SERIAL_IMX */
 static inline void mxc_init_imx_uart(void)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 09d2b5c..8235b8c 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -13,6 +13,10 @@ extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
 
+extern const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst;
+#define imx51_add_imx_uart(id, pdata)	\
+	imx_add_imx_uart_1irq(&imx51_imx_uart_data[id], pdata)
+
 extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
 #define imx51_add_cspi(pdata)	\
 	imx_add_spi_imx(&imx51_cspi_data, pdata)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 70b76d1..5f40082 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -17,63 +17,6 @@
 #include <mach/imx-uart.h>
 #include <mach/irqs.h>
 
-static struct resource uart0[] = {
-	{
-		.start = MX51_UART1_BASE_ADDR,
-		.end = MX51_UART1_BASE_ADDR + 0xfff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX51_MXC_INT_UART1,
-		.end = MX51_MXC_INT_UART1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device0 = {
-	.name = "imx-uart",
-	.id = 0,
-	.resource = uart0,
-	.num_resources = ARRAY_SIZE(uart0),
-};
-
-static struct resource uart1[] = {
-	{
-		.start = MX51_UART2_BASE_ADDR,
-		.end = MX51_UART2_BASE_ADDR + 0xfff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX51_MXC_INT_UART2,
-		.end = MX51_MXC_INT_UART2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device1 = {
-	.name = "imx-uart",
-	.id = 1,
-	.resource = uart1,
-	.num_resources = ARRAY_SIZE(uart1),
-};
-
-static struct resource uart2[] = {
-	{
-		.start = MX51_UART3_BASE_ADDR,
-		.end = MX51_UART3_BASE_ADDR + 0xfff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX51_MXC_INT_UART3,
-		.end = MX51_MXC_INT_UART3,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device2 = {
-	.name = "imx-uart",
-	.id = 2,
-	.resource = uart2,
-	.num_resources = ARRAY_SIZE(uart2),
-};
-
 static struct resource mxc_fec_resources[] = {
 	{
 		.start	= MX51_MXC_FEC_BASE_ADDR,
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 5c2918f..67a6d69 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -1,6 +1,3 @@
-extern struct platform_device mxc_uart_device0;
-extern struct platform_device mxc_uart_device1;
-extern struct platform_device mxc_uart_device2;
 extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index ffa93d1..d0e417c 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -30,6 +30,7 @@
 
 #include <asm/mach/arch.h>
 
+#include "devices-imx51.h"
 #include "devices.h"
 
 #define MBIMX51_TSC2007_GPIO	(2*32 + 30)
@@ -114,7 +115,7 @@ static struct pad_desc mbimx51_pads[] = {
 	MX51_PAD_KEY_COL3__KEY_COL3,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -172,8 +173,8 @@ void __init eukrea_mbimx51_baseboard_init(void)
 	mxc_iomux_v3_setup_multiple_pads(mbimx51_pads,
 					ARRAY_SIZE(mbimx51_pads));
 
-	mxc_register_device(&mxc_uart_device1, NULL);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+	imx51_add_imx_uart(1, NULL);
+	imx51_add_imx_uart(2, &uart_pdata);
 
 	gpio_request(MBIMX51_LED0, "LED0");
 	gpio_direction_output(MBIMX51_LED0, 1);
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index af7fabb..2039640 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -94,6 +94,16 @@ const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
+#ifdef CONFIG_ARCH_MX51
+const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
+#define imx51_imx_uart_data_entry(_id, _hwid)				\
+	imx_imx_uart_1irq_data_entry(MX51, _id, _hwid, SZ_4K)
+	imx51_imx_uart_data_entry(0, 1),
+	imx51_imx_uart_data_entry(1, 2),
+	imx51_imx_uart_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
 struct platform_device *__init imx_add_imx_uart_3irq(
 		const struct imx_imx_uart_3irq_data *data,
 		const struct imxuart_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index b919235..b7359d7 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -310,9 +310,9 @@
 #define MX51_MXC_INT_SLIM_B		28
 #define MX51_MXC_INT_SSI1		29
 #define MX51_MXC_INT_SSI2		30
-#define MX51_MXC_INT_UART1		31
-#define MX51_MXC_INT_UART2		32
-#define MX51_MXC_INT_UART3		33
+#define MX51_INT_UART1			31
+#define MX51_INT_UART2			32
+#define MX51_INT_UART3			33
 #define MX51_MXC_INT_RESV34		34
 #define MX51_MXC_INT_RESV35		35
 #define MX51_INT_ECSPI1			36
-- 
1.7.2.3
