From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Mar 2014 18:47:52 -0500
Subject: UART 8250 and HW Flow Control
Message-ID: <20140320234752.GA26964@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

long ago you wrote a patch (see below) which converted TI16C750 flow
control quirk into a capability flag followed by a fifosize check.

I've tried to fully understand the rationale behind that commit and,
specifically why 32 bytes. If I understood correctly the problem is that
RTS goes low as soon as FIFO Trigger Level is reached which means that
if the far end isn't fast enough, it might miss our Request To Send.

But then, this causes a problem for UARTs with small FIFOs. I mean, if
the far end _does_ use auto-CTS, then we could enable auto-RTS in our
side, but that commit prevents that unless we patch that check.

Right now we're dealing with a use case which is using a BT device over
UART at 3Mbaud and the UART on the SoC has 16 bytes of FIFO (it's a
16550a compatible UART).

Our first (quickest, dirtiest, crappiest) option is to just change 32
into 16 get it over with. HW Flow Control gets enabled and everybody is
happy, soon after that "what ifs" started to pop :-)

I wonder if a better (albeit with impact to performance, probably)
approach would be to patch tty_{un,}throttle() so that we don't write
an ammount >= FIFO_TRIGGER_LEVEL in affected UARTs, but that doesn't
sound very nice either, or does it ?

Do you have any extra insider's information about the reason for that
patch and/or any suggestions on how to patch it in a better way ?

I know it's an old commit (took it from historic Linux tree) but worth
asking anyway.

commit 1ad14ded82602e3753c724ce4647b44faf4dc658
Author: Russell King <rmk@flint.arm.linux.org.uk>
Date:   Tue Oct 19 16:37:05 2004 +0100

    [SERIAL] Convert TI16C750 flow control into a port capability.
    
    Add UART_CAP_AFE, and use this to enable TI16C750 flow control,
    but only if we have 32 bytes or more of FIFO.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 6e2e62d..7e63a7f 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -210,7 +210,7 @@ static const struct serial8250_config uart_config[] = {
 		.tx_loadsz	= 64,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
 				  UART_FCR7_64BYTE,
-		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
+		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_AFE,
 	},
 	[PORT_STARTECH] = {
 		.name		= "Startech",
@@ -1584,11 +1584,14 @@ serial8250_set_termios(struct uart_port *port, struct termios *termios,
 	}
 
 	/*
-	 * TI16C750: hardware flow control and 64 byte FIFOs. When AFE is
-	 * enabled, RTS will be deasserted when the receive FIFO contains
-	 * more characters than the trigger, or the MCR RTS bit is cleared.
+	 * MCR-based auto flow control.  When AFE is enabled, RTS will be
+	 * deasserted when the receive FIFO contains more characters than
+	 * the trigger, or the MCR RTS bit is cleared.  In the case where
+	 * the remote UART is not using CTS auto flow control, we must
+	 * have sufficient FIFO entries for the latency of the remote
+	 * UART to respond.  IOW, at least 32 bytes of FIFO.
 	 */
-	if (up->port.type == PORT_16750) {
+	if (up->capabilities & UART_CAP_AFE && up->port.fifosize >= 32) {
 		up->mcr &= ~UART_MCR_AFE;
 		if (termios->c_cflag & CRTSCTS)
 			up->mcr |= UART_MCR_AFE;
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
index bbf767d..dcf5859 100644
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -47,6 +47,7 @@ struct serial8250_config {
 #define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
 #define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
 #define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
+#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
 
 #undef SERIAL_DEBUG_PCI
 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/e898ab78/attachment-0001.sig>
