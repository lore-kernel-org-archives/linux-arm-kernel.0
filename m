From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 28 Feb 2016 11:25:51 +0200
Subject: [PATCH] serial: imx: support RS-485 Rx disable on Tx
Message-ID: <3b5ba06fdb9c1bdd0b3018bf2f623f52b2856d18.1456651551.git.baruch@tkos.co.il>
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
 drivers/tty/serial/imx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9362f54c816c..333d34ff358c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -361,6 +361,8 @@ static void imx_stop_tx(struct uart_port *port)
 			imx_port_rts_inactive(sport, &temp);
 		else
 			imx_port_rts_active(sport, &temp);
+		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			temp |= UCR2_RXEN;
 		writel(temp, port->membase + UCR2);
 
 		temp = readl(port->membase + UCR4);
@@ -568,6 +570,8 @@ static void imx_start_tx(struct uart_port *port)
 			imx_port_rts_inactive(sport, &temp);
 		else
 			imx_port_rts_active(sport, &temp);
+		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			temp &= ~UCR2_RXEN;
 		writel(temp, port->membase + UCR2);
 
 		/* enable transmitter and shifter empty irq */
@@ -1614,7 +1618,6 @@ static int imx_rs485_config(struct uart_port *port,
 	/* unimplemented */
 	rs485conf->delay_rts_before_send = 0;
 	rs485conf->delay_rts_after_send = 0;
-	rs485conf->flags |= SER_RS485_RX_DURING_TX;
 
 	/* RTS is required to control the transmitter */
 	if (!sport->have_rtscts)
-- 
2.7.0
