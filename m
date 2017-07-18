From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jul 2017 18:37:55 +0100
Subject: [PATCH] irqchip/gic: Ensure we have an ISB between ack and
 ->handle_irq
Message-ID: <1500399475-11489-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devices that expose their interrupt status registers via system
registers (e.g. Statistical profiling, CPU PMU, DynamIQ PMU, arch timer,
vgic (although unused by Linux), ...) rely on a context synchronising
operation on the CPU to ensure that the updated status register is
visible to the CPU when handling the interrupt. This usually happens as
a result of taking the IRQ exception in the first place, but there are
two race scenarios where this isn't the case.

For example, let's say we have two peripherals (X and Y), where Y uses a
system register for its interrupt status.

Case 1:
1. CPU takes an IRQ exception as a result of X raising an interrupt
2. Y then raises its interrupt line, but the update to its system
   register is not yet visible to the CPU
3. The GIC decides to expose Y's interrupt number first in the Ack
   register
4. The CPU runs the IRQ handler for Y, but the status register is stale

Case 2:
1. CPU takes an IRQ exception as a result of X raising an interrupt
2. CPU reads the interrupt number for X from the Ack register and runs
   its IRQ handler
3. Y raises its interrupt line and the Ack register is updated, but
   again, the update to its system register is not yet visible to the
   CPU.
4. Since the GIC drivers poll the Ack register, we read Y's interrupt
   number and run its handler without a context synchronisation
   operation, therefore seeing the stale register value.

In either case, we run the risk of missing an IRQ. This patch solves the
problem by ensuring that we execute an ISB in the GIC drivers prior
to invoking the interrupt handler. This is already the case for GICv3
and EOIMode 1 (the usual case for the host).

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 ++
 drivers/irqchip/irq-gic.c    | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbffb7ab6203..b1297ff8b6d0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -353,6 +353,8 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 
 			if (static_key_true(&supports_deactivate))
 				gic_write_eoir(irqnr);
+			else
+				isb();
 
 			err = handle_domain_irq(gic_data.domain, irqnr, regs);
 			if (err) {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1b1df4f770bd..f45aef69e352 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -361,6 +361,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		if (likely(irqnr > 15 && irqnr < 1020)) {
 			if (static_key_true(&supports_deactivate))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
+			isb();
 			handle_domain_irq(gic->domain, irqnr, regs);
 			continue;
 		}
@@ -401,10 +402,12 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 		goto out;
 
 	cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
-	if (unlikely(gic_irq < 32 || gic_irq > 1020))
+	if (unlikely(gic_irq < 32 || gic_irq > 1020)) {
 		handle_bad_irq(desc);
-	else
+	} else {
+		isb();
 		generic_handle_irq(cascade_irq);
+	}
 
  out:
 	chained_irq_exit(chip, desc);
-- 
2.1.4
