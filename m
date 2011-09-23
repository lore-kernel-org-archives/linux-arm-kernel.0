From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:23 +0100
Subject: [RFC PATCH 05/14] ARM: GIC: Add global gic_handle_irq_offset()
	function
In-Reply-To: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1316796692-15964-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to gic_handle_irq(), gic_handle_irq_offset() is provided
for those platform who insist on having their GIC base interrupt
at something different from zero. At the moment, Exynos4 is the
only one...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c               |   24 ++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    1 +
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index a7b2a4a..ea8bfc5 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -232,6 +232,30 @@ asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
+asmlinkage void __exception_irq_entry gic_handle_irq_offset(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+	u32 offset = gic_data[0].irq_offset;
+
+	do {
+		irqstat = readl_relaxed(gic_cpu_base_addr + GIC_CPU_INTACK);
+		irqnr = irqstat & ~0x1c00;
+
+		if (likely(irqnr > 15 && irqnr < 1021)) {
+			handle_IRQ(irqnr + offset, regs);
+			continue;
+		}
+		if (irqnr < 16) {
+			writel_relaxed(irqstat, gic_cpu_base_addr + GIC_CPU_EOI);
+#ifdef CONFIG_SMP
+			do_IPI(irqnr, regs);
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
index 45e4ab4..0f454c6 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -39,6 +39,7 @@ extern struct irq_chip gic_arch_extn;
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
 void gic_handle_irq(struct pt_regs *regs);
+void gic_handle_irq_offset(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 
-- 
1.7.0.4
