From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 18 Jul 2017 12:59:40 +0200
Subject: [PATCH v4 1/9] serial: fsl_lpuart: clear unsupported options in
 .rs485_config()
In-Reply-To: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
References: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170718105948.21986-2-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The struct serial_rs485 parameter is both input and output and is
supposed to hold the actually used configuration on return. So clear
unsupported settings.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/fsl_lpuart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 343de8c384b0..4becfbf35c4c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1019,6 +1019,11 @@ static int lpuart_config_rs485(struct uart_port *port,
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
