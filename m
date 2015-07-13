From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:18 +0700
Subject: [RFCv2 PATCH 2/8] gic: Introduce gic_init_irq_alloc_info()
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1436778864-17645-3-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, gic_irq_domain_alloc assumes that the arg parameter must be
a pointer to of_phandle_args. This is not appropriate for using with ACPI.

Furthermore, there are several irq mappings (i.e. SPI, PPI, and GSI),
which can be used when allocating GIC irqs. This can be confusing
when used in multiple initialization path (i.e. DT, ACPI, MSI, etc.).

This patch introduces struct gic_irq_alloc_info, which replaces the
of_phandle_args when calling gic_irq_domain_alloc(). Also, it introduces
gic_init_irq_alloc_info(), a new helper function to help simplifying
GIC irq allocation, which hooks into the new
irq_domain_ops.init_alloc_info.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic.c       | 82 ++++++++++++++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic.h | 11 ++++++
 2 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 7f943ef..8ac8ec4 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -852,22 +852,18 @@ static struct notifier_block gic_cpu_notifier = {
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
-	int i;
+	int i, ret;
 	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct gic_irq_alloc_info *info = arg;
+	u32 intspec[3];
 
-	if (acpi_disabled) {	/* DT case */
-		int ret;
-		unsigned int type = IRQ_TYPE_NONE;
-		struct of_phandle_args *irq_data = arg;
-
-		ret = gic_irq_domain_xlate(domain, irq_data->np,
-					irq_data->args,
-					irq_data->args_count, &hwirq, &type);
-		if (ret)
-			return ret;
-	} else {	/* ACPI case */
-		hwirq = (irq_hw_number_t)*(u32 *)arg;
-	}
+	intspec[0] = info->gic_int_type;
+	intspec[1] = info->hwirq;
+	intspec[2] = info->irq_type;
+	ret = gic_irq_domain_xlate(domain, info->ref, intspec, 3, &hwirq, &type);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < nr_irqs; i++)
 		gic_irq_domain_map(domain, virq + i, hwirq + i);
@@ -875,10 +871,68 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
+static int gic_init_irq_alloc_info(uint32_t *data, int nr, void *ref,
+				   void **info)
+{
+	struct gic_irq_alloc_info *alloc_info;
+	unsigned int gic_int_type;
+	unsigned int hwirq;
+	unsigned int irq_type;
+
+	if (nr != 3)
+		return -EINVAL;
+
+	gic_int_type = data[0];
+	hwirq = data[1];
+	irq_type = data[2];
+
+	alloc_info = kzalloc(sizeof(struct gic_irq_alloc_info), GFP_KERNEL);
+	if (!alloc_info)
+		return -ENOMEM;
+
+	if ((irq_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_HIGH &&
+	    (irq_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	alloc_info->irq_type = irq_type;
+	alloc_info->ref = ref;
+
+	/*
+	 * ACPI have no bindings to indicate SPI or PPI, so we
+	 * use different mappings from DT in ACPI.
+	 *
+	 * For FDT
+	 * PPI interrupt: in the range [0, 15];
+	 * SPI interrupt: in the range [0, 987];
+	 *
+	 * For ACPI, GSI should be unique so using
+	 * the hwirq directly for the mapping:
+	 * PPI interrupt: in the range [16, 31];
+	 * SPI interrupt: in the range [32, 1019];
+	 */
+
+	if (gic_int_type != GIC_INT_TYPE_GSI) {
+		alloc_info->gic_int_type = gic_int_type;
+		alloc_info->hwirq = hwirq;
+	} else {
+		if (hwirq < 32) {
+			alloc_info->gic_int_type = GIC_INT_TYPE_PPI;
+			alloc_info->hwirq = hwirq - 16;
+		} else {
+			alloc_info->gic_int_type = GIC_INT_TYPE_SPI;
+			alloc_info->hwirq = hwirq - 32;
+		}
+	}
+
+	*info = alloc_info;
+	return 0;
+}
+
 static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
 	.xlate = gic_irq_domain_xlate,
 	.alloc = gic_irq_domain_alloc,
 	.free = irq_domain_free_irqs_top,
+	.init_alloc_info = gic_init_irq_alloc_info,
 };
 
 static const struct irq_domain_ops gic_irq_domain_ops = {
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 9de976b..4808514 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -89,12 +89,23 @@
 #define GICH_MISR_EOI			(1 << 0)
 #define GICH_MISR_U			(1 << 1)
 
+#define GIC_INT_TYPE_SPI		0
+#define GIC_INT_TYPE_PPI		1
+#define GIC_INT_TYPE_GSI		~0U
+
 #ifndef __ASSEMBLY__
 
 #include <linux/irqdomain.h>
 
 struct device_node;
 
+struct gic_irq_alloc_info {
+	void *ref;
+	unsigned int irq_type;
+	unsigned int gic_int_type;
+	unsigned int hwirq;
+};
+
 void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
-- 
2.1.0
