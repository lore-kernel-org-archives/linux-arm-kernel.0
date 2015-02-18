From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 21:41:08 +0100
Subject: [PATCH 7/7] serial: imx: add support for half duplex rs485
In-Reply-To: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The transmitter is expected to be controlled by the UART's RTS pin.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 94 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 806b3cfb7f55..ad43019a4880 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -364,8 +364,20 @@ static void imx_stop_tx(struct uart_port *port)
 	if (sport->dma_is_enabled && sport->dma_is_txing)
 		return;
 
-	temp = readl(sport->port.membase + UCR1);
-	writel(temp & ~UCR1_TXMPTYEN, sport->port.membase + UCR1);
+	temp = readl(port->membase + UCR1);
+	writel(temp & ~UCR1_TXMPTYEN, port->membase + UCR1);
+
+	/* in rs485 mode disable transmitter if shifter is empty */
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    readl(port->membase + USR2) & USR2_TXDC) {
+		temp = readl(port->membase + UCR2);
+		temp |= UCR2_CTS;
+		writel(temp, port->membase + UCR2);
+
+		temp = readl(port->membase + UCR4);
+		temp &= ~UCR4_TCEN;
+		writel(temp, port->membase + UCR4);
+	}
 }
 
 /*
@@ -520,6 +532,17 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		/* enable transmitter and shifter empty irq */
+		temp = readl(port->membase + UCR2);
+		temp &= ~UCR2_CTS;
+		writel(temp, port->membase + UCR2);
+
+		temp = readl(port->membase + UCR4);
+		temp |= UCR4_TCEN;
+		writel(temp, port->membase + UCR4);
+	}
+
 	if (!sport->dma_is_enabled) {
 		temp = readl(sport->port.membase + UCR1);
 		writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
@@ -661,6 +684,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	unsigned int sts2;
 
 	sts = readl(sport->port.membase + USR1);
+	sts2 = readl(sport->port.membase + USR2);
 
 	if (sts & USR1_RRDY) {
 		if (sport->dma_is_enabled)
@@ -669,8 +693,10 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 			imx_rxint(irq, dev_id);
 	}
 
-	if (sts & USR1_TRDY &&
-			readl(sport->port.membase + UCR1) & UCR1_TXMPTYEN)
+	if ((sts & USR1_TRDY &&
+	     readl(sport->port.membase + UCR1) & UCR1_TXMPTYEN) ||
+	    (sts2 & USR2_TXDC &&
+	     readl(sport->port.membase + UCR4) & UCR4_TCEN))
 		imx_txint(irq, dev_id);
 
 	if (sts & USR1_RTSD)
@@ -679,7 +705,6 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts & USR1_AWAKE)
 		writel(USR1_AWAKE, sport->port.membase + USR1);
 
-	sts2 = readl(sport->port.membase + USR2);
 	if (sts2 & USR2_ORE) {
 		dev_err(sport->port.dev, "Rx FIFO overrun\n");
 		sport->port.icount.overrun++;
@@ -731,11 +756,13 @@ static void imx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
-	temp = readl(sport->port.membase + UCR2) & ~(UCR2_CTS | UCR2_CTSC);
-	if (mctrl & TIOCM_RTS)
-		temp |= UCR2_CTS | UCR2_CTSC;
-
-	writel(temp, sport->port.membase + UCR2);
+	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
+		temp = readl(sport->port.membase + UCR2);
+		temp &= ~(UCR2_CTS | UCR2_CTSC);
+		if (mctrl & TIOCM_RTS)
+			temp |= UCR2_CTS | UCR2_CTSC;
+		writel(temp, sport->port.membase + UCR2);
+	}
 
 	temp = readl(sport->port.membase + uts_reg(sport)) & ~UTS_LOOP;
 	if (mctrl & TIOCM_LOOP)
@@ -1029,7 +1056,7 @@ static int imx_startup(struct uart_port *port)
 	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
 	writel(temp, sport->port.membase + UCR1);
 
-	temp = read(sport->port.membase + UCR4);
+	temp = readl(sport->port.membase + UCR4);
 	temp |= UCR4_OREN;
 	writel(temp, sport->port.membase + UCR4);
 
@@ -1144,7 +1171,17 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_cflag & CRTSCTS) {
 		if (sport->have_rtscts) {
 			ucr2 &= ~UCR2_IRTS;
-			ucr2 |= UCR2_CTSC;
+
+			if (port->rs485.flags & SER_RS485_ENABLED)
+				/*
+				 * RTS is mandatory for rs485 operation, so keep
+				 * it under manual control and keep transmitter
+				 * disabled.
+				 */
+				ucr2 |= UCR2_CTS;
+			else
+				ucr2 |= UCR2_CTSC;
+
 
 			/* Can we enable the DMA support? */
 			if (is_imx6q_uart(sport) && !uart_console(port)
@@ -1153,7 +1190,9 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		} else {
 			termios->c_cflag &= ~CRTSCTS;
 		}
-	}
+	} else if (port->rs485.flags & SER_RS485_ENABLED)
+		/* disable transmitter */
+		ucr2 |= UCR2_CTS;
 
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
@@ -1374,6 +1413,34 @@ static void imx_poll_put_char(struct uart_port *port, unsigned char c)
 }
 #endif
 
+static int imx_rs485_config(struct uart_port *port,
+			    struct serial_rs485 *rs485conf)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+
+	/* unimplemented */
+	rs485conf->delay_rts_before_send = 0;
+	rs485conf->delay_rts_after_send = 0;
+
+	/* RTS is required to control the transmitter */
+	if (!sport->have_rtscts)
+		rs485conf->flags &= ~SER_RS485_ENABLED;
+
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		unsigned long temp;
+
+		/* disable transmitter */
+		temp = readl(sport->port.membase + UCR2);
+		temp &= ~UCR2_CTSC;
+		temp |= UCR2_CTS;
+		writel(temp, sport->port.membase + UCR2);
+	}
+
+	port->rs485 = *rs485conf;
+
+	return 0;
+}
+
 static struct uart_ops imx_pops = {
 	.tx_empty	= imx_tx_empty,
 	.set_mctrl	= imx_set_mctrl,
@@ -1731,6 +1798,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.irq = rxirq;
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
+	sport->port.rs485_config = imx_rs485_config;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
-- 
2.1.4
