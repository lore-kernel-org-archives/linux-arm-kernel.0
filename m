From: eric@anholt.net (Eric Anholt)
Date: Tue,  7 Jul 2015 14:13:37 -0700
Subject: [PATCH 4/4] irqchip: Add bcm2836 interrupt controller for Raspberry
 Pi 2.
In-Reply-To: <1436303617-17185-1-git-send-email-eric@anholt.net>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
Message-ID: <1436303617-17185-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This interrupt controller is the new root interrupt controller with
the timer, PMU events, and IPIs, and the bcm2835's interrupt
controller is chained off of it to handle the peripherals.

SMP IPI support was mostly written by Andrea Merello, while I wrote
most of the rest of the IRQ handling.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-bcm2836.c | 200 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 drivers/irqchip/irq-bcm2836.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b8d4e96..9727681 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
+obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
new file mode 100644
index 0000000..cdb545f
--- /dev/null
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -0,0 +1,200 @@
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
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <asm/exception.h>
+
+#define LOCAL_PM_ROUTING_SET		0x010
+#define LOCAL_PM_ROUTING_CLR		0x014
+#define LOCAL_TIMER_INT_CONTROL0	0x040
+#define LOCAL_MAILBOX_INT_CONTROL0	0x050
+#define LOCAL_IRQ_PENDING0		0x060
+#define LOCAL_MAILBOX0_SET0		0x080
+#define LOCAL_MAILBOX0_CLR0		0x0c0
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
+
+struct arm_local_intc {
+	struct irq_domain *domain;
+	void __iomem *base;
+};
+
+static struct arm_local_intc intc  __read_mostly;
+
+static void bcm2836_mask_per_cpu_irq(unsigned int reg, unsigned int bit)
+{
+	void __iomem *reg_base = intc.base + reg;
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		writel(readl(reg_base + 4 * i) & ~BIT(bit), reg_base + 4 * i);
+}
+
+static void bcm2836_unmask_per_cpu_irq(unsigned int reg, unsigned int bit)
+{
+	void __iomem *reg_base = intc.base + reg;
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		writel(readl(reg_base + 4 * i) | BIT(bit), reg_base + 4 * i);
+}
+
+static void bcm2836_mask_timer_irq(struct irq_data *d)
+{
+	bcm2836_mask_per_cpu_irq(LOCAL_TIMER_INT_CONTROL0,
+				 d->hwirq - LOCAL_IRQ_CNTPSIRQ);
+}
+
+static void bcm2836_unmask_timer_irq(struct irq_data *d)
+{
+	bcm2836_unmask_per_cpu_irq(LOCAL_TIMER_INT_CONTROL0,
+				   d->hwirq - LOCAL_IRQ_CNTPSIRQ);
+}
+
+static struct irq_chip bcm2836_timer_irqchip = {
+	.name = "bcm2836-timer",
+	.irq_mask = bcm2836_mask_timer_irq,
+	.irq_unmask = bcm2836_unmask_timer_irq
+};
+
+static void bcm2836_mask_pmu_irq(struct irq_data *d)
+{
+	writel(0xf, intc.base + LOCAL_PM_ROUTING_CLR);
+}
+
+static void bcm2836_unmask_pmu_irq(struct irq_data *d)
+{
+	writel(0xf, intc.base + LOCAL_PM_ROUTING_SET);
+}
+
+static struct irq_chip bcm2836_pmu_irqchip = {
+	.name = "bcm2836-pmu",
+	.irq_mask = bcm2836_mask_pmu_irq,
+	.irq_unmask = bcm2836_unmask_pmu_irq
+};
+
+static void bcm2836_mask_gpu_irq(struct irq_data *d)
+{
+}
+
+static void bcm2836_unmask_gpu_irq(struct irq_data *d)
+{
+}
+
+static struct irq_chip bcm2836_gpu_irqchip = {
+	.name = "bcm2836-gpu",
+	.irq_mask = bcm2836_mask_gpu_irq,
+	.irq_unmask = bcm2836_unmask_gpu_irq
+};
+
+static void bcm2836_register_irq(int hwirq, struct irq_chip *chip)
+{
+	int irq = irq_create_mapping(intc.domain, hwirq);
+
+	irq_set_percpu_devid(irq);
+	irq_set_chip_and_handler(irq, chip, handle_percpu_devid_irq);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+}
+
+static void __exception_irq_entry bcm2836_handle_irq(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	u32 stat;
+
+	stat = readl_relaxed(intc.base + LOCAL_IRQ_PENDING0 + 4 * cpu);
+	if (stat & 0x10) {
+		void __iomem *mailbox0 = (intc.base +
+					  LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+		u32 mbox_val = readl(mailbox0);
+		u32 ipi = ffs(mbox_val) - 1;
+
+		writel(1 << ipi, mailbox0);
+		handle_IPI(ipi, regs);
+	} else {
+		u32 hwirq = ffs(stat) - 1;
+
+		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
+	}
+}
+
+#ifdef CONFIG_SMP
+static void bcm2836_send_ipi(const struct cpumask *mask, unsigned int ipi)
+{
+	int cpu;
+	void __iomem *mailbox0_base = intc.base + LOCAL_MAILBOX0_SET0;
+
+	/*
+	 * Ensure that stores to normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	for_each_cpu(cpu, mask)	{
+		writel(1 << ipi, mailbox0_base + 16 * cpu);
+	}
+}
+#endif
+
+static const struct irq_domain_ops bcm2836_intc_ops = {
+	.xlate = irq_domain_xlate_onecell
+};
+
+static int __init bcm2836_l1_intc_of_init(struct device_node *node,
+					  struct device_node *parent)
+{
+	intc.base = of_iomap(node, 0);
+	if (!intc.base) {
+		panic("%s: unable to map local interrupt registers\n",
+			node->full_name);
+	}
+
+	intc.domain = irq_domain_add_linear(node, LAST_IRQ + 1,
+					    &bcm2836_intc_ops, NULL);
+	if (!intc.domain)
+		panic("%s: unable to create IRQ domain\n", node->full_name);
+
+	bcm2836_register_irq(LOCAL_IRQ_CNTPSIRQ, &bcm2836_timer_irqchip);
+	bcm2836_register_irq(LOCAL_IRQ_CNTPNSIRQ, &bcm2836_timer_irqchip);
+	bcm2836_register_irq(LOCAL_IRQ_CNTHPIRQ, &bcm2836_timer_irqchip);
+	bcm2836_register_irq(LOCAL_IRQ_CNTVIRQ, &bcm2836_timer_irqchip);
+	bcm2836_register_irq(LOCAL_IRQ_GPU_FAST, &bcm2836_gpu_irqchip);
+	bcm2836_register_irq(LOCAL_IRQ_PMU_FAST, &bcm2836_pmu_irqchip);
+
+#ifdef CONFIG_SMP
+	/* unmask IPIs */
+	bcm2836_unmask_per_cpu_irq(LOCAL_MAILBOX_INT_CONTROL0, 0);
+	set_smp_cross_call(bcm2836_send_ipi);
+#endif
+
+	set_handle_irq(bcm2836_handle_irq);
+	return 0;
+}
+
+IRQCHIP_DECLARE(bcm2836_l1_intc, "brcm,bcm2836-l1-intc",
+		bcm2836_l1_intc_of_init);
-- 
2.1.4
