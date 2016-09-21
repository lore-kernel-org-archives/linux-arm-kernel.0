From: clingutla@codeaurora.org (Lingutla Chandrasekhar)
Date: Wed, 21 Sep 2016 14:12:39 +0530
Subject: [RFC] irqchip/gic-v3: Implement suspend and resume callbacks
Message-ID: <1474447359-29551-1-git-send-email-clingutla@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement suspend and resume syscore_ops to disable and
enable non wake up capable interrupts.

When system enters suspend, enable only wakeup capable
interrupts. While resuming, enable previously enabled interrupts
and show triggered/pending interrupts.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ede5672..511a5a1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -33,6 +33,7 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -57,6 +58,10 @@ struct gic_chip_data {
 	u32			nr_redist_regions;
 	unsigned int		irq_nr;
 	struct partition_desc	*ppi_descs[16];
+#ifdef CONFIG_PM
+	unsigned int wakeup_irqs[32];
+	unsigned int enabled_irqs[32];
+#endif
 };
 
 static struct gic_chip_data gic_data __read_mostly;
@@ -330,6 +335,81 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int gic_suspend(void)
+{
+	unsigned int i;
+	void __iomem *base = gic_data.dist_base;
+
+	for (i = 0; i * 32 < gic->irq_nr; i++) {
+		gic->enabled_irqs[i]
+			= readl_relaxed(base + GICD_ISENABLER + i * 4);
+		/* disable all of them */
+		writel_relaxed(0xffffffff, base + GICD_ICENABLER + i * 4);
+		/* enable the wakeup set */
+		writel_relaxed(gic->wakeup_irqs[i],
+			base + GICD_ISENABLER + i * 4);
+	}
+	return 0;
+}
+
+static void gic_show_pending(void)
+{
+	unsigned int i;
+	u32 enabled;
+	u32 pending[32];
+	void __iomem *base = gic_data.dist_base;
+
+	for (i = 0; i * 32 < gic->irq_nr; i++) {
+		enabled = readl_relaxed(base + GICD_ICENABLER + i * 4);
+		pending[i] = readl_relaxed(base + GICD_ISPENDR + i * 4);
+		pending[i] &= enabled;
+	}
+
+	for_each_set_bit(i, (unsigned long *)pending, gic->irq_nr) {
+		unsigned int irq = irq_find_mapping(gic->domain, i);
+		struct irq_desc *desc = irq_to_desc(irq);
+		const char *name = "null";
+
+		if (desc == NULL)
+			name = "stray irq";
+		else if (desc->action && desc->action->name)
+			name = desc->action->name;
+
+		pr_debug("Pending IRQ: %d [%s]\n", __func__, irq, name);
+	}
+}
+
+static void gic_resume(void)
+{
+	unsigned int i;
+	void __iomem *base = gic_data.dist_base;
+
+	gic_show_pending();
+
+	for (i = 0; i * 32 < gic->irq_nr; i++) {
+		/* disable all of them */
+		writel_relaxed(0xffffffff, base + GICD_ICENABLER + i * 4);
+		/* enable the enabled set */
+		writel_relaxed(gic->enabled_irqs[i],
+			base + GICD_ISENABLER + i * 4);
+	}
+}
+
+static struct syscore_ops gic_syscore_ops = {
+	.suspend = gic_suspend,
+	.resume = gic_resume,
+};
+
+static int __init gic_init_sys(void)
+{
+	register_syscore_ops(&gic_syscore_ops);
+	return 0;
+}
+device_initcall(gic_init_sys);
+
+#endif
+
 static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 {
 	u64 aff;
@@ -666,6 +746,32 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+#ifdef CONFIG_PM
+int gic_set_wake(struct irq_data *d, unsigned int on)
+{
+	int ret = -ENXIO;
+	unsigned int reg_offset, bit_offset;
+	unsigned int gicirq = gic_irq(d);
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+
+	/* per-cpu interrupts cannot be wakeup interrupts */
+	WARN_ON(gicirq < 32);
+
+	reg_offset = gicirq / 32;
+	bit_offset = gicirq % 32;
+
+	if (on)
+		gic_data->wakeup_irqs[reg_offset] |=  1 << bit_offset;
+	else
+		gic_data->wakeup_irqs[reg_offset] &=  ~(1 << bit_offset);
+
+	return ret;
+}
+
+#else
+#define gic_set_wake	NULL
+#endif
+
 #ifdef CONFIG_CPU_PM
 /* Check whether it's single security state view */
 static bool gic_dist_security_disabled(void)
@@ -707,6 +813,7 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_set_wake           = gic_set_wake,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
@@ -723,6 +830,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.irq_set_wake		= gic_set_wake,
 };
 
 #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.
