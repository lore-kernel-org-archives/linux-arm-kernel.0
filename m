From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat,  2 Jul 2011 18:02:24 +0400
Subject: [PATCH V2 2/2] mioa701: move gpio-pullup functionality to gpio-vbus
In-Reply-To: <1309615344-12714-1-git-send-email-dbaryshkov@gmail.com>
References: <1309615344-12714-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309615344-12714-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-vbus can (and should?) handle D+ pullup gpio for us. Move
gpio-pullup handling to gpio-vbus and stop providing udc_info as it's
empty now. Also tell gpio-vbus that it should disable D+ pullup on
suspend, as did pxa27x_udc driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index bcbd359..2039a53 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -402,14 +402,11 @@ static void gsm_exit(void)
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
+	.disconnect_on_suspend = 1,
 };
 
 /*
@@ -770,7 +767,6 @@ static void __init mioa701_machine_init(void)
 	pxa_set_fb_info(NULL, &mioa701_pxafb_info);
 	pxa_set_mci_info(&mioa701_mci_info);
 	pxa_set_keypad_info(&mioa701_keypad_info);
-	pxa_set_udc_info(&mioa701_udc_info);
 	pxa_set_ac97_info(&mioa701_ac97_info);
 	pm_power_off = mioa701_poweroff;
 	arm_pm_restart = mioa701_restart;
-- 
1.7.5.4
