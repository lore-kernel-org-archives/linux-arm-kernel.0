From: elen.song@atmel.com (Elen Song)
Date: Tue, 9 Jul 2013 14:33:43 +0800
Subject: [PATCH 4/7] serial: at91: make DBGU support dma and pdc transfers
In-Reply-To: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373351626-30143-5-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the DBGU lack of receive timeout register, so we use a timer to trigger
data receive.

Signed-off-by: Elen Song <elen.song@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   51 ++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a425ff2..52beb7e 100644
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
+	struct timer_list 	uart_timer;	/* dbgu timer */
 };
 
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
@@ -968,6 +970,15 @@ err_dma:
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
@@ -1424,18 +1435,34 @@ static int atmel_startup(struct uart_port *port)
 
 	if (atmel_use_pdc_rx(port)) {
 		/* set UART timeout */
-		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
-		UART_PUT_CR(port, ATMEL_US_STTTO);
-
-		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
+		if (port->line == 0) {
+			setup_timer(&atmel_port->uart_timer,
+				    atmel_uart_timer_callback,
+				    (unsigned long)port);
+			mod_timer(&atmel_port->uart_timer,
+				  jiffies + uart_poll_timeout(port));
+		} else {
+			UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
+			UART_PUT_CR(port, ATMEL_US_STTTO);
+
+			UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
+		}
 		/* enable PDC controller */
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
 	} else if (atmel_use_dma_rx(port)) {
 		/* set UART timeout */
-		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
-		UART_PUT_CR(port, ATMEL_US_STTTO);
-
-		UART_PUT_IER(port, ATMEL_US_TIMEOUT);
+		if (port->line == 0) {
+			setup_timer(&atmel_port->uart_timer,
+				    atmel_uart_timer_callback,
+				    (unsigned long)port);
+			mod_timer(&atmel_port->uart_timer,
+				  jiffies + uart_poll_timeout(port));
+		} else {
+			UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
+			UART_PUT_CR(port, ATMEL_US_STTTO);
+
+			UART_PUT_IER(port, ATMEL_US_TIMEOUT);
+		}
 	} else {
 		/* enable receive only */
 		UART_PUT_IER(port, ATMEL_US_RXRDY);
@@ -1471,6 +1498,9 @@ static void atmel_shutdown(struct uart_port *port)
 					 DMA_FROM_DEVICE);
 			kfree(pdc->buf);
 		}
+
+		if (port->line == 0)
+			del_timer_sync(&atmel_port->uart_timer);
 	}
 	if (atmel_use_pdc_tx(port)) {
 		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
@@ -1484,8 +1514,11 @@ static void atmel_shutdown(struct uart_port *port)
 	if (atmel_use_dma_tx(port))
 		atmel_tx_dma_release(atmel_port);
 
-	if (atmel_use_dma_rx(port))
+	if (atmel_use_dma_rx(port)) {
 		atmel_rx_dma_release(atmel_port);
+		if (port->line == 0)
+			del_timer_sync(&atmel_port->uart_timer);
+	}
 
 	/*
 	 * Disable all interrupts, port and break condition.
-- 
1.7.9.5
