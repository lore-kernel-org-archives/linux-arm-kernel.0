From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 27 Apr 2011 20:50:02 +0200
Subject: [PATCH v2] pxa/magician: use gpio arrays for backlight and global
	gpio initialization
In-Reply-To: <1303329323.21545.6.camel@flow>
References: <1303329323.21545.6.camel@flow>
Message-ID: <1303930204.14964.6.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array() in backlight init and exit
functions and global gpio initialization.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/magician.c |   57 +++++++++++++++++-------------------------
 1 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 9984ef7..34aabe9 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -344,22 +344,14 @@ static struct pxafb_mach_info samsung_info = {
  * Backlight
  */
 
+static struct gpio magician_bl_gpios[] = {
+        { EGPIO_MAGICIAN_BL_POWER,  GPIOF_DIR_OUT, "Backlight power" },
+        { EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Backlight power 2" },
+};
+
 static int magician_backlight_init(struct device *dev)
 {
-	int ret;
-
-	ret = gpio_request(EGPIO_MAGICIAN_BL_POWER, "BL_POWER");
-	if (ret)
-		goto err;
-	ret = gpio_request(EGPIO_MAGICIAN_BL_POWER2, "BL_POWER2");
-	if (ret)
-		goto err2;
-	return 0;
-
-err2:
-	gpio_free(EGPIO_MAGICIAN_BL_POWER);
-err:
-	return ret;
+	return gpio_request_array(ARRAY_AND_SIZE(magician_bl_gpios));
 }
 
 static int magician_backlight_notify(struct device *dev, int brightness)
@@ -376,8 +368,7 @@ static int magician_backlight_notify(struct device *dev, int brightness)
 
 static void magician_backlight_exit(struct device *dev)
 {
-	gpio_free(EGPIO_MAGICIAN_BL_POWER);
-	gpio_free(EGPIO_MAGICIAN_BL_POWER2);
+	gpio_free_array(ARRAY_AND_SIZE(magician_bl_gpios));
 }
 
 static struct platform_pwm_backlight_data backlight_data = {
@@ -712,16 +703,25 @@ static struct platform_device *devices[] __initdata = {
 	&leds_gpio,
 };
 
+static struct gpio magician_global_gpios[] = {
+	{ GPIO13_MAGICIAN_CPLD_IRQ,   GPIOF_IN, "CPLD_IRQ" },
+	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
+	{ GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
+	{ GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
+	{ GPIO106_MAGICIAN_LCD_POWER_3, GPIOF_OUT_INIT_LOW, "LCD power 3" },
+	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH, "nIR_EN" },
+};
+
 static void __init magician_init(void)
 {
 	void __iomem *cpld;
 	int lcd_select;
 	int err;
 
-	gpio_request(GPIO13_MAGICIAN_CPLD_IRQ, "CPLD_IRQ");
-	gpio_request(GPIO107_MAGICIAN_DS1WM_IRQ, "DS1WM_IRQ");
-
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(magician_pin_config));
+	err = gpio_request_array(ARRAY_AND_SIZE(magician_global_gpios));
+	if (err)
+		pr_err ("magician: Failed to request GPIOs.\n");
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
@@ -729,11 +729,7 @@ static void __init magician_init(void)
 
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
-	err = gpio_request(GPIO83_MAGICIAN_nIR_EN, "nIR_EN");
-	if (!err) {
-		gpio_direction_output(GPIO83_MAGICIAN_nIR_EN, 1);
-		pxa_set_ficp_info(&magician_ficp_info);
-	}
+	pxa_set_ficp_info(&magician_ficp_info);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_i2c_info(&i2c_info);
 	pxa_set_mci_info(&magician_mci_info);
@@ -747,16 +743,9 @@ static void __init magician_init(void)
 		system_rev = board_id & 0x7;
 		lcd_select = board_id & 0x8;
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
-		if (lcd_select && (system_rev < 3)) {
-			gpio_request(GPIO75_MAGICIAN_SAMSUNG_POWER, "SAMSUNG_POWER");
-			gpio_direction_output(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
-		}
-		gpio_request(GPIO104_MAGICIAN_LCD_POWER_1, "LCD_POWER_1");
-		gpio_request(GPIO105_MAGICIAN_LCD_POWER_2, "LCD_POWER_2");
-		gpio_request(GPIO106_MAGICIAN_LCD_POWER_3, "LCD_POWER_3");
-		gpio_direction_output(GPIO104_MAGICIAN_LCD_POWER_1, 0);
-		gpio_direction_output(GPIO105_MAGICIAN_LCD_POWER_2, 0);
-		gpio_direction_output(GPIO106_MAGICIAN_LCD_POWER_3, 0);
+		if (lcd_select && (system_rev < 3))
+			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
+				         GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
 		pxa_set_fb_info(NULL, lcd_select ? &samsung_info : &toppoly_info);
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
-- 
1.7.4.4
