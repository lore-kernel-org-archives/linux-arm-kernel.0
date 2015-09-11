From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Fri, 11 Sep 2015 15:40:52 -0700
Subject: Patch "ARM: OMAP: wakeupgen: Restore the irq_set_type() mechanism"
 has been added to the 4.1-stable tree
Message-ID: <1442011252231252@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    ARM: OMAP: wakeupgen: Restore the irq_set_type() mechanism

to the 4.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     arm-omap-wakeupgen-restore-the-irq_set_type-mechanism.patch
and it can be found in the queue-4.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 63059a272398ef5dc1bd7065a036e8b6e82d1af7 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 14 Aug 2015 15:20:28 +0300
Subject: ARM: OMAP: wakeupgen: Restore the irq_set_type() mechanism

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit 63059a272398ef5dc1bd7065a036e8b6e82d1af7 upstream.

The conversion of the wakeupgen irqchip to hierarchical irq domains
failed to provide a mechanism to properly set the trigger type of an
interrupt.

The wakeupgen irq chip itself has no mechanism and therefor no
irq_set_type() callback. The code before the conversion relayed the
trigger configuration directly to the underlying GIC.

Restore the correct behaviour by setting the wakeupgen irq_set_type
callback to irq_chip_set_type_parent(). This propagates the
set_trigger() call to the underlying GIC irqchip.

[ tglx: Massaged changelog ]

Fixes: 7136d457f365 ('ARM: omap: convert wakeupgen to stacked domains')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: <linux@arm.linux.org.uk>
Cc: <nsekhar@ti.com>
Cc: <jason@lakedaemon.net>
Cc: <balbi@ti.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/1439554830-19502-5-git-send-email-grygorii.strashko at ti.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-omap2/omap-wakeupgen.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -392,6 +392,7 @@ static struct irq_chip wakeupgen_chip =
 	.irq_mask		= wakeupgen_mask,
 	.irq_unmask		= wakeupgen_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,


Patches currently in stable-queue which might be from grygorii.strashko at ti.com are

queue-4.1/irqchip-crossbar-restore-the-mask-on-suspend-behaviour.patch
queue-4.1/genirq-don-t-return-enosys-in-irq_chip_retrigger_hierarchy.patch
queue-4.1/irqchip-crossbar-restore-set_wake-functionality.patch
queue-4.1/irqchip-crossbar-restore-the-irq_set_type-mechanism.patch
queue-4.1/arm-dts-dra7-fix-broken-pbias-device-creation.patch
queue-4.1/genirq-introduce-irq_chip_set_type_parent-helper.patch
queue-4.1/arm-omap-wakeupgen-restore-the-irq_set_type-mechanism.patch
