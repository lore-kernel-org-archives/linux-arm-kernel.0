From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 10 Dec 2011 22:47:39 +0530
Subject: [PATCH] ARM: Exynos: Add irq domain and device tree support for
 interrupt combiner
Message-ID: <1323537459-1848-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common irq domain for the interrupts managed by the interrupt combiners is
setup. All the instances of irq combiner reference the common irq domain for
translating hardware interrupts to linux irq number.

In case of device tree based boot, a interrupt specifier translator is setup
that can translate interrupt specifiers for device nodes which use combiner
as their interrupt parent.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
This patch is based on the following tree.
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

 .../bindings/arm/samsung/interrupt-combiner.txt    |   18 ++++++
 arch/arm/mach-exynos/cpu.c                         |   29 +++++++---
 arch/arm/mach-exynos/irq-combiner.c                |   58 +++++++++++++++++---
 3 files changed, 87 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt b/Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
new file mode 100644
index 0000000..6ca30d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
@@ -0,0 +1,18 @@
+* Samsung Exynos Interrupt Combiner Controller
+
+Samsung's Exynos4 architecture includes a interrupt combiner which can combine
+interrupt sources as a group and provide a single interrupt request for the
+group. The interrupt request from each group are connected to a parent interrupt
+controller, such as GIC in case of Exynos4210.
+
+Required properties:
+- compatible: should be "samsung,exynos4210-combiner".
+- #interrupt-cells: should be <2>. The meaning of the cells are
+	* First Cell: Combiner Group Number.
+	* Second Cell: Interrupt number within the group.
+- reg: Base address and size of interrupt combiner registers.
+- interrupt-controller: Identifies the node as an interrupt controller.
+
+Optional properties:
+- interrupt-parent: pHandle of the parent interrupt controller, if not
+  inherited from the parent node.
diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 8e09f34..14f86ba 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -37,9 +37,10 @@
 
 unsigned int gic_bank_offset __read_mostly;
 
-extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
-			 unsigned int irq_start);
+extern int combiner_init(unsigned int combiner_nr, void __iomem *base);
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
+extern int combiner_init_irq_domain(unsigned int irq_base, unsigned int nr_irq,
+					struct device_node *np);
 
 /* Initial IO mappings */
 static struct map_desc exynos_iodesc[] __initdata = {
@@ -242,16 +243,30 @@ static void exynos4_gic_irq_fix_base(struct irq_data *d)
 			    (gic_bank_offset * smp_processor_id());
 }
 
+void __init combiner_of_init(struct device_node *np, struct device_node *parent)
+{
+	int irq;
+
+	if (combiner_init_irq_domain(COMBINER_IRQ(0, 0), MAX_COMBINER_NR *
+					MAX_IRQ_IN_COMBINER, np))
+		BUG();
+	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
+		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq));
+		combiner_cascade_irq(irq, IRQ_SPI(irq));
+	}
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id exynos4_dt_irq_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ .compatible = "samsung,exynos4120-combiner",
+			.data = combiner_of_init, },
 	{},
 };
 #endif
 
 void __init exynos4_init_irq(void)
 {
-	int irq;
 
 	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
 
@@ -266,12 +281,8 @@ void __init exynos4_init_irq(void)
 	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
 
-	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
-
-		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
-				COMBINER_IRQ(irq, 0));
-		combiner_cascade_irq(irq, IRQ_SPI(irq));
-	}
+	if (!of_have_populated_dt())
+		combiner_of_init(NULL, NULL);
 
 	/* The parameters of s5p_init_irq() are for VIC init.
 	 * Theses parameters should be NULL and 0 because EXYNOS4
diff --git a/arch/arm/mach-exynos/irq-combiner.c b/arch/arm/mach-exynos/irq-combiner.c
index 5a2758a..84f24c9 100644
--- a/arch/arm/mach-exynos/irq-combiner.c
+++ b/arch/arm/mach-exynos/irq-combiner.c
@@ -13,6 +13,8 @@
 */
 
 #include <linux/io.h>
