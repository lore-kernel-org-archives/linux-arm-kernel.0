From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jan 2012 15:01:25 +0000
Subject: [PATCH] ARM: kexec: EOI active and mask all interrupts in kexec crash
 path
Message-ID: <1326898885-28105-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kexec machine crash code can be called in interrupt context via a
sysrq trigger made using the magic key combination. If the irq chip
dealing with the serial interrupt is using the fasteoi flow handler,
then we will never EOI the interrupt because the interrupt handler will
be fatal. In the case of a GIC, this results in the crash kernel not
receiving interrupts on that CPU interface.

This patch adds code (based on the PowerPC implementation) to EOI any
pending interrupts on the crash CPU before masking and disabling all
interrupts. Secondary cores are not a problem since they are placed into
a cpu_relax() loop via an IPI.

Reported-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/machine_kexec.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 764bd45..f007c54 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -53,6 +54,28 @@ void machine_crash_nonpanic_core(void *unused)
 		cpu_relax();
 }
 
+static void machine_kexec_mask_interrupts(void) {
+	unsigned int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
+			chip->irq_eoi(&desc->irq_data);
+
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
+
+		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
+			chip->irq_disable(&desc->irq_data);
+	}
+}
+
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	unsigned long msecs;
@@ -70,6 +93,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 		printk(KERN_WARNING "Non-crashing CPUs did not react to IPI\n");
 
 	crash_save_cpu(regs, smp_processor_id());
+	machine_kexec_mask_interrupts();
 
 	printk(KERN_INFO "Loading crashdump kernel...\n");
 }
-- 
1.7.4.1
