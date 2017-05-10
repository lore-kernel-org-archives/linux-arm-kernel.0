From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 May 2017 14:26:20 +0100
Subject: [PATCH] irqchip/bcm2836: Move SMP startup code to arch/arm
Message-ID: <20170510132620.19685-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the RPi-2/3 irqchip's key features is that it contains some
SMP startup code for the 32bit ARM architecture version. The only
reason I can imagine for this is "RPi is special".

Let's move this code where it belongs (in the platform support code),
creating a shared include file for this purpose.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
This is only compile-tested (I do not own this HW).

 arch/arm/mach-bcm/board_bcm2835.c   | 36 ++++++++++++++++-
 drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
 include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/irqchip/irq-bcm2836.h

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 0c1edfc98696..1e7c6aa54b68 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -16,10 +16,43 @@
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/clk/bcm2835.h>
+#include <linux/irqchip/irq-bcm2836.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#ifdef CONFIG_SMP
+static const struct of_device_id bcm2836_intc[] = {
+	{ .compatible = "brcm,bcm2836-l1-intc" },
+	{ },
+};
+
+static int bcm2836_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	np = of_find_matching_node(NULL, bcm2836_intc);
+	if (!np)
+		return -ENODEV;
+
+	base = of_iomap(np, 0);
+	if (!base)
+		return -ENOMEM;
+
+	writel(virt_to_phys(secondary_startup),
+	       base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
+
+	iounmap(base);
+
+	return 0;
+}
+
+static const struct smp_operations bcm2836_smp_ops = {
+	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
+};
+#endif
+
 static void __init bcm2835_init(void)
 {
 	bcm2835_init_clocks();
@@ -37,5 +70,6 @@ static const char * const bcm2835_compat[] = {
 
 DT_MACHINE_START(BCM2835, "BCM2835")
 	.init_machine = bcm2835_init,
-	.dt_compat = bcm2835_compat
+	.dt_compat = bcm2835_compat,
+	.smp = smp_ops(bcm2836_smp_ops),
 MACHINE_END
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index e7463e3c0814..cb4a6f52005e 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -19,62 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
-#include <asm/exception.h>
-
-#define LOCAL_CONTROL			0x000
-#define LOCAL_PRESCALER			0x008
+#include <linux/irqchip/irq-bcm2836.h>
 
-/*
- * The low 2 bits identify the CPU that the GPU IRQ goes to, and the
- * next 2 bits identify the CPU that the GPU FIQ goes to.
- */
-#define LOCAL_GPU_ROUTING		0x00c
-/* When setting bits 0-3, enables PMU interrupts on that CPU. */
-#define LOCAL_PM_ROUTING_SET		0x010
-/* When setting bits 0-3, disables PMU interrupts on that CPU. */
-#define LOCAL_PM_ROUTING_CLR		0x014
-/*
- * The low 4 bits of this are the CPU's timer IRQ enables, and the
- * next 4 bits are the CPU's timer FIQ enables (which override the IRQ
- * bits).
- */
-#define LOCAL_TIMER_INT_CONTROL0	0x040
-/*
- * The low 4 bits of this are the CPU's per-mailbox IRQ enables, and
- * the next 4 bits are the CPU's per-mailbox FIQ enables (which
- * override the IRQ bits).
- */
-#define LOCAL_MAILBOX_INT_CONTROL0	0x050
-/*
- * The CPU's interrupt status register.  Bits are defined by the the
- * LOCAL_IRQ_* bits below.
- */
-#define LOCAL_IRQ_PENDING0		0x060
-/* Same status bits as above, but for FIQ. */
-#define LOCAL_FIQ_PENDING0		0x070
-/*
- * Mailbox write-to-set bits.  There are 16 mailboxes, 4 per CPU, and
- * these bits are organized by mailbox number and then CPU number.  We
- * use mailbox 0 for IPIs.  The mailbox's interrupt is raised while
- * any bit is set.
- */
-#define LOCAL_MAILBOX0_SET0		0x080
-#define LOCAL_MAILBOX3_SET0		0x08c
-/* Mailbox write-to-clear bits. */
-#define LOCAL_MAILBOX0_CLR0		0x0c0
-#define LOCAL_MAILBOX3_CLR0		0x0cc
-
-#define LOCAL_IRQ_CNTPSIRQ	0
-#define LOCAL_IRQ_CNTPNSIRQ	1
-#define LOCAL_IRQ_CNTHPIRQ	2
-#define LOCAL_IRQ_CNTVIRQ	3
-#define LOCAL_IRQ_MAILBOX0	4
-#define LOCAL_IRQ_MAILBOX1	5
-#define LOCAL_IRQ_MAILBOX2	6
-#define LOCAL_IRQ_MAILBOX3	7
-#define LOCAL_IRQ_GPU_FAST	8
-#define LOCAL_IRQ_PMU_FAST	9
-#define LAST_IRQ		LOCAL_IRQ_PMU_FAST
+#include <asm/exception.h>
 
 struct bcm2836_arm_irqchip_intc {
 	struct irq_domain *domain;
@@ -215,24 +162,6 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 					     cpu);
 	return 0;
 }
-
-#ifdef CONFIG_ARM
-static int __init bcm2836_smp_boot_secondary(unsigned int cpu,
-					     struct task_struct *idle)
-{
-	unsigned long secondary_startup_phys =
-		(unsigned long)virt_to_phys((void *)secondary_startup);
-
-	writel(secondary_startup_phys,
-	       intc.base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
-
-	return 0;
-}
-
-static const struct smp_operations bcm2836_smp_ops __initconst = {
-	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
-};
-#endif
 #endif
 
 static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
@@ -249,10 +178,6 @@ bcm2836_arm_irqchip_smp_init(void)
 			  bcm2836_cpu_dying);
 
 	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
-
-#ifdef CONFIG_ARM
-	smp_set_ops(&bcm2836_smp_ops);
-#endif
 #endif
 }
 
