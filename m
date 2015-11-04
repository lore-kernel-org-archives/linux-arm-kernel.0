From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 3 Nov 2015 16:20:43 -0800
Subject: [PATCH 2/9] tty: xuartps: Use spinlock to serialize HW access
In-Reply-To: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446596450-20918-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of disabling the IRQ, use the spin lock to serialize accesses to
the HW. This protects the driver from interference of non-IRQ callbacks
with each other and makes the driver more consistent in its
serialization method.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 50d4082d2354..dc1987f3dc0a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -947,10 +947,9 @@ static int cdns_uart_poll_get_char(struct uart_port *port)
 {
 	u32 imr;
 	int c;
+	unsigned long flags;
 
-	/* Disable all interrupts */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Check if FIFO is empty */
 	if (readl(port->membase + CDNS_UART_SR_OFFSET) & CDNS_UART_SR_RXEMPTY)
@@ -959,8 +958,7 @@ static int cdns_uart_poll_get_char(struct uart_port *port)
 		c = (unsigned char) readl(
 					port->membase + CDNS_UART_FIFO_OFFSET);
 
-	/* Enable interrupts */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return c;
 }
@@ -968,10 +966,9 @@ static int cdns_uart_poll_get_char(struct uart_port *port)
 static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	u32 imr;
+	unsigned long flags;
 
-	/* Disable all interrupts */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Wait until FIFO is empty */
 	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
@@ -986,8 +983,7 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 				CDNS_UART_SR_TXEMPTY))
 		cpu_relax();
 
-	/* Enable interrupts */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return;
 }
-- 
2.6.2.3.ga463a5b
