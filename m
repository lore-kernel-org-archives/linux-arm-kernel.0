From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 03 Sep 2011 18:55:51 +0530
Subject: [PATCH] arm: exynos4: add support for dt irq specifier to linux virq
	conversion
Message-ID: <1315056351-26486-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for conversion of device tree interrupt specifier to linux
virq domain for GIC and Interrupt combiner controllers.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
For GIC controller, this patch is based on Rob Herring's
"[RFC PATCH 0/3] Yet another GIC OF binding series" patchset
with v2 of the third patch in that series.

The concept of irq domain for interrupt combiner controller
is based on Grant's 'simple' irq converter.

 .../devicetree/bindings/irq/samsung-combiner.txt   |   24 ++++++++
 arch/arm/mach-exynos4/cpu.c                        |   56 +++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/irq/samsung-combiner.txt

diff --git a/Documentation/devicetree/bindings/irq/samsung-combiner.txt b/Documentation/devicetree/bindings/irq/samsung-combiner.txt
new file mode 100644
index 0000000..b020f79
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
index 746d6fc..de3d6e4 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -10,6 +10,10 @@
 
 #include <linux/sched.h>
 #include <linux/sysdev.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/irqdomain.h>
+#include <linux/slab.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -31,6 +35,7 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
+#include <mach/irqs.h>
 
 extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 			 unsigned int irq_start);
@@ -182,13 +187,62 @@ static void exynos4_gic_irq_eoi(struct irq_data *d)
 			    (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
 }
 
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
+#endif
+
 void __init exynos4_init_irq(void)
 {
 	int irq;
-
-	gic_init(0, IRQ_SPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+#ifdef CONFIG_OF
+	struct of_intc_desc desc;
+	struct irq_domain *domain;
+	struct device_node *node;
+
+	memset(&desc, 0, sizeof(desc));
+	desc.irq_base = IRQ_SPI(0);
+	desc.controller = of_find_compatible_node(NULL, NULL,
+				"arm,cortex-a9-gic");
+	if (desc.controller)
+		gic_of_init(&desc);
+	else
+#endif
+		gic_init(0, IRQ_SPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
 	gic_arch_extn.irq_eoi = exynos4_gic_irq_eoi;
 
+#ifdef CONFIG_OF
+	node = of_find_compatible_node(NULL, NULL,
+			"samsung,exynos4-combiner");
+	if (node) {
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (domain) {
+			domain->of_node = node;
+			domain->ops = &exynos4_irq_domain_combiner_ops;
+			irq_domain_add(domain);
+		} else {
+			WARN_ON(1);
+		}
+	}
+#endif
+
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
 
 		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
-- 
1.6.6.rc2
