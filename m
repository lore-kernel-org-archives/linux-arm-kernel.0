From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sat, 5 Dec 2015 20:39:20 -0800
Subject: [PATCH LINUX v4 04/13] tty: xuartps: Clear interrupt status register
 in shutdown
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1449376769-13369-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When shutting down the UART, clear the interrupt status register. Bits
in the ISR are cleared by writing them as '1'.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
---
v4:
 - clarify workings of the ISR in the commit message
---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6a7cd4e057ae..ef114d7a0623 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -828,6 +828,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
 	writel(status, port->membase + CDNS_UART_IDR_OFFSET);
+	writel(0xffffffff, port->membase + CDNS_UART_ISR_OFFSET);
 
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
-- 
2.6.3.3.g9bb996a
