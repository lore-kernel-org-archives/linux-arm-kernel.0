From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:36 +0400
Subject: [PATCH 10/15] poodle: convert to use gpio-pullup
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-11-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to use gpio-pullup transceiver instead of relying on UDC driver managing GPIO.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/poodle.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 16d14fd..01aed35 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -28,6 +28,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
+#include <linux/usb/gpio_vbus.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -41,7 +42,6 @@
 
 #include <mach/pxa25x.h>
 #include <mach/mmc.h>
-#include <mach/udc.h>
 #include <mach/irda.h>
 #include <mach/poodle.h>
 #include <mach/pxafb.h>
@@ -297,11 +297,18 @@ static struct pxaficp_platform_data poodle_ficp_platform_data = {
 /*
  * USB Device Controller
  */
-static struct pxa2xx_udc_mach_info udc_info __initdata = {
+static struct gpio_vbus_mach_info udc_info = {
 	/* no connect GPIO; poodle can't tell connection status */
 	.gpio_pullup	= POODLE_GPIO_USB_PULLUP,
 };
 
+static struct platform_device poodle_gpio_pullup = {
+	.name	= "gpio-pullup",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &udc_info,
+	},
+};
 
 /* PXAFB device */
 static struct pxafb_mode_info poodle_fb_mode = {
@@ -408,6 +415,7 @@ static struct platform_device *devices[] __initdata = {
 	&poodle_scoop_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,
+	&poodle_gpio_pullup,
 };
 
 static struct i2c_board_info __initdata poodle_i2c_devices[] = {
@@ -446,7 +454,6 @@ static void __init poodle_init(void)
 		pr_warning("poodle: Unable to register LoCoMo device\n");
 
 	pxa_set_fb_info(&poodle_locomo_device.dev, &poodle_fb_info);
-	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&poodle_mci_platform_data);
 	pxa_set_ficp_info(&poodle_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
-- 
1.7.5.4
