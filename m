From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 06 Oct 2012 13:44:46 +0100
Subject: [RFC 17/24] SERIAL: omap: always set TCR
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <E1TKTkM-0002nW-Mp@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We always setup the TCR register in the software flow control path,
and when hardware flow control is enabled.  Remove this redundant
setup, and place it before we setup any hardware flow control.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index da0d4b1..22877ac 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -871,30 +871,29 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
-	/* Hardware Flow Control Configuration */
+	/* Enable access to TCR/TLR */
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 
-	if (termios->c_cflag & CRTSCTS) {
-		/* Enable access to TCR/TLR */
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-		serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
+	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
 
-		serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
+	/* Hardware Flow Control Configuration */
 
+	if (termios->c_cflag & CRTSCTS) {
 		/* Enable AUTORTS and AUTOCTS */
 		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
 
 		/* Ensure MCR RTS is asserted */
 		up->mcr |= UART_MCR_RTS;
-
-		/* Disable access to TCR/TLR */
-		serial_out(up, UART_MCR, up->mcr);
 	} else {
 		/* Disable AUTORTS and AUTOCTS */
 		up->efr &= ~(UART_EFR_CTS | UART_EFR_RTS);
 	}
 
+	/* Disable access to TCR/TLR */
+	serial_out(up, UART_MCR, up->mcr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, up->efr);
 
@@ -934,10 +933,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		up->mcr &= ~UART_MCR_XONANY;
 
-	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, up->efr);
-- 
1.7.4.4
