From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 21 Sep 2012 19:59:59 +0200
Subject: [PATCH] RFC: serial: pl011: allow very high baudrates
Message-ID: <1348250399-5651-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The ST Microelectronics variant of the PL011 is capable of supporting
very high non-standard baud rates, even above 4 Mbps. Mostly this
works, but when we try to use 4050000 baud, the code in
tty_termios_encode_baud_rate(), which is called from
uart_get_baud_rate() will do some fuzzy matching and "snap" the
baudrate to 4000000 baud, which happens to be in the baud_table[].

However there is an encouraging comment from Alan Cox above the
tty_termios_input_baud_rate() function stating that device
drivers should use ->c_[io]speed directly as they are updated.

I tried this, but that requires the driver to handle a few
odd cases such as when the ->c_ispeed and ->c_ospeed differs,
or when they are both send it as 0 (which happens a lot in
the kernel) so that would require pushing a lot of duplicate
code into the driver to get the same behaviour.

Here I take a middle-ground approach: if the baud rate of
->c_ispeed and ->c_ospeed differs, or if either of them is
zero, I still call the uart_get_baud_rate() function, but
root the baudrate to what the block can handle at max.

Cc: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Signed-off-by: Guillaume Jaunet <guillaume.jaunet@stericsson.com>
Signed-off-by: Christophe Arnal <christophe.arnal@stericsson.com>
Signed-off-by: Matthias Locher <matthias.locher@stericsson.com>
Signed-off-by: Rajanikanth HV <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
After discussing with Alan and Russell I still don't feel this
is the right solution, but it demonstrates Russell's point of
how intelligence (here just some checking of ->c_[io]speed,
but you get the point) is moved out of the serial/tty core and
out into the drivers if we do this.

Maybe a new function is needed in the serial core, one that
will just call out to serial and tty like this if the c_[io]speed
differs or either is zero?
---
 drivers/tty/serial/amba-pl011.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cb9f694..778a6a5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1492,18 +1492,36 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int lcr_h, old_cr;
 	unsigned long flags;
-	unsigned int baud, quot, clkdiv;
+	unsigned int max_baud, baud, quot;
 
 	if (uap->vendor->oversampling)
-		clkdiv = 8;
+		max_baud = port->uartclk / 8;
 	else
-		clkdiv = 16;
+		max_baud = port->uartclk / 16;
 
 	/*
-	 * Ask the core to calculate the divisor for us.
+	 * For "zero" speeds or in the case where in and output
+	 * speed differs, fall back on using the serial core to
+	 * determine applicable baudrate.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0,
-				  port->uartclk / clkdiv);
+	if ((termios->c_ispeed != termios->c_ospeed) ||
+	    (termios->c_ispeed == 0) ||
+	    (termios->c_ospeed == 0))
+		baud = uart_get_baud_rate(port, termios, old, 0,
+					  max_baud);
+	else {
+		/*
+		 * Else we just use the requested speed from
+		 * termios. But we sanity check it so as not to
+		 * exceed hardware limits.
+		 */
+		baud = termios->c_ospeed;
+		if (baud > max_baud)
+			baud = max_baud;
+	}
+	dev_dbg(uap->port.dev, "c_ispeed: %u, c_ospeed: %u, "
+		"max_baud: %u, resulting baud rate %u bps\n",
+		termios->c_ispeed, termios->c_ospeed, max_baud, baud);
 
 	if (baud > port->uartclk/16)
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
-- 
1.7.11.3
