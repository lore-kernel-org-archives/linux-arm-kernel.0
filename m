From: elen.song@atmel.com (Elen Song)
Date: Tue, 16 Jul 2013 10:43:47 +0800
Subject: [PATCH V2 8/8] serial: at91: modify UART to use software timer to
 trigger rx
In-Reply-To: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
References: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373942627-7121-9-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 769b90b..67617a8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -826,7 +826,7 @@ static void atmel_release_rx_dma(struct uart_port *port)
 	atmel_port->chan_rx = NULL;
 	atmel_port->cookie_rx = -EINVAL;
 
-	if (port->line == 0)
+	if (!atmel_port->is_usart)
 		del_timer_sync(&atmel_port->uart_timer);
 }
 
@@ -1230,7 +1230,7 @@ static void atmel_release_rx_pdc(struct uart_port *port)
 		kfree(pdc->buf);
 	}
 
-	if (port->line == 0)
+	if (!atmel_port->is_usart)
 		del_timer_sync(&atmel_port->uart_timer);
 }
 
@@ -1593,7 +1593,7 @@ static int atmel_startup(struct uart_port *port)
 
 	if (atmel_use_pdc_rx(port)) {
 		/* set UART timeout */
-		if (port->line == 0) {
+		if (!atmel_port->is_usart) {
 			setup_timer(&atmel_port->uart_timer,
 					atmel_uart_timer_callback,
 					(unsigned long)port);
@@ -1610,7 +1610,7 @@ static int atmel_startup(struct uart_port *port)
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
 	} else if (atmel_use_dma_rx(port)) {
 		/* set UART timeout */
-		if (port->line == 0) {
+		if (!atmel_port->is_usart) {
 			setup_timer(&atmel_port->uart_timer,
 					atmel_uart_timer_callback,
 					(unsigned long)port);
-- 
1.7.9.5
