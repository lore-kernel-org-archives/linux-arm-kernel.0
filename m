From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 May 2013 10:21:45 +0800
Subject: [PATCH v2 3/5] irqchip: mmp: support MULTI_IRQ_HANDLER
In-Reply-To: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
References: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1369707707-30295-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support CONFIG_MULTI_IRQ_HANDLER in ARCH_MMP. So remove entry-macro.S.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/Kconfig                             |  1 +
 arch/arm/mach-mmp/include/mach/entry-macro.S | 26 -----------------
 drivers/irqchip/irq-mmp.c                    | 42 +++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..b8ba50b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -550,6 +550,7 @@ config ARCH_MMP
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
 	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_GPIO_H
 	select PINCTRL
 	select PLAT_PXA
diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
deleted file mode 100644
index bd152e2..0000000
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/entry-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <asm/irq.h>
-#include <mach/regs-icu.h>
-
-	.macro	get_irqnr_preamble, base, tmp
-	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
-	and	\tmp, \tmp, #0xff00
-	cmp	\tmp, #0x5800
-	ldr	\base, =mmp_icu_base
-	ldr	\base, [\base, #0]
-	addne	\base, \base, #0x10c		@ PJ1 AP INT SEL register
-	addeq	\base, \base, #0x104		@ PJ4 IRQ SEL register
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\tmp, [\base, #0]
-	and	\irqnr, \tmp, #0x3f
-	tst	\tmp, #(1 << 6)
-	.endm
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 2f088ba..f54ebca 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -21,6 +21,9 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/exception.h>
+#include <asm/mach/irq.h>
+
 #include <mach/irqs.h>
 
 #ifdef CONFIG_CPU_MMP2
@@ -34,6 +37,13 @@
 
 #define MAX_ICU_NR		16
 
+#define PJ1_INT_SEL		0x10c
+#define PJ4_INT_SEL		0x104
+
+/* bit fields in PJ1_INT_SEL and PJ4_INT_SEL */
+#define SEL_INT_PENDING		(1 << 6)
+#define SEL_INT_NUM_MASK	0x3f
+
 struct icu_chip_data {
 	int			nr_irqs;
 	unsigned int		virq_base;
@@ -54,7 +64,7 @@ struct mmp_intc_conf {
 	unsigned int	conf_mask;
 };
 
-void __iomem *mmp_icu_base;
+static void __iomem *mmp_icu_base;
 static struct icu_chip_data icu_data[MAX_ICU_NR];
 static int max_icu_nr;
 
@@ -193,6 +203,32 @@ static struct mmp_intc_conf mmp2_conf = {
 	.conf_mask	= 0x7f,
 };
 
+static asmlinkage void __exception_irq_entry
+mmp_handle_irq(struct pt_regs *regs)
+{
+	int irq, hwirq;
+
+	hwirq = readl_relaxed(mmp_icu_base + PJ1_INT_SEL);
+	if (!(hwirq & SEL_INT_PENDING))
+		return;
+	hwirq &= SEL_INT_NUM_MASK;
+	irq = irq_find_mapping(icu_data[0].domain, hwirq);
+	handle_IRQ(irq, regs);
+}
+
+static asmlinkage void __exception_irq_entry
+mmp2_handle_irq(struct pt_regs *regs)
+{
+	int irq, hwirq;
+
+	hwirq = readl_relaxed(mmp_icu_base + PJ4_INT_SEL);
+	if (!(hwirq & SEL_INT_PENDING))
+		return;
+	hwirq &= SEL_INT_NUM_MASK;
+	irq = irq_find_mapping(icu_data[0].domain, hwirq);
+	handle_IRQ(irq, regs);
+}
+
 /* MMP (ARMv5) */
 void __init icu_init_irq(void)
 {
@@ -214,6 +250,7 @@ void __init icu_init_irq(void)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 	irq_set_default_host(icu_data[0].domain);
+	set_handle_irq(mmp_handle_irq);
 #ifdef CONFIG_CPU_PXA910
 	icu_irq_chip.irq_set_wake = pxa910_set_wake;
 #endif
@@ -320,6 +357,7 @@ void __init mmp2_init_icu(void)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 	irq_set_default_host(icu_data[0].domain);
+	set_handle_irq(mmp2_handle_irq);
 #ifdef CONFIG_CPU_MMP2
 	icu_irq_chip.irq_set_wake = mmp2_set_wake;
 #endif
@@ -378,6 +416,7 @@ static int __init mmp_of_init(struct device_node *node,
 	icu_data[0].conf_disable = mmp_conf.conf_disable;
 	icu_data[0].conf_mask = mmp_conf.conf_mask;
 	irq_set_default_host(icu_data[0].domain);
+	set_handle_irq(mmp_handle_irq);
 	max_icu_nr = 1;
 	return 0;
 }
@@ -395,6 +434,7 @@ static int __init mmp2_of_init(struct device_node *node,
 	icu_data[0].conf_disable = mmp2_conf.conf_disable;
 	icu_data[0].conf_mask = mmp2_conf.conf_mask;
 	irq_set_default_host(icu_data[0].domain);
+	set_handle_irq(mmp2_handle_irq);
 	max_icu_nr = 1;
 	return 0;
 }
-- 
1.8.1.2
