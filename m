From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 22 Oct 2015 15:39:25 -0500
Subject: [PATCH] serial: amba-pl011: use cpu_relax when polling registers
Message-ID: <1445546365-7998-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Busy loops that poll on a register should call cpu_relax().  On some
architectures, it can lower CPU power consumption or yield to a
hyperthreaded twin processor.  It also serves as a compiler barrier,
so it can replace barrier() calls.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd27e98..4b5014b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1076,7 +1076,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	/* Disable RX and TX DMA */
 	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
-		barrier();
+		cpu_relax();
 
 	spin_lock_irq(&uap->port.lock);
 	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
@@ -1520,7 +1520,7 @@ static void pl011_put_poll_char(struct uart_port *port,
 	    container_of(port, struct uart_amba_port, port);
 
 	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
-		barrier();
+		cpu_relax();
 
 	writew(ch, uap->port.membase + UART01x_DR);
 }
@@ -2053,7 +2053,7 @@ static void pl011_console_putchar(struct uart_port *port, int ch)
 	    container_of(port, struct uart_amba_port, port);
 
 	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
-		barrier();
+		cpu_relax();
 	writew(ch, uap->port.membase + UART01x_DR);
 }
 
@@ -2093,6 +2093,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 */
 	do {
 		status = readw(uap->port.membase + UART01x_FR);
+		cpu_relax();
 	} while (status & UART01x_FR_BUSY);
 	if (!uap->vendor->always_enabled)
 		writew(old_cr, uap->port.membase + UART011_CR);
@@ -2205,10 +2206,10 @@ static struct console amba_console = {
 static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
-		;
+		cpu_relax();
 	writeb(c, port->membase + UART01x_DR);
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
-		;
+		cpu_relax();
 }
 
 static void pl011_early_write(struct console *con, const char *s, unsigned n)
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
