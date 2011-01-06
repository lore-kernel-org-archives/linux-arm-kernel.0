From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  6 Jan 2011 21:52:50 +0200
Subject: [PATCH 5/7] ARM: S3C2410: H1940: Fix lcd_power_set function
In-Reply-To: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
References: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1294343572-28518-6-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of lcd_power_set is not reliable, sometimes
it does not enable LCD at all.
Mimic WinCE behavior to fix this issue.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 6a3cf78..5531c4c 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -30,6 +30,7 @@
 #include <linux/leds.h>
 #include <linux/pda_power.h>
 #include <linux/s3c_adc_battery.h>
+#include <linux/delay.h>
 
 #include <video/platform_lcd.h>
 
@@ -228,15 +229,15 @@ static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
 	.num_displays = 1,
 	.default_display = 0,
 
-	.lpcsel=	0x02,
-	.gpccon=	0xaa940659,
-	.gpccon_mask=	0xffffffff,
-	.gpcup=		0x0000ffff,
-	.gpcup_mask=	0xffffffff,
-	.gpdcon=	0xaa84aaa0,
-	.gpdcon_mask=	0xffffffff,
-	.gpdup=		0x0000faff,
-	.gpdup_mask=	0xffffffff,
+	.lpcsel =	0x02,
+	.gpccon =	0xaa940659,
+	.gpccon_mask =	0xffffc0f0,
+	.gpcup =	0x0000ffff,
+	.gpcup_mask =	0xffffffff,
+	.gpdcon =	0xaa84aaa0,
+	.gpdcon_mask =	0xffffffff,
+	.gpdup =	0x0000faff,
+	.gpdup_mask =	0xffffffff,
 };
 
 static int power_supply_init(struct device *dev)
@@ -545,14 +546,14 @@ static struct platform_device h1940_backlight = {
 static void h1940_lcd_power_set(struct plat_lcd_data *pd,
 					unsigned int power)
 {
-	int value;
+	int value, retries = 100;
 
 	if (!power) {
 		gpio_set_value(S3C2410_GPC(0), 0);
 		/* wait for 3ac */
 		do {
 			value = gpio_get_value(S3C2410_GPC(6));
-		} while (value);
+		} while (value && retries--);
 
 		gpio_set_value(H1940_LATCH_LCD_P2, 0);
 		gpio_set_value(H1940_LATCH_LCD_P3, 0);
@@ -570,6 +571,9 @@ static void h1940_lcd_power_set(struct plat_lcd_data *pd,
 		gpio_set_value(H1940_LATCH_LCD_P0, 1);
 		gpio_set_value(H1940_LATCH_LCD_P1, 1);
 
+		gpio_direction_input(S3C2410_GPC(1));
+		gpio_direction_input(S3C2410_GPC(4));
+		mdelay(10);
 		s3c_gpio_cfgpin(S3C2410_GPC(1), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S3C2410_GPC(4), S3C_GPIO_SFN(2));
 
-- 
1.7.3.2
