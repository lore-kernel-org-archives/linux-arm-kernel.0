From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:15 +0000
Subject: [PATCH 5/9] ARM: meson: serial: only disable tx irq on stop
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1447857679-30158-6-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since disabling the transmit state machine still allows characters to
be transmitted when written to the UART write FIFO, simply disable the
transmit interrupt when the UART port is stopped.

This has not shown an improvement with the console issues when running
systemd, but seems like it should be done.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Edward Cragg <ed.cragg@codethink.co.uk>
---
---
 drivers/tty/serial/meson_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index c7bad2b..9327efd 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -110,7 +110,7 @@ static void meson_uart_stop_tx(struct uart_port *port)
 	u32 val;
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	val &= ~AML_UART_TX_EN;
+	val &= ~AML_UART_TX_INT_EN;
 	writel(val, port->membase + AML_UART_CONTROL);
 }
 
@@ -133,7 +133,7 @@ static void meson_uart_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
+	val &= ~AML_UART_RX_EN;
 	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
 	writel(val, port->membase + AML_UART_CONTROL);
 
-- 
2.6.2