+#include <linux/export.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mach/irq.h>
 
@@ -26,8 +28,10 @@ struct combiner_chip_data {
 	unsigned int irq_offset;
 	unsigned int irq_mask;
 	void __iomem *base;
+	struct irq_domain *domain;
 };
 
+static struct irq_domain combiner_irq_domain;
 static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
 
 static inline void __iomem *combiner_base(struct irq_data *data)
@@ -40,14 +44,14 @@ static inline void __iomem *combiner_base(struct irq_data *data)
 
 static void combiner_mask_irq(struct irq_data *data)
 {
-	u32 mask = 1 << (data->irq % 32);
+	u32 mask = 1 << (data->hwirq % 32);
 
 	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
 }
 
 static void combiner_unmask_irq(struct irq_data *data)
 {
-	u32 mask = 1 << (data->irq % 32);
+	u32 mask = 1 << (data->hwirq % 32);
 
 	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
 }
@@ -96,17 +100,18 @@ void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
 	irq_set_chained_handler(irq, combiner_handle_cascade_irq);
 }
 
-void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
-			  unsigned int irq_start)
+void __init combiner_init(unsigned int combiner_nr, void __iomem *base)
 {
-	unsigned int i;
+	unsigned int i, hwirq;
 
 	if (combiner_nr >= MAX_COMBINER_NR)
 		BUG();
 
 	combiner_data[combiner_nr].base = base;
-	combiner_data[combiner_nr].irq_offset = irq_start;
+	combiner_data[combiner_nr].irq_offset =	irq_domain_to_irq(
+		&combiner_irq_domain, combiner_nr * MAX_IRQ_IN_COMBINER);
 	combiner_data[combiner_nr].irq_mask = 0xff << ((combiner_nr % 4) << 3);
+	combiner_data[combiner_nr].domain = &combiner_irq_domain;
 
 	/* Disable all interrupts */
 
@@ -114,11 +119,46 @@ void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
 		     base + COMBINER_ENABLE_CLEAR);
 
 	/* Setup the Linux IRQ subsystem */
-
-	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
-				+ MAX_IRQ_IN_COMBINER; i++) {
+	for (hwirq = 0; hwirq < MAX_IRQ_IN_COMBINER; hwirq++) {
+		i = combiner_data[combiner_nr].irq_offset + hwirq;
 		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
 		irq_set_chip_data(i, &combiner_data[combiner_nr]);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
 }
+
+static int combiner_dt_translate(struct irq_domain *d,
+		struct device_node *controller, const u32 *intspec,
+		unsigned int intsize, unsigned long *out_hwirq,
+		unsigned int *out_type)
+{
+	if (d->of_node != controller)
+		return -EINVAL;
+	if (intsize < 2)
+		return -EINVAL;
+
+	*out_hwirq = intspec[0] * MAX_IRQ_IN_COMBINER + intspec[1];
+	*out_type = 0;
+	return 0;
+}
+
+static struct irq_domain_ops combiner_irq_domain_ops = {
+	.dt_translate = combiner_dt_translate,
+};
+
+int __init combiner_init_irq_domain(unsigned int irq_base, unsigned int nr_irq,
+					struct device_node *np)
+{
+	struct irq_domain *domain = &combiner_irq_domain;
+
+	domain->irq_base = irq_alloc_descs(irq_base, irq_base, nr_irq, 0);
+	if (domain->irq_base < 0) {
+		pr_err("failed to alloc irq descs, combiner init failed\n");
+		return -EBUSY;
+	}
+	domain->nr_irq = nr_irq;
+	domain->ops = &combiner_irq_domain_ops;
+	domain->of_node = np;
+	irq_domain_add(domain);
+	return 0;
+}
-- 
1.6.6.rc2
