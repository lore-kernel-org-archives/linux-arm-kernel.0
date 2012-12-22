From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 22 Dec 2012 10:27:39 -0800
Subject: [PATCH 1/2] ARM: pxa: palm27x: fix udc device initialization
In-Reply-To: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
References: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356200860-3241-2-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some bad behaviour from the usb gadget during machine
initialization by changing the management of the D+ pull-up gpio from the
gpio-vbus driver to the pxa27x-udc driver.  Also, code that drives the pull-up
high is removed.  (The gpio-vbus driver can optionally manage the D+ line
pull-up, but the pxa27x-udc driver does this itself.)

Without this patch, the host senses the presence of the usb gadget during
machine initialization (when palm27x_udc_init() runs), at which point it tries
to enumerate the newly detected usb gadget.  But because the pxa27x-udc driver
has not been initialized yet, there's no gadget driver to respond to the host,
and enumeration fails.  Tested on my Palm Treo680.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/palm27x.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 17d4c53..298a8a9 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -167,7 +167,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
 #if	defined(CONFIG_USB_PXA27X) || \
 	defined(CONFIG_USB_PXA27X_MODULE)
 static struct gpio_vbus_mach_info palm27x_udc_info = {
-	.gpio_vbus_inverted	= 1,
+	.gpio_pullup = -1,  /* pxa27x-udc driver handles D+ pull-up, not vbus */
 };
 
 static struct platform_device palm27x_gpio_vbus = {
@@ -180,17 +180,22 @@ static struct platform_device palm27x_gpio_vbus = {
 
 void __init palm27x_udc_init(int vbus, int pullup, int vbus_inverted)
 {
-	palm27x_udc_info.gpio_vbus	= vbus;
-	palm27x_udc_info.gpio_pullup	= pullup;
+	struct pxa2xx_udc_mach_info udc_mach_info = {
+		.udc_is_connected = NULL,
+		.udc_command = NULL,
+		.gpio_pullup_inverted = false,
+	};
+	udc_mach_info.gpio_pullup = pullup;
 
+	palm27x_udc_info.gpio_vbus	= vbus;
 	palm27x_udc_info.gpio_vbus_inverted = vbus_inverted;
 
-	if (!gpio_request(pullup, "USB Pullup")) {
-		gpio_direction_output(pullup,
-			palm27x_udc_info.gpio_vbus_inverted);
-		gpio_free(pullup);
-	} else
+	/* driver will quietly ignore an invalid gpio */
+	if (!gpio_is_valid(pullup)) {
+		pr_err("Palm27x: USB D+ pull-up gpio is invalid!\n");
 		return;
+	}
+	pxa_set_udc_info(&udc_mach_info);
 
 	platform_device_register(&palm27x_gpio_vbus);
 }
-- 
1.7.8.6
