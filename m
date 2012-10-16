From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Oct 2012 12:01:06 +0100
Subject: [PATCH 10/11] SERIAL: omap: fix MCR TCRTLR bit handling
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <E1TO4tW-0000Wl-SY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MCR TCRTLR bit can only be changed when ECB is set in the EFR.
Unfortunately, several places were trying to alter this bit while ECB
was clear:

- serial_omap_configure_xonxoff() was attempting to clear the bit after
  explicitly clearing the ECB bit.
- serial_omap_set_termios() was trying the same trick after setting the
  SCR, and when trying to change the TCR register when hardware flow
  control was enabled.

Fix this by ensuring that we always have ECB set whenever the TCRTLR bit
is changed.

Moreover, we start out by reading the EFR and MCR registers, which may
have indeterminent bit settings for the ECB and TCRTLR bits.  Ensure
that these bits always start off in a known state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 537829f..7cc151c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -706,9 +706,10 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
 }
 
@@ -729,7 +730,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned char cval = 0;
-	unsigned char efr = 0;
 	unsigned long flags = 0;
 	unsigned int baud, quot;
 
@@ -839,12 +839,12 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	up->efr = serial_in(up, UART_EFR);
+	up->efr = serial_in(up, UART_EFR) & ~UART_EFR_ECB;
 	up->efr &= ~UART_EFR_SCD;
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-	up->mcr = serial_in(up, UART_MCR);
+	up->mcr = serial_in(up, UART_MCR) & ~UART_MCR_TCRTLR;
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	/* FIFO ENABLE, DMA MODE */
 
@@ -863,9 +863,12 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_out(up, UART_OMAP_SCR, up->scr);
 
-	serial_out(up, UART_EFR, up->efr);
+	/* Reset UART_MCR_TCRTLR: this must be done with the EFR_ECB bit set */
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
 
@@ -904,20 +907,21 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Hardware Flow Control Configuration */
 
 	if (termios->c_cflag & CRTSCTS) {
-		efr |= (UART_EFR_CTS | UART_EFR_RTS);
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-
-		up->mcr = serial_in(up, UART_MCR);
-		serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
-
+		/* Enable access to TCR/TLR */
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		up->efr = serial_in(up, UART_EFR);
 		serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+		serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 
 		serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-		serial_out(up, UART_EFR, efr); /* Enable AUTORTS and AUTOCTS */
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+
+		/* Enable AUTORTS and AUTOCTS */
+		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
+
+		/* Disable access to TCR/TLR */
 		serial_out(up, UART_MCR, up->mcr | UART_MCR_RTS);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, up->efr);
 		serial_out(up, UART_LCR, cval);
 	} else {
 		/* Disable AUTORTS and AUTOCTS */
-- 
1.7.4.4
