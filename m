From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 07 Oct 2011 02:41:43 +0530
Subject: [PATCH 2/2] arm: exynos4: add support for dt irq specifier to linux
	virq conversion
In-Reply-To: <1317935503-11756-1-git-send-email-thomas.abraham@linaro.org>
References: <1317935503-11756-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1317935503-11756-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for conversion of device tree interrupt specifier to linux
virq domain for GIC and Interrupt combiner controllers.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/cpu.c          |   20 ++++++++++++++-
 arch/arm/mach-exynos4/irq-combiner.c |   44 ++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 1c5e803..9898f9c 100644
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
@@ -218,13 +222,27 @@ static void exynos4_gic_irq_fix_base(struct irq_data *d)
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
index 5a2758a..d2d143a 100644
--- a/arch/arm/mach-exynos4/irq-combiner.c
+++ b/arch/arm/mach-exynos4/irq-combiner.c
@@ -13,6 +13,10 @@
 */
 
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/slab.h>
 
 #include <asm/mach/irq.h>
 
@@ -122,3 +126,43 @@ void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
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
