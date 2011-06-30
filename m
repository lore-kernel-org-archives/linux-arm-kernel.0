From: daiane.angolini@freescale.com (Daiane Angolini)
Date: Thu, 30 Jun 2011 14:41:46 -0300
Subject: [PATCH] ARM: mach-mx5/mx53_ard: Add gpio_keys support
Message-ID: <1309455706-9509-1-git-send-email-daiane.angolini@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daiane Angolini <daiane.angolini@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 6a47d4c..b4e7c58 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -216,6 +216,7 @@ config MACH_MX53_ARD
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	help
 	  Include support for MX53 ARD platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 280cefc..e2b8b2f 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -39,6 +39,11 @@
 #define ARD_SD1_CD		IMX_GPIO_NR(1, 1)
 #define ARD_SD1_WP		IMX_GPIO_NR(1, 9)
 #define ARD_I2CPORTEXP_B	IMX_GPIO_NR(2, 3)
+#define ARD_VOLUMEDOWN		IMX_GPIO_NR(4, 0)
+#define ARD_HOME			IMX_GPIO_NR(5, 10)
+#define ARD_BACK			IMX_GPIO_NR(5, 11)
+#define ARD_PROG			IMX_GPIO_NR(5, 12)
+#define ARD_VOLUMEUP		IMX_GPIO_NR(5, 13)
 
 static iomux_v3_cfg_t mx53_ard_pads[] = {
 	/* UART1 */
@@ -91,6 +96,35 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
 	/* I2C3 */
 	MX53_PAD_GPIO_3__I2C3_SCL,
 	MX53_PAD_GPIO_16__I2C3_SDA,
+	/* GPIO */
+	MX53_PAD_DISP0_DAT16__GPIO5_10,	/* home */
+	MX53_PAD_DISP0_DAT17__GPIO5_11,	/* back */
+	MX53_PAD_DISP0_DAT18__GPIO5_12,	/* prog */
+	MX53_PAD_DISP0_DAT19__GPIO5_13,	/* vol up */
+	MX53_PAD_GPIO_10__GPIO4_0,		/* vol down */
+};
+
+#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
+{							\
+	.gpio		= gpio_num,				\
+	.type		= EV_KEY,				\
+	.code		= ev_code,				\
+	.active_low	= act_low,				\
+	.desc		= "btn " descr,			\
+	.wakeup		= wake,					\
+}
+
+static struct gpio_keys_button ard_buttons[] = {
+	GPIO_BUTTON(ARD_HOME, KEY_HOME, 1, "home", 0),
+	GPIO_BUTTON(ARD_BACK, KEY_BACK, 1, "back", 0),
+	GPIO_BUTTON(ARD_PROG, KEY_PROGRAM, 1, "program", 0),
+	GPIO_BUTTON(ARD_VOLUMEUP, KEY_VOLUMEUP, 1, "volume-up", 0),
+	GPIO_BUTTON(ARD_VOLUMEDOWN, KEY_VOLUMEDOWN, 1, "volume-down", 0),
+};
+
+static const struct gpio_keys_platform_data ard_button_data __initconst = {
+	.buttons        = ard_buttons,
+	.nbuttons       = ARRAY_SIZE(ard_buttons),
 };
 
 static struct resource ard_smsc911x_resources[] = {
@@ -199,6 +233,7 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
+	imx_add_gpio_keys(&ard_button_data);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.4.1
