From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 20 Sep 2012 11:46:08 +0200
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
Message-ID: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The ST Microelectronics variant of the PL011 is capable of supporting
very high non-standard baud rates, even above 4 Mbps. However the
uart_get_baud_rate() will not allow us to set these, so override that
calculation on very high speeds.

Cc: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Signed-off-by: Guillaume Jaunet <guillaume.jaunet@stericsson.com>
Signed-off-by: Christophe Arnal <christophe.arnal@stericsson.com>
Signed-off-by: Matthias Locher <matthias.locher@stericsson.com>
Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 32240a7..8ac1a42 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1507,10 +1507,19 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/*
-	 * Ask the core to calculate the divisor for us.
+	 * Override baud calculation for very high non-standard baudrates
+	 * on the ST Micro oversampling variant. This must override the
+	 * uart_get_baud_rate() call, because this function changes
+	 * baudrate to the default on these baudrates.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0,
-				  max_baud);
+	if (uap->vendor->oversampling &&
+	    ((termios->c_ispeed > 4000000) ||
+	     (termios->c_ospeed > 4000000)))
+		baud = termios->c_ispeed;
+	else
+		/* Ask the core to calculate the divisor for us. */
+		baud = uart_get_baud_rate(port, termios, old, 0,
+					  max_baud);
 
 	if (baud > port->uartclk/16)
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
-- 
1.7.11.3
