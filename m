From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 19 May 2015 01:11:36 +0300
Subject: [PATCH 2/2] ARM: sa1100: move irq driver to drivers/irqchip/
In-Reply-To: <1431987096-16308-1-git-send-email-dbaryshkov@gmail.com>
References: <1431987096-16308-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1431987096-16308-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move current sa11x0 IRQ driver to the irqchip subsystem.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/Makefile |   2 +-
 arch/arm/mach-sa1100/irq.c    | 177 ------------------------------------------
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-sa11x0.c  | 175 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 178 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/irq.c
 create mode 100644 drivers/irqchip/irq-sa11x0.c

diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 61ff91e..ebc4d58 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := clock.o generic.o irq.o #nmi-oopser.o
+obj-y := clock.o generic.o #nmi-oopser.o
 
 # Specific board support
 obj-$(CONFIG_SA1100_ASSABET)		+= assabet.o
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
deleted file mode 100644
index fdec5ed..0000000
--- a/arch/arm/mach-sa1100/irq.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * linux/arch/arm/mach-sa1100/irq.c
- *
- * Copyright (C) 2015 Dmitry Eremin-Solenikov
- * Copyright (C) 1999-2001 Nicolas Pitre
- *
- * Generic IRQ handling for the SA11x0.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/syscore_ops.h>
-#include <linux/irqchip/irq-sa11x0.h>
-
-#include <soc/sa1100/pwer.h>
-
-#include <asm/exception.h>
-
-#define ICIP	0x00  /* IC IRQ Pending reg. */
-#define ICMR	0x04  /* IC Mask Reg.        */
-#define ICLR	0x08  /* IC Level Reg.       */
-#define ICCR	0x0C  /* IC Control Reg.     */
-#define ICFP	0x10  /* IC FIQ Pending reg. */
-#define ICPR	0x20  /* IC Pending Reg.     */
-
-static void __iomem *iobase;
-
-/*
- * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
- * this is for internal IRQs i.e. from IRQ LCD to RTCAlrm.
- */
-static void sa1100_mask_irq(struct irq_data *d)
-{
-	u32 reg;
-
-	reg = readl_relaxed(iobase + ICMR);
-	reg &= ~BIT(d->hwirq);
-	writel_relaxed(reg, iobase + ICMR);
-}
-
-static void sa1100_unmask_irq(struct irq_data *d)
-{
-	u32 reg;
-
-	reg = readl_relaxed(iobase + ICMR);
-	reg |= BIT(d->hwirq);
-	writel_relaxed(reg, iobase + ICMR);
-}
-
-static int sa1100_set_wake(struct irq_data *d, unsigned int on)
-{
-	return sa11x0_sc_set_wake(d->hwirq, on);
-}
-
-static struct irq_chip sa1100_normal_chip = {
-	.name		= "SC",
-	.irq_ack	= sa1100_mask_irq,
-	.irq_mask	= sa1100_mask_irq,
-	.irq_unmask	= sa1100_unmask_irq,
-	.irq_set_wake	= sa1100_set_wake,
-};
-
-static int sa1100_normal_irqdomain_map(struct irq_domain *d,
-		unsigned int irq, irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &sa1100_normal_chip,
-				 handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID);
-
-	return 0;
-}
-
-static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
-	.map = sa1100_normal_irqdomain_map,
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
-static struct irq_domain *sa1100_normal_irqdomain;
-
-static struct sa1100irq_state {
-	unsigned int	saved;
-	unsigned int	icmr;
-	unsigned int	iclr;
-	unsigned int	iccr;
-} sa1100irq_state;
-
-static int sa1100irq_suspend(void)
-{
-	struct sa1100irq_state *st = &sa1100irq_state;
-
-	st->saved = 1;
-	st->icmr = readl_relaxed(iobase + ICMR);
-	st->iclr = readl_relaxed(iobase + ICLR);
-	st->iccr = readl_relaxed(iobase + ICCR);
-
-	/*
-	 * Disable all GPIO-based interrupts.
-	 */
-	writel_relaxed(st->icmr & 0xfffff000, iobase + ICMR);
-
-	return 0;
-}
-
-static void sa1100irq_resume(void)
-{
-	struct sa1100irq_state *st = &sa1100irq_state;
-
-	if (st->saved) {
-		writel_relaxed(st->iccr, iobase + ICCR);
-		writel_relaxed(st->iclr, iobase + ICLR);
-
-		writel_relaxed(st->icmr, iobase + ICMR);
-	}
-}
-
-static struct syscore_ops sa1100irq_syscore_ops = {
-	.suspend	= sa1100irq_suspend,
-	.resume		= sa1100irq_resume,
-};
-
-static int __init sa1100irq_init_devicefs(void)
-{
-	register_syscore_ops(&sa1100irq_syscore_ops);
-	return 0;
-}
-
-device_initcall(sa1100irq_init_devicefs);
-
-static asmlinkage void __exception_irq_entry
-sa1100_handle_irq(struct pt_regs *regs)
-{
-	uint32_t icip, icmr, mask;
-
-	do {
-		icip = readl_relaxed(iobase + ICIP);
-		icmr = readl_relaxed(iobase + ICMR);
-		mask = icip & icmr;
-
-		if (mask == 0)
-			break;
-
-		handle_domain_irq(sa1100_normal_irqdomain,
-				ffs(mask) - 1, regs);
-	} while (1);
-}
-
-void __init sa11x0_init_irq_nodt(int irq_start, resource_size_t io_start)
-{
-	iobase = ioremap(io_start, SZ_64K);
-	if (WARN_ON(!iobase))
-		return;
-
-	/* disable all IRQs */
-	writel_relaxed(0, iobase + ICMR);
-
-	/* all IRQs are IRQ, not FIQ */
-	writel_relaxed(0, iobase + ICLR);
-
-	/*
-	 * Whatever the doc says, this has to be set for the wait-on-irq
-	 * instruction to work... on a SA1100 rev 9 at least.
-	 */
-	writel_relaxed(1, iobase + ICCR);
-
-	sa1100_normal_irqdomain = irq_domain_add_simple(NULL,
-			32, irq_start,
-			&sa1100_normal_irqdomain_ops, NULL);
-
-	set_handle_irq(sa1100_handle_irq);
-}
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..49f372a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
+obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
new file mode 100644
index 0000000..97d257b
--- /dev/null
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2015 Dmitry Eremin-Solenikov
+ * Copyright (C) 1999-2001 Nicolas Pitre
+ *
+ * Generic IRQ handling for the SA11x0.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/syscore_ops.h>
+#include <linux/irqchip/irq-sa11x0.h>
+
+#include <soc/sa1100/pwer.h>
+
+#include <asm/exception.h>
+
+#define ICIP	0x00  /* IC IRQ Pending reg. */
+#define ICMR	0x04  /* IC Mask Reg.        */
+#define ICLR	0x08  /* IC Level Reg.       */
+#define ICCR	0x0C  /* IC Control Reg.     */
+#define ICFP	0x10  /* IC FIQ Pending reg. */
+#define ICPR	0x20  /* IC Pending Reg.     */
+
+static void __iomem *iobase;
+
+/*
+ * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
+ * this is for internal IRQs i.e. from IRQ LCD to RTCAlrm.
+ */
+static void sa1100_mask_irq(struct irq_data *d)
+{
+	u32 reg;
+
+	reg = readl_relaxed(iobase + ICMR);
+	reg &= ~BIT(d->hwirq);
+	writel_relaxed(reg, iobase + ICMR);
+}
+
+static void sa1100_unmask_irq(struct irq_data *d)
+{
+	u32 reg;
+
+	reg = readl_relaxed(iobase + ICMR);
+	reg |= BIT(d->hwirq);
+	writel_relaxed(reg, iobase + ICMR);
+}
+
+static int sa1100_set_wake(struct irq_data *d, unsigned int on)
+{
+	return sa11x0_sc_set_wake(d->hwirq, on);
+}
+
+static struct irq_chip sa1100_normal_chip = {
+	.name		= "SC",
+	.irq_ack	= sa1100_mask_irq,
+	.irq_mask	= sa1100_mask_irq,
+	.irq_unmask	= sa1100_unmask_irq,
+	.irq_set_wake	= sa1100_set_wake,
+};
+
+static int sa1100_normal_irqdomain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sa1100_normal_chip,
+				 handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
+	.map = sa1100_normal_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irq_domain *sa1100_normal_irqdomain;
+
+static struct sa1100irq_state {
+	unsigned int	saved;
+	unsigned int	icmr;
+	unsigned int	iclr;
+	unsigned int	iccr;
+} sa1100irq_state;
+
+static int sa1100irq_suspend(void)
+{
+	struct sa1100irq_state *st = &sa1100irq_state;
+
+	st->saved = 1;
+	st->icmr = readl_relaxed(iobase + ICMR);
+	st->iclr = readl_relaxed(iobase + ICLR);
+	st->iccr = readl_relaxed(iobase + ICCR);
+
+	/*
+	 * Disable all GPIO-based interrupts.
+	 */
+	writel_relaxed(st->icmr & 0xfffff000, iobase + ICMR);
+
+	return 0;
+}
+
+static void sa1100irq_resume(void)
+{
+	struct sa1100irq_state *st = &sa1100irq_state;
+
+	if (st->saved) {
+		writel_relaxed(st->iccr, iobase + ICCR);
+		writel_relaxed(st->iclr, iobase + ICLR);
+
+		writel_relaxed(st->icmr, iobase + ICMR);
+	}
+}
+
+static struct syscore_ops sa1100irq_syscore_ops = {
+	.suspend	= sa1100irq_suspend,
+	.resume		= sa1100irq_resume,
+};
+
+static int __init sa1100irq_init_devicefs(void)
+{
+	register_syscore_ops(&sa1100irq_syscore_ops);
+	return 0;
+}
+
+device_initcall(sa1100irq_init_devicefs);
+
+static asmlinkage void __exception_irq_entry
+sa1100_handle_irq(struct pt_regs *regs)
+{
+	uint32_t icip, icmr, mask;
+
+	do {
+		icip = readl_relaxed(iobase + ICIP);
+		icmr = readl_relaxed(iobase + ICMR);
+		mask = icip & icmr;
+
+		if (mask == 0)
+			break;
+
+		handle_domain_irq(sa1100_normal_irqdomain,
+				ffs(mask) - 1, regs);
+	} while (1);
+}
+
+void __init sa11x0_init_irq_nodt(int irq_start, resource_size_t io_start)
+{
+	iobase = ioremap(io_start, SZ_64K);
+	if (WARN_ON(!iobase))
+		return;
+
+	/* disable all IRQs */
+	writel_relaxed(0, iobase + ICMR);
+
+	/* all IRQs are IRQ, not FIQ */
+	writel_relaxed(0, iobase + ICLR);
+
+	/*
+	 * Whatever the doc says, this has to be set for the wait-on-irq
+	 * instruction to work... on a SA1100 rev 9 at least.
+	 */
+	writel_relaxed(1, iobase + ICCR);
+
+	sa1100_normal_irqdomain = irq_domain_add_simple(NULL,
+			32, irq_start,
+			&sa1100_normal_irqdomain_ops, NULL);
+
+	set_handle_irq(sa1100_handle_irq);
+}
-- 
2.1.4
