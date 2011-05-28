From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 28 May 2011 21:05:02 +0200
Subject: [PATCH 2/3] ARM: mx5: convert to new leds-gpio registration helper
In-Reply-To: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1306609503-31746-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of per machine struct platform_device definitions and allows
to move the platform data and led definition to .init.rodata.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig                    |    4 ++++
 arch/arm/mach-mx5/board-mx51_efikamx.c       |   15 ++++-----------
 arch/arm/mach-mx5/board-mx51_efikasb.c       |   16 ++++------------
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |   18 +++---------------
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |   19 ++++---------------
 5 files changed, 19 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 799fbc4..f25e9d7 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -109,6 +109,7 @@ config MACH_EUKREA_MBIMX51_BASEBOARD
 	bool
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select LEDS_GPIO_REGISTER
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMX51 evaluation board.
@@ -135,6 +136,7 @@ config MACH_EUKREA_MBIMXSD51_BASEBOARD
 	prompt "Eukrea MBIMXSD development board"
 	bool
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select LEDS_GPIO_REGISTER
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
@@ -151,6 +153,7 @@ config MX51_EFIKA_COMMON
 
 config MACH_MX51_EFIKAMX
 	bool "Support MX51 Genesi Efika MX nettop"
+	select LEDS_GPIO_REGISTER
 	select MX51_EFIKA_COMMON
 	help
 	  Include support for Genesi Efika MX nettop. This includes specific
@@ -158,6 +161,7 @@ config MACH_MX51_EFIKAMX
 
 config MACH_MX51_EFIKASB
 	bool "Support MX51 Genesi Efika Smartbook"
+	select LEDS_GPIO_REGISTER
 	select MX51_EFIKA_COMMON
 	help
 	  Include support for Genesi Efika Smartbook. This includes specific
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 6e36231..f38fb63 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -139,7 +139,7 @@ static void __init mx51_efikamx_board_id(void)
 	}
 }
 
-static struct gpio_led mx51_efikamx_leds[] = {
+static const struct gpio_led mx51_efikamx_leds[] __initconst = {
 	{
 		.name = "efikamx:green",
 		.default_trigger = "default-on",
@@ -157,19 +157,12 @@ static struct gpio_led mx51_efikamx_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data mx51_efikamx_leds_data = {
+static const struct gpio_led_platform_data
+		mx51_efikamx_leds_data __initconst = {
 	.leds = mx51_efikamx_leds,
 	.num_leds = ARRAY_SIZE(mx51_efikamx_leds),
 };
 
-static struct platform_device mx51_efikamx_leds_device = {
-	.name = "leds-gpio",
-	.id = -1,
-	.dev = {
-		.platform_data = &mx51_efikamx_leds_data,
-	},
-};
-
 static struct gpio_keys_button mx51_efikamx_powerkey[] = {
 	{
 		.code = KEY_POWER,
@@ -248,7 +241,7 @@ static void __init mx51_efikamx_init(void)
 		mx51_efikamx_leds[2].default_trigger = "mmc1";
 	}
 
-	platform_device_register(&mx51_efikamx_leds_device);
+	gpio_leds_register_device(&mx51_efikamx_leds_data);
 	imx_add_gpio_keys(&mx51_efikamx_powerkey_data);
 
 	if (system_rev == 0x11) {
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index 474fc6e..dbf9d92 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -132,7 +132,7 @@ static void __init mx51_efikasb_usb(void)
 		mxc_register_device(&mxc_usbh2_device, &usbh2_config);
 }
 
-static struct gpio_led mx51_efikasb_leds[] = {
+static const struct gpio_led mx51_efikasb_leds[] __initconst = {
 	{
 		.name = "efikasb:green",
 		.default_trigger = "default-on",
@@ -146,19 +146,12 @@ static struct gpio_led mx51_efikasb_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data mx51_efikasb_leds_data = {
+static const struct gpio_led_platform_data
+		mx51_efikasb_leds_data __initconst = {
 	.leds = mx51_efikasb_leds,
 	.num_leds = ARRAY_SIZE(mx51_efikasb_leds),
 };
 
-static struct platform_device mx51_efikasb_leds_device = {
-	.name = "leds-gpio",
-	.id = -1,
-	.dev = {
-		.platform_data = &mx51_efikasb_leds_data,
-	},
-};
-
 static struct gpio_keys_button mx51_efikasb_keys[] = {
 	{
 		.code = KEY_POWER,
@@ -256,9 +249,8 @@ static void __init efikasb_board_init(void)
 	mx51_efikasb_usb();
 	imx51_add_sdhci_esdhc_imx(1, NULL);
 
-	platform_device_register(&mx51_efikasb_leds_device);
+	gpio_leds_register_device(-1, &mx51_efikasb_leds_data);
 	imx_add_gpio_keys(&mx51_efikasb_keys_data);
-
 }
 
 static void __init mx51_efikasb_timer_init(void)
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index 97292d2..02ce720 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -37,7 +37,7 @@
 #define MBIMX51_LED2		IMX_GPIO_NR(3, 7)
 #define MBIMX51_LED3		IMX_GPIO_NR(3, 8)
 
-static struct gpio_led mbimx51_leds[] = {
+static const struct gpio_led mbimx51_leds[] __initconst = {
 	{
 		.name			= "led0",
 		.default_trigger	= "heartbeat",
@@ -64,23 +64,11 @@ static struct gpio_led mbimx51_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data mbimx51_leds_info = {
+static const struct gpio_led_platform_data mbimx51_leds_info __initconst = {
 	.leds		= mbimx51_leds,
 	.num_leds	= ARRAY_SIZE(mbimx51_leds),
 };
 
-static struct platform_device mbimx51_leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &mbimx51_leds_info,
-	},
-};
-
-static struct platform_device *devices[] __initdata = {
-	&mbimx51_leds_gpio,
-};
-
 static iomux_v3_cfg_t mbimx51_pads[] = {
 	/* UART2 */
 	MX51_PAD_UART2_RXD__UART2_RXD,
@@ -204,7 +192,7 @@ void __init eukrea_mbimx51_baseboard_init(void)
 	gpio_direction_output(MBIMX51_LED3, 1);
 	gpio_free(MBIMX51_LED3);
 
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	gpio_led_register_device(-1, &mbimx51_leds_info);
 
 	imx51_add_imx_keypad(&mbimx51_map_data);
 
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 31c871e..2619239 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -74,7 +74,7 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 #define GPIO_LED1	IMX_GPIO_NR(3, 30)
 #define GPIO_SWITCH1	IMX_GPIO_NR(3, 31)
 
-static struct gpio_led eukrea_mbimxsd_leds[] = {
+static const struct gpio_led eukrea_mbimxsd_leds[] __initconst = {
 	{
 		.name			= "led1",
 		.default_trigger	= "heartbeat",
@@ -83,19 +83,12 @@ static struct gpio_led eukrea_mbimxsd_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data eukrea_mbimxsd_led_info = {
+static const struct gpio_led_platform_data
+		eukrea_mbimxsd_led_info __initconst = {
 	.leds		= eukrea_mbimxsd_leds,
 	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd_leds),
 };
 
-static struct platform_device eukrea_mbimxsd_leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &eukrea_mbimxsd_led_info,
-	},
-};
-
 static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
 	{
 		.gpio		= GPIO_SWITCH1,
@@ -112,10 +105,6 @@ static const struct gpio_keys_platform_data
 	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&eukrea_mbimxsd_leds_gpio,
-};
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -154,6 +143,6 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	gpio_led_register_device(-1, &eukrea_mbimxsd_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
-- 
1.7.2.5