diff --git a/include/linux/irqchip/irq-bcm2836.h b/include/linux/irqchip/irq-bcm2836.h
new file mode 100644
index 000000000000..218a6e1b18d8
--- /dev/null
+++ b/include/linux/irqchip/irq-bcm2836.h
@@ -0,0 +1,70 @@
+/*
+ * Root interrupt controller for the BCM2836 (Raspberry Pi 2).
+ *
+ * Copyright 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define LOCAL_CONTROL			0x000
+#define LOCAL_PRESCALER			0x008
+
+/*
+ * The low 2 bits identify the CPU that the GPU IRQ goes to, and the
+ * next 2 bits identify the CPU that the GPU FIQ goes to.
+ */
+#define LOCAL_GPU_ROUTING		0x00c
+/* When setting bits 0-3, enables PMU interrupts on that CPU. */
+#define LOCAL_PM_ROUTING_SET		0x010
+/* When setting bits 0-3, disables PMU interrupts on that CPU. */
+#define LOCAL_PM_ROUTING_CLR		0x014
+/*
+ * The low 4 bits of this are the CPU's timer IRQ enables, and the
+ * next 4 bits are the CPU's timer FIQ enables (which override the IRQ
+ * bits).
+ */
+#define LOCAL_TIMER_INT_CONTROL0	0x040
+/*
+ * The low 4 bits of this are the CPU's per-mailbox IRQ enables, and
+ * the next 4 bits are the CPU's per-mailbox FIQ enables (which
+ * override the IRQ bits).
+ */
+#define LOCAL_MAILBOX_INT_CONTROL0	0x050
+/*
+ * The CPU's interrupt status register.  Bits are defined by the the
+ * LOCAL_IRQ_* bits below.
+ */
+#define LOCAL_IRQ_PENDING0		0x060
+/* Same status bits as above, but for FIQ. */
+#define LOCAL_FIQ_PENDING0		0x070
+/*
+ * Mailbox write-to-set bits.  There are 16 mailboxes, 4 per CPU, and
+ * these bits are organized by mailbox number and then CPU number.  We
+ * use mailbox 0 for IPIs.  The mailbox's interrupt is raised while
+ * any bit is set.
+ */
+#define LOCAL_MAILBOX0_SET0		0x080
+#define LOCAL_MAILBOX3_SET0		0x08c
+/* Mailbox write-to-clear bits. */
+#define LOCAL_MAILBOX0_CLR0		0x0c0
+#define LOCAL_MAILBOX3_CLR0		0x0cc
+
+#define LOCAL_IRQ_CNTPSIRQ	0
+#define LOCAL_IRQ_CNTPNSIRQ	1
+#define LOCAL_IRQ_CNTHPIRQ	2
+#define LOCAL_IRQ_CNTVIRQ	3
+#define LOCAL_IRQ_MAILBOX0	4
+#define LOCAL_IRQ_MAILBOX1	5
+#define LOCAL_IRQ_MAILBOX2	6
+#define LOCAL_IRQ_MAILBOX3	7
+#define LOCAL_IRQ_GPU_FAST	8
+#define LOCAL_IRQ_PMU_FAST	9
+#define LAST_IRQ		LOCAL_IRQ_PMU_FAST
-- 
2.11.0
