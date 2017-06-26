From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 26 Jun 2017 11:07:58 +0200
Subject: [PATCH v3 4/9] serial: atmel: Use common rs485 device tree parsing
 function
In-Reply-To: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170626090803.10981-5-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

Note that there is a small difference between the removed and the now
used implementation: The former cleared flags to 0 if rs485-rts-delay
was given, the common helper clears SER_RS485_RX_DURING_TX and
SER_RS485_ENABLED only but always which makes more sense.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
[ukleinek: point out semantic change in commit log]
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/atmel_serial.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 937d67f22fba..245d9c227ad5 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1684,29 +1684,6 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
 	}
 }
 
-static void atmel_init_rs485(struct uart_port *port,
-				struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-
-	struct serial_rs485 *rs485conf = &port->rs485;
-	u32 rs485_delay[2];
-
-	/* rs485 properties */
-	if (of_property_read_u32_array(np, "rs485-rts-delay",
-				       rs485_delay, 2) == 0) {
-		rs485conf->delay_rts_before_send = rs485_delay[0];
-		rs485conf->delay_rts_after_send = rs485_delay[1];
-		rs485conf->flags = 0;
-	}
-
-	if (of_get_property(np, "rs485-rx-during-tx", NULL))
-		rs485conf->flags |= SER_RS485_RX_DURING_TX;
-
-	if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL))
-		rs485conf->flags |= SER_RS485_ENABLED;
-}
-
 static void atmel_set_ops(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -2390,7 +2367,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	atmel_init_property(atmel_port, pdev);
 	atmel_set_ops(port);
 
-	atmel_init_rs485(port, pdev);
+	of_get_rs485_mode(pdev->dev.of_node, &port->rs485);
 
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
-- 
2.11.0
