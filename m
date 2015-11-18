From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:17 +0000
Subject: [PATCH 7/9] ARM: meson: serial: disable rx/tx irqs during console
 write
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1447857679-30158-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As an attempt to stop issues with bad console output, ensure that both the
rx and tx interrupts are disabled during the console write to avoid any
problems with console and non-console being called together.

This should help with the SMP case as it should stop other cores being
signalled during the console write.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d3f2c96..12436cc 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -472,7 +472,7 @@ static void meson_serial_console_write(struct console *co, const char *s,
 	struct uart_port *port;
 	unsigned long flags;
 	int locked;
-	u32 val;
+	u32 val, tmp;
 
 	port = meson_ports[co->index];
 	if (!port)
@@ -489,9 +489,12 @@ static void meson_serial_console_write(struct console *co, const char *s,
 	}
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	writel(val | AML_UART_TX_EN, port->membase + AML_UART_CONTROL);
+	val |= AML_UART_TX_EN;
+	tmp = val & ~(AML_UART_TX_INT_EN | AML_UART_RX_INT_EN);
+	writel(tmp, port->membase + AML_UART_CONTROL);
 
 	uart_console_write(port, s, count, meson_console_putchar);
+	writel(val, port->membase + AML_UART_CONTROL);
 
 	if (locked)
 		spin_unlock(&port->lock);
-- 
2.6.2
