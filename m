From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 13:49:42 +0100
Subject: [PATCH] tty: serial: meson: Add support for XTAL clock input
Message-ID: <1454935783-17027-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the baudrate calculation for 24 MHz XTAL clock found on gxbb platforms.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Forward-ported from vendor kernel. On top of my meson earlycon patch.
 
 drivers/tty/serial/meson_uart.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 9efcfa2de31e..4415631bab17 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -78,6 +78,7 @@
 /* AML_UART_REG5 bits */
 #define AML_UART_BAUD_MASK		0x7fffff
 #define AML_UART_BAUD_USE		BIT(23)
+#define AML_UART_BAUD_XTAL		BIT(24)
 
 #define AML_UART_PORT_NUM		6
 #define AML_UART_DEV_NAME		"ttyAML"
@@ -299,7 +300,12 @@ static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
 
 	val = readl(port->membase + AML_UART_REG5);
 	val &= ~AML_UART_BAUD_MASK;
-	val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+	if (port->uartclk == 24000000) {
+		val = ((port->uartclk / 3) / baud) - 1;
+		val |= AML_UART_BAUD_XTAL;
+	} else {
+		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
+	}
 	val |= AML_UART_BAUD_USE;
 	writel(val, port->membase + AML_UART_REG5);
 }
-- 
2.6.2
