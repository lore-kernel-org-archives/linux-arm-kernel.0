From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 19 May 2015 11:51:14 +0100
Subject: [PATCH] serial/amba-pl011: Fix mismerge between v4.1-rc4 and tty-next
Message-ID: <1432032674-22167-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 02730d3c053a9af1d402e1c8dc8bbbc5a1340406
(Merge 4.1-rc4 into tty-next), git mismerged some lines,
reintroducing a reference to the removed field
uart_amba_port.tx_irq_seen.  This causes a build failure.

This patch removes the mismerged lines, restoring the code to what
was in tty-next (which was the intention).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

This patch is based on tty-next commit
02730d3c053a9af1d402e1c8dc8bbbc5a1340406 (Merge 4.1-rc4 into tty-next).

Without it, amba-pl011.c won't build.

 drivers/tty/serial/amba-pl011.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6fabc05..f5bd842 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1578,9 +1578,6 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
-	/* Assume that TX IRQ doesn't work until we see one: */
-	uap->tx_irq_seen = 0;
-
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
-- 
1.7.10.4
