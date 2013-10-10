From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Oct 2013 10:43:31 +0200
Subject: [PATCH 1/2] tty/serial: at91: fix uart/usart selection for older
 products
Message-ID: <a58fe8bc7fdd128a2f9cf60785f81ebde4c0c247.1381394411.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 055560b04a8cd063aea916fd083b7aec02c2adb8 (serial: at91:
distinguish usart and uart) the older products which do not have a
name field in their register map are unable to use their serial output.
As the main console output is usually the serial interface (aka DBGU) it
is pretty unfortunate.
So, instead of failing during probe() we just silently configure the serial
peripheral as an uart. It allows us to use these serial outputs.
The proper solution is proposed in another patch.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d067285..6b0f75e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1499,7 +1499,7 @@ static void atmel_set_ops(struct uart_port *port)
 /*
  * Get ip name usart or uart
  */
-static int atmel_get_ip_name(struct uart_port *port)
+static void atmel_get_ip_name(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	int name = UART_GET_IP_NAME(port);
@@ -1518,10 +1518,7 @@ static int atmel_get_ip_name(struct uart_port *port)
 		atmel_port->is_usart = false;
 	} else {
 		dev_err(port->dev, "Not supported ip name, set to uart\n");
-		return -EINVAL;
 	}
-
-	return 0;
 }
 
 /*
@@ -2405,9 +2402,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	/*
 	 * Get port name of usart or uart
 	 */
-	ret = atmel_get_ip_name(&port->uart);
-	if (ret < 0)
-		goto err_add_port;
+	atmel_get_ip_name(&port->uart);
 
 	return 0;
 
-- 
1.8.2.2
