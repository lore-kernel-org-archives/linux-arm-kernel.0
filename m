From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:37 +0000
Subject: [PATCH v3 03/17] ARM: GIC: Add global gic_handle_irq() function
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the GIC code with a low level handler that can be used
by platforms using CONFIG_MULTI_IRQ_HANDLER.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c               |   27 +++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 1565fca..2d29d86 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 
 #include <asm/irq.h>
+#include <asm/exception.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
 
@@ -242,6 +243,32 @@ static int gic_set_wake(struct irq_data *d, unsigned int on)
 #define gic_set_wake	NULL
 #endif
 
+asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+	struct gic_chip_data *gic = &gic_data[0];
+	void __iomem *cpu_base = gic_data_cpu_base(gic);
+
+	do {
+		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
+		irqnr = irqstat & ~0x1c00;
+
+		if (likely(irqnr > 15 && irqnr < 1021)) {
+			irqnr = irq_domain_to_irq(&gic->domain, irqnr);
+			handle_IRQ(irqnr, regs);
+			continue;
+		}
+		if (irqnr < 16) {
+			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
+#ifdef CONFIG_SMP
+			handle_IPI(irqnr, regs);
+#endif
+			continue;
+		}
+		break;
+	} while (1);
+}
+
 static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct gic_chip_data *chip_data = irq_get_handler_data(irq);
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 729e00b..a38eee2 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -42,6 +42,7 @@ extern struct irq_chip gic_arch_extn;
 void gic_init(unsigned int, int, void __iomem *, void __iomem *);
 int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init_base(unsigned int, void __iomem *, void __iomem *);
+void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 
-- 
1.7.0.4
