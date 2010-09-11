From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 12 Sep 2010 00:45:18 +0300
Subject: [PATCH v2 4/5] h1940: Fix backlight and LCD power functions
In-Reply-To: <1283871605-32068-5-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-5-git-send-email-anarsoul@gmail.com>
Message-ID: <1284241518-32587-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: init gpio mode/value right after gpio_request

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/h1940-latch.h |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c               |   80 ++++++++++++++++++----
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
index ef7d8cf..97e42bf 100644
--- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
+++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
@@ -20,7 +20,7 @@
 
 /* SD layer latch */
 
-#define H1940_LATCH_SDQ1		H1940_LATCH_GPIO(0)
+#define H1940_LATCH_LCD_P0		H1940_LATCH_GPIO(0)
 #define H1940_LATCH_LCD_P1		H1940_LATCH_GPIO(1)
 #define H1940_LATCH_LCD_P2		H1940_LATCH_GPIO(2)
 #define H1940_LATCH_LCD_P3		H1940_LATCH_GPIO(3)
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index cc8660e..974c6e4 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -106,13 +106,7 @@ static struct s3c2410_uartcfg h1940_uartcfgs[] __initdata = {
 
 /* Board control latch control */
 
-static unsigned int latch_state = H1940_LATCH_BIT(H1940_LATCH_LCD_P4) |
-	H1940_LATCH_BIT(H1940_LATCH_SM803_ENABLE)	|
-	H1940_LATCH_BIT(H1940_LATCH_SDQ1)			|
-	H1940_LATCH_BIT(H1940_LATCH_LCD_P1)			|
-	H1940_LATCH_BIT(H1940_LATCH_LCD_P2)			|
-	H1940_LATCH_BIT(H1940_LATCH_LCD_P3)			|
-	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN);
+static unsigned int latch_state;
 
 static void h1940_latch_control(unsigned int clear, unsigned int set)
 {
@@ -275,15 +269,32 @@ static int h1940_backlight_init(struct device *dev)
 	gpio_direction_output(S3C2410_GPB(0), 0);
 	s3c_gpio_setpull(S3C2410_GPB(0), S3C_GPIO_PULL_NONE);
 	s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
+	gpio_set_value(H1940_LATCH_MAX1698_nSHUTDOWN, 1);
 
 	return 0;
 }
 
+static int h1940_backlight_notify(struct device *dev, int brightness)
+{
+	if (!brightness) {
+		gpio_direction_output(S3C2410_GPB(0), 1);
+		gpio_set_value(H1940_LATCH_MAX1698_nSHUTDOWN, 0);
+	} else {
+		gpio_direction_output(S3C2410_GPB(0), 0);
+		s3c_gpio_setpull(S3C2410_GPB(0), S3C_GPIO_PULL_NONE);
+		s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
+		gpio_set_value(H1940_LATCH_MAX1698_nSHUTDOWN, 1);
+	}
+	return brightness;
+}
+
 static void h1940_backlight_exit(struct device *dev)
 {
 	gpio_direction_output(S3C2410_GPB(0), 1);
+	gpio_set_value(H1940_LATCH_MAX1698_nSHUTDOWN, 0);
 }
 
