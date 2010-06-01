From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 1 Jun 2010 11:48:18 +0200
Subject: [PATCH 2/2] ARM: PL011 baudrate extension for ST-Ericssons derivative
Message-ID: <1275385698-1599-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>

Implementation of the ST-Ericsson baudrate extension in the PL011
block. In this modified variant it is possible to change the
sampling factor from 16 to 8, and thanks to this we can get higher
baudrates while still using the same peripheral clock.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/serial/amba-pl011.c |   27 +++++++++++++++++++++++++--
 include/linux/amba/serial.h |    1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 7f0c271..ed4ab21 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -74,6 +74,7 @@ struct uart_amba_port {
 	unsigned int		ifls;		/* vendor-specific */
 	unsigned int            lcrh_tx;        /* vendor-specific */
 	unsigned int            lcrh_rx;        /* vendor-specific */
+	bool		        oversampling;   /* vendor-specific */
 	bool			autorts;
 };
 
@@ -83,6 +84,7 @@ struct vendor_data {
 	unsigned int		fifosize;
 	unsigned int            lcrh_tx;
 	unsigned int            lcrh_rx;
+	bool		        oversampling;
 };
 
 static struct vendor_data vendor_arm = {
@@ -90,6 +92,7 @@ static struct vendor_data vendor_arm = {
 	.fifosize		= 16,
 	.lcrh_tx                = UART011_LCRH,
 	.lcrh_rx                = UART011_LCRH,
+        .oversampling	        = false,
 };
 
 static struct vendor_data vendor_st = {
@@ -97,6 +100,7 @@ static struct vendor_data vendor_st = {
 	.fifosize		= 64,
 	.lcrh_tx                = ST_UART011_LCRH_TX,
 	.lcrh_rx                = ST_UART011_LCRH_RX,
+        .oversampling	        = true,
 };
 
 static void pl011_stop_tx(struct uart_port *port)
@@ -499,8 +503,13 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
-	quot = port->uartclk * 4 / baud;
+        baud = uart_get_baud_rate(port, termios, old, 0,
+                                  port->uartclk/(uap->oversampling?8:16));
+
+        if (baud > port->uartclk/16)
+                quot = port->uartclk * 8 / baud;
+        else
+                quot = port->uartclk * 4 / baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -579,6 +588,13 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		uap->autorts = false;
 	}
 
+        if (uap->oversampling) {
+                if (baud > port->uartclk/16)
+                        old_cr |= ST_UART011_CR_OVSFACT;
+                else
+                        old_cr &= ~ST_UART011_CR_OVSFACT;
+        }
+
 	/* Set baud rate */
 	writew(quot & 0x3f, port->membase + UART011_FBRD);
 	writew(quot >> 6, port->membase + UART011_IBRD);
@@ -744,6 +760,12 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 		fbrd = readw(uap->port.membase + UART011_FBRD);
 
 		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
+
+		if (uap->oversampling) {
+			if (readw(uap->port.membase + UART011_CR)
+				  & ST_UART011_CR_OVSFACT)
+				*baud *= 2;
+		}
 	}
 }
 
@@ -839,6 +861,7 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	uap->ifls = vendor->ifls;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
+        uap->oversampling = vendor->oversampling;
 	uap->port.dev = &dev->dev;
 	uap->port.mapbase = dev->res.start;
 	uap->port.membase = base;
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index cf3cb61..a87c6a5 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -86,6 +86,7 @@
 #define UART010_CR_TIE 		0x0020
 #define UART010_CR_RIE 		0x0010
 #define UART010_CR_MSIE		0x0008
+#define ST_UART011_CR_OVSFACT	0x0008	/* Oversampling factor */
 #define UART01x_CR_IIRLP	0x0004	/* SIR low power mode */
 #define UART01x_CR_SIREN	0x0002	/* SIR enable */
 #define UART01x_CR_UARTEN	0x0001	/* UART enable */
-- 
1.6.3.3
