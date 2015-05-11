From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 May 2015 13:00:31 +0200
Subject: [PATCH] tty/serial: at91: RS485 mode: 0 is valid for
 delay_rts_after_send
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA8D002E7C@edb1.wapice.localdomain>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA8D002E7C@edb1.wapice.localdomain>
Message-ID: <1431342044-23343-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In RS485 mode, we may want to set the delay_rts_after_send value to 0.
In the datasheet, the 0 value is said to "disable" the Transmitter Timeguard but
this is exactly the expected behavior if we want no delay...

Moreover, if the value was set to non-zero value by device-tree or earlier
ioctl command, it was impossible to change it back to zero.

Reported-by: Sami Pietik?inen <Sami.Pietikainen@wapice.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable at vger.kernel.org  # 3.2+
---
 drivers/tty/serial/atmel_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 27dade29646b..5ca1dfb0561c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -315,8 +315,7 @@ static int atmel_config_rs485(struct uart_port *port,
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		if ((rs485conf->delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
+		UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -354,8 +353,7 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	/* override mode to RS485 if needed, otherwise keep the current mode */
 	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if ((port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
+		UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
 		mode &= ~ATMEL_US_USMODE;
 		mode |= ATMEL_US_USMODE_RS485;
 	}
@@ -2061,8 +2059,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* mode */
 	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if ((port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
+		UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else if (termios->c_cflag & CRTSCTS) {
 		/* RS232 with hardware handshake (RTS/CTS) */
-- 
2.1.3
