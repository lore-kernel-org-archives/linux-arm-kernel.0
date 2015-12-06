From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sat, 5 Dec 2015 20:39:18 -0800
Subject: [PATCH LINUX v4 02/13] tty: xuartps: Use spinlock to serialize HW
 access
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1449376769-13369-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of disabling the IRQ, use the spin lock to serialize accesses to
the HW. This protects the driver from interference of non-IRQ callbacks
with each other and makes the driver more consistent in its
serialization method.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/xilinx_uartps.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 50d4082d2354..2c98c357d9a0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -945,12 +945,10 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 #ifdef CONFIG_CONSOLE_POLL
 static int cdns_uart_poll_get_char(struct uart_port *port)
 {
-	u32 imr;
 	int c;
+	unsigned long flags;
 
-	/* Disable all interrupts */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Check if FIFO is empty */
 	if (readl(port->membase + CDNS_UART_SR_OFFSET) & CDNS_UART_SR_RXEMPTY)
@@ -959,19 +957,16 @@ static int cdns_uart_poll_get_char(struct uart_port *port)
 		c = (unsigned char) readl(
 					port->membase + CDNS_UART_FIFO_OFFSET);
 
-	/* Enable interrupts */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return c;
 }
 
 static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	u32 imr;
+	unsigned long flags;
 
-	/* Disable all interrupts */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Wait until FIFO is empty */
 	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
@@ -986,8 +981,7 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 				CDNS_UART_SR_TXEMPTY))
 		cpu_relax();
 
-	/* Enable interrupts */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return;
 }
-- 
2.6.3.3.g9bb996a
