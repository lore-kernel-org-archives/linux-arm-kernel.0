From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 3 Nov 2015 16:20:45 -0800
Subject: [PATCH 4/9] tty: xuartps: Clear interrupt status register in shutdown
In-Reply-To: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446596450-20918-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When shutting down the UART, clear the interrupt status register.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5edd1efca015..738df6bb2646 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -825,6 +825,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
 	writel(status, port->membase + CDNS_UART_IDR_OFFSET);
+	writel(0xffffffff, port->membase + CDNS_UART_ISR_OFFSET);
 
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
-- 
2.6.2.3.ga463a5b
