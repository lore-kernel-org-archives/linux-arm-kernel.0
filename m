From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:22 +0100
Subject: [PATCH v2 03/16] ARM: GIC: Add global gic_handle_irq() function
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the GIC code with a low level handler that can be used
by platforms using CONFIG_MULTI_IRQ_HANDLER. Though the handler is
written in C, the compiled code doesn't feel much slower than its
assembly counterpart (at least with my gcc 4.4.1).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/common/gic.c               |   23 +++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index a3f335c..5a22896 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -209,6 +209,29 @@ static int gic_set_wake(struct irq_data *d, unsigned int on)
 #define gic_set_wake	NULL
 #endif
 
+asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+
+	do {
+		irqstat = readl_relaxed(gic_cpu_base_addr + GIC_CPU_INTACK);
+		irqnr = irqstat & ~0x1c00;
+
+		if (likely(irqnr > 15 && irqnr < 1021)) {
+			handle_IRQ(irqnr, regs);
+			continue;
+		}
+		if (irqnr < 16) {
+			writel_relaxed(irqstat, gic_cpu_base_addr + GIC_CPU_EOI);
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
index 2dadd50..45e4ab4 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -38,6 +38,7 @@ extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
+void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 
-- 
1.7.0.4
