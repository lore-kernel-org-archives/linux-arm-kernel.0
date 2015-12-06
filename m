From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sat, 5 Dec 2015 20:39:27 -0800
Subject: [PATCH LINUX v4 11/13] tty: xuartps: Cleanup: Reformat if-else
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1449376769-13369-12-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert an if-else into the more common early return on error, reducing
the indent level of the happy path.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 124 ++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 1229bb3a275e..7afab0c36528 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -203,58 +203,55 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 	isrstatus &= port->read_status_mask;
 	isrstatus &= ~port->ignore_status_mask;
 
-	if ((isrstatus & CDNS_UART_IXR_TOUT) ||
-		(isrstatus & CDNS_UART_IXR_RXTRIG)) {
-		/* Receive Timeout Interrupt */
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-					CDNS_UART_SR_RXEMPTY)) {
-			u32 data;
-			char status = TTY_NORMAL;
-
-			data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
-
-			/* Non-NULL byte after BREAK is garbage (99%) */
-			if (data && (port->read_status_mask &
-						CDNS_UART_IXR_BRK)) {
-				port->read_status_mask &= ~CDNS_UART_IXR_BRK;
-				port->icount.brk++;
-				if (uart_handle_break(port))
-					continue;
-			}
+	if (!(isrstatus & (CDNS_UART_IXR_TOUT | CDNS_UART_IXR_RXTRIG)))
+		return;
+
+	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
+				CDNS_UART_SR_RXEMPTY)) {
+		u32 data;
+		char status = TTY_NORMAL;
+
+		data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
+
+		/* Non-NULL byte after BREAK is garbage (99%) */
+		if (data && (port->read_status_mask & CDNS_UART_IXR_BRK)) {
+			port->read_status_mask &= ~CDNS_UART_IXR_BRK;
+			port->icount.brk++;
+			if (uart_handle_break(port))
+				continue;
+		}
 
 #ifdef SUPPORT_SYSRQ
-			/*
-			 * uart_handle_sysrq_char() doesn't work if
-			 * spinlocked, for some reason
-			 */
-			 if (port->sysrq) {
-				spin_unlock(&port->lock);
-				if (uart_handle_sysrq_char(port,
-							(unsigned char)data)) {
-					spin_lock(&port->lock);
-					continue;
-				}
+		/*
+		 * uart_handle_sysrq_char() doesn't work if
+		 * spinlocked, for some reason
+		 */
+		 if (port->sysrq) {
+			spin_unlock(&port->lock);
+			if (uart_handle_sysrq_char(port, data)) {
 				spin_lock(&port->lock);
+				continue;
 			}
+			spin_lock(&port->lock);
+		}
 #endif
 
-			port->icount.rx++;
-
-			if (isrstatus & CDNS_UART_IXR_PARITY) {
-				port->icount.parity++;
-				status = TTY_PARITY;
-			} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
-				port->icount.frame++;
-				status = TTY_FRAME;
-			} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
-				port->icount.overrun++;
-			}
+		port->icount.rx++;
 
-			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
-					 data, status);
+		if (isrstatus & CDNS_UART_IXR_PARITY) {
+			port->icount.parity++;
+			status = TTY_PARITY;
+		} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
+			port->icount.frame++;
+			status = TTY_FRAME;
+		} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
+			port->icount.overrun++;
 		}
-		tty_flip_buffer_push(&port->state->port);
+
+		uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
+				 data, status);
 	}
+	tty_flip_buffer_push(&port->state->port);
 }
 
 /**
@@ -1422,27 +1419,30 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		rc = -ENODEV;
 		goto err_out_notif_unreg;
-	} else {
-		/* Register the port.
-		 * This function also registers this device with the tty layer
-		 * and triggers invocation of the config_port() entry point.
-		 */
-		port->mapbase = res->start;
-		port->irq = irq;
-		port->dev = &pdev->dev;
-		port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
-		port->private_data = cdns_uart_data;
-		cdns_uart_data->port = port;
-		platform_set_drvdata(pdev, port);
-		rc = uart_add_one_port(&cdns_uart_uart_driver, port);
-		if (rc) {
-			dev_err(&pdev->dev,
-				"uart_add_one_port() failed; err=%i\n", rc);
-			goto err_out_notif_unreg;
-		}
-		return 0;
 	}
 
+	/*
+	 * Register the port.
+	 * This function also registers this device with the tty layer
+	 * and triggers invocation of the config_port() entry point.
+	 */
+	port->mapbase = res->start;
+	port->irq = irq;
+	port->dev = &pdev->dev;
+	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
+	port->private_data = cdns_uart_data;
+	cdns_uart_data->port = port;
+	platform_set_drvdata(pdev, port);
+
+	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"uart_add_one_port() failed; err=%i\n", rc);
+		goto err_out_notif_unreg;
+	}
+
+	return 0;
+
 err_out_notif_unreg:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
-- 
2.6.3.3.g9bb996a
