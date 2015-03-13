From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 13 Mar 2015 15:56:22 +0000
Subject: [PATCH v2 2/2] serial/amba-pl011: Leave the TX IRQ alone when the
 UART is not open
In-Reply-To: <1426262182-2298-1-git-send-email-Dave.Martin@arm.com>
References: <1426262182-2298-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1426262182-2298-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting the TX IRQ re-asserted from scratch can be inefficient in
some setups.

This patch avoids clearing the TX IRQ across pl011_shutdown()...
pl011_startup(), so that if the port is closed and reopened, the
IRQ will still work afterwards without having to bootstrap it again.

The TX IRQ continues to be masked in IMSC when the UART is not in
use.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index bdb4831..c3d631d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1646,9 +1646,6 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
-	/* Assume that TX IRQ doesn't work until we see one: */
-	uap->tx_irq_seen = false;
-
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
@@ -1712,7 +1709,7 @@ static void pl011_shutdown(struct uart_port *port)
 	spin_lock_irq(&uap->port.lock);
 	uap->im = 0;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
 	spin_unlock_irq(&uap->port.lock);
 
 	pl011_dma_shutdown(uap);
-- 
1.7.10.4
