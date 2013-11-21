From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:10 +0400
Subject: [PATCH 2/6] arm: sa1100: h3600: refactor LCD GPIO handling
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1385048414-9812-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array to request all GPIOs at once. Also don't call
gpio_free. There is little point freeing LCD gpios once they are
requested. Instead guard them with bool variable.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/h3600.c | 48 ++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index b8dc5bd..559c2a0 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -28,35 +28,39 @@
 /*
  * helper for sa1100fb
  */
+static struct gpio h3600_lcd_gpio[] = {
+	{ H3XXX_EGPIO_LCD_ON,	GPIOF_OUT_INIT_LOW,	"LCD power" },
+	{ H3600_EGPIO_LCD_PCI,	GPIOF_OUT_INIT_LOW,	"LCD control" },
+	{ H3600_EGPIO_LCD_5V_ON, GPIOF_OUT_INIT_LOW,	"LCD 5v" },
+	{ H3600_EGPIO_LVDD_ON,	GPIOF_OUT_INIT_LOW,	"LCD 9v/-6.5v" },
+};
+
+static bool h3600_lcd_request(void)
+{
+	static bool h3600_lcd_ok;
+	int rc;
+
+	if (h3600_lcd_ok)
+		return true;
+
+	rc = gpio_request_array(h3600_lcd_gpio, ARRAY_SIZE(h3600_lcd_gpio));
+	if (rc)
+		pr_err("%s: can't request GPIOs\n", __func__);
+	else
+		h3600_lcd_ok = true;
+
+	return h3600_lcd_ok;
+}
+
 static void h3600_lcd_power(int enable)
 {
-	if (gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power")) {
-		pr_err("%s: can't request H3XXX_EGPIO_LCD_ON\n", __func__);
-		goto err1;
-	}
-	if (gpio_request(H3600_EGPIO_LCD_PCI, "LCD control")) {
-		pr_err("%s: can't request H3XXX_EGPIO_LCD_PCI\n", __func__);
-		goto err2;
-	}
-	if (gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v")) {
-		pr_err("%s: can't request H3XXX_EGPIO_LCD_5V_ON\n", __func__);
-		goto err3;
-	}
-	if (gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v")) {
-		pr_err("%s: can't request H3600_EGPIO_LVDD_ON\n", __func__);
-		goto err4;
-	}
+	if (!h3600_lcd_request())
+		return;
 
 	gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
 	gpio_direction_output(H3600_EGPIO_LCD_PCI, enable);
 	gpio_direction_output(H3600_EGPIO_LCD_5V_ON, enable);
 	gpio_direction_output(H3600_EGPIO_LVDD_ON, enable);
-
-	gpio_free(H3600_EGPIO_LVDD_ON);
-err4:	gpio_free(H3600_EGPIO_LCD_5V_ON);
-err3:	gpio_free(H3600_EGPIO_LCD_PCI);
-err2:	gpio_free(H3XXX_EGPIO_LCD_ON);
-err1:	return;
 }
 
 static const struct sa1100fb_rgb h3600_rgb_16 = {
-- 
1.8.4.2
