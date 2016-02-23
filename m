From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 23 Feb 2016 14:34:23 +0000
Subject: [PATCH v4 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <1456238068-25079-1-git-send-email-vladimir.murzin@arm.com>
References: <1456238068-25079-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1456238068-25079-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support early console for MPS2 UART which can be enabled via
earlycon=mps2,0x40004000

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/tty/serial/Kconfig     |    1 +
 drivers/tty/serial/mps2-uart.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3a248be..4ed6e51 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1454,6 +1454,7 @@ config SERIAL_MPS2_UART_CONSOLE
 	bool "MPS2 UART console support"
 	depends on SERIAL_MPS2_UART
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 
 config SERIAL_MPS2_UART
 	bool "MPS2 UART port"
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 5a4e167..4f42326 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -439,6 +439,34 @@ static struct console mps2_uart_console = {
 
 #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
 
+static void mps2_early_putchar(struct uart_port *port, int ch)
+{
+
+	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
+		cpu_relax();
+
+	writeb((unsigned char)ch, port->membase + UARTn_DATA);
+}
+
+static void mps2_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, mps2_early_putchar);
+}
+
+static int __init mps2_early_console_setup(struct earlycon_device *device,
+					   const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = mps2_early_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(mps2, "arm,mps2-uart", mps2_early_console_setup);
+
 #else
 #define MPS2_SERIAL_CONSOLE NULL
 #endif
-- 
1.7.9.5
