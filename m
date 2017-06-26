From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 26 Jun 2017 11:07:59 +0200
Subject: [PATCH v3 5/9] serial: fsl_lpuart: Use common rs485 device tree
 parsing function
In-Reply-To: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170626090803.10981-6-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

As a side effect this adds support for parsing rs485-rts-delay and
rs485-rx-during-tx. As the driver doesn't support this though, probing
fails if these are defined.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/fsl_lpuart.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6e39ef96c6ca..68ac72a5c5fe 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2049,6 +2049,24 @@ static int lpuart_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	of_get_rs485_mode(np, &sport->port.rs485);
+
+	if (sport->port.rs485.flags & SER_RS485_RX_DURING_TX) {
+		dev_err(&pdev->dev, "driver doesn't support RX during TX\n");
+		return -ENOSYS;
+	}
+
+	if (sport->port.rs485.delay_rts_before_send ||
+	    sport->port.rs485.delay_rts_after_send) {
+		dev_err(&pdev->dev, "driver doesn't support RTS delays\n");
+		return -ENOSYS;
+	}
+
+	if (sport->port.rs485.flags & SER_RS485_ENABLED) {
+		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
+		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
+	}
+
 	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
 	if (!sport->dma_tx_chan)
 		dev_info(sport->port.dev, "DMA tx channel request failed, "
@@ -2059,12 +2077,6 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_info(sport->port.dev, "DMA rx channel request failed, "
 				"operating without rx DMA\n");
 
-	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time")) {
-		sport->port.rs485.flags |= SER_RS485_ENABLED;
-		sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
-		writeb(UARTMODEM_TXRTSE, sport->port.membase + UARTMODEM);
-	}
-
 	return 0;
 }
 
-- 
2.11.0
