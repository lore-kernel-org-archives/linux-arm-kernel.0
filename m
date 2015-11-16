From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 19:13:25 +0000
Subject: [PATCH 1/4] arm: kexec: Deactivate in-flight interrupts
In-Reply-To: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
References: <1447701208-18150-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1447701208-18150-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

machine_kexec_mask_interrupts iterates over the system interrupts
and tries to mask all interrupts, including those that are currently
being handled.

The current method includes finding out if an interrupt is in progress,
and call the EOI method if that's the case. This methods has a few
issues when used with the GIC:

- In a hypothetical GIC centric world where we can handle
  interrupts at different priorities, nothing guarantees that
  we're going to EOI the interrupts in the mandated reverse order
  we have taken them.

- With the split EOI/Deactivate mode the GIC runs in when using
  virtualization, an interrupt can be EOIed, and still be active.
  The current code would not recognize that state (the interrupt
  is not flagged as being in progress from a host PoV).

A sensible way of avoiding these issues is to forcefully deactivate
the interrupt at the distributor level, and to only use EOI if
the deactivation has failed (which probably means that the irqchip
is not a GIC).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/machine_kexec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 8bf3b7c..66662e6 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -8,6 +8,7 @@
 #include <linux/reboot.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/memblock.h>
 #include <asm/pgtable.h>
 #include <linux/of_fdt.h>
@@ -98,12 +99,20 @@ static void machine_kexec_mask_interrupts(void)
 
 	for_each_irq_desc(i, desc) {
 		struct irq_chip *chip;
+		int ret;
 
 		chip = irq_desc_get_chip(desc);
 		if (!chip)
 			continue;
 
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
+		/*
+		 * First try to remove the active state. If this
+		 * fails, try to EOI the interrupt.
+		 */
+		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+
+		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
+		    chip->irq_eoi)
 			chip->irq_eoi(&desc->irq_data);
 
 		if (chip->irq_mask)
-- 
2.1.4
