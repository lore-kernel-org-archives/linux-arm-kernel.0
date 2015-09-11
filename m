From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Fri, 11 Sep 2015 15:41:24 -0700
Subject: Patch "irqchip/crossbar: Restore the mask on suspend behaviour" has
 been added to the 4.1-stable tree
Message-ID: <144201128410165@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    irqchip/crossbar: Restore the mask on suspend behaviour

to the 4.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     irqchip-crossbar-restore-the-mask-on-suspend-behaviour.patch
and it can be found in the queue-4.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 4fd8f47e7e5b64a74b60f23c2e08ba8234d659d1 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 14 Aug 2015 15:20:29 +0300
Subject: irqchip/crossbar: Restore the mask on suspend behaviour

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit 4fd8f47e7e5b64a74b60f23c2e08ba8234d659d1 upstream.

The ARM GIC requires that all interrupts which are not used as a
wakeup source have to be masked during suspend.

The conversion of the crossbar irqchip to hierarchical irq domains
failed to mark the crossbar irqchip with the IRQCHIP_MASK_ON_SUSPEND
flag and therefor broke the suspend requirement of the GIC.

Before the conversion the flags were visible because the GIC was the
top level irqchip. After the conversion the crossbar irqchip is the
top level irq chip whose flags are evaluated in suspend_device_irq().
As the flag is not set the masking of the non-wakeup irqs is not
invoked which breaks suspend.

Add the IRQCHIP_MASK_ON_SUSPEND flag to the crossbar irqchip, so the
GIC interrupts get masked properly.

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
Link: http://lkml.kernel.org/r/1439554830-19502-6-git-send-email-grygorii.strashko at ti.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-crossbar.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -70,6 +70,7 @@ static struct irq_chip crossbar_chip = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= irq_chip_set_wake_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
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
