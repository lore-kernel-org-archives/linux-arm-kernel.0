From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 28 May 2011 21:05:01 +0200
Subject: [PATCH 1/3] ARM: imx: convert to new leds-gpio registration helper
Message-ID: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of per machine struct platform_device definitions and allows
to move the platform data and led definition to .init.rodata.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                      |    5 +++++
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |   23 ++++++-----------------
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   15 ++++-----------
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |   13 +++----------
 arch/arm/mach-imx/mach-mx31moboard.c           |   14 +++-----------
 arch/arm/mach-imx/mx31lite-db.c                |   15 ++++-----------
 6 files changed, 25 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 59c97a3..e8dd22f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -167,6 +167,7 @@ config MACH_EUKREA_MBIMXSD25_BASEBOARD
 	bool "Eukrea MBIMXSD development board"
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_SSI
+	select LEDS_GPIO_REGISTER
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
@@ -265,6 +266,7 @@ config MACH_EUKREA_MBIMX27_BASEBOARD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select LEDS_GPIO_REGISTER
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMX27 evaluation board.
@@ -403,6 +405,7 @@ config MACH_MX31LITE
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_RTC
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select LEDS_GPIO_REGISTER
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -471,6 +474,7 @@ config MACH_MX31MOBOARD
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select LEDS_GPIO_REGISTER
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for mx31moboard platform. This includes specific
@@ -577,6 +581,7 @@ config MACH_EUKREA_MBIMXSD35_BASEBOARD
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IPU_CORE
+	select LEDS_GPIO_REGISTER
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 5911281..5db3e14 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -112,7 +112,7 @@ eukrea_mbimx27_keymap_data __initconst = {
 	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
 };
 
-static struct gpio_led gpio_leds[] = {
+static const struct gpio_led eukrea_mbimx27_gpio_leds[] __initconst = {
 	{
 		.name			= "led1",
 		.default_trigger	= "heartbeat",
@@ -127,17 +127,10 @@ static struct gpio_led gpio_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data gpio_led_info = {
-	.leds		= gpio_leds,
-	.num_leds	= ARRAY_SIZE(gpio_leds),
-};
-
-static struct platform_device leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &gpio_led_info,
-	},
+static const struct gpio_led_platform_data
+		eukrea_mbimx27_gpio_led_info __initconst = {
+	.leds		= eukrea_mbimx27_gpio_leds,
+	.num_leds	= ARRAY_SIZE(eukrea_mbimx27_gpio_leds),
 };
 
 static struct imx_fb_videomode eukrea_mbimx27_modes[] = {
@@ -293,10 +286,6 @@ static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
 	},
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&leds_gpio,
-};
-
 static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.dat3_card_detect = 1,
 };
@@ -377,5 +366,5 @@ void __init eukrea_mbimx27_baseboard_init(void)
 
 	imx27_add_imx_keypad(&eukrea_mbimx27_keymap_data);
 
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	gpio_led_register_device(-1, &eukrea_mbimx27_gpio_led_info);
 }
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index f9ef04a..01ebcb3 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -173,7 +173,7 @@ static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
 	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
 };
 
-static struct gpio_led eukrea_mbimxsd_leds[] = {
+static const struct gpio_led eukrea_mbimxsd_leds[] __initconst = {
 	{
 		.name			= "led1",
 		.default_trigger	= "heartbeat",
@@ -182,19 +182,12 @@ static struct gpio_led eukrea_mbimxsd_leds[] = {
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
@@ -212,7 +205,6 @@ static const struct gpio_keys_platform_data
 };
 
 static struct platform_device *platform_devices[] __initdata = {
-	&eukrea_mbimxsd_leds_gpio,
 	&eukrea_mbimxsd_lcd_powerdev,
 };
 
@@ -287,5 +279,6 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	gpio_led_register_device(-1, &eukrea_mbimxsd_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 4909ea0..558eb52 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -193,19 +193,12 @@ static struct gpio_led eukrea_mbimxsd_leds[] = {
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
@@ -223,7 +216,6 @@ static const struct gpio_keys_platform_data
 };
 
 static struct platform_device *platform_devices[] __initdata = {
-	&eukrea_mbimxsd_leds_gpio,
 	&eukrea_mbimxsd_lcd_powerdev,
 };
 
@@ -299,5 +291,6 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	gpio_led_register_device(-1, &eukrea_mbimxsd_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index eaa51e4..abe688b 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -425,7 +425,7 @@ static int __init moboard_usbh2_init(void)
 	return 0;
 }
 
-static struct gpio_led mx31moboard_leds[] = {
+static const struct gpio_led mx31moboard_leds[] __initconst = {
 	{
 		.name	= "coreboard-led-0:red:running",
 		.default_trigger = "heartbeat",
@@ -442,26 +442,17 @@ static struct gpio_led mx31moboard_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data mx31moboard_led_pdata = {
+static const struct gpio_led_platform_data mx31moboard_led_pdata __initconst = {
 	.num_leds	= ARRAY_SIZE(mx31moboard_leds),
 	.leds		= mx31moboard_leds,
 };
 
-static struct platform_device mx31moboard_leds_device = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &mx31moboard_led_pdata,
-	},
-};
-
 static const struct ipu_platform_data mx3_ipu_data __initconst = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
 
 static struct platform_device *devices[] __initdata = {
 	&mx31moboard_flash,
-	&mx31moboard_leds_device,
 };
 
 static struct mx3_camera_pdata camera_pdata __initdata = {
@@ -511,6 +502,7 @@ static void __init mx31moboard_init(void)
 		"moboard");
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	gpio_led_register_device(-1, &mx31moboard_led_pdata);
 
 	imx31_add_imx_uart0(&uart0_pdata);
 	imx31_add_imx_uart4(&uart4_pdata);
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index 5aa053e..bf0fb87 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -161,7 +161,7 @@ static const struct spi_imx_master spi0_pdata __initconst = {
 
 /* GPIO LEDs */
 
-static struct gpio_led litekit_leds[] = {
+static const struct gpio_led litekit_leds[] __initconst = {
 	{
 		.name           = "GPIO0",
 		.gpio           = IOMUX_TO_GPIO(MX31_PIN_COMPARE),
@@ -176,19 +176,12 @@ static struct gpio_led litekit_leds[] = {
 	}
 };
 
-static struct gpio_led_platform_data litekit_led_platform_data = {
+static const struct gpio_led_platform_data
+		litekit_led_platform_data __initconst = {
 	.leds           = litekit_leds,
 	.num_leds       = ARRAY_SIZE(litekit_leds),
 };
 
-static struct platform_device litekit_led_device = {
-	.name   = "leds-gpio",
-	.id     = -1,
-	.dev    = {
-		.platform_data = &litekit_led_platform_data,
-	},
-};
-
 void __init mx31lite_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
@@ -197,7 +190,7 @@ void __init mx31lite_db_init(void)
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_mmc(0, &mmc_pdata);
 	imx31_add_spi_imx0(&spi0_pdata);
-	platform_device_register(&litekit_led_device);
+	gpio_led_register_device(-1, &litekit_led_platform_data);
 	imx31_add_imx2_wdt(NULL);
 	imx31_add_mxc_rtc(NULL);
 }
-- 
1.7.2.5
