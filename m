From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jun 2017 11:49:37 +0200
Subject: [PATCH v2 1/9] serial: fsl_lpuart: clear unsupported options in
 .rs485_config()
In-Reply-To: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170623094945.31908-2-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The struct serial_rs485 parameter is both input and output and is
supposed to hold the actually used configuration on return. So clear
unsupported settings.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This is new in v2. It's actually a fix that could be applied
independently. I kept it in the series to ease my tracking and having
the other lpuart patch apply cleanly.

 drivers/tty/serial/fsl_lpuart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 15df1ba78095..6e39ef96c6ca 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -985,6 +985,11 @@ static int lpuart_config_rs485(struct uart_port *port,
 		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
 	writeb(modem, sport->port.membase + UARTMODEM);
 
+	/* clear unsupported configurations */
+	rs485->delay_rts_before_send = 0;
+	rs485->delay_rts_after_send = 0;
+	rs485->flags &= ~SER_RS485_RX_DURING_TX;
+
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
 		modem |= UARTMODEM_TXRTSE;
-- 
2.11.0
