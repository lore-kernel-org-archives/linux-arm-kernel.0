From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  4 Mar 2015 12:27:34 +0000
Subject: [PATCH REPOST 2/2] serial/amba-pl011: Leave the TX IRQ alone when the
 UART is not open
In-Reply-To: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
References: <1425472054-7543-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1425472054-7543-3-git-send-email-Dave.Martin@arm.com>
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
index 69910f7..92783fc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1676,9 +1676,6 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
-	/* Assume that TX IRQ doesn't work until we see one: */
-	uap->tx_irq_seen = 0;
-
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
@@ -1742,7 +1739,7 @@ static void pl011_shutdown(struct uart_port *port)
 	spin_lock_irq(&uap->port.lock);
 	uap->im = 0;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
 	spin_unlock_irq(&uap->port.lock);
 
 	pl011_dma_shutdown(uap);
-- 
1.7.10.4
