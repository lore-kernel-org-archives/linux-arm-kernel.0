From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:13 +0400
Subject: [PATCH 5/6] arm: sa1100: h3xxx: move serial port GPIO handling to
 common place
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1385048414-9812-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both h3100 and h3600 request UART gpios during init_machine time. As
sa1100 gpio driver is going to become proper machine driver, move gpio
handling to UART port functions. Request all gpios using gpio_request
array once and then guard them from rerequesting with bool variable.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/h3100.c |  7 -------
 arch/arm/mach-sa1100/h3600.c |  7 -------
 arch/arm/mach-sa1100/h3xxx.c | 27 +++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index daa27c4..3c43219 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -122,15 +122,8 @@ static struct irda_platform_data h3100_irda_data = {
 	.shutdown	= h3100_irda_shutdown,
 };
 
-static struct gpio_default_state h3100_default_gpio[] = {
-	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-};
-
 static void __init h3100_mach_init(void)
 {
-	h3xxx_init_gpio(h3100_default_gpio, ARRAY_SIZE(h3100_default_gpio));
 	h3xxx_mach_init();
 
 	sa11x0_register_lcd(&h3100_lcd_info);
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index a663e72..5be54c2 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -130,15 +130,8 @@ static struct irda_platform_data h3600_irda_data = {
 	.shutdown	= h3600_irda_shutdown,
 };
 
-static struct gpio_default_state h3600_default_gpio[] = {
-	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-};
-
 static void __init h3600_mach_init(void)
 {
-	h3xxx_init_gpio(h3600_default_gpio, ARRAY_SIZE(h3600_default_gpio));
 	h3xxx_mach_init();
 
 	sa11x0_register_lcd(&h3600_lcd_info);
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index f17e738..82e8702 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -116,9 +116,34 @@ static struct resource h3xxx_flash_resource =
 /*
  * H3xxx uart support
  */
+static struct gpio h3xxx_uart_gpio[] = {
+	{ H3XXX_GPIO_COM_DCD,	GPIOF_IN,		"COM DCD" },
+	{ H3XXX_GPIO_COM_CTS,	GPIOF_IN,		"COM CTS" },
+	{ H3XXX_GPIO_COM_RTS,	GPIOF_OUT_INIT_LOW,	"COM RTS" },
+};
+
+static bool h3xxx_uart_request_gpios(void)
+{
+	static bool h3xxx_uart_gpio_ok;
+	int rc;
+
+	if (h3xxx_uart_gpio_ok)
+		return true;
+
+	rc = gpio_request_array(h3xxx_uart_gpio, ARRAY_SIZE(h3xxx_uart_gpio));
+	if (rc)
+		pr_err("h3xxx_uart_request_gpios: error %d\n", rc);
+	else
+		h3xxx_uart_gpio_ok = true;
+
+	return h3xxx_uart_gpio_ok;
+}
+
 static void h3xxx_uart_set_mctrl(struct uart_port *port, u_int mctrl)
 {
 	if (port->mapbase == _Ser3UTCR0) {
+		if (!h3xxx_uart_request_gpios())
+			return;
 		gpio_set_value(H3XXX_GPIO_COM_RTS, !(mctrl & TIOCM_RTS));
 	}
 }
@@ -128,6 +153,8 @@ static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
 	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
 
 	if (port->mapbase == _Ser3UTCR0) {
+		if (!h3xxx_uart_request_gpios())
+			return ret;
 		/*
 		 * DCD and CTS bits are inverted in GPLR by RS232 transceiver
 		 */
-- 
1.8.4.2
