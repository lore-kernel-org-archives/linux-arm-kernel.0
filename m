From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 1 Jun 2010 11:47:59 +0200
Subject: [PATCH 1/2] ARM: PL011 TX/RX split of LCR for ST-Ericssons derivative
Message-ID: <1275385679-1526-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>

In the ST-Ericsson version of the PL011 the TX and RX have different
control registers.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/serial/amba-pl011.c |   61 +++++++++++++++++++++++++++++++++++--------
 include/linux/amba/serial.h |    2 +
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index eb4cb48..7f0c271 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -69,9 +69,11 @@
 struct uart_amba_port {
 	struct uart_port	port;
 	struct clk		*clk;
-	unsigned int		im;	/* interrupt mask */
+	unsigned int		im;		/* interrupt mask */
 	unsigned int		old_status;
-	unsigned int		ifls;	/* vendor-specific */
+	unsigned int		ifls;		/* vendor-specific */
+	unsigned int            lcrh_tx;        /* vendor-specific */
+	unsigned int            lcrh_rx;        /* vendor-specific */
 	bool			autorts;
 };
 
@@ -79,16 +81,22 @@ struct uart_amba_port {
 struct vendor_data {
 	unsigned int		ifls;
 	unsigned int		fifosize;
+	unsigned int            lcrh_tx;
+	unsigned int            lcrh_rx;
 };
 
 static struct vendor_data vendor_arm = {
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
 	.fifosize		= 16,
+	.lcrh_tx                = UART011_LCRH,
+	.lcrh_rx                = UART011_LCRH,
 };
 
 static struct vendor_data vendor_st = {
 	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
 	.fifosize		= 64,
+	.lcrh_tx                = ST_UART011_LCRH_TX,
+	.lcrh_rx                = ST_UART011_LCRH_RX,
 };
 
 static void pl011_stop_tx(struct uart_port *port)
@@ -327,12 +335,12 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	unsigned int lcr_h;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	lcr_h = readw(uap->port.membase + UART011_LCRH);
+	lcr_h = readw(uap->port.membase + uap->lcrh_tx);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
-	writew(lcr_h, uap->port.membase + UART011_LCRH);
+	writew(lcr_h, uap->port.membase + uap->lcrh_tx);
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
@@ -393,7 +401,17 @@ static int pl011_startup(struct uart_port *port)
 	writew(cr, uap->port.membase + UART011_CR);
 	writew(0, uap->port.membase + UART011_FBRD);
 	writew(1, uap->port.membase + UART011_IBRD);
-	writew(0, uap->port.membase + UART011_LCRH);
+	writew(0, uap->port.membase + uap->lcrh_rx);
+	if (uap->lcrh_tx != uap->lcrh_rx) {
+                int i;
+                /*
+                 * Wait 10 PCLKs before writing LCRH_TX register,
+                 * to get this delay write read only register 10 times
+                 */
+                for (i = 0; i < 10; ++i)
+                        writew(0xff, uap->port.membase + UART011_MIS);
+                writew(0, uap->port.membase + uap->lcrh_tx);
+	}
 	writew(0, uap->port.membase + UART01x_DR);
 	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
 		barrier();
@@ -422,10 +440,19 @@ static int pl011_startup(struct uart_port *port)
 	return retval;
 }
 
+static void pl011_shutdown_channel(struct uart_amba_port *uap,
+					unsigned int lcrh)
+{
+      unsigned long val;
+
+      val = readw(uap->port.membase + lcrh);
+      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
+      writew(val, uap->port.membase + lcrh);
+}
+
 static void pl011_shutdown(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
-	unsigned long val;
 
 	/*
 	 * disable all interrupts
@@ -450,9 +477,9 @@ static void pl011_shutdown(struct uart_port *port)
 	/*
 	 * disable break condition and fifos
 	 */
-	val = readw(uap->port.membase + UART011_LCRH);
-	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
-	writew(val, uap->port.membase + UART011_LCRH);
+	pl011_shutdown_channel(uap, uap->lcrh_rx);
+	if (uap->lcrh_rx != uap->lcrh_tx)
+		pl011_shutdown_channel(uap, uap->lcrh_tx);
 
 	/*
 	 * Shut down the clock producer
@@ -561,7 +588,17 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * NOTE: MUST BE WRITTEN AFTER UARTLCR_M & UARTLCR_L
 	 * ----------^----------^----------^----------^-----
 	 */
-	writew(lcr_h, port->membase + UART011_LCRH);
+	writew(lcr_h, port->membase + uap->lcrh_rx);
+	if (uap->lcrh_rx != uap->lcrh_tx) {
+                int i;
+                /*
+                 * Wait 10 PCLKs before writing LCRH_TX register,
+                 * to get this delay write read only register 10 times
+                 */
+                for (i = 0; i < 10; ++i)
+                        writew(0xff, uap->port.membase + UART011_MIS);
+		writew(lcr_h, port->membase + uap->lcrh_tx);
+	}
 	writew(old_cr, port->membase + UART011_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -688,7 +725,7 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 	if (readw(uap->port.membase + UART011_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
 
-		lcr_h = readw(uap->port.membase + UART011_LCRH);
+		lcr_h = readw(uap->port.membase + uap->lcrh_tx);
 
 		*parity = 'n';
 		if (lcr_h & UART01x_LCRH_PEN) {
@@ -800,6 +837,8 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	}
 
 	uap->ifls = vendor->ifls;
+	uap->lcrh_rx = vendor->lcrh_rx;
+	uap->lcrh_tx = vendor->lcrh_tx;
 	uap->port.dev = &dev->dev;
 	uap->port.mapbase = dev->res.start;
 	uap->port.membase = base;
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 5a5a7fd..cf3cb61 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -38,10 +38,12 @@
 #define UART01x_FR		0x18	/* Flag register (Read only). */
 #define UART010_IIR		0x1C	/* Interrupt indentification register (Read). */
 #define UART010_ICR		0x1C	/* Interrupt clear register (Write). */
+#define ST_UART011_LCRH_RX      0x1C    /* Rx line control register. */
 #define UART01x_ILPR		0x20	/* IrDA low power counter register. */
 #define UART011_IBRD		0x24	/* Integer baud rate divisor register. */
 #define UART011_FBRD		0x28	/* Fractional baud rate divisor register. */
 #define UART011_LCRH		0x2c	/* Line control register. */
+#define ST_UART011_LCRH_TX      0x2c    /* Tx Line control register. */
 #define UART011_CR		0x30	/* Control register. */
 #define UART011_IFLS		0x34	/* Interrupt fifo level select. */
 #define UART011_IMSC		0x38	/* Interrupt mask. */
-- 
1.6.3.3
