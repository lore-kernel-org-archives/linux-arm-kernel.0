From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 10:08:58 +0000
Subject: [PATCH 3/7] ARM: PL011: Allow better handling of vendor data
In-Reply-To: <20110103100753.GB26785@n2100.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
Message-ID: <E1PZhLW-0007pZ-Tq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than copying all vendor data into the port structure, copy
just that which is frequently used, and keep a pointer to the
remaining vendor data structure.  This makes it easier to add
vendor quirks in the future.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |   51 ++++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index c77b3eb..6afdd9b 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -63,22 +63,6 @@
 #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
 #define UART_DUMMY_DR_RX	(1 << 16)
 
-/*
- * We wrap our port structure around the generic uart_port.
- */
-struct uart_amba_port {
-	struct uart_port	port;
-	struct clk		*clk;
-	unsigned int		im;		/* interrupt mask */
-	unsigned int		old_status;
-	unsigned int		ifls;		/* vendor-specific */
-	unsigned int		lcrh_tx;	/* vendor-specific */
-	unsigned int		lcrh_rx;	/* vendor-specific */
-	bool			oversampling;   /* vendor-specific */
-	bool			autorts;
-	char			type[12];
-};
-
 /* There is by now@least one vendor with differing details, so handle it */
 struct vendor_data {
 	unsigned int		ifls;
@@ -104,6 +88,21 @@ static struct vendor_data vendor_st = {
 	.oversampling		= true,
 };
 
+/*
+ * We wrap our port structure around the generic uart_port.
+ */
+struct uart_amba_port {
+	struct uart_port	port;
+	struct clk		*clk;
+	const struct vendor_data *vendor;
+	unsigned int		im;		/* interrupt mask */
+	unsigned int		old_status;
+	unsigned int		lcrh_tx;	/* vendor-specific */
+	unsigned int		lcrh_rx;	/* vendor-specific */
+	bool			autorts;
+	char			type[12];
+};
+
 static void pl011_stop_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -397,7 +396,7 @@ static int pl011_startup(struct uart_port *port)
 	if (retval)
 		goto clk_dis;
 
-	writew(uap->ifls, uap->port.membase + UART011_IFLS);
+	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
 	/*
 	 * Provoke TX FIFO interrupt into asserting.
@@ -503,13 +502,18 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int lcr_h, old_cr;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, clkdiv;
+
+	if (uap->vendor->oversampling)
+		clkdiv = 8;
+	else
+		clkdiv = 16;
 
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
 	baud = uart_get_baud_rate(port, termios, old, 0,
-				  port->uartclk/(uap->oversampling ? 8 : 16));
+				  port->uartclk / clkdiv);
 
 	if (baud > port->uartclk/16)
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
@@ -593,8 +597,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		uap->autorts = false;
 	}
 
-	if (uap->oversampling) {
-		if (baud > port->uartclk/16)
+	if (uap->vendor->oversampling) {
+		if (baud > port->uartclk / 16)
 			old_cr |= ST_UART011_CR_OVSFACT;
 		else
 			old_cr &= ~ST_UART011_CR_OVSFACT;
@@ -767,7 +771,7 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 
 		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
 
-		if (uap->oversampling) {
+		if (uap->vendor->oversampling) {
 			if (readw(uap->port.membase + UART011_CR)
 				  & ST_UART011_CR_OVSFACT)
 				*baud *= 2;
@@ -864,10 +868,9 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 		goto unmap;
 	}
 
-	uap->ifls = vendor->ifls;
+	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
-	uap->oversampling = vendor->oversampling;
 	uap->port.dev = &dev->dev;
 	uap->port.mapbase = dev->res.start;
 	uap->port.membase = base;
-- 
1.6.2.5
