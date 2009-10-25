From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 16:49:37 +0300
Subject: [PATCH] SA1100: h3100/h3600: emit messages on failed gpio_request
Message-ID: <mailman.90.1256484975.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3100.c |    3 ++-
 arch/arm/mach-sa1100/h3600.c |   16 ++++++++++++----
 arch/arm/mach-sa1100/h3xxx.c |    8 ++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 793e68c..3571411 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -31,7 +31,8 @@ static void h3100_lcd_power(int enable)
 		gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
 		gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
 		gpio_free(H3XXX_EGPIO_LCD_ON);
-	}
+	} else
+		pr_err("%s: can't request H3XXX_EGPIO_LCD_ON\n", __func__);
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
index ec9d9db..432ce93 100644
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
@@ -147,7 +149,9 @@ static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
 			gpio_direction_output(H3XXX_EGPIO_RS232_ON, !state);
 			gpio_free(H3XXX_EGPIO_RS232_ON);
-		}
+		} else
+			pr_err("%s: can't request H3XXX_EGPIO_RS232_ON\n",
+				__func__);
 }
 
 /*
-- 
1.6.3.4


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-SA1100-h3100-h3600-always-build-htc-egpio-driver.patch"
