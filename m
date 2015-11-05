From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 4 Nov 2015 23:21:16 -0800
Subject: [PATCH v2 07/10] tty: xuartps: Acquire port lock for shutdown
In-Reply-To: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446708079-1105-8-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shutting down the UART port can happen while console operations are in
progress. Holding the port lock serializes these operations and avoids
the UART HW to be disabled in the middle of console prints.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5efd1b9d220f..7fd226d65496 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -823,6 +823,9 @@ static int cdns_uart_startup(struct uart_port *port)
 static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
@@ -832,6 +835,9 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	free_irq(port->irq, port);
 }
 
-- 
2.6.2.3.ga463a5b
