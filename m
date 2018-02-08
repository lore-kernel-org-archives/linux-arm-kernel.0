From: vigneshr@ti.com (Vignesh R)
Date: Thu, 8 Feb 2018 18:25:41 +0530
Subject: [PATCH 1/2] serial: 8250: Don't service RX FIFO if interrupts are
 disabled
In-Reply-To: <20180208125542.15649-1-vigneshr@ti.com>
References: <20180208125542.15649-1-vigneshr@ti.com>
Message-ID: <20180208125542.15649-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, data in RX FIFO is read based on UART_LSR register state even
if RDI and RLSI interrupts are disabled in UART_IER register.
This is because when IRQ handler is called due to TX FIFO empty event,
RX FIFO is serviced based on UART_LSR register status instead of
UART_IIR status. This defeats the purpose of disabling UART RX
FIFO interrupts during throttling(see, omap_8250_throttle()) as IRQ
handler continues to drain UART RX FIFO resulting in overflow of buffer
at tty layer.
Fix this by making sure that driver drains UART RX FIFO only when
UART_IIR_RDI is set along with UART_LSR_BI or UART_LSR_DR bits.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1328c7e70108..ffbb955d1c06 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1854,7 +1854,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI)) {
+	if (status & (UART_LSR_DR | UART_LSR_BI) &&
+	    iir & UART_IIR_RDI) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.16.1
