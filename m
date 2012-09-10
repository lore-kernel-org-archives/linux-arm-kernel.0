From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun, 9 Sep 2012 21:11:54 -0700
Subject: [PATCH 01/14] serial/amba-pl011: fix ages old copy-paste errors
In-Reply-To: <20120910040802.GA1261@lizard>
References: <20120910040802.GA1261@lizard>
Message-ID: <20120910041154.GA29537@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The PL011 driver has a number of symbols referring to "pl01x"
(probably once shared with the pl010 driver) and some even named
"pl010" (probably a pure copy-paste artifact). Lets name all
local static functions with the prefix pl011_* for clarity.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---

The patch was taken from the TTY tree.

If this patch rejects because 'already applied', this means that your
tree is probably based on TTY tree or -next (e.g. -mm). In which case
you don't need this patch, just drop it.

If your tree is based on Linus' tree, you need this patch to not bring
horrible conflicts into -next.

 drivers/tty/serial/amba-pl011.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d3553b5..92b1ac8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1215,14 +1215,14 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static unsigned int pl01x_tx_empty(struct uart_port *port)
+static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status = readw(uap->port.membase + UART01x_FR);
 	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
 }
 
-static unsigned int pl01x_get_mctrl(struct uart_port *port)
+static unsigned int pl011_get_mctrl(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int result = 0;
@@ -1285,7 +1285,7 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-static int pl010_get_poll_char(struct uart_port *port)
+static int pl011_get_poll_char(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status;
@@ -1297,7 +1297,7 @@ static int pl010_get_poll_char(struct uart_port *port)
 	return readw(uap->port.membase + UART01x_DR);
 }
 
-static void pl010_put_poll_char(struct uart_port *port,
+static void pl011_put_poll_char(struct uart_port *port,
 			 unsigned char ch)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1637,7 +1637,7 @@ static const char *pl011_type(struct uart_port *port)
 /*
  * Release the memory region(s) being used by 'port'
  */
-static void pl010_release_port(struct uart_port *port)
+static void pl011_release_port(struct uart_port *port)
 {
 	release_mem_region(port->mapbase, SZ_4K);
 }
@@ -1645,7 +1645,7 @@ static void pl010_release_port(struct uart_port *port)
 /*
  * Request the memory region(s) being used by 'port'
  */
-static int pl010_request_port(struct uart_port *port)
+static int pl011_request_port(struct uart_port *port)
 {
 	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
 			!= NULL ? 0 : -EBUSY;
@@ -1654,18 +1654,18 @@ static int pl010_request_port(struct uart_port *port)
 /*
  * Configure/autoconfigure the port.
  */
-static void pl010_config_port(struct uart_port *port, int flags)
+static void pl011_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		port->type = PORT_AMBA;
-		pl010_request_port(port);
+		pl011_request_port(port);
 	}
 }
 
 /*
  * verify the new serial_struct (for TIOCSSERIAL).
  */
-static int pl010_verify_port(struct uart_port *port, struct serial_struct *ser)
+static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
@@ -1678,9 +1678,9 @@ static int pl010_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 static struct uart_ops amba_pl011_pops = {
-	.tx_empty	= pl01x_tx_empty,
+	.tx_empty	= pl011_tx_empty,
 	.set_mctrl	= pl011_set_mctrl,
-	.get_mctrl	= pl01x_get_mctrl,
+	.get_mctrl	= pl011_get_mctrl,
 	.stop_tx	= pl011_stop_tx,
 	.start_tx	= pl011_start_tx,
 	.stop_rx	= pl011_stop_rx,
@@ -1691,13 +1691,13 @@ static struct uart_ops amba_pl011_pops = {
 	.flush_buffer	= pl011_dma_flush_buffer,
 	.set_termios	= pl011_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl010_release_port,
-	.request_port	= pl010_request_port,
-	.config_port	= pl010_config_port,
-	.verify_port	= pl010_verify_port,
+	.release_port	= pl011_release_port,
+	.request_port	= pl011_request_port,
+	.config_port	= pl011_config_port,
+	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
-	.poll_get_char = pl010_get_poll_char,
-	.poll_put_char = pl010_put_poll_char,
+	.poll_get_char = pl011_get_poll_char,
+	.poll_put_char = pl011_put_poll_char,
 #endif
 };
 
-- 
1.7.11.5
