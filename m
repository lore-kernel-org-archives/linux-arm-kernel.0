From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:51 +0100
Subject: [PATCH 1/8] ARM: pxa: PalmTE2: Use gpio arrays in backlight init
Message-ID: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array() / gpio_free_array() in backlight init and exit
functions. This makes the code cleaner and less error prone.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palmte2.c |   31 +++++++------------------------
 1 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 3f25014..66311c7 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -136,30 +136,14 @@ static struct platform_device palmte2_pxa_keys = {
 /******************************************************************************
  * Backlight
  ******************************************************************************/
+static struct gpio palmte_bl_gpios[] = {
+	{ GPIO_NR_PALMTE2_BL_POWER, GPIOF_INIT_LOW, "Backlight power" },
+	{ GPIO_NR_PALMTE2_LCD_POWER, GPIOF_INIT_LOW, "LCD power" },
+};
+
 static int palmte2_backlight_init(struct device *dev)
 {
-	int ret;
-
-	ret = gpio_request(GPIO_NR_PALMTE2_BL_POWER, "BL POWER");
-	if (ret)
-		goto err;
-	ret = gpio_direction_output(GPIO_NR_PALMTE2_BL_POWER, 0);
-	if (ret)
-		goto err2;
-	ret = gpio_request(GPIO_NR_PALMTE2_LCD_POWER, "LCD POWER");
-	if (ret)
-		goto err2;
-	ret = gpio_direction_output(GPIO_NR_PALMTE2_LCD_POWER, 0);
-	if (ret)
-		goto err3;
-
-	return 0;
-err3:
-	gpio_free(GPIO_NR_PALMTE2_LCD_POWER);
-err2:
-	gpio_free(GPIO_NR_PALMTE2_BL_POWER);
-err:
-	return ret;
+	return gpio_request_array(ARRAY_AND_SIZE(palmte_bl_gpios));
 }
 
 static int palmte2_backlight_notify(struct device *dev, int brightness)
@@ -171,8 +155,7 @@ static int palmte2_backlight_notify(struct device *dev, int brightness)
 
 static void palmte2_backlight_exit(struct device *dev)
 {
-	gpio_free(GPIO_NR_PALMTE2_BL_POWER);
-	gpio_free(GPIO_NR_PALMTE2_LCD_POWER);
+	gpio_free_array(ARRAY_AND_SIZE(palmte_bl_gpios));
 }
 
 static struct platform_pwm_backlight_data palmte2_backlight_data = {
-- 
1.7.2.3
