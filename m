From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri,  4 Jun 2010 03:07:33 +0200
Subject: [PATCH 2/3] pxa: Fix all devices using wm97xx_batt.h
In-Reply-To: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file is scheduled for removal, therefore fix all devices that use this
file to use the suggested wm97xx.h and pass platform data properly.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/mioa701.c  |   10 +++++++---
 arch/arm/mach-pxa/palmld.c   |   19 ++++++++++---------
 arch/arm/mach-pxa/palmt5.c   |   19 ++++++++++---------
 arch/arm/mach-pxa/palmte2.c  |   20 ++++++++++++--------
 arch/arm/mach-pxa/palmtreo.c |    1 -
 arch/arm/mach-pxa/palmtx.c   |   19 ++++++++++---------
 arch/arm/mach-pxa/palmz72.c  |   20 ++++++++++++--------
 7 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index d60db87..dbfe4ba 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -34,7 +34,7 @@
 #include <linux/irq.h>
 #include <linux/pda_power.h>
 #include <linux/power_supply.h>
-#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/mtd/physmap.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/regulator/max1586.h>
@@ -636,7 +636,7 @@ static struct platform_device power_dev = {
 	},
 };
 
-static struct wm97xx_batt_info mioa701_battery_data = {
+static struct wm97xx_batt_pdata mioa701_battery_data = {
 	.batt_aux	= WM97XX_AUX_ID1,
 	.temp_aux	= -1,
 	.charge_gpio	= -1,
@@ -648,6 +648,10 @@ static struct wm97xx_batt_info mioa701_battery_data = {
 	.batt_name	= "mioa701_battery",
 };
 
+static struct wm97xx_pdata mioa701_wm97xx_pdata = {
+	.batt_pdata	= &mioa701_battery_data,
+};
+
 /*
  * Voltage regulation
  */
@@ -716,6 +720,7 @@ struct i2c_pxa_platform_data i2c_pdata = {
 
 static pxa2xx_audio_ops_t mioa701_ac97_info = {
 	.reset_gpio = 95,
+	.codec_pdata = { &mioa701_wm97xx_pdata, },
 };
 
 /*
@@ -794,7 +799,6 @@ static void __init mioa701_machine_init(void)
 	set_pxa_fb_info(&mioa701_pxafb_info);
 	pxa_set_mci_info(&mioa701_mci_info);
 	pxa_set_keypad_info(&mioa701_keypad_info);
-	wm97xx_bat_set_pdata(&mioa701_battery_data);
 	pxa_set_udc_info(&mioa701_udc_info);
 	pxa_set_ac97_info(&mioa701_ac97_info);
 	pm_power_off = mioa701_poweroff;
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 1963819..83a1a55 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -22,7 +22,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/sysdev.h>
 #include <linux/mtd/mtd.h>
@@ -387,9 +387,9 @@ static struct platform_device power_supply = {
 };
 
 /******************************************************************************
- * WM97xx battery
+ * WM97xx audio, battery
  ******************************************************************************/
-static struct wm97xx_batt_info wm97xx_batt_pdata = {
+static struct wm97xx_batt_pdata palmld_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
 	.charge_gpio	= -1,
@@ -403,15 +403,17 @@ static struct wm97xx_batt_info wm97xx_batt_pdata = {
 	.batt_name	= "main-batt",
 };
 
-/******************************************************************************
- * aSoC audio
- ******************************************************************************/
-static struct palm27x_asoc_info palmld_asoc_pdata = {
-	.jack_gpio	= GPIO_NR_PALMLD_EARPHONE_DETECT,
+static struct wm97xx_pdata palmld_wm97xx_pdata = {
+	.batt_pdata	= &palmld_batt_pdata,
 };
 
 static pxa2xx_audio_ops_t palmld_ac97_pdata = {
 	.reset_gpio	= 95,
+	.codec_pdata	= { &palmld_wm97xx_pdata, },
+};
+
+static struct palm27x_asoc_info palmld_asoc_pdata = {
+	.jack_gpio	= GPIO_NR_PALMLD_EARPHONE_DETECT,
 };
 
 static struct platform_device palmld_asoc = {
@@ -521,7 +523,6 @@ static void __init palmld_init(void)
 	pxa_set_ac97_info(&palmld_ac97_pdata);
 	pxa_set_ficp_info(&palmld_ficp_platform_data);
 	pxa_set_keypad_info(&palmld_keypad_platform_data);
-	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 5305a39..0b36d7d 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -24,7 +24,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 
@@ -298,9 +298,9 @@ static struct platform_device power_supply = {
 };
 
 /******************************************************************************
- * WM97xx battery
+ * WM97xx audio, battery
  ******************************************************************************/
-static struct wm97xx_batt_info wm97xx_batt_pdata = {
+static struct wm97xx_batt_pdata palmt5_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
 	.charge_gpio	= -1,
@@ -314,15 +314,17 @@ static struct wm97xx_batt_info wm97xx_batt_pdata = {
 	.batt_name	= "main-batt",
 };
 
-/******************************************************************************
- * aSoC audio
- ******************************************************************************/
-static struct palm27x_asoc_info palmt5_asoc_pdata = {
-	.jack_gpio	= GPIO_NR_PALMT5_EARPHONE_DETECT,
+static struct wm97xx_pdata palmt5_wm97xx_pdata = {
+	.batt_pdata	= &palmt5_batt_pdata,
 };
 
 static pxa2xx_audio_ops_t palmt5_ac97_pdata = {
 	.reset_gpio	= 95,
+	.codec_pdata	= { &palmt5_wm97xx_pdata, },
+};
+
+static struct palm27x_asoc_info palmt5_asoc_pdata = {
+	.jack_gpio	= GPIO_NR_PALMT5_EARPHONE_DETECT,
 };
 
 static struct platform_device palmt5_asoc = {
@@ -411,7 +413,6 @@ static void __init palmt5_init(void)
 	pxa_set_ac97_info(&palmt5_ac97_pdata);
 	pxa_set_ficp_info(&palmt5_ficp_platform_data);
 	pxa_set_keypad_info(&palmt5_keypad_platform_data);
-	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 3d284ff..93c11a0 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -23,7 +23,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 
@@ -271,9 +271,9 @@ static struct platform_device power_supply = {
 };
 
 /******************************************************************************
- * WM97xx battery
+ * WM97xx audio, battery
  ******************************************************************************/
-static struct wm97xx_batt_info wm97xx_batt_pdata = {
+static struct wm97xx_batt_pdata palmte2_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
 	.charge_gpio	= -1,
@@ -287,9 +287,14 @@ static struct wm97xx_batt_info wm97xx_batt_pdata = {
 	.batt_name	= "main-batt",
 };
 
-/******************************************************************************
- * aSoC audio
- ******************************************************************************/
+static struct wm97xx_pdata palmte2_wm97xx_pdata = {
+	.batt_pdata	= &palmte2_batt_pdata,
+};
+
+static pxa2xx_audio_ops_t palmte2_ac97_pdata = {
+	.codec_pdata	= { &palmte2_wm97xx_pdata, },
+};
+
 static struct palm27x_asoc_info palmte2_asoc_pdata = {
 	.jack_gpio	= GPIO_NR_PALMTE2_EARPHONE_DETECT,
 };
@@ -361,9 +366,8 @@ static void __init palmte2_init(void)
 	set_pxa_fb_info(&palmte2_lcd_screen);
 	pxa_set_mci_info(&palmte2_mci_platform_data);
 	palmte2_udc_init();
-	pxa_set_ac97_info(NULL);
+	pxa_set_ac97_info(&palmte2_ac97_pdata);
 	pxa_set_ficp_info(&palmte2_ficp_platform_data);
-	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index d8b4469..4eb0258 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -23,7 +23,6 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
 #include <linux/power_supply.h>
 #include <linux/sysdev.h>
 #include <linux/w1-gpio.h>
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index ecc1a40..a5429cd 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -25,7 +25,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/mtd/nand.h>
@@ -359,9 +359,9 @@ static struct platform_device power_supply = {
 };
 
 /******************************************************************************
- * WM97xx battery
+ * WM97xx audio, battery
  ******************************************************************************/
-static struct wm97xx_batt_info wm97xx_batt_pdata = {
+static struct wm97xx_batt_pdata palmtx_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
 	.charge_gpio	= -1,
@@ -375,15 +375,17 @@ static struct wm97xx_batt_info wm97xx_batt_pdata = {
 	.batt_name	= "main-batt",
 };
 
-/******************************************************************************
- * aSoC audio
- ******************************************************************************/
-static struct palm27x_asoc_info palmtx_asoc_pdata = {
-	.jack_gpio	= GPIO_NR_PALMTX_EARPHONE_DETECT,
+static struct wm97xx_pdata palmtx_wm97xx_pdata = {
+	.batt_pdata	= &palmtx_batt_pdata,
 };
 
 static pxa2xx_audio_ops_t palmtx_ac97_pdata = {
 	.reset_gpio	= 95,
+	.codec_pdata	= { &palmtx_wm97xx_pdata, },
+};
+
+static struct palm27x_asoc_info palmtx_asoc_pdata = {
+	.jack_gpio	= GPIO_NR_PALMTX_EARPHONE_DETECT,
 };
 
 static struct platform_device palmtx_asoc = {
@@ -562,7 +564,6 @@ static void __init palmtx_init(void)
 	pxa_set_ac97_info(&palmtx_ac97_pdata);
 	pxa_set_ficp_info(&palmtx_ficp_platform_data);
 	pxa_set_keypad_info(&palmtx_keypad_platform_data);
-	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 3a7925c..b78c6b4 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -27,7 +27,7 @@
 #include <linux/pda_power.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
-#include <linux/wm97xx_batt.h>
+#include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 
@@ -325,9 +325,9 @@ static struct platform_device power_supply = {
 };
 
 /******************************************************************************
- * WM97xx battery
+ * WM97xx audio, battery
  ******************************************************************************/
-static struct wm97xx_batt_info wm97xx_batt_pdata = {
+static struct wm97xx_batt_pdata palmz72_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
 	.charge_gpio	= -1,
@@ -341,9 +341,14 @@ static struct wm97xx_batt_info wm97xx_batt_pdata = {
 	.batt_name	= "main-batt",
 };
 
-/******************************************************************************
- * aSoC audio
- ******************************************************************************/
+static struct wm97xx_pdata palmz72_wm97xx_pdata = {
+	.batt_pdata	= &palmz72_batt_pdata,
+};
+
+static pxa2xx_audio_ops_t palmz72_ac97_pdata = {
+	.codec_pdata	= { &palmz72_wm97xx_pdata, },
+};
+
 static struct platform_device palmz72_asoc = {
 	.name = "palm27x-asoc",
 	.id   = -1,
@@ -480,10 +485,9 @@ static void __init palmz72_init(void)
 	set_pxa_fb_info(&palmz72_lcd_screen);
 	pxa_set_mci_info(&palmz72_mci_platform_data);
 	palmz72_udc_init();
-	pxa_set_ac97_info(NULL);
+	pxa_set_ac97_info(&palmz72_ac97_pdata);
 	pxa_set_ficp_info(&palmz72_ficp_platform_data);
 	pxa_set_keypad_info(&palmz72_keypad_platform_data);
-	wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
1.7.1
