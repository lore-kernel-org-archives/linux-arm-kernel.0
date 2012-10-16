From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Oct 2012 12:01:27 +0100
Subject: [PATCH 11/11] SERIAL: omap: fix hardware assisted flow control
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <E1TO4tr-0000Wp-Bf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the UART device has hardware flow control enabled, it ignores the
MCR RTS bit in the MCR register, and keeps RTS asserted as long as we
continue to read characters from the UART receiver FIFO.  This means
that when the TTY buffers become full, the UART doesn't tell the remote
end to stop sending, which causes the TTY layer to start dropping
characters.

A similar problem exists with software flow control.  We need the FIFO
register to fill when software flow control is enabled to provoke the
UART to send the XOFF character.

Fix this by implementing the throttle/unthrottle callbacks, and use
these to disable receiver interrupts.  This in turn means that the UART
FIFO will fill, which will then cause the UART's hardware to deassert
the RTS signal and/or send the XOFF character, stopping the remote end.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7cc151c..aabc94d 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -303,6 +303,34 @@ static void serial_omap_start_tx(struct uart_port *port)
 	pm_runtime_put_autosuspend(up->dev);
 }
 
+static void serial_omap_throttle(struct uart_port *port)
+{
+	struct uart_omap_port *up = to_uart_omap_port(port);
+	unsigned long flags;
+
+	pm_runtime_get_sync(up->dev);
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(up->dev);
+	pm_runtime_put_autosuspend(up->dev);
+}
+
+static void serial_omap_unthrottle(struct uart_port *port)
+{
+	struct uart_omap_port *up = to_uart_omap_port(port);
+	unsigned long flags;
+
+	pm_runtime_get_sync(up->dev);
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(up->dev);
+	pm_runtime_put_autosuspend(up->dev);
+}
+
 static unsigned int check_modem_status(struct uart_omap_port *up)
 {
 	unsigned int status;
@@ -1000,6 +1028,7 @@ static void serial_omap_config_port(struct uart_port *port, int flags)
 	dev_dbg(up->port.dev, "serial_omap_config_port+%d\n",
 							up->port.line);
 	up->port.type = PORT_OMAP;
+	up->port.flags |= UPF_SOFT_FLOW | UPF_HARD_FLOW;
 }
 
 static int
@@ -1203,6 +1232,8 @@ static struct uart_ops serial_omap_pops = {
 	.get_mctrl	= serial_omap_get_mctrl,
 	.stop_tx	= serial_omap_stop_tx,
 	.start_tx	= serial_omap_start_tx,
+	.throttle	= serial_omap_throttle,
+	.unthrottle	= serial_omap_unthrottle,
 	.stop_rx	= serial_omap_stop_rx,
 	.enable_ms	= serial_omap_enable_ms,
 	.break_ctl	= serial_omap_break_ctl,
-- 
1.7.4.4
