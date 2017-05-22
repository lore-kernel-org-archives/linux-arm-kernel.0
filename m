From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 May 2017 15:37:03 +0200
Subject: [PATCH] serial: meson: hide an unused function
Message-ID: <20170522133746.880230-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added meson_uart_enable_tx_engine function is only called
from the console setup, not the runtime uart, which has an open-coded
version of the same register access. This produces a harmless warning
when the console code is disabled:

drivers/tty/serial/meson_uart.c:127:13: error: 'meson_uart_enable_tx_engine' defined but not used [-Werror=unused-function]

Let's move the function inside of the #ifdef to avoid the warning.

Fixes: ba50f1df13c8 ("serial: meson: remove unneeded variable assignment in meson_serial_port_write")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/meson_uart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 082e038e67f8..c0e34dabadd8 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -124,15 +124,6 @@ static void meson_uart_stop_rx(struct uart_port *port)
 	writel(val, port->membase + AML_UART_CONTROL);
 }
 
-static void meson_uart_enable_tx_engine(struct uart_port *port)
-{
-	u32 val;
-
-	val = readl(port->membase + AML_UART_CONTROL);
-	val |= AML_UART_TX_EN;
-	writel(val, port->membase + AML_UART_CONTROL);
-}
-
 static void meson_uart_shutdown(struct uart_port *port)
 {
 	unsigned long flags;
@@ -451,6 +442,14 @@ static struct uart_ops meson_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
+static void meson_uart_enable_tx_engine(struct uart_port *port)
+{
+	u32 val;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val |= AML_UART_TX_EN;
+	writel(val, port->membase + AML_UART_CONTROL);
+}
 
 static void meson_console_putchar(struct uart_port *port, int ch)
 {
-- 
2.9.0
