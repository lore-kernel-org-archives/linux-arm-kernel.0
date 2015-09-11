From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Fri, 11 Sep 2015 15:41:18 -0700
Subject: Patch "irqchip/crossbar: Restore set_wake functionality" has been
 added to the 4.1-stable tree
Message-ID: <1442011278165210@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    irqchip/crossbar: Restore set_wake functionality

to the 4.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     irqchip-crossbar-restore-set_wake-functionality.patch
and it can be found in the queue-4.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 8200fe4347870d4ad6475048bcdf3e7c106c5268 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 14 Aug 2015 15:20:30 +0300
Subject: irqchip/crossbar: Restore set_wake functionality

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit 8200fe4347870d4ad6475048bcdf3e7c106c5268 upstream.

The TI crossbar irqchip doesn't provides any facility to configure the
wakeup sources, but the conversion to hierarchical irqdomains set the
irq_set_wake callback to irq_chip_set_wake_parent. The parent chip
(OMAP wakeupgen) has no irq_set_wake function either so the call will
fail with -ENOSYS. As a result the irq_set_wake() call in the resume
path will trigger an 'Unbalanced wake disable' warning.

Before the conversion the GIC irqchip was the top level irqchip and
correctly flagged with IRQCHIP_SKIP_SET_WAKE.

Restore the correct behaviour by removing the irq_set_type callback
from the crossbar irqchip and set the IRQCHIP_SKIP_SET_WAKE flag which
lets the irq_set_irq_wake() call from the driver succeed.

[ tglx: Massaged changelog ]

Fixes: 783d31863fb8 ('irqchip: crossbar: Convert dra7 crossbar...')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: <linux@arm.linux.org.uk>
Cc: <nsekhar@ti.com>
Cc: <jason@lakedaemon.net>
Cc: <balbi@ti.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <tony@atomide.com>
Cc: <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/1439554830-19502-7-git-send-email-grygorii.strashko at ti.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-crossbar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -68,9 +68,9 @@ static struct irq_chip crossbar_chip = {
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_wake		= irq_chip_set_wake_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SKIP_SET_WAKE,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif


Patches currently in stable-queue which might be from grygorii.strashko at ti.com are

queue-4.1/irqchip-crossbar-restore-the-mask-on-suspend-behaviour.patch
queue-4.1/genirq-don-t-return-enosys-in-irq_chip_retrigger_hierarchy.patch
queue-4.1/irqchip-crossbar-restore-set_wake-functionality.patch
queue-4.1/irqchip-crossbar-restore-the-irq_set_type-mechanism.patch
queue-4.1/arm-dts-dra7-fix-broken-pbias-device-creation.patch
queue-4.1/genirq-introduce-irq_chip_set_type_parent-helper.patch
queue-4.1/arm-omap-wakeupgen-restore-the-irq_set_type-mechanism.patch
