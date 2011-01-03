From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 10:09:19 +0000
Subject: [PATCH 4/7] ARM: PL011: Separate hardware FIFO size from TTY FIFO size
In-Reply-To: <20110103100753.GB26785@n2100.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
Message-ID: <E1PZhLr-0007pd-BT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DMA support, we need to tell the TTY subsystem that the DMA buffer
is the size of the FIFO, otherwise things like tty_wait_until_sent()
will time out too early.  Keep (and use) the hardware value separately
from the port->fifosize.

This was part of a larger patch from Linus Walleij, with a little
modification.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 6afdd9b..f9b6b82 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -97,6 +97,7 @@ struct uart_amba_port {
 	const struct vendor_data *vendor;
 	unsigned int		im;		/* interrupt mask */
 	unsigned int		old_status;
+	unsigned int		fifosize;	/* vendor-specific */
 	unsigned int		lcrh_tx;	/* vendor-specific */
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	bool			autorts;
@@ -203,7 +204,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 		return;
 	}
 
-	count = uap->port.fifosize >> 1;
+	count = uap->fifosize >> 1;
 	do {
 		writew(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -541,7 +542,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (!(termios->c_cflag & PARODD))
 			lcr_h |= UART01x_LCRH_EPS;
 	}
-	if (port->fifosize > 1)
+	if (uap->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -871,12 +872,13 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
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
