From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 07 Dec 2011 19:29:52 +0530
Subject: [PATCH 4/4] arm: exynos4: add device tree support for external wakeup
 interrupt controller
In-Reply-To: <1323266392-28330-4-git-send-email-thomas.abraham@linaro.org>
References: <1323266392-28330-1-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-2-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-3-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1323266392-28330-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for external wakeup source interrupt controller
on Exynos4.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../bindings/arm/samsung/wakeup-eint.txt           |   14 ++++++++++++++
 arch/arm/mach-exynos/cpu.c                         |    5 ++++-
 arch/arm/mach-exynos/irq-eint.c                    |    9 +++++++++
 3 files changed, 27 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt b/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
new file mode 100644
index 0000000..0ca5782
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt
@@ -0,0 +1,14 @@
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
+    interrupt source number. The value of should be <2>. The first cell
+    represents the wakeup interrupt source number and the second cell
+    should be zero (currently unused).
diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 6d27c36..306c13c 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -245,6 +245,8 @@ static void exynos4_gic_irq_fix_base(struct irq_data *d)
 #ifdef CONFIG_OF
 static const struct of_device_id exynos4_dt_irq_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ .compatible = "samsung,exynos4210-wakeup-eint",
+		.data = exynos4_init_irq_eint, },
 	{},
 };
 #endif
@@ -278,7 +280,8 @@ void __init exynos4_init_irq(void)
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
-	exynos4_init_irq_eint();
+	if (!of_have_populated_dt())
+		exynos4_init_irq_eint();
 }
 
 struct sysdev_class exynos4_sysclass = {
diff --git a/arch/arm/mach-exynos/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
index 771b156..e78fdfa 100644
--- a/arch/arm/mach-exynos/irq-eint.c
+++ b/arch/arm/mach-exynos/irq-eint.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/irqdomain.h>
 #include <linux/export.h>
+#include <linux/of.h>
 
 #include <plat/pm.h>
 #include <plat/cpu.h>
@@ -210,6 +211,14 @@ int __init exynos4_init_irq_eint(void)
 	}
 	domain->nr_irq = EXYNOS4_EINT_NR;
 	domain->ops = &irq_domain_simple_ops;
+#ifdef CONFIG_OF
+	if (of_have_populated_dt()) {
+		domain->of_node = of_find_compatible_node(NULL, NULL,
+					"samsung,exynos4210-wakeup-eint");
+		if (!domain->of_node)
+			pr_info("exynos4_init_irq_eint: of_node not found\n");
+	}
+#endif
 	irq_domain_add(domain);
 
 	irq_domain_for_each_irq(domain, hwirq, irq) {
-- 
1.6.6.rc2
