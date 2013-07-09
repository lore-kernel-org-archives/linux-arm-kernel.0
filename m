From: elen.song@atmel.com (Elen Song)
Date: Tue, 9 Jul 2013 14:33:45 +0800
Subject: [PATCH 6/7] serial: at91: modify UART to use software timer to
 trigger rx
In-Reply-To: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373351626-30143-7-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5762244..5beddad 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1470,7 +1470,7 @@ static int atmel_startup(struct uart_port *port)
 
 	if (atmel_use_pdc_rx(port)) {
 		/* set UART timeout */
-		if (port->line == 0) {
+		if (!atmel_port->is_usart) {
 			setup_timer(&atmel_port->uart_timer,
 				    atmel_uart_timer_callback,
 				    (unsigned long)port);
@@ -1486,7 +1486,7 @@ static int atmel_startup(struct uart_port *port)
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
 	} else if (atmel_use_dma_rx(port)) {
 		/* set UART timeout */
-		if (port->line == 0) {
+		if (!atmel_port->is_usart) {
 			setup_timer(&atmel_port->uart_timer,
 				    atmel_uart_timer_callback,
 				    (unsigned long)port);
@@ -1534,7 +1534,7 @@ static void atmel_shutdown(struct uart_port *port)
 			kfree(pdc->buf);
 		}
 
-		if (port->line == 0)
+		if (!atmel_port->is_usart)
 			del_timer_sync(&atmel_port->uart_timer);
 	}
 	if (atmel_use_pdc_tx(port)) {
@@ -1551,7 +1551,7 @@ static void atmel_shutdown(struct uart_port *port)
 
 	if (atmel_use_dma_rx(port)) {
 		atmel_rx_dma_release(atmel_port);
-		if (port->line == 0)
+		if (!atmel_port->is_usart)
 			del_timer_sync(&atmel_port->uart_timer);
 	}
 
-- 
1.7.9.5
