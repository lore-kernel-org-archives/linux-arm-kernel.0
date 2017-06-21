From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Jun 2017 12:21:25 +0200
Subject: [PATCH 4/9] serial: fsl_lpuart: Use common rs485 device tree parsing
 function
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170621102130.21024-5-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/fsl_lpuart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 15df1ba78095..7988a8a981d1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2054,8 +2054,9 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_info(sport->port.dev, "DMA rx channel request failed, "
 				"operating without rx DMA\n");
 
-	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time")) {
-		sport->port.rs485.flags |= SER_RS485_ENABLED;
+	of_get_rs485_mode(np, &sport->port.rs485);
+
+	if (sport->port.rs485.flags & SER_RS485_ENABLED) {
 		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
 		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
 	}
-- 
2.11.0
