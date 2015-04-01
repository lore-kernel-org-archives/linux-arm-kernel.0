From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  1 Apr 2015 12:09:44 +0100
Subject: [PATCH REPOST v4 1/2] Revert "serial/amba-pl011: Leave the TX IRQ
 alone when the UART is not open"
In-Reply-To: <1427886345-8507-1-git-send-email-Dave.Martin@arm.com>
References: <1427886345-8507-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1427886584-8680-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit f2ee6dfa0e8597eea8b98d240b0033994e20d215.

Jakub Kici?ski observed that this patch can cause the pl011
driver to hang if if the only process with a pl011 port open is
killed by a signal, pl011_shutdown() can get called with an
arbitrary amount of data still in the FIFO.

Calling _shutdown() with the TX FIFO non-empty is questionable
behaviour and my itself be a bug.

Since the affected patch was speculative anyway, and brings limited
benefit, the simplest course is to remove the assumption that TXIS
will always be left asserted after the port is shut down.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5a4e9d5..6f5a072 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1639,6 +1639,9 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
+	/* Assume that TX IRQ doesn't work until we see one: */
+	uap->tx_irq_seen = 0;
+
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
@@ -1702,7 +1705,7 @@ static void pl011_shutdown(struct uart_port *port)
 	spin_lock_irq(&uap->port.lock);
 	uap->im = 0;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
+	writew(0xffff, uap->port.membase + UART011_ICR);
 	spin_unlock_irq(&uap->port.lock);
 
 	pl011_dma_shutdown(uap);
-- 
1.7.10.4
