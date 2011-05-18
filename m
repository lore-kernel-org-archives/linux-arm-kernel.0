From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 18 May 2011 15:57:46 +0400
Subject: [PATCH] mioa701: move gpio-pullup functionality to gpio-vbus
Message-ID: <1305719866-9811-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-vbus can (and should?) handle D+ pullup gpio for us. Move gpio-pullup handling
to gpio-vbus and stop providing udc_info as it's empty now.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 05f9efb..239d81e 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -402,14 +402,10 @@ static void gsm_exit(void)
 /*
  * USB UDC
  */
-static struct pxa2xx_udc_mach_info mioa701_udc_info = {
-	.gpio_pullup	  = GPIO22_USB_ENABLE,
-};
-
 struct gpio_vbus_mach_info gpio_vbus_data = {
 	.gpio_vbus = GPIO13_nUSB_DETECT,
 	.gpio_vbus_inverted = 1,
-	.gpio_pullup = -1,
+	.gpio_pullup = GPIO22_USB_ENABLE,
 };
 
 /*
@@ -797,7 +793,6 @@ static void __init mioa701_machine_init(void)
 	pxa_set_fb_info(NULL, &mioa701_pxafb_info);
 	pxa_set_mci_info(&mioa701_mci_info);
 	pxa_set_keypad_info(&mioa701_keypad_info);
-	pxa_set_udc_info(&mioa701_udc_info);
 	pxa_set_ac97_info(&mioa701_ac97_info);
 	pm_power_off = mioa701_poweroff;
 	arm_pm_restart = mioa701_restart;
-- 
1.7.4.4
