From: elen.song@atmel.com (Elen Song)
Date: Tue, 16 Jul 2013 10:43:45 +0800
Subject: [PATCH V2 6/8] serial: at91: make DBGU support dma and pdc transfers
In-Reply-To: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
References: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373942627-7121-7-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the DBGU lack of receive timeout register, so we use a timer to trigger
data receive.

Signed-off-by: Elen Song <elen.song@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   48 ++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ad787fd1..afecdfa 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -41,6 +41,7 @@
 #include <linux/uaccess.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/timer.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -167,6 +168,7 @@ struct atmel_uart_port {
 
 	struct serial_rs485	rs485;		/* rs485 settings */
 	unsigned int		tx_done_mask;
+	struct timer_list       uart_timer;     /* dbgu timer */
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -821,6 +823,9 @@ static void atmel_release_rx_dma(struct uart_port *port)
 	atmel_port->desc_rx = NULL;
 	atmel_port->chan_rx = NULL;
 	atmel_port->cookie_rx = -EINVAL;
+
+	if (port->line == 0)
+		del_timer_sync(&atmel_port->uart_timer);
 }
 
 static void atmel_rx_from_dma(struct uart_port *port)
@@ -950,6 +955,15 @@ chan_err:
 	return -EINVAL;
 }
 
+static void atmel_uart_timer_callback(unsigned long data)
+{
+	struct uart_port *port = (void *)data;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	tasklet_schedule(&atmel_port->tasklet);
+	mod_timer(&atmel_port->uart_timer, jiffies + uart_poll_timeout(port));
+}
+
 /*
  * receive interrupt handler.
  */
@@ -1213,6 +1227,9 @@ static void atmel_release_rx_pdc(struct uart_port *port)
 				 DMA_FROM_DEVICE);
 		kfree(pdc->buf);
 	}
+
+	if (port->line == 0)
+		del_timer_sync(&atmel_port->uart_timer);
 }
 
 static void atmel_rx_from_pdc(struct uart_port *port)
@@ -1546,17 +1563,36 @@ static int atmel_startup(struct uart_port *port)
 
 	if (atmel_use_pdc_rx(port)) {
 		/* set UART timeout */
-		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
-		UART_PUT_CR(port, ATMEL_US_STTTO);
+		if (port->line == 0) {
+			setup_timer(&atmel_port->uart_timer,
+					atmel_uart_timer_callback,
+					(unsigned long)port);
+			mod_timer(&atmel_port->uart_timer,
+					jiffies + uart_poll_timeout(port));
+		/* set USART timeout */
+		} else {
+			UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
+			UART_PUT_CR(port, ATMEL_US_STTTO);
 
-		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
+			UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
+		}
 		/* enable PDC controller */
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
 	} else if (atmel_use_dma_rx(port)) {
-		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
-		UART_PUT_CR(port, ATMEL_US_STTTO);
+		/* set UART timeout */
+		if (port->line == 0) {
+			setup_timer(&atmel_port->uart_timer,
+					atmel_uart_timer_callback,
+					(unsigned long)port);
+			mod_timer(&atmel_port->uart_timer,
+					jiffies + uart_poll_timeout(port));
+		/* set USART timeout */
+		} else {
+			UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
+			UART_PUT_CR(port, ATMEL_US_STTTO);
 
-		UART_PUT_IER(port, ATMEL_US_TIMEOUT);
+			UART_PUT_IER(port, ATMEL_US_TIMEOUT);
+		}
 	} else {
 		/* enable receive only */
 		UART_PUT_IER(port, ATMEL_US_RXRDY);
-- 
1.7.9.5
