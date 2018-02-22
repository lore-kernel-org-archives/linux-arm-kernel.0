From: gabriel.matni@exfo.com (Gabriel Matni)
Date: Thu, 22 Feb 2018 20:30:56 +0000
Subject: [PATCH] serial: mvebu_uart: fix tx lost characters
Message-ID: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Matni <gabriel.matni@exfo.com>

Fixes missing characters on kernel console at low baud rates (i.e.9600).
The driver should poll TX_RDY instead of TX_EMPTY to ensure that the
transmitter holding is ready to receive a new byte. Polling TX_EMPTY isn't
enough as the hardware buffer can become empty but not yet ready for CPU to
write the next byte.

Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>
---
drivers/tty/serial/mvebu-uart.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index a100e98259d7..f0df0640208e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
   u32 val;

   readl_poll_timeout_atomic(port->membase + UART_STAT, val,
-             (val & STAT_TX_EMP), 1, 10000);
+             (val & STAT_TX_RDY(port)), 1, 10000);
}

static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
--
2.7.4
