From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Thu, 9 Jun 2016 20:40:34 +0530
Subject: [PATCH 3/8] tty: serial: fsl_lpuart: fix clearing of receive flag
In-Reply-To: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20160609151039.20817-4-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan.agner@toradex.com>

Commit 8e4934c6d6c6 ("tty: serial: fsl_lpuart: clear receive flag
on FIFO flush") implemented clearing of the receive flag by reading
the status register only. It turned out that even though we flush
the FIFO afterwards, a explicit read of the data register is still
required.

This leads to a FIFO underrun. To avoid this, follow the advice in
the overrun "Operation section": Unconditionally clear RXUF after
using RXFLUSH.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 75a2098..97c1fda 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -935,13 +935,16 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
-	/* explicitly clear RDRF */
-	readb(sport->port.membase + UARTSR1);
-
 	/* flush Tx and Rx FIFO */
 	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
 			sport->port.membase + UARTCFIFO);
 
+	/* explicitly clear RDRF */
+	if (readb(sport->port.membase + UARTSR1) & UARTSR1_RDRF) {
+		readb(sport->port.membase + UARTDR);
+		writeb(UARTSFIFO_RXUF, sport->port.membase + UARTSFIFO);
+	}
+
 	writeb(0, sport->port.membase + UARTTWFIFO);
 	writeb(1, sport->port.membase + UARTRWFIFO);
 
-- 
2.8.3
