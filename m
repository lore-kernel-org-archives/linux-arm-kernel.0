From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 30 Nov 2010 17:45:42 -0200
Subject: [PATCH v4 2/3] ARM: mx5: dynamically allocate imx-keypad devices
In-Reply-To: <1291146343-25808-1-git-send-email-fabio.estevam@freescale.com>
References: <1291146343-25808-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1291146343-25808-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/Kconfig                       |    2 ++
 arch/arm/mach-mx5/board-mx51_3ds.c              |    5 ++---
 arch/arm/mach-mx5/devices-imx51.h               |    4 ++++
 arch/arm/mach-mx5/devices.c                     |   19 -------------------
 arch/arm/mach-mx5/devices.h                     |    1 -
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c    |    5 ++---
 arch/arm/plat-mxc/devices/platform-imx-keypad.c |    5 +++++
 arch/arm/plat-mxc/include/mach/mx51.h           |    2 +-
 8 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 7f5a696..9a2450b 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -30,6 +30,7 @@ config MACH_MX51_3DS
 	bool "Support MX51PDK (3DS)"
 	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
@@ -56,6 +57,7 @@ choice
 config MACH_EUKREA_MBIMX51_BASEBOARD
 	prompt "Eukrea MBIMX51 development board"
 	bool
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  This adds board specific devices that can be found on Eukrea's
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 6cc2805..43cd5ab 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -12,7 +12,6 @@
 
 #include <linux/irq.h>
 #include <linux/platform_device.h>
-#include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
@@ -120,14 +119,14 @@ static int mx51_3ds_board_keymap[] = {
 	KEY(3, 5, KEY_BACK)
 };
 
-static struct matrix_keymap_data mx51_3ds_map_data = {
+static const struct matrix_keymap_data mx51_3ds_map_data __initconst = {
 	.keymap		= mx51_3ds_board_keymap,
 	.keymap_size	= ARRAY_SIZE(mx51_3ds_board_keymap),
 };
 
 static void mxc_init_keypad(void)
 {
-	mxc_register_device(&mxc_keypad_device, &mx51_3ds_map_data);
+	imx51_add_imx_keypad(&mx51_3ds_map_data);
 }
 #else
 static inline void mxc_init_keypad(void)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 939d2e8..3e31f3e 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -47,3 +47,7 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data __initconst;
 #define imx51_imx2_wdt_data(pdata)	\
 	imx_add_imx2_wdt_data(&imx51_imx2_wdt_data, pdata)
+
+extern const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst;
+#define imx51_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index ac55f7f..d733a97 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -97,25 +97,6 @@ struct platform_device mxc_usbh1_device = {
 	},
 };
 
-static struct resource mxc_kpp_resources[] = {
-	{
-		.start = MX51_MXC_INT_KPP,
-		.end = MX51_MXC_INT_KPP,
-		.flags = IORESOURCE_IRQ,
-	} , {
-		.start = MX51_KPP_BASE_ADDR,
-		.end = MX51_KPP_BASE_ADDR + 0x8 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_keypad_device = {
-	.name = "imx-keypad",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_kpp_resources),
-	.resource = mxc_kpp_resources,
-};
-
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index ccb7cdc..0905843 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -2,4 +2,3 @@ extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_hsi2c_device;
-extern struct platform_device mxc_keypad_device;
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index 94c293f..e86ade4 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -21,7 +21,6 @@
 #include <linux/fsl_devices.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/leds.h>
-#include <linux/input/matrix_keypad.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -157,7 +156,7 @@ static int mbimx51_keymap[] = {
 	KEY(3, 3, KEY_ENTER),
 };
 
-static struct matrix_keymap_data mbimx51_map_data = {
+static const struct matrix_keymap_data mbimx51_map_data __initconst = {
 	.keymap		= mbimx51_keymap,
 	.keymap_size	= ARRAY_SIZE(mbimx51_keymap),
 };
@@ -209,7 +208,7 @@ void __init eukrea_mbimx51_baseboard_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_keypad_device, &mbimx51_map_data);
+	imx51_add_imx_keypad(&mbimx51_map_data);
 
 	gpio_request(MBIMX51_TSC2007_GPIO, "tsc2007_irq");
 	gpio_direction_input(MBIMX51_TSC2007_GPIO);
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index 40238f0..2636611 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -41,6 +41,11 @@ const struct imx_imx_keypad_data imx35_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX35, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX51
+const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX51, SZ_16);
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 struct platform_device *__init imx_add_imx_keypad(
 		const struct imx_imx_keypad_data *data,
 		const struct matrix_keymap_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 8fddfef..a99522f 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -301,7 +301,7 @@
 #define MX51_MXC_INT_GPIO4_HIGH		57
 #define MX51_MXC_INT_WDOG1		58
 #define MX51_MXC_INT_WDOG2		59
-#define MX51_MXC_INT_KPP		60
+#define MX51_INT_KPP			60
 #define MX51_MXC_INT_PWM1		61
 #define MX51_INT_I2C1			62
 #define MX51_INT_I2C2			63
-- 
1.6.0.4
