From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 29 Feb 2016 14:34:10 +0200
Subject: [PATCH v2] serial: imx: support RS-485 Rx disable on Tx
Message-ID: <fbc7c561dc1a8f5193262ab471b105935c4d7cea.1456749250.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some RS-232 to RS-485 transceivers require Rx to be disabled on Tx to
avoid echo of Tx data into the Rx buffer. Specifically, the XR3160E
RS-232/RS-485/RS-422 transceiver behaves this way.

This commit disables Rx on active Tx when SER_RS485_ENABLED is active and
SER_RS485_RX_DURING_TX is disabled.

Note that this is a change in behavior of the driver. Until now
SER_RS485_RX_DURING_TX was enabled unconditionally even when disabled in
the TIOCSRS485 ioctl serial_rs485 flags field.

Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
   * Make Rx enable more robust as Uwe Kleine-K?nig suggested
   * Expand Cc list
---
 drivers/tty/serial/imx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9362f54c816c..87950c111cbe 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -361,6 +361,7 @@ static void imx_stop_tx(struct uart_port *port)
 			imx_port_rts_inactive(sport, &temp);
 		else
 			imx_port_rts_active(sport, &temp);
+		temp |= UCR2_RXEN;
 		writel(temp, port->membase + UCR2);
 
 		temp = readl(port->membase + UCR4);
@@ -568,6 +569,8 @@ static void imx_start_tx(struct uart_port *port)
 			imx_port_rts_inactive(sport, &temp);
 		else
 			imx_port_rts_active(sport, &temp);
+		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			temp &= ~UCR2_RXEN;
 		writel(temp, port->membase + UCR2);
 
 		/* enable transmitter and shifter empty irq */
@@ -1610,19 +1613,17 @@ static int imx_rs485_config(struct uart_port *port,
 			    struct serial_rs485 *rs485conf)
 {
 	struct imx_port *sport = (struct imx_port *)port;
+	unsigned long temp;
 
 	/* unimplemented */
 	rs485conf->delay_rts_before_send = 0;
 	rs485conf->delay_rts_after_send = 0;
-	rs485conf->flags |= SER_RS485_RX_DURING_TX;
 
 	/* RTS is required to control the transmitter */
 	if (!sport->have_rtscts)
 		rs485conf->flags &= ~SER_RS485_ENABLED;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
-		unsigned long temp;
-
 		/* disable transmitter */
 		temp = readl(sport->port.membase + UCR2);
 		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
@@ -1632,6 +1633,14 @@ static int imx_rs485_config(struct uart_port *port,
 		writel(temp, sport->port.membase + UCR2);
 	}
 
+	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
+	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
+	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
+		temp = readl(sport->port.membase + UCR2);
+		temp |= UCR2_RXEN;
+		writel(temp, sport->port.membase + UCR2);
+	}
+
 	port->rs485 = *rs485conf;
 
 	return 0;
-- 
2.7.0
