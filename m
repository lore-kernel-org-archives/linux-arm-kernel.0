From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 13:41:29 +0530
Subject: [PATCH 3/3] ARM: Exynos4: Add support for dt irq specifier to linux
	virq conversion
In-Reply-To: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318234289-22041-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for conversion of device tree interrupt specifier to linux
virq domain for GIC and Interrupt combiner controllers.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/irq/samsung-combiner.txt   |   24 ++++++++++
 arch/arm/mach-exynos4/cpu.c                        |   20 ++++++++-
 arch/arm/mach-exynos4/irq-combiner.c               |   45 ++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/irq/samsung-combiner.txt

diff --git a/Documentation/devicetree/bindings/irq/samsung-combiner.txt b/Documentation/devicetree/bindings/irq/samsung-combiner.txt
new file mode 100644
index 0000000..b7d5c30
--- /dev/null
+++ b/Documentation/devicetree/bindings/irq/samsung-combiner.txt
@@ -0,0 +1,24 @@
+* Exynos4 Interrupt Combiner Controller
+
+Samsung's Exynos4 architecture includes a interrupt combiner which
+can combine interrupt sources as a group and provide a single
+interrupt request for the group. The interrupt request from each
+group are connected to a parent interrupt controller, which is GIC
+in case of Exynos4.
+
+Required properties:
+- compatible: should be "samsung,exynos4-combiner".
+- interrupt-cells: should be <2>. The meaning of the cells are
+    * First Cell: Combiner Group Number.
+    * Second Cell: Interrupt within the group.
+- reg: Base address and size of interrupt combiner registers.
+- interrupt-controller: Identifies the node as an interrupt controller.
+
+Example:
+
+	combiner: interrupt-controller at 10440000 {
+		compatible = "samsung,exynos4-combiner";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0x10440000 0x200>;
+	};
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 358624d..776e8d4 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -10,6 +10,8 @@
 
 #include <linux/sched.h>
 #include <linux/sysdev.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -38,6 +40,8 @@ unsigned int gic_bank_offset __read_mostly;
 extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 			 unsigned int irq_start);
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
+extern void combiner_init_dt(struct device_node *node,
+				struct device_node *parent);
 
 /* Initial IO mappings */
 static struct map_desc exynos4_iodesc[] __initdata = {
@@ -229,13 +233,27 @@ static void exynos4_gic_irq_fix_base(struct irq_data *d)
 			    (gic_bank_offset * smp_processor_id());
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id exynos4_dt_irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ .compatible = "samsung,exynos4-combiner", .data = combiner_init_dt, },
+	{},
+};
+#endif
+
 void __init exynos4_init_irq(void)
 {
 	int irq;
 
 	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
 
-	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+#ifdef CONFIG_OF
+	if (of_have_populated_dt())
+		of_irq_init(exynos4_dt_irq_match);
+	else
+#endif
+		gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+
 	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
diff --git a/arch/arm/mach-exynos4/irq-combiner.c b/arch/arm/mach-exynos4/irq-combiner.c
index 5a2758a..198bd0d 100644
--- a/arch/arm/mach-exynos4/irq-combiner.c
+++ b/arch/arm/mach-exynos4/irq-combiner.c
@@ -12,7 +12,12 @@
  * published by the Free Software Foundation.
 */
 
+#include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/slab.h>
 
 #include <asm/mach/irq.h>
 
@@ -122,3 +127,43 @@ void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
 }
+
+#ifdef CONFIG_OF
+/* Translate dt irq specifier to linux virq for interrupt combiner controller */
+static int exynos4_irq_domain_combiner_dt_translate(struct irq_domain *d,
+			struct device_node *controller,
+			const u32 *intspec, unsigned int intsize,
+			unsigned long *out_hwirq, unsigned int *out_type)
+{
+	if (d->of_node != controller)
+		return -EINVAL;
+	if (intsize < 2)
+		return -EINVAL;
+
+	*out_hwirq = COMBINER_IRQ(intspec[0], intspec[1]);
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static struct irq_domain_ops exynos4_irq_domain_combiner_ops = {
+	.dt_translate = exynos4_irq_domain_combiner_dt_translate,
+};
+
+void __init combiner_init_dt(struct device_node *node,
+					struct device_node *parent)
+{
+	struct irq_domain *domain;
+
+	if (WARN(!node, "combiner_init_dt: invalid node in parameter\n"))
+		return;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (domain) {
+		domain->of_node = node;
+		domain->ops = &exynos4_irq_domain_combiner_ops;
+		irq_domain_add(domain);
+	} else {
+		WARN_ON(1);
+	}
+}
+#endif
-- 
1.6.6.rc2
