From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 14 Feb 2011 15:33:18 +0300
Subject: [PATCH 3/5] tosa: switch to using gpio-vbus transceiver
In-Reply-To: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
References: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1297686800-27599-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch from handling gpio-vbus in pxa25x_udc to using standard gpio-vbus
tranceiver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/tosa.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index af152e7..88b2329 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -34,6 +34,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/usb/gpio_vbus.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -240,12 +241,20 @@ static struct scoop_pcmcia_config tosa_pcmcia_config = {
 /*
  * USB Device Controller
  */
-static struct pxa2xx_udc_mach_info udc_info __initdata = {
+static struct gpio_vbus_mach_info tosa_udc_info = {
 	.gpio_pullup		= TOSA_GPIO_USB_PULLUP,
 	.gpio_vbus		= TOSA_GPIO_USB_IN,
 	.gpio_vbus_inverted	= 1,
 };
 
+static struct platform_device tosa_gpio_vbus = {
+	.name	= "gpio-vbus",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &tosa_udc_info,
+	},
+};
+
 /*
  * MMC/SD Device
  */
@@ -885,6 +894,7 @@ static struct platform_device *devices[] __initdata = {
 	&tosaled_device,
 	&tosa_bt_device,
 	&sharpsl_rom_device,
+	&tosa_gpio_vbus,
 };
 
 static void tosa_poweroff(void)
@@ -931,7 +941,6 @@ static void __init tosa_init(void)
 	dummy = gpiochip_reserve(TOSA_TC6393XB_GPIO_BASE, 16);
 
 	pxa_set_mci_info(&tosa_mci_platform_data);
-	pxa_set_udc_info(&udc_info);
 	pxa_set_ficp_info(&tosa_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
 	pxa_set_ac97_info(NULL);
-- 
1.7.2.3
