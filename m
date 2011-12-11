From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 11 Dec 2011 12:21:41 +0530
Subject: [PATCH v2 4/4] ARM: Exynos4: Add device tree support for external
 wakeup interrupt controller
In-Reply-To: <1323586301-24537-4-git-send-email-thomas.abraham@linaro.org>
References: <1323586301-24537-1-git-send-email-thomas.abraham@linaro.org>
 <1323586301-24537-2-git-send-email-thomas.abraham@linaro.org>
 <1323586301-24537-3-git-send-email-thomas.abraham@linaro.org>
 <1323586301-24537-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1323586301-24537-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for external wakeup source interrupt controller
on Exynos4.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../bindings/arm/samsung/wakeup-eint.txt           |   26 ++++++++++++++++++++
 arch/arm/mach-exynos/cpu.c                         |    7 ++++-
 arch/arm/mach-exynos/irq-eint.c                    |    4 ++-
 arch/arm/plat-samsung/include/plat/exynos4.h       |    5 +++-
 4 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt b/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
new file mode 100644
index 0000000..7906e5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
@@ -0,0 +1,26 @@
+* Samsung Exynos4 External Wakeup Interrupt Source Controller
+
+Samsung Exynos4 processor supports 32 external wakeup interrupt sources. First
+16 of these interrupts are directly connected to GIC and the rest 16 of the
+interrupts are grouped together to deliver a single interrupt to GIC.
+
+Required properties:
+
+- compatible: should be "samsung,exynos4210-wakeup-eint".
+- interrupt-controller: Identifies the node as an interrupt controller.
+- interrupt-cells: Specifies the number of cells required to specify the
+  interrupt source number. The value of should be <2>. The first cell
+  represents the wakeup interrupt source number and the second cell
+  should be zero (currently unused).
+
+Optional properties:
+- interrupt-parent: phandle of the parent interrupt controller, required if
+  not inheriting the interrupt parent from the parent node.
+
+Example:
+
+	wakeup_eint: interrupt-controller-wakeup-eint {
+		compatible = "samsung,exynos4210-wakeup-eint";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 2e6ae21..12165b1 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -261,6 +261,8 @@ static const struct of_device_id exynos4_dt_irq_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
 	{ .compatible = "samsung,exynos4120-combiner",
 			.data = combiner_of_init, },
+	{ .compatible = "samsung,exynos4210-wakeup-eint",
+		.data = exynos4_init_irq_eint, },
 	{},
 };
 #endif
@@ -281,15 +283,16 @@ void __init exynos4_init_irq(void)
 	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
 
-	if (!of_have_populated_dt())
+	if (!of_have_populated_dt()) {
 		combiner_of_init(NULL, NULL);
+		exynos4_init_irq_eint(NULL, NULL);
+	}
 
 	/* The parameters of s5p_init_irq() are for VIC init.
 	 * Theses parameters should be NULL and 0 because EXYNOS4
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
-	exynos4_init_irq_eint();
 }
 
 struct sysdev_class exynos4_sysclass = {
diff --git a/arch/arm/mach-exynos/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
index c8bad66..4ee88f6 100644
--- a/arch/arm/mach-exynos/irq-eint.c
+++ b/arch/arm/mach-exynos/irq-eint.c
@@ -197,7 +197,8 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-int __init exynos4_init_irq_eint(void)
+int __init exynos4_init_irq_eint(struct device_node *np,
+					struct device_node *parent)
 {
 	int irq, hwirq;
 	struct irq_domain *domain = &exynos4_eint_irq_domain;
@@ -210,6 +211,7 @@ int __init exynos4_init_irq_eint(void)
 	}
 	domain->nr_irq = EXYNOS4_EINT_NR;
 	domain->ops = &irq_domain_simple_ops;
+	domain->of_node = np;
 	irq_domain_add(domain);
 
 	irq_domain_for_each_irq(domain, hwirq, irq) {
diff --git a/arch/arm/plat-samsung/include/plat/exynos4.h b/arch/arm/plat-samsung/include/plat/exynos4.h
index a501461..5895f8b 100644
--- a/arch/arm/plat-samsung/include/plat/exynos4.h
+++ b/arch/arm/plat-samsung/include/plat/exynos4.h
@@ -12,6 +12,8 @@
 
 /* Common init code for EXYNOS4 related SoCs */
 
+#include <linux/of.h>
+
 extern void exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void exynos4_register_clocks(void);
 extern void exynos4210_register_clocks(void);
@@ -24,7 +26,8 @@ extern void exynos4_init_irq(void);
 extern void exynos4_map_io(void);
 extern void exynos4_init_clocks(int xtal);
 extern struct sys_timer exynos4_timer;
-extern int exynos4_init_irq_eint(void);
+extern int exynos4_init_irq_eint(struct device_node *np,
+					struct device_node *parent);
 
 #define exynos4_init_uarts exynos4_common_init_uarts
 
-- 
1.6.6.rc2
