From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:37 +0400
Subject: [PATCH 11/15] h5000: convert to use gpio-pullup
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-12-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to use gpio-pullup transceiver instead of relying on UDC driver managing GPIO.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/h5000.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index 657db46..4b3ca92 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/usb/gpio_vbus.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -31,7 +32,6 @@
 
 #include <mach/pxa25x.h>
 #include <mach/h5000.h>
-#include <mach/udc.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
@@ -117,10 +117,18 @@ static struct platform_device h5000_flash[] = {
  * USB Device Controller
  */
 
-static struct pxa2xx_udc_mach_info h5000_udc_mach_info __initdata = {
+static struct gpio_vbus_mach_info h5000_udc_mach_info = {
 	.gpio_pullup = H5000_GPIO_USB_PULLUP,
 };
 
+static struct platform_device h5000_gpio_pullup = {
+	.name	= "gpio-pullup",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &h5000_udc_mach_info,
+	},
+};
+
 /*
  * GPIO setup
  */
@@ -187,6 +195,7 @@ static void fix_msc(void)
 static struct platform_device *devices[] __initdata = {
 	&h5000_flash[0],
 	&h5000_flash[1],
+	&h5000_gpio_pullup,
 };
 
 static void __init h5000_init(void)
@@ -197,7 +206,6 @@ static void __init h5000_init(void)
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
-	pxa_set_udc_info(&h5000_udc_mach_info);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
-- 
1.7.5.4
