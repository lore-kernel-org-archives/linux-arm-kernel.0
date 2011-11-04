From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:49 +0000
Subject: [PATCH v3 15/17] ARM: omap2/3: Add global omap2/3_intc_handle_irq()
	functions
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the OMAP2/3 IRQ code with low level handlers that can be used
by platforms using CONFIG_MULTI_IRQ_HANDLER. Though the handlers are
written in C, the compiled code looks very similar to its assembly
counterpart (at least with my gcc 4.4.1).

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/irq.c              |   50 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h |    2 +
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 65f1be6..ec52bee 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
+#include <asm/exception.h>
 #include <asm/mach/irq.h>
 
 
@@ -35,6 +36,11 @@
 /* Number of IRQ state bits in each MIR register */
 #define IRQ_BITS_PER_REG	32
 
+#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
+#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
+#define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
+
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -191,6 +197,44 @@ void __init ti816x_init_irq(void)
 	omap_init_irq(OMAP34XX_IC_BASE, 128);
 }
 
+static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs *regs)
+{
+	u32 irqnr;
+
+	do {
+		irqnr = readl_relaxed(base_addr + 0x98);
+		if (irqnr)
+			goto out;
+
+		irqnr = readl_relaxed(base_addr + 0xb8);
+		if (irqnr)
+			goto out;
+
+		irqnr = readl_relaxed(base_addr + 0xd8);
+#ifdef CONFIG_SOC_OMAPTI816X
+		if (irqnr)
+			goto out;
+		irqnr = readl_relaxed(base_addr + 0xf8);
+#endif
+
+out:
+		if (!irqnr)
+			break;
+
+		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
+		irqnr &= ACTIVEIRQ_MASK;
+
+		if (irqnr)
+			handle_IRQ(irqnr, regs);
+	} while (irqnr);
+}
+
+asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs)
+{
+	void __iomem *base_addr = OMAP2_IRQ_BASE;
+	omap_intc_handle_irq(base_addr, regs);
+}
+
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
@@ -263,4 +307,10 @@ void omap3_intc_resume_idle(void)
 	/* Re-enable autoidle */
 	intc_bank_write_reg(1, &irq_banks[0], INTC_SYSCONFIG);
 }
+
+asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
+{
+	void __iomem *base_addr = OMAP3_IRQ_BASE;
+	omap_intc_handle_irq(base_addr, regs);
+}
 #endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 30e1071..8b19a63 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -448,6 +448,8 @@ void omap_intc_restore_context(void);
 void omap3_intc_suspend(void);
 void omap3_intc_prepare_idle(void);
 void omap3_intc_resume_idle(void);
+void omap2_intc_handle_irq(struct pt_regs *regs);
+void omap3_intc_handle_irq(struct pt_regs *regs);
 #endif
 
 #include <mach/hardware.h>
-- 
1.7.0.4
