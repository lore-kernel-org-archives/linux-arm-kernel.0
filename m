From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 2 Feb 2010 09:02:18 +0530
Subject: [PATCH] amba-pl011: support hardware flow control
Message-ID: <mailman.201.1265809553.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable/disable automatic hardware flow control as requested by the
termios.  The controller does not allow us to control the RTS line when
auto-RTS is enabled, so we enable auto-RTS only if the kernel has not
disabled RTS.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/serial/amba-pl011.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index ef7adc8..ce6c353 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -71,6 +71,7 @@ struct uart_amba_port {
 	unsigned int		im;	/* interrupt mask */
 	unsigned int		old_status;
 	unsigned int		ifls;	/* vendor-specific */
+	bool			autorts;
 };
 
 /* There is by now at least one vendor with differing details, so handle it */
@@ -308,6 +309,11 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	TIOCMBIT(TIOCM_OUT1, UART011_CR_OUT1);
 	TIOCMBIT(TIOCM_OUT2, UART011_CR_OUT2);
 	TIOCMBIT(TIOCM_LOOP, UART011_CR_LBE);
+
+	if (uap->autorts) {
+		/* We need to disable auto-RTS if we want to turn RTS off */
+		TIOCMBIT(TIOCM_RTS, UART011_CR_RTSEN);
+	}
 #undef TIOCMBIT
 
 	writew(cr, uap->port.membase + UART011_CR);
@@ -437,6 +443,7 @@ static void pl011_shutdown(struct uart_port *port)
 	/*
 	 * disable the port
 	 */
+	uap->autorts = false;
 	writew(UART01x_CR_UARTEN | UART011_CR_TXE, uap->port.membase + UART011_CR);
 
 	/*
@@ -456,6 +463,7 @@ static void
 pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		     struct ktermios *old)
 {
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int lcr_h, old_cr;
 	unsigned long flags;
 	unsigned int baud, quot;
@@ -532,6 +540,17 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	old_cr = readw(port->membase + UART011_CR);
 	writew(0, port->membase + UART011_CR);
 
+	if (termios->c_cflag & CRTSCTS) {
+		if (old_cr & UART011_CR_RTS)
+			old_cr |= UART011_CR_RTSEN;
+
+		old_cr |= UART011_CR_CTSEN;
+		uap->autorts = true;
+	} else {
+		old_cr &= ~(UART011_CR_CTSEN | UART011_CR_RTSEN);
+		uap->autorts = false;
+	}
+
 	/* Set baud rate */
 	writew(quot & 0x3f, port->membase + UART011_FBRD);
 	writew(quot >> 6, port->membase + UART011_IBRD);
-- 
1.6.5.3
