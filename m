From: neilb@suse.de (NeilBrown)
Date: Fri, 4 May 2012 15:12:21 +1000
Subject: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice
 level-triggered interrupts.
In-Reply-To: <alpine.LFD.2.02.1204251402360.2542@ionos>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.85239.stgit@notabene.brown>
 <alpine.LFD.2.02.1204251018530.2542@ionos>
 <20120425193916.0db1b4b1@notabene.brown>
 <alpine.LFD.2.02.1204251402360.2542@ionos>
Message-ID: <20120504151221.6998d4e5@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Apr 2012 14:54:54 +0200 (CEST) Thomas Gleixner
<tglx@linutronix.de> wrote:

> Why not simply managing the pending bit for level irqs ?
> 

Hi Thomas,
 thanks again for the patch.  I finally made time to test it and it works as
expected.  I've included it below with a change-log entry and tested-by:
in case that helps.

Thanks,
NeilBrown


From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 25 Apr 2012 12:54:54 +0200
Subject: [PATCH] IRQ: allow check_wakeup_irqs to notice level-triggered interrupts.

Level triggered interrupts do not cause IRQS_PENDING to be set when
they fire-while-disabled as the 'pending' state is always present in
the level - they automatically refire where re-enabled.

However the IRQS_PENDING flag is also used to abort a suspend cycle -
if any 'is_wakeup_set' interrupt is PENDING, check_wakeup_irqs() will
cause suspend to abort. Without IRQS_PENDING, suspend won't abort.

Consequently, level-triggered interrupts that fire during the 'noirq'
phase of suspend do not currently abort suspend.

So set IRQS_PENDING even for level triggered interrupts, and make sure
to clear the flag in check_irq_resend.

Also: in check_wakeup_irqs, ignore 'is_wakeup' interrupts that were
already disabled before suspend_device_irqs() disabled them further.

Tested-by: NeilBrown <neilb@suse.de>

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6080f6b..741f836 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -379,8 +379,10 @@ handle_level_irq(unsigned int irq, struct irq_desc *desc)
 	 * If its disabled or no action available
 	 * keep it masked and get out of here
 	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data)))
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
 		goto out_unlock;
+	}
 
 	handle_irq_event(desc);
 
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 15e53b1..b858ce3 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -103,7 +103,8 @@ int check_wakeup_irqs(void)
 	int irq;
 
 	for_each_irq_desc(irq, desc) {
-		if (irqd_is_wakeup_set(&desc->irq_data)) {
+		if (desc->depth == 1 &&
+		    irqd_is_wakeup_set(&desc->irq_data)) {
 			if (desc->istate & IRQS_PENDING)
 				return -EBUSY;
 			continue;
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 14dd576..6454db7 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -58,10 +58,13 @@ void check_irq_resend(struct irq_desc *desc, unsigned int irq)
 	/*
 	 * We do not resend level type interrupts. Level type
 	 * interrupts are resent by hardware when they are still
-	 * active.
+	 * active. Clear the pending bit so suspend/resume does not
+	 * get confused.
 	 */
-	if (irq_settings_is_level(desc))
+	if (irq_settings_is_level(desc)) {
+		desc->istate &= ~IRQS_PENDING;
 		return;
+	}
 	if (desc->istate & IRQS_REPLAY)
 		return;
 	if (desc->istate & IRQS_PENDING) {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/f8e80438/attachment.sig>
