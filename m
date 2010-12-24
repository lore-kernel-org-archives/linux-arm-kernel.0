From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:25:10 +0000
Subject: [PATCH 3/6] ARM: PL011: Ensure IRQs are disabled in UART interrupt
	handler
In-Reply-To: <20101224102359.GC20587@n2100.arm.linux.org.uk>
References: <20101224102359.GC20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4pi-0006GK-JT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the DMA support introduces a separate interrupt-time callback, our
interrupt handler will not be the only handler which takes the port
lock, so we need to ensure that IRQs are disabled.  We must use the
_irqsave variant so we don't inadvertently enable interrupts.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 11cfa90..1aa7d45 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -247,10 +247,11 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
+	unsigned long flags;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
 
-	spin_lock(&uap->port.lock);
+	spin_lock_irqsave(&uap->port.lock, flags);
 
 	status = readw(uap->port.membase + UART011_MIS);
 	if (status) {
@@ -275,7 +276,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		handled = 1;
 	}
 
-	spin_unlock(&uap->port.lock);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
 
 	return IRQ_RETVAL(handled);
 }
-- 
1.6.2.5
