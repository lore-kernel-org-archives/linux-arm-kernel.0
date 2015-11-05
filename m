From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 4 Nov 2015 23:21:12 -0800
Subject: [PATCH v2 03/10] tty: xuartps: Always enable transmitter in start_tx
In-Reply-To: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446708079-1105-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

start_tx must start transmitting characters. Regardless of the state of
the circular buffer, always enable the transmitter hardware.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2c98c357d9a0..df6778d17949 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -512,9 +512,6 @@ static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status, numbytes = port->fifosize;
 
-	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
-		return;
-
 	/*
 	 * Set the TX enable bit and clear the TX disable bit to enable the
 	 * transmitter.
@@ -524,6 +521,9 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	status |= CDNS_UART_CR_TX_EN;
 	writel(status, port->membase + CDNS_UART_CR_OFFSET);
 
+	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
+		return;
+
 	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR_OFFSET) &
 				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
 		/* Break if no more data available in the UART buffer */
-- 
2.6.2.3.ga463a5b
