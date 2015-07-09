From: Dave.Martin@arm.com (Dave Martin)
Date: Thu,  9 Jul 2015 11:57:12 +0100
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Message-ID: <1436439433-10258-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
sufficient to inhibit pl011_int() from being triggered by a local
IRQ and trying to re-take the same lock.  This can lead to
deadlocks.

This patch uses the _irq() locking variants instead to ensure that
pl011_int() handling for a given port is deferred until any
pl011_tx_softirq() work for that port is complete.

Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: stable <stable@vger.kernel.org> # 4.1
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
