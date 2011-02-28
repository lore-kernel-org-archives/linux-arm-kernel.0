From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 28 Feb 2011 18:04:33 +0100
Subject: [PATCH 1/2] ARM: imx: use imx_add_gpio_keys to register "gpio-keys"
	devices
Message-ID: <1298912674-15153-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   15 +++------------
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |   14 +++-----------
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c   |   15 +++------------
 arch/arm/mach-mx3/mach-armadillo5x0.c          |   15 +++------------
 arch/arm/mach-mx3/mach-pcm037_eet.c            |   15 +++------------
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |   15 +++------------
 6 files changed, 18 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index cb705c2..3745e50 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -22,7 +22,6 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <video/platform_lcd.h>
 
@@ -207,23 +206,14 @@ static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
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
 
@@ -293,4 +283,5 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 40a3666..94fd02d 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -27,7 +27,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <asm/mach-types.h>
@@ -124,19 +123,12 @@ static struct gpio_keys_button visstrim_gpio_keys[] = {
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
@@ -180,7 +172,6 @@ static struct platform_device visstrim_m10_nor_mtd_device = {
 };
 
 static struct platform_device *platform_devices[] __initdata = {
-	&visstrim_gpio_keys_device,
 	&visstrim_m10_nor_mtd_device,
 };
 
@@ -238,6 +229,7 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
 	imx27_add_mxc_ehci_otg(&visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
+	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 14a5ffc..0d3f4b5 100644
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
@@ -219,23 +218,14 @@ static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
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
 
@@ -307,4 +297,5 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 28b6f41..c801eba 100644
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
index fda5654..e5756d4 100644
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
@@ -184,9 +176,8 @@ static int __init eet_init_devices(void)
 	imx31_add_spi_imx0(&pcm037_spi1_pdata);
 #endif
 
-	platform_device_register(&pcm037_gpio_keys_device);
+	imx_add_gpio_keys(&pcm037_gpio_keys_platform_data);
 
 	return 0;
 }
-
 late_initcall(eet_init_devices);
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index c372a43..606b7b2 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -27,7 +27,6 @@
 #include <linux/irq.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
 
@@ -104,23 +103,14 @@ static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
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
@@ -162,4 +152,5 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
 }
-- 
1.7.2.3
