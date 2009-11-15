From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 15 Nov 2009 13:22:41 +0300
Subject: [PATCH v2] SA1100: h3100/h3600: emit messages on failed gpio_request
Message-ID: <mailman.30.1258306259.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
v1 -> v2:
more braces added to conform CodingStyle and to silence gcc warning:
arch/arm/mach-sa1100/h3xxx.c: In function 'h3xxx_uart_pm':
arch/arm/mach-sa1100/h3xxx.c:148: warning: suggest explicit braces to avoid
ambiguous 'else'

 arch/arm/mach-sa1100/h3100.c |    2 ++
 arch/arm/mach-sa1100/h3600.c |   16 ++++++++++++----
 arch/arm/mach-sa1100/h3xxx.c |   10 ++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 793e68c..0c7cea0 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -31,6 +31,8 @@ static void h3100_lcd_power(int enable)
 		gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
 		gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
 		gpio_free(H3XXX_EGPIO_LCD_ON);
+	} else {
+		pr_err("%s: can't request H3XXX_EGPIO_LCD_ON\n", __func__);
 	}
 }
 
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 47587cc..af3b714 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -27,14 +27,22 @@
  */
 static void h3600_lcd_power(int enable)
 {
-	if (gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power"))
+	if (gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power")) {
+		pr_err("%s: can't request H3XXX_EGPIO_LCD_ON\n", __func__);
 		goto err1;
-	if (gpio_request(H3600_EGPIO_LCD_PCI, "LCD control"))
+	}
+	if (gpio_request(H3600_EGPIO_LCD_PCI, "LCD control")) {
+		pr_err("%s: can't request H3XXX_EGPIO_LCD_PCI\n", __func__);
 		goto err2;
-	if (gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v"))
+	}
+	if (gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v")) {
+		pr_err("%s: can't request H3XXX_EGPIO_LCD_5V_ON\n", __func__);
 		goto err3;
-	if (gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v"))
+	}
+	if (gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v")) {
+		pr_err("%s: can't request H3600_EGPIO_LVDD_ON\n", __func__);
 		goto err4;
+	}
 
 	gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
 	gpio_direction_output(H3600_EGPIO_LCD_PCI, enable);
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index ec9d9db..8697dfe 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -83,8 +83,10 @@ static void h3xxx_set_vpp(int vpp)
 static int h3xxx_flash_init(void)
 {
 	int err = gpio_request(H3XXX_EGPIO_VPP_ON, "Flash Vpp");
-	if (err)
+	if (err) {
+		pr_err("%s: can't request H3XXX_EGPIO_VPP_ON\n", __func__);
 		return err;
+	}
 
 	err = gpio_direction_output(H3XXX_EGPIO_VPP_ON, 0);
 	if (err)
@@ -143,11 +145,15 @@ static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
 
 static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
-	if (port->mapbase == _Ser3UTCR0)
+	if (port->mapbase == _Ser3UTCR0) {
 		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
 			gpio_direction_output(H3XXX_EGPIO_RS232_ON, !state);
 			gpio_free(H3XXX_EGPIO_RS232_ON);
+		} else {
+			pr_err("%s: can't request H3XXX_EGPIO_RS232_ON\n",
+				__func__);
 		}
+	}
 }
 
 /*
-- 
1.6.3.4


--cNdxnHkX5QqsyA0e--
