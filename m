From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:18 +0000
Subject: [PATCH 8/9] ARM: meson: serial: ensure tx irq on if more work to do
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1447857679-30158-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tx_stop() call turns the interrupt off, but the tx_start() does not
check if the interrupt is enabled. Switch it back on if there is more
work to do.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 12436cc..6c36526 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -144,6 +144,7 @@ static void meson_uart_start_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int ch;
+	u32 val;
 
 	if (uart_tx_stopped(port)) {
 		meson_uart_stop_tx(port);
@@ -167,6 +168,12 @@ static void meson_uart_start_tx(struct uart_port *port)
 		port->icount.tx++;
 	}
 
+	if (!uart_circ_empty(xmit)) {
+		val = readl(port->membase + AML_UART_CONTROL);
+		val |= AML_UART_TX_INT_EN;
+		writel(val, port->membase + AML_UART_CONTROL);
+	}
+
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 }
-- 
2.6.2
