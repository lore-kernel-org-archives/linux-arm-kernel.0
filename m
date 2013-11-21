From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:09 +0400
Subject: [PATCH 1/6] arm: sa1100: h3100: refactor LCD GPIO handling
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1385048414-9812-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As GPIOs are going to move to platform device, there is no guarantee
that they will be available at init_machine time.

Request all GPIOs directly in lcd_power callback and not at init_machine
time.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/h3100.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index b8f2b15..5b78c9f 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -28,15 +28,35 @@
 /*
  * helper for sa1100fb
  */
+static struct gpio h3100_lcd_gpio[] = {
+	{ H3100_GPIO_LCD_3V_ON, GPIOF_OUT_INIT_LOW, "LCD 3V" },
+	{ H3XXX_EGPIO_LCD_ON, GPIOF_OUT_INIT_LOW, "LCD ON" },
+};
+
+static bool h3100_lcd_request(void)
+{
+	static bool h3100_lcd_ok;
+	int rc;
+
+	if (h3100_lcd_ok)
+		return true;
+
+	rc = gpio_request_array(h3100_lcd_gpio, ARRAY_SIZE(h3100_lcd_gpio));
+	if (rc)
+		pr_err("%s: can't request GPIOs\n", __func__);
+	else
+		h3100_lcd_ok = true;
+
+	return h3100_lcd_ok;
+}
+
 static void h3100_lcd_power(int enable)
 {
-	if (!gpio_request(H3XXX_EGPIO_LCD_ON, "LCD ON")) {
-		gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
-		gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
-		gpio_free(H3XXX_EGPIO_LCD_ON);
-	} else {
-		pr_err("%s: can't request H3XXX_EGPIO_LCD_ON\n", __func__);
-	}
+	if (!h3100_lcd_request())
+		return;
+
+	gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
+	gpio_set_value(H3XXX_EGPIO_LCD_ON, enable);
 }
 
 static struct sa1100fb_mach_info h3100_lcd_info = {
@@ -91,7 +111,6 @@ static struct gpio_default_state h3100_default_gpio[] = {
 	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
 	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
 	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-	{ H3100_GPIO_LCD_3V_ON,	GPIO_MODE_OUT0,	"LCD 3v" },
 };
 
 static void __init h3100_mach_init(void)
-- 
1.8.4.2
