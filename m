From: ladis@linux-mips.org (Ladislav Michl)
Date: Tue, 1 Aug 2017 14:52:44 +0200
Subject: [PATCH] serial: amba-pl011: Add basic rs485 support
Message-ID: <20170801125244.cmeycp5ujp2lmmwr@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently RS485 mode can be selected only via DT bindings.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Notes: this change was sitting in my tree for a year and now with
 "serial: Add common rs485 device tree parsing function" et al.
 patches being submitted is time to move forward a bit.
 Although rpi with this patched driver is working for months I do not
 like mdelay in interrupt while waiting for last bit to leave tx wire.
 If anyone has better idea, I'll happily implement it. Thank you.

 drivers/tty/serial/amba-pl011.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8a857bb34fbb..44016840f5df 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1319,9 +1319,22 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 static void pl011_stop_tx(struct uart_port *port)
 {
+	unsigned int cr;
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	/* Handle RS-485 */
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+			mdelay(1);
+		cr = readw(uap->port.membase + UART011_CR);
+		if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+			cr &= ~UART011_CR_RTS;
+		else
+			cr |= UART011_CR_RTS;
+		writew(cr, uap->port.membase + UART011_CR);
+	}
+
 	uap->im &= ~UART011_TXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_dma_tx_stop(uap);
@@ -1340,9 +1353,20 @@ static void pl011_start_tx_pio(struct uart_amba_port *uap)
 
 static void pl011_start_tx(struct uart_port *port)
 {
+	unsigned int cr;
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	/* Handle RS-485 */
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		cr = readw(uap->port.membase + UART011_CR);
+		if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+			cr |= UART011_CR_RTS;
+		else
+			cr &= ~UART011_CR_RTS;
+		writew(cr, uap->port.membase + UART011_CR);
+	}
+
 	if (!pl011_dma_tx_start(uap))
 		pl011_start_tx_pio(uap);
 }
@@ -2588,6 +2612,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 		return PTR_ERR(base);
 
 	index = pl011_probe_dt_alias(index, dev);
+	of_get_rs485_mode(dev->of_node, &uap->port.rs485);
 
 	uap->old_cr = 0;
 	uap->port.dev = dev;
-- 
2.11.0
