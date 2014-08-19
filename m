From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 19 Aug 2014 16:31:14 +0400
Subject: [PATCH 2/3] ARM: clps711x: edb7211: Use new PWM driver for backlight
In-Reply-To: <1408451475-1140-1-git-send-email-shc_work@mail.ru>
References: <1408451475-1140-1-git-send-email-shc_work@mail.ru>
Message-ID: <1408451475-1140-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove existing tricks for handling PWM and use CLPS711X PWM driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/clps711x_defconfig    |  4 +++-
 arch/arm/mach-clps711x/board-edb7211.c | 37 ++++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 0facf9d..fc105c9 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -68,8 +68,8 @@ CONFIG_GPIO_GENERIC_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CLPS711X=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_PWM=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -77,6 +77,8 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_CLPS711X=y
 CONFIG_EXT2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_MINIX_FS=y
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index fdf54d4..f339797 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -14,8 +14,9 @@
 #include <linux/types.h>
 #include <linux/i2c-gpio.h>
 #include <linux/interrupt.h>
-#include <linux/backlight.h>
 #include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/pwm_backlight.h>
 #include <linux/memblock.h>
 
 #include <linux/mtd/physmap.h>
@@ -108,23 +109,23 @@ static struct plat_lcd_data edb7211_lcd_power_pdata = {
 	.set_power	= edb7211_lcd_power_set,
 };
 
-static void edb7211_lcd_backlight_set_intensity(int intensity)
-{
-	gpio_set_value(EDB7211_LCDBL, !!intensity);
-	clps_writel((clps_readl(PMPCON) & 0xf0ff) | (intensity << 8), PMPCON);
-}
+static struct pwm_lookup edb7211_pwm_lookup[] = {
+	PWM_LOOKUP("clps711x-pwm", 0, "pwm-backlight.0", NULL,
+		   0, PWM_POLARITY_NORMAL),
+};
 
-static struct generic_bl_info edb7211_lcd_backlight_pdata = {
-	.name			= "lcd-backlight.0",
-	.default_intensity	= 0x01,
-	.max_intensity		= 0x0f,
-	.set_bl_intensity	= edb7211_lcd_backlight_set_intensity,
+static struct platform_pwm_backlight_data pwm_bl_pdata = {
+	.dft_brightness	= 0x01,
+	.max_brightness	= 0x0f,
+	.enable_gpio	= EDB7211_LCDBL,
 };
 
+static struct resource clps711x_pwm_res =
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + PMPCON, SZ_4);
+
 static struct gpio edb7211_gpios[] __initconst = {
 	{ EDB7211_LCD_DC_DC_EN,	GPIOF_OUT_INIT_LOW,	"LCD DC-DC" },
 	{ EDB7211_LCDEN,	GPIOF_OUT_INIT_LOW,	"LCD POWER" },
-	{ EDB7211_LCDBL,	GPIOF_OUT_INIT_LOW,	"LCD BACKLIGHT" },
 };
 
 /* Reserve screen memory region@the start of main system memory. */
@@ -153,12 +154,18 @@ static void __init edb7211_init_late(void)
 	gpio_request_array(edb7211_gpios, ARRAY_SIZE(edb7211_gpios));
 
 	platform_device_register(&edb7211_flash_pdev);
+
 	platform_device_register_data(NULL, "platform-lcd", 0,
 				      &edb7211_lcd_power_pdata,
 				      sizeof(edb7211_lcd_power_pdata));
-	platform_device_register_data(NULL, "generic-bl", 0,
-				      &edb7211_lcd_backlight_pdata,
-				      sizeof(edb7211_lcd_backlight_pdata));
+
+	platform_device_register_simple("clps711x-pwm", PLATFORM_DEVID_NONE,
+					&clps711x_pwm_res, 1);
+	pwm_add_table(edb7211_pwm_lookup, ARRAY_SIZE(edb7211_pwm_lookup));
+
+	platform_device_register_data(&platform_bus, "pwm-backlight", 0,
+				      &pwm_bl_pdata, sizeof(pwm_bl_pdata));
+
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 	platform_device_register_simple("cs89x0", 0, edb7211_cs8900_resource,
 					ARRAY_SIZE(edb7211_cs8900_resource));
-- 
1.8.5.5
