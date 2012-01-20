From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:03:03 +0000
Subject: [PATCH] ARM: ecard: get rid of NO_IRQ madness
Message-ID: <E1RoBJH-0005UG-Pj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the NO_IRQ madness from Acorn expansion card handling code.
Thankfully, are relatively few users of this here, and so it's easy to
audit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/ecard.c     |    6 +++---
 drivers/scsi/arm/arxescsi.c |    2 +-
 drivers/scsi/arm/fas216.c   |    4 ++--
 drivers/scsi/arm/fas216.h   |    4 ----
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index 4dd0eda..ddcda2e 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -578,7 +578,7 @@ ecard_irq_handler(unsigned int irq, struct irq_desc *desc)
 	for (ec = cards; ec; ec = ec->next) {
 		int pending;
 
-		if (!ec->claimed || ec->irq == NO_IRQ || ec->slot_no == 8)
+		if (!ec->claimed || !ec->irq || ec->slot_no == 8)
 			continue;
 
 		if (ec->ops && ec->ops->irqpending)
@@ -805,8 +805,8 @@ static struct expansion_card *__init ecard_alloc_card(int type, int slot)
 
 	ec->slot_no = slot;
 	ec->easi = type == ECARD_EASI;
-	ec->irq = NO_IRQ;
-	ec->fiq = NO_IRQ;
+	ec->irq = 0;
+	ec->fiq = 0;
 	ec->dma = NO_DMA;
 	ec->ops = &ecard_default_ops;
 
diff --git a/drivers/scsi/arm/arxescsi.c b/drivers/scsi/arm/arxescsi.c
index a750aa7..2a28b4a 100644
--- a/drivers/scsi/arm/arxescsi.c
+++ b/drivers/scsi/arm/arxescsi.c
@@ -305,7 +305,7 @@ arxescsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 	info->base = base;
 
 	info->info.scsi.io_base		= base + 0x2000;
-	info->info.scsi.irq		= NO_IRQ;
+	info->info.scsi.irq		= 0;
 	info->info.scsi.dma		= NO_DMA;
 	info->info.scsi.io_shift	= 5;
 	info->info.ifcfg.clockrate	= 24; /* MHz */
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index e85c40b..6206a66 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2176,7 +2176,7 @@ static void fas216_done(FAS216_Info *info, unsigned int result)
 	fn = (void (*)(FAS216_Info *, struct scsi_cmnd *, unsigned int))SCpnt->host_scribble;
 	fn(info, SCpnt, result);
 
-	if (info->scsi.irq != NO_IRQ) {
+	if (info->scsi.irq) {
 		spin_lock_irqsave(&info->host_lock, flags);
 		if (info->scsi.phase == PHASE_IDLE)
 			fas216_kick(info);
@@ -2276,7 +2276,7 @@ static int fas216_noqueue_command_lck(struct scsi_cmnd *SCpnt,
 	 * We should only be using this if we don't have an interrupt.
 	 * Provide some "incentive" to use the queueing code.
 	 */
-	BUG_ON(info->scsi.irq != NO_IRQ);
+	BUG_ON(info->scsi.irq);
 
 	info->internal_done = 0;
 	fas216_queue_command_lck(SCpnt, fas216_internal_done);
diff --git a/drivers/scsi/arm/fas216.h b/drivers/scsi/arm/fas216.h
index 84b7127..df2e1b3 100644
--- a/drivers/scsi/arm/fas216.h
+++ b/drivers/scsi/arm/fas216.h
@@ -12,10 +12,6 @@
 #ifndef FAS216_H
 #define FAS216_H
 
-#ifndef NO_IRQ
-#define NO_IRQ 255
-#endif
-
 #include <scsi/scsi_eh.h>
 
 #include "queue.h"
-- 
1.7.4.4
