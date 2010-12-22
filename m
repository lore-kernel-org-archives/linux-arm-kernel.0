From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 23:09:09 +0000
Subject: [PATCH 2/6] ARM: PL011: Separate hardware FIFO size from TTY FIFO size
Message-ID: <E1PVXnx-0007I9-2a@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DMA support, we need to tell the TTY subsystem that the DMA buffer
is the size of the FIFO, otherwise things like tty_wait_until_sent()
will time out too early.  Keep (and use) the hardware value separately
from the port->fifosize.

This was part of a larger patch from Linus Walleij, with a little
modification.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 6066b18..11cfa90 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -74,6 +74,7 @@ struct uart_amba_port {
 	unsigned int		ifls;		/* vendor-specific */
 	unsigned int		lcrh_tx;	/* vendor-specific */
 	unsigned int		lcrh_rx;	/* vendor-specific */
+	unsigned int		fifosize;	/* vendor-specific */
 	bool			oversampling;   /* vendor-specific */
 	bool			autorts;
 };
@@ -203,7 +204,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 		return;
 	}
 
-	count = uap->port.fifosize >> 1;
+	count = uap->fifosize >> 1;
 	do {
 		writew(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -536,7 +537,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (!(termios->c_cflag & PARODD))
 			lcr_h |= UART01x_LCRH_EPS;
 	}
-	if (port->fifosize > 1)
+	if (uap->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -866,12 +867,13 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
 	uap->oversampling = vendor->oversampling;
+	uap->fifosize = vendor->fifosize;
 	uap->port.dev = &dev->dev;
 	uap->port.mapbase = dev->res.start;
 	uap->port.membase = base;
 	uap->port.iotype = UPIO_MEM;
 	uap->port.irq = dev->irq[0];
-	uap->port.fifosize = vendor->fifosize;
+	uap->port.fifosize = uap->fifosize;
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
-- 
1.6.2.5
