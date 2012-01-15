From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Jan 2012 12:15:09 +0000
Subject: [RFC] Fix handling of pending IRQs at request time
Message-ID: <20120115121509.GS1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an interrupt is marked as pending, and then subsequently requested,
the interrupt is not delivered to the handler.  The pending status is
entirely ignored, and is left set.  The patch below ensures that this
pending status is acted upon while requesting the interrupt.

This matters for two reasons:

1. If a suspend/resume cycle subsequently occurs, upon resume, we call
   check_irq_resend() while the interrupt layer is resuming.  This notices
   the pending IRQ, and tries to deliver it.

   However, at this time, the device drivers have not been resumed.  If
   the device is behind a serial bus which has not been configured, this
   can cause the kernel to hang or timeout while trying to access the
   inaccessible device.

2. If the device whose interrupt is being requested has already asserted
   its interrupt signal (and is holding it at its own active level) we
   need to process that interrupt to clear down the interrupt, to allow
   an edge-triggered interrupt input to respond to subsequent activations.

This can be caused by an interrupt occuring after free_irq(), the flow
handler noticing that it's been disabled, and recording an IRQS_PENDING
status, or by use of the probe_irq_*() functions.  Either gets us to the
state where we have IRQS_PENDING set, and remaining set indefinitely
after a subsequent request_irq() succeeds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 kernel/irq/manage.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1da999f..ef21e65 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1026,9 +1026,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		if (new->flags & IRQF_ONESHOT)
 			desc->istate |= IRQS_ONESHOT;
 
-		if (irq_settings_can_autoenable(desc))
+		if (irq_settings_can_autoenable(desc)) {
 			irq_startup(desc);
-		else
+			check_irq_resend(desc, irq);
+		} else
 			/* Undo nested disables: */
 			desc->depth = 1;
 
