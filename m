From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  7 Apr 2011 22:24:01 +0200
Subject: [PATCH v2] ARM: imx: use imx_add_gpio_keys to register "gpio-keys"
	devices
In-Reply-To: <20110406153702.GG13963@pengutronix.de>
References: <20110406153702.GG13963@pengutronix.de>
Message-ID: <1302207841-12450-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
changes since first patch:
 - add mach-vpr200.c (as already noted earlier)
 - add the needed "select IMX_HAVE_PLATFORM_GPIO_KEYS"

 arch/arm/mach-imx/Kconfig                      |    2 ++
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   15 +++------------
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |   14 +++-----------
 arch/arm/mach-mx3/Kconfig                      |    4 ++++
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c   |   15 +++------------
 arch/arm/mach-mx3/mach-armadillo5x0.c          |   15 +++------------
 arch/arm/mach-mx3/mach-pcm037_eet.c            |   15 +++------------
 arch/arm/mach-mx3/mach-vpr200.c                |   12 +++---------
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |   15 +++------------
 9 files changed, 27 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 56b930a..4ac00e9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -129,6 +129,7 @@ choice
 
 config MACH_EUKREA_MBIMXSD25_BASEBOARD
 	bool "Eukrea MBIMXSD development board"
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
 	  This adds board specific devices that can be found on Eukrea's
@@ -254,6 +255,7 @@ config MACH_MX27_3DS
 config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
 	select SOC_IMX27
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 6269053..176e61b 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -22,7 +22,6 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <video/platform_lcd.h>
 
@@ -208,23 +207,14 @@ static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
 	},
 };
 
-static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
+static const struct gpio_keys_platform_data
+		eukrea_mbimxsd_button_data __initconst = {
 	.buttons	= eukrea_mbimxsd_gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
 };
 
-static struct platform_device eukrea_mbimxsd_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &eukrea_mbimxsd_button_data,
-	}
-};
-
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_mbimxsd_leds_gpio,
-	&eukrea_mbimxsd_button_device,
 	&eukrea_mbimxsd_lcd_powerdev,
 };
 
@@ -299,4 +289,5 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index d7e0d21..7ae43b1 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -27,7 +27,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
@@ -130,19 +129,12 @@ static struct gpio_keys_button visstrim_gpio_keys[] = {
 	}
 };
 
-static struct gpio_keys_platform_data visstrim_gpio_keys_platform_data = {
+static const struct gpio_keys_platform_data
+		visstrim_gpio_keys_platform_data __initconst = {
 	.buttons	= visstrim_gpio_keys,
 	.nbuttons	= ARRAY_SIZE(visstrim_gpio_keys),
 };
 
-static struct platform_device visstrim_gpio_keys_device = {
-	.name	= "gpio-keys",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &visstrim_gpio_keys_platform_data,
-	},
-};
-
 /* Visstrim_SM10 has a microSD slot connected to sdhc1 */
 static int visstrim_m10_sdhc1_init(struct device *dev,
 		irq_handler_t detect_irq, void *data)
@@ -186,7 +178,6 @@ static struct platform_device visstrim_m10_nor_mtd_device = {
 };
 
 static struct platform_device *platform_devices[] __initdata = {
-	&visstrim_gpio_keys_device,
 	&visstrim_m10_nor_mtd_device,
 };
 
@@ -255,6 +246,7 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
 	imx27_add_mxc_ehci_otg(&visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
+	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 340809a..b0831ef 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -68,6 +68,7 @@ config MACH_PCM037
 config MACH_PCM037_EET
 	bool "Support pcm037 EET board extensions"
 	depends on MACH_PCM037
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Add support for PCM037 EET baseboard extensions. If you are using the
@@ -168,6 +169,7 @@ config MACH_PCM043
 config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
 	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -233,6 +235,7 @@ choice
 
 config MACH_EUKREA_MBIMXSD35_BASEBOARD
 	bool "Eukrea MBIMXSD development board"
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
 	  This adds board specific devices that can be found on Eukrea's
@@ -244,6 +247,7 @@ config MACH_VPR200
 	bool "Support VPR200 platform"
 	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 2e288b3..63981ca 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <video/platform_lcd.h>
 #include <linux/i2c.h>
@@ -223,23 +222,14 @@ static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
 	},
 };
 
-static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
+static const struct gpio_keys_platform_data
+		eukrea_mbimxsd_button_data __initconst = {
 	.buttons	= eukrea_mbimxsd_gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
 };
 
-static struct platform_device eukrea_mbimxsd_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &eukrea_mbimxsd_button_data,
-	}
-};
-
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_mbimxsd_leds_gpio,
-	&eukrea_mbimxsd_button_device,
 	&eukrea_mbimxsd_lcd_powerdev,
 };
 
