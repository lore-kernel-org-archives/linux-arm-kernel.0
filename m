From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Jun 2017 12:21:26 +0200
Subject: [PATCH 5/9] serial: omap-serial: Use common rs485 device tree parsing
 function
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170621102130.21024-6-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.
Note that the common helper is more strict and only evaluates the
optional properties if the required rs485-rts-delay is present.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org

 drivers/tty/serial/omap-serial.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1ea05ac57aa7..6e4728d3a24c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1638,17 +1638,7 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 		up->rts_gpio = -EINVAL;
 	}
 
-	if (of_property_read_u32_array(np, "rs485-rts-delay",
-				    rs485_delay, 2) == 0) {
-		rs485conf->delay_rts_before_send = rs485_delay[0];
-		rs485conf->delay_rts_after_send = rs485_delay[1];
-	}
-
-	if (of_property_read_bool(np, "rs485-rx-during-tx"))
-		rs485conf->flags |= SER_RS485_RX_DURING_TX;
-
-	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
-		rs485conf->flags |= SER_RS485_ENABLED;
+	of_get_rs485_mode(np, rs485conf);
 
 	return 0;
 }
-- 
2.11.0
