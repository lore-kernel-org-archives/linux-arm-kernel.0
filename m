From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  2 Feb 2011 19:59:58 +0300
Subject: [PATCH 1/6] eseries: switch to using gpio-vbus transceiver
In-Reply-To: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
References: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1296666003-31647-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch from handling gpio-vbus in pxa25x_udc to using standard gpio-vbus
tranceiver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Ian Molton <spyro@f2s.com>
---
 arch/arm/mach-pxa/eseries.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index b25690c..2b30be6 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/t7l66xb.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/usb/gpio_vbus.h>
 
 #include <video/w100fb.h>
 
@@ -51,12 +52,20 @@ void __init eseries_fixup(struct machine_desc *desc,
 		mi->bank[0].size = (64*1024*1024);
 }
 
-struct pxa2xx_udc_mach_info e7xx_udc_mach_info = {
+struct gpio_vbus_mach_info e7xx_udc_info = {
 	.gpio_vbus   = GPIO_E7XX_USB_DISC,
 	.gpio_pullup = GPIO_E7XX_USB_PULLUP,
 	.gpio_pullup_inverted = 1
 };
 
+static struct platform_device e7xx_gpio_vbus = {
+	.name	= "gpio-vbus",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &e7xx_udc_info,
+	},
+};
+
 struct pxaficp_platform_data e7xx_ficp_platform_data = {
 	.gpio_pwdown		= GPIO_E7XX_IR_OFF,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
@@ -165,6 +174,7 @@ static struct platform_device e330_tc6387xb_device = {
 
 static struct platform_device *e330_devices[] __initdata = {
 	&e330_tc6387xb_device,
+	&e7xx_gpio_vbus,
 };
 
 static void __init e330_init(void)
@@ -175,7 +185,6 @@ static void __init e330_init(void)
 	eseries_register_clks();
 	eseries_get_tmio_gpios();
 	platform_add_devices(ARRAY_AND_SIZE(e330_devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
 }
 
 MACHINE_START(E330, "Toshiba e330")
@@ -214,6 +223,7 @@ static struct platform_device e350_t7l66xb_device = {
 
 static struct platform_device *e350_devices[] __initdata = {
 	&e350_t7l66xb_device,
+	&e7xx_gpio_vbus,
 };
 
 static void __init e350_init(void)
@@ -224,7 +234,6 @@ static void __init e350_init(void)
 	eseries_register_clks();
 	eseries_get_tmio_gpios();
 	platform_add_devices(ARRAY_AND_SIZE(e350_devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
 }
 
 MACHINE_START(E350, "Toshiba e350")
@@ -333,6 +342,7 @@ static struct platform_device e400_t7l66xb_device = {
 
 static struct platform_device *e400_devices[] __initdata = {
 	&e400_t7l66xb_device,
+	&e7xx_gpio_vbus,
 };
 
 static void __init e400_init(void)
@@ -346,7 +356,6 @@ static void __init e400_init(void)
 	eseries_get_tmio_gpios();
 	set_pxa_fb_info(&e400_pxafb_mach_info);
 	platform_add_devices(ARRAY_AND_SIZE(e400_devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
 }
 
 MACHINE_START(E400, "Toshiba e400")
@@ -519,6 +528,7 @@ static struct platform_device e740_t7l66xb_device = {
 static struct platform_device *e740_devices[] __initdata = {
 	&e740_fb_device,
 	&e740_t7l66xb_device,
+	&e7xx_gpio_vbus,
 };
 
 static void __init e740_init(void)
@@ -532,7 +542,6 @@ static void __init e740_init(void)
 			"UDCCLK", &pxa25x_device_udc.dev),
 	eseries_get_tmio_gpios();
 	platform_add_devices(ARRAY_AND_SIZE(e740_devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
 	pxa_set_ac97_info(NULL);
 	pxa_set_ficp_info(&e7xx_ficp_platform_data);
 }
@@ -711,6 +720,7 @@ static struct platform_device e750_tc6393xb_device = {
 static struct platform_device *e750_devices[] __initdata = {
 	&e750_fb_device,
 	&e750_tc6393xb_device,
+	&e7xx_gpio_vbus,
 };
 
 static void __init e750_init(void)
@@ -723,7 +733,6 @@ static void __init e750_init(void)
 			"GPIO11_CLK", NULL),
 	eseries_get_tmio_gpios();
 	platform_add_devices(ARRAY_AND_SIZE(e750_devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
 	pxa_set_ac97_info(NULL);
 	pxa_set_ficp_info(&e7xx_ficp_platform_data);
 }
@@ -873,12 +882,21 @@ static struct platform_device e800_fb_device = {
 
 /* --------------------------- UDC definitions --------------------------- */
 
-static struct pxa2xx_udc_mach_info e800_udc_mach_info = {
+static struct gpio_vbus_mach_info e800_udc_info = {
 	.gpio_vbus   = GPIO_E800_USB_DISC,
 	.gpio_pullup = GPIO_E800_USB_PULLUP,
 	.gpio_pullup_inverted = 1
 };
 
+static struct platform_device e800_gpio_vbus = {
+	.name	= "gpio-vbus",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &e800_udc_info,
+	},
+};
+
+
 /* ----------------- e800 tc6393xb parameters ------------------ */
 
 static struct tc6393xb_platform_data e800_tc6393xb_info = {
@@ -907,6 +925,7 @@ static struct platform_device e800_tc6393xb_device = {
 static struct platform_device *e800_devices[] __initdata = {
 	&e800_fb_device,
 	&e800_tc6393xb_device,
+	&e800_gpio_vbus,
 };
 
 static void __init e800_init(void)
@@ -919,7 +938,6 @@ static void __init e800_init(void)
 			"GPIO11_CLK", NULL),
 	eseries_get_tmio_gpios();
 	platform_add_devices(ARRAY_AND_SIZE(e800_devices));
-	pxa_set_udc_info(&e800_udc_mach_info);
 	pxa_set_ac97_info(NULL);
 }
 
-- 
1.7.2.3
