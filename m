From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sat, 5 Dec 2015 20:39:21 -0800
Subject: [PATCH LINUX v4 05/13] tty: xuartps: Improve startup function
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1449376769-13369-6-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The startup function is supposed to initialize the UART for receiving.
Hence, don't enable the TX part. Also, protect HW accesses with the port
lock.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ef114d7a0623..6ffd3bbe3e18 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -758,6 +758,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
  */
 static int cdns_uart_startup(struct uart_port *port)
 {
+	unsigned long flags;
 	unsigned int retval = 0, status = 0;
 
 	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
@@ -765,6 +766,8 @@ static int cdns_uart_startup(struct uart_port *port)
 	if (retval)
 		return retval;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
@@ -775,15 +778,14 @@ static int cdns_uart_startup(struct uart_port *port)
 	writel(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST,
 			port->membase + CDNS_UART_CR_OFFSET);
 
-	status = readl(port->membase + CDNS_UART_CR_OFFSET);
-
-	/* Clear the RX disable and TX disable bits and then set the TX enable
-	 * bit and RX enable bit to enable the transmitter and receiver.
+	/*
+	 * Clear the RX disable bit and then set the RX enable bit to enable
+	 * the receiver.
 	 */
-	writel((status & ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS))
-			| (CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN |
-			CDNS_UART_CR_STOPBRK),
-			port->membase + CDNS_UART_CR_OFFSET);
+	status = readl(port->membase + CDNS_UART_CR_OFFSET);
+	status &= CDNS_UART_CR_RX_DIS;
+	status |= CDNS_UART_CR_RX_EN;
+	writel(status, port->membase + CDNS_UART_CR_OFFSET);
 
 	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
 	 * no parity.
@@ -814,6 +816,8 @@ static int cdns_uart_startup(struct uart_port *port)
 		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
 		port->membase + CDNS_UART_IER_OFFSET);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	return retval;
 }
 
-- 
2.6.3.3.g9bb996a