+
 static struct platform_pwm_backlight_data backlight_data = {
 	.pwm_id         = 0,
 	.max_brightness = 100,
@@ -291,6 +302,7 @@ static struct platform_pwm_backlight_data backlight_data = {
 	/* tcnt = 0x31 */
 	.pwm_period_ns  = 36296,
 	.init           = h1940_backlight_init,
+	.notify		= h1940_backlight_notify,
 	.exit           = h1940_backlight_exit,
 };
 
@@ -309,19 +321,37 @@ static void h1940_lcd_power_set(struct plat_lcd_data *pd,
 	int value;
 
 	if (!power) {
-		/* set to 3ec */
-		gpio_direction_output(S3C2410_GPC(0), 0);
+		gpio_set_value(S3C2410_GPC(0), 0);
 		/* wait for 3ac */
 		do {
 			value = gpio_get_value(S3C2410_GPC(6));
 		} while (value);
-		/* set to 38c */
-		gpio_direction_output(S3C2410_GPC(5), 0);
+
+		gpio_set_value(H1940_LATCH_LCD_P2, 0);
+		gpio_set_value(H1940_LATCH_LCD_P3, 0);
+		gpio_set_value(H1940_LATCH_LCD_P4, 0);
+
+		gpio_direction_output(S3C2410_GPC(1), 0);
+		gpio_direction_output(S3C2410_GPC(4), 0);
+
+		gpio_set_value(H1940_LATCH_LCD_P1, 0);
+		gpio_set_value(H1940_LATCH_LCD_P0, 0);
+
+		gpio_set_value(S3C2410_GPC(5), 0);
+
 	} else {
-		/* Set to 3ac */
-		gpio_direction_output(S3C2410_GPC(5), 1);
-		/* Set to 3ad */
-		gpio_direction_output(S3C2410_GPC(0), 1);
+		gpio_set_value(H1940_LATCH_LCD_P0, 1);
+		gpio_set_value(H1940_LATCH_LCD_P1, 1);
+
+		s3c_gpio_cfgpin(S3C2410_GPC(1), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin(S3C2410_GPC(4), S3C_GPIO_SFN(2));
+
+		gpio_set_value(S3C2410_GPC(5), 1);
+		gpio_set_value(S3C2410_GPC(0), 1);
+
+		gpio_set_value(H1940_LATCH_LCD_P3, 1);
+		gpio_set_value(H1940_LATCH_LCD_P2, 1);
+		gpio_set_value(H1940_LATCH_LCD_P4, 1);
 	}
 }
 
@@ -366,6 +396,8 @@ static void __init h1940_map_io(void)
 #endif
 	s3c_pm_init();
 
+	/* Add latch gpio chip, set latch initial value */
+	h1940_latch_control(0, 0);
 	WARN_ON(gpiochip_add(&h1940_latch_gpiochip));
 }
 
@@ -404,9 +436,27 @@ static void __init h1940_init(void)
 	writel(tmp, S3C2410_UPLLCON);
 
 	gpio_request(S3C2410_GPC(0), "LCD power");
+	gpio_request(S3C2410_GPC(1), "LCD power");
+	gpio_request(S3C2410_GPC(4), "LCD power");
 	gpio_request(S3C2410_GPC(5), "LCD power");
 	gpio_request(S3C2410_GPC(6), "LCD power");
+	gpio_request(H1940_LATCH_LCD_P0, "LCD power");
+	gpio_request(H1940_LATCH_LCD_P1, "LCD power");
+	gpio_request(H1940_LATCH_LCD_P2, "LCD power");
+	gpio_request(H1940_LATCH_LCD_P3, "LCD power");
+	gpio_request(H1940_LATCH_LCD_P4, "LCD power");
+	gpio_request(H1940_LATCH_MAX1698_nSHUTDOWN, "LCD power");
+	gpio_direction_output(S3C2410_GPC(0), 0);
+	gpio_direction_output(S3C2410_GPC(1), 0);
+	gpio_direction_output(S3C2410_GPC(4), 0);
+	gpio_direction_output(S3C2410_GPC(5), 0);
 	gpio_direction_input(S3C2410_GPC(6));
+	gpio_direction_output(H1940_LATCH_LCD_P0, 0);
+	gpio_direction_output(H1940_LATCH_LCD_P1, 0);
+	gpio_direction_output(H1940_LATCH_LCD_P2, 0);
+	gpio_direction_output(H1940_LATCH_LCD_P3, 0);
+	gpio_direction_output(H1940_LATCH_LCD_P4, 0);
+	gpio_direction_output(H1940_LATCH_MAX1698_nSHUTDOWN, 0);
 
 	gpio_request(H1940_LATCH_USB_DP, "USB pullup");
 	gpio_direction_output(H1940_LATCH_USB_DP, 0);
-- 
1.7.2.2
