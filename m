From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 17:39:21 +0100
Subject: [PATCH REPOST] serial/amba-pl011: Disable interrupts around TX softirq
Message-ID: <1437755961-15403-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
sufficient to inhibit pl011_int() from being triggered by a local
IRQ and trying to re-take the same lock.  This can lead to
deadlocks.

This patch uses the _irq() locking variants instead to ensure that
pl011_int() handling for a given port is deferred until any
pl011_tx_softirq() work for that port is complete.


Notes for stable:

This patch fixes an issue that is fixed by the following upstream
commit, which is a more substantial rewrite of the affected code,
fixing multiple, mostly more minor issues:

        1e84d22322ceed4767db1e5342c830dd60c8210f
        serial/amba-pl011: Refactor and simplify TX FIFO handling

The upstream patch was rejected for stable on the reasonable grounds
that it was too big and complex a patch.  The original buggy code was
merged in v4.1, and the rewrite was merged in v4.2, leaving only v4.1
affected.


This patch replaces the 1e84d22, for 4.1.x only.

Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: stable <stable@vger.kernel.org> # 4.1.x
---
 drivers/tty/serial/amba-pl011.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 763eb20..0cc622a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1360,9 +1360,9 @@ static void pl011_tx_softirq(struct work_struct *work)
 	struct uart_amba_port *uap =
 		container_of(dwork, struct uart_amba_port, tx_softirq_work);
 
-	spin_lock(&uap->port.lock);
+	spin_lock_irq(&uap->port.lock);
 	while (pl011_tx_chars(uap)) ;
-	spin_unlock(&uap->port.lock);
+	spin_unlock_irq(&uap->port.lock);
 }
 
 static void pl011_tx_irq_seen(struct uart_amba_port *uap)
-- 
1.7.10.4