@@ -315,4 +305,5 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 226829b..ace0c4c 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -34,7 +34,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
 #include <linux/input.h>
-#include <linux/gpio_keys.h>
 #include <linux/i2c.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -280,20 +279,12 @@ static struct gpio_keys_button armadillo5x0_buttons[] = {
 	}
 };
 
-static struct gpio_keys_platform_data armadillo5x0_button_data = {
+static const struct gpio_keys_platform_data
+		armadillo5x0_button_data __initconst = {
 	.buttons	= armadillo5x0_buttons,
 	.nbuttons	= ARRAY_SIZE(armadillo5x0_buttons),
 };
 
-static struct platform_device armadillo5x0_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &armadillo5x0_button_data,
-	}
-};
-
 /*
  * NAND Flash
  */
@@ -496,7 +487,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 
 static struct platform_device *devices[] __initdata = {
 	&armadillo5x0_smc911x_device,
-	&armadillo5x0_button_device,
 };
 
 /*
@@ -508,6 +498,7 @@ static void __init armadillo5x0_init(void)
 			ARRAY_SIZE(armadillo5x0_pins), "armadillo5x0");
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	imx_add_gpio_keys(&armadillo5x0_button_data);
 	imx31_add_imx_i2c1(NULL);
 
 	/* Register UART */
diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index df6fb07..3f81e35 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -7,7 +7,6 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
@@ -156,20 +155,13 @@ static struct gpio_keys_button pcm037_gpio_keys[] = {
 	},
 };
 
-static struct gpio_keys_platform_data pcm037_gpio_keys_platform_data = {
+static const struct gpio_keys_platform_data
+		pcm037_gpio_keys_platform_data __initconst = {
 	.buttons	= pcm037_gpio_keys,
 	.nbuttons	= ARRAY_SIZE(pcm037_gpio_keys),
 	.rep		= 0, /* No auto-repeat */
 };
 
-static struct platform_device pcm037_gpio_keys_device = {
-	.name	= "gpio-keys",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &pcm037_gpio_keys_platform_data,
-	},
-};
-
 static int __init eet_init_devices(void)
 {
 	if (!machine_is_pcm037() || pcm037_variant() != PCM037_EET)
@@ -182,9 +174,8 @@ static int __init eet_init_devices(void)
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
 	imx31_add_spi_imx0(&pcm037_spi1_pdata);
 
-	platform_device_register(&pcm037_gpio_keys_device);
+	imx_add_gpio_keys(&pcm037_gpio_keys_platform_data);
 
 	return 0;
 }
-
 late_initcall(eet_init_devices);
diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-mx3/mach-vpr200.c
index 2cf390f..fda6c79 100644
--- a/arch/arm/mach-mx3/mach-vpr200.c
+++ b/arch/arm/mach-mx3/mach-vpr200.c
@@ -141,18 +141,12 @@ static struct gpio_keys_button vpr200_gpio_keys_table[] = {
 	{KEY_F9, GPIO_BUTTON8, 1, "vpr-keys: F9", 1, VPR_KEY_DEBOUNCE},
 };
 
-static struct gpio_keys_platform_data vpr200_gpio_keys_data = {
+static const struct gpio_keys_platform_data
+		vpr200_gpio_keys_data __initconst = {
 	.buttons = vpr200_gpio_keys_table,
 	.nbuttons = ARRAY_SIZE(vpr200_gpio_keys_table),
 };
 
-static struct platform_device vpr200_device_gpiokeys = {
-	.name = "gpio-keys",
-	.dev = {
-		.platform_data = &vpr200_gpio_keys_data,
-	}
-};
-
 static struct mc13xxx_platform_data vpr200_pmic = {
 	.flags = MC13XXX_USE_ADC | MC13XXX_USE_TOUCHSCREEN,
 };
@@ -266,7 +260,6 @@ static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
 
 static struct platform_device *devices[] __initdata = {
 	&vpr200_flash,
-	&vpr200_device_gpiokeys,
 };
 
 /*
@@ -278,6 +271,7 @@ static void __init vpr200_board_init(void)
 
 	imx35_add_fec(NULL);
 	imx35_add_imx2_wdt(NULL);
+	imx_add_gpio_keys(&vpr200_gpio_keys_data);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index e6c1119..0c80b62 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -27,7 +27,6 @@
 #include <linux/irq.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
 
@@ -108,23 +107,14 @@ static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
 	},
 };
 
-static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
+static const struct gpio_keys_platform_data
+		eukrea_mbimxsd_button_data __initconst = {
 	.buttons	= eukrea_mbimxsd_gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
 };
 
-static struct platform_device eukrea_mbimxsd_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &eukrea_mbimxsd_button_data,
-	}
-};
-
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_mbimxsd_leds_gpio,
-	&eukrea_mbimxsd_button_device,
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -166,4 +156,5 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
-- 
1.7.2.3
