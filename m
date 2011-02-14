From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 14 Feb 2011 15:33:17 +0300
Subject: [PATCH 2/5] gumstix: switch to using gpio-vbus transceiver
In-Reply-To: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
References: <1297686800-27599-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1297686800-27599-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch from handling gpio-vbus in pxa25x_udc to using standard gpio-vbus
tranceiver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>
---
 arch/arm/mach-pxa/gumstix.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 6fd319e..d65e4bd 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -26,6 +26,7 @@
 #include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/usb/gpio_vbus.h>
 
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -106,14 +107,22 @@ static void __init gumstix_mmc_init(void)
 #endif
 
 #ifdef CONFIG_USB_GADGET_PXA25X
-static struct pxa2xx_udc_mach_info gumstix_udc_info __initdata = {
+static struct gpio_vbus_mach_info gumstix_udc_info = {
 	.gpio_vbus		= GPIO_GUMSTIX_USB_GPIOn,
 	.gpio_pullup		= GPIO_GUMSTIX_USB_GPIOx,
 };
 
+static struct platform_device gumstix_gpio_vbus = {
+	.name	= "gpio-vbus",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gumstix_udc_info,
+	},
+};
+
 static void __init gumstix_udc_init(void)
 {
-	pxa_set_udc_info(&gumstix_udc_info);
+	platform_device_register(&gumstix_gpio_vbus);
 }
 #else
 static void gumstix_udc_init(void)
-- 
1.7.2.3
