From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Feb 2014 12:07:46 +0400
Subject: [PATCH v2 RESEND 1/3] ARM: clps711x: Add CLPS711X irqchip driver
Message-ID: <1391328466-30873-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                |   2 -
 arch/arm/mach-clps711x/common.h |   3 +
 drivers/irqchip/Kconfig         |   8 ++
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-clps711x.c  | 243 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 255 insertions(+), 2 deletions(-)
 create mode 100644 drivers/irqchip/irq-clps711x.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e254198..56a56f7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -388,8 +388,6 @@ config ARCH_CLPS711X
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
 	select MFD_SYSCON
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 9a6767b..f6b43a9 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -16,3 +16,6 @@ extern void clps711x_timer_init(void);
 extern void clps711x_handle_irq(struct pt_regs *regs);
 extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
 extern void clps711x_init_early(void);
+
+/* drivers/irqchip/irq-clps711x.c */
+void clps711x_intc_init(phys_addr_t, resource_size_t);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 61ffdca..ec42d2d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -39,6 +39,14 @@ config IMGPDC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config CLPS711X_IRQCHIP
+	bool
+	depends on ARCH_CLPS711X
+	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	default y
+
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 98589e7..9c84342 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
 obj-$(CONFIG_ARCH_MOXART)		+= irq-moxart.o
+obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
new file mode 100644
index 0000000..33340dc
--- /dev/null
+++ b/drivers/irqchip/irq-clps711x.c
@@ -0,0 +1,243 @@
+/*
+ *  CLPS711X IRQ driver
+ *
+ *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+#include <asm/exception.h>
+#include <asm/mach/irq.h>
+
+#include "irqchip.h"
+
+#define CLPS711X_INTSR1	(0x0240)
+#define CLPS711X_INTMR1	(0x0280)
+#define CLPS711X_BLEOI	(0x0600)
+#define CLPS711X_MCEOI	(0x0640)
+#define CLPS711X_TEOI	(0x0680)
+#define CLPS711X_TC1EOI	(0x06c0)
+#define CLPS711X_TC2EOI	(0x0700)
+#define CLPS711X_RTCEOI	(0x0740)
+#define CLPS711X_UMSEOI	(0x0780)
+#define CLPS711X_COEOI	(0x07c0)
+#define CLPS711X_INTSR2	(0x1240)
+#define CLPS711X_INTMR2	(0x1280)
+#define CLPS711X_SRXEOF	(0x1600)
+#define CLPS711X_KBDEOI	(0x1700)
+#define CLPS711X_INTSR3	(0x2240)
+#define CLPS711X_INTMR3	(0x2280)
+
+static const struct {
+#define CLPS711X_FLAG_EN	(1 << 0)
+#define CLPS711X_FLAG_FIQ	(1 << 1)
+	unsigned int	flags;
+	phys_addr_t	eoi;
+} clps711x_irqs[] = {
+	[1]	= { CLPS711X_FLAG_FIQ, CLPS711X_BLEOI, },
+	[3]	= { CLPS711X_FLAG_FIQ, CLPS711X_MCEOI, },
+	[4]	= { CLPS711X_FLAG_EN, CLPS711X_COEOI, },
+	[5]	= { CLPS711X_FLAG_EN, },
+	[6]	= { CLPS711X_FLAG_EN, },
+	[7]	= { CLPS711X_FLAG_EN, },
+	[8]	= { CLPS711X_FLAG_EN, CLPS711X_TC1EOI, },
+	[9]	= { CLPS711X_FLAG_EN, CLPS711X_TC2EOI, },
+	[10]	= { CLPS711X_FLAG_EN, CLPS711X_RTCEOI, },
+	[11]	= { CLPS711X_FLAG_EN, CLPS711X_TEOI, },
+	[12]	= { CLPS711X_FLAG_EN, },
+	[13]	= { CLPS711X_FLAG_EN, },
+	[14]	= { CLPS711X_FLAG_EN, CLPS711X_UMSEOI, },
+	[15]	= { CLPS711X_FLAG_EN, CLPS711X_SRXEOF, },
+	[16]	= { CLPS711X_FLAG_EN, CLPS711X_KBDEOI, },
+	[17]	= { CLPS711X_FLAG_EN, },
+	[18]	= { CLPS711X_FLAG_EN, },
+	[28]	= { CLPS711X_FLAG_EN, },
+	[29]	= { CLPS711X_FLAG_EN, },
+	[32]	= { CLPS711X_FLAG_FIQ, },
+};
+
+static struct {
+	void __iomem		*base;
+	void __iomem		*intmr[3];
+	void __iomem		*intsr[3];
+	struct irq_domain	*domain;
+	struct irq_domain_ops	ops;
+} *clps711x_intc;
+
+static asmlinkage void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
+{
+	u32 irqnr, irqstat;
+
+	do {
+		irqstat = readw_relaxed(clps711x_intc->intmr[0]) &
+			  readw_relaxed(clps711x_intc->intsr[0]);
+		if (irqstat) {
+			irqnr =	irq_find_mapping(clps711x_intc->domain,
+						 fls(irqstat) - 1);
+			handle_IRQ(irqnr, regs);
+		}
+
+		irqstat = readw_relaxed(clps711x_intc->intmr[1]) &
+			  readw_relaxed(clps711x_intc->intsr[1]);
+		if (irqstat) {
+			irqnr =	irq_find_mapping(clps711x_intc->domain,
+						 fls(irqstat) - 1 + 16);
+			handle_IRQ(irqnr, regs);
+		}
+	} while (irqstat);
+}
+
+static void clps711x_intc_eoi(struct irq_data *d)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	writel_relaxed(0, clps711x_intc->base + clps711x_irqs[hwirq].eoi);
+}
+
+static void clps711x_intc_mask(struct irq_data *d)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
+	u32 tmp;
+
+	tmp = readl_relaxed(intmr);
+	tmp &= ~(1 << (hwirq % 16));
+	writel_relaxed(tmp, intmr);
+}
+
+static void clps711x_intc_unmask(struct irq_data *d)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
+	u32 tmp;
+
+	tmp = readl_relaxed(intmr);
+	tmp |= 1 << (hwirq % 16);
+	writel_relaxed(tmp, intmr);
+}
+
+static struct irq_chip clps711x_intc_chip = {
+	.name		= "clps711x-intc",
+	.irq_eoi	= clps711x_intc_eoi,
+	.irq_mask	= clps711x_intc_mask,
+	.irq_unmask	= clps711x_intc_unmask,
+};
+
+static int __init clps711x_intc_irq_map(struct irq_domain *h, unsigned int virq,
+					irq_hw_number_t hw)
+{
+	irq_flow_handler_t handler = handle_level_irq;
+	unsigned int flags = IRQF_VALID | IRQF_PROBE;
+
+	if (!clps711x_irqs[hw].flags)
+		return 0;
+
+	if (clps711x_irqs[hw].flags & CLPS711X_FLAG_FIQ) {
+		handler = handle_bad_irq;
+		flags |= IRQF_NOAUTOEN;
+	} else if (clps711x_irqs[hw].eoi) {
+		handler = handle_fasteoi_irq;
+	}
+
+	/* Clear down pending interrupt */
+	if (clps711x_irqs[hw].eoi)
+		writel_relaxed(0, clps711x_intc->base + clps711x_irqs[hw].eoi);
+
+	irq_set_chip_and_handler(virq, &clps711x_intc_chip, handler);
+	set_irq_flags(virq, flags);
+
+	return 0;
+}
+
+static int __init _clps711x_intc_init(struct device_node *np,
+				      phys_addr_t base, resource_size_t size)
+{
+	int err;
+
+	clps711x_intc = kzalloc(sizeof(*clps711x_intc), GFP_KERNEL);
+	if (!clps711x_intc)
+		return -ENOMEM;
+
+	clps711x_intc->base = ioremap(base, size);
+	if (!clps711x_intc->base) {
+		err = -ENOMEM;
+		goto out_kfree;
+	}
+
+	clps711x_intc->intsr[0] = clps711x_intc->base + CLPS711X_INTSR1;
+	clps711x_intc->intmr[0] = clps711x_intc->base + CLPS711X_INTMR1;
+	clps711x_intc->intsr[1] = clps711x_intc->base + CLPS711X_INTSR2;
+	clps711x_intc->intmr[1] = clps711x_intc->base + CLPS711X_INTMR2;
+	clps711x_intc->intsr[2] = clps711x_intc->base + CLPS711X_INTSR3;
+	clps711x_intc->intmr[2] = clps711x_intc->base + CLPS711X_INTMR3;
+
+	/* Mask all interrupts */
+	writel_relaxed(0, clps711x_intc->intmr[0]);
+	writel_relaxed(0, clps711x_intc->intmr[1]);
+	writel_relaxed(0, clps711x_intc->intmr[2]);
+
+	err = irq_alloc_descs(-1, 0, ARRAY_SIZE(clps711x_irqs), numa_node_id());
+	if (IS_ERR_VALUE(err))
+		goto out_iounmap;
+
+	clps711x_intc->ops.map = clps711x_intc_irq_map;
+	clps711x_intc->ops.xlate = irq_domain_xlate_onecell;
+	clps711x_intc->domain =
+		irq_domain_add_legacy(np, ARRAY_SIZE(clps711x_irqs),
+				      0, 0, &clps711x_intc->ops, NULL);
+	if (!clps711x_intc->domain) {
+		err = -ENOMEM;
+		goto out_irqfree;
+	}
+
+	irq_set_default_host(clps711x_intc->domain);
+	set_handle_irq(clps711x_irqh);
+
+#ifdef CONFIG_FIQ
+	init_FIQ(0);
+#endif
+
+	return 0;
+
+out_irqfree:
+	irq_free_descs(0, ARRAY_SIZE(clps711x_irqs));
+
+out_iounmap:
+	iounmap(clps711x_intc->base);
+
+out_kfree:
+	kfree(clps711x_intc);
+
+	return err;
+}
+
+void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
+{
+	BUG_ON(_clps711x_intc_init(NULL, base, size));
+}
+
+#ifdef CONFIG_IRQCHIP
+static int __init clps711x_intc_init_dt(struct device_node *np,
+					struct device_node *parent)
+{
+	struct resource res;
+	int err;
+
+	err = of_address_to_resource(np, 0, &res);
+	if (err)
+		return err;
+
+	return _clps711x_intc_init(np, res.start, resource_size(&res));
+}
+IRQCHIP_DECLARE(clps711x, "cirrus,clps711x-intc", clps711x_intc_init_dt);
+#endif
-- 
1.8.3.2
