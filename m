From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:35 +0400
Subject: [PATCH 09/15] corgi: convert to use gpio-pullup
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-10-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to use gpio-pullup transceiver instead of relying on UDC driver managing GPIO.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/corgi.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3a5507e..dd7b6a7 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -32,6 +32,7 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/usb/gpio_vbus.h>
 #include <video/w100fb.h>
 
 #include <asm/setup.h>
@@ -48,7 +49,6 @@
 #include <mach/pxa25x.h>
 #include <mach/irda.h>
 #include <mach/mmc.h>
-#include <mach/udc.h>
 #include <mach/corgi.h>
 #include <mach/sharpsl_pm.h>
 
@@ -461,11 +461,19 @@ static struct pxaficp_platform_data corgi_ficp_platform_data = {
 /*
  * USB Device Controller
  */
-static struct pxa2xx_udc_mach_info udc_info __initdata = {
+static struct gpio_vbus_mach_info udc_info = {
 	/* no connect GPIO; corgi can't tell connection status */
 	.gpio_pullup		= CORGI_GPIO_USB_PULLUP,
 };
 
+static struct platform_device corgi_gpio_pullup = {
+	.name	= "gpio-pullup",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &udc_info,
+	},
+};
+
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MASTER)
 static struct pxa2xx_spi_master corgi_spi_info = {
 	.num_chipselect	= 3,
@@ -642,6 +650,7 @@ static struct platform_device *devices[] __initdata = {
 	&corgiled_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,
+	&corgi_gpio_pullup,
 };
 
 static struct i2c_board_info __initdata corgi_i2c_devices[] = {
@@ -691,7 +700,6 @@ static void __init corgi_init(void)
 
 	corgi_init_spi();
 
- 	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&corgi_mci_platform_data);
 	pxa_set_ficp_info(&corgi_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
-- 
1.7.5.4
