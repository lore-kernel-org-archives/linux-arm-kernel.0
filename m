From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 23:09:18 +0100
Subject: [PATCH 7'/7] fixup! serial: imx: add support for half duplex rs485
In-Reply-To: <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424297358-19352-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
Hello,

can you please squash this patch into patch 7/7? It adds support for handling
the rs485 flags that I found in my notes after sending out the series.

If you prefer me to send the whole patch 7 instead please tell me.

Best regards
Uwe

 drivers/tty/serial/imx.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index ad43019a4880..44a7b5d570e4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -371,7 +371,10 @@ static void imx_stop_tx(struct uart_port *port)
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    readl(port->membase + USR2) & USR2_TXDC) {
 		temp = readl(port->membase + UCR2);
-		temp |= UCR2_CTS;
+		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			temp &= ~UCR2_CTS;
+		else
+			temp |= UCR2_CTS;
 		writel(temp, port->membase + UCR2);
 
 		temp = readl(port->membase + UCR4);
@@ -535,7 +538,10 @@ static void imx_start_tx(struct uart_port *port)
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		/* enable transmitter and shifter empty irq */
 		temp = readl(port->membase + UCR2);
-		temp &= ~UCR2_CTS;
+		if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+			temp &= ~UCR2_CTS;
+		else
+			temp |= UCR2_CTS;
 		writel(temp, port->membase + UCR2);
 
 		temp = readl(port->membase + UCR4);
@@ -1178,7 +1184,9 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 				 * it under manual control and keep transmitter
 				 * disabled.
 				 */
-				ucr2 |= UCR2_CTS;
+				if (!(port->rs485.flags &
+				      SER_RS485_RTS_AFTER_SEND))
+					ucr2 |= UCR2_CTS;
 			else
 				ucr2 |= UCR2_CTSC;
 
@@ -1192,7 +1200,8 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		}
 	} else if (port->rs485.flags & SER_RS485_ENABLED)
 		/* disable transmitter */
-		ucr2 |= UCR2_CTS;
+		if (!(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
+			ucr2 |= UCR2_CTS;
 
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
@@ -1421,6 +1430,7 @@ static int imx_rs485_config(struct uart_port *port,
 	/* unimplemented */
 	rs485conf->delay_rts_before_send = 0;
 	rs485conf->delay_rts_after_send = 0;
+	rs485conf->flags |= SER_RS485_RX_DURING_TX;
 
 	/* RTS is required to control the transmitter */
 	if (!sport->have_rtscts)
@@ -1432,7 +1442,10 @@ static int imx_rs485_config(struct uart_port *port,
 		/* disable transmitter */
 		temp = readl(sport->port.membase + UCR2);
 		temp &= ~UCR2_CTSC;
-		temp |= UCR2_CTS;
+		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
+			temp &= ~UCR2_CTS;
+		else
+			temp |= UCR2_CTS;
 		writel(temp, sport->port.membase + UCR2);
 	}
 
@@ -1799,6 +1812,8 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
 	sport->port.rs485_config = imx_rs485_config;
+	sport->port.rs485.flags =
+		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
-- 
2.1.4
