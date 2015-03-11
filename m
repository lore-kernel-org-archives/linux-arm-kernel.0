From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:44:52 +0000
Subject: [PATCH v6 1/2] ARM: exynos4/5: convert pmu wakeup to stacked domains
In-Reply-To: <1426088693-15724-1-git-send-email-marc.zyngier@arm.com>
References: <1426088693-15724-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088693-15724-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos has been (ab)using the gic_arch_extn to provide
wakeup from suspend, and it makes a lot of sense to convert
this code to use stacked domains instead.

This patch does just this, updating the DT files to actually
reflect what the HW provides.

BIG FAT WARNING: because the DTs were so far lying by not
exposing the fact that the PMU block is actually the first
interrupt controller in the chain for RTC, kernels with this patch
applied wont have any suspend-resume facility when booted
with old DTs, and old kernels with updated DTs may not even boot.

Also, I stronly suspect that there is more than two wake-up
interrupts on these platforms, but I leave it to the maintainers
to fix their mess.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/exynos3250.dtsi |   6 +-
 arch/arm/boot/dts/exynos4.dtsi    |   4 ++
 arch/arm/boot/dts/exynos5250.dtsi |   4 ++
 arch/arm/boot/dts/exynos5420.dtsi |   4 ++
 arch/arm/mach-exynos/exynos.c     |  15 ++--
 arch/arm/mach-exynos/suspend.c    | 139 ++++++++++++++++++++++++++++++++++----
 6 files changed, 147 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 277b48b..554e9be 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -130,6 +130,9 @@
 		pmu_system_controller: system-controller at 10020000 {
 			compatible = "samsung,exynos3250-pmu", "syscon";
 			reg = <0x10020000 0x4000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
 		};
 
 		mipi_phy: video-phy at 10020710 {
@@ -183,7 +186,8 @@
 		rtc: rtc at 10070000 {
 			compatible = "samsung,exynos3250-rtc";
 			reg = <0x10070000 0x100>;
-			interrupts = <0 73 0>, <0 74 0>;
+			interrupts = <0 41 0>, <0 42 0>;
+			interrupt-parent = <&pmu_system_controller>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 76173ca..1d21f02 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -152,6 +152,9 @@
 	pmu_system_controller: system-controller at 10020000 {
 		compatible = "samsung,exynos4210-pmu", "syscon";
 		reg = <0x10020000 0x4000>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	dsi_0: dsi at 11C80000 {
@@ -264,6 +267,7 @@
 	rtc at 10070000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
+		interrupt-parent = <&pmu_system_controller>;
 		interrupts = <0 44 0>, <0 45 0>;
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 9bb1b0b..72fa2d1 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -196,6 +196,9 @@
 		clock-names = "clkout16";
 		clocks = <&clock CLK_FIN_PLL>;
 		#clock-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	sysreg_system_controller: syscon at 10050000 {
@@ -232,6 +235,7 @@
 	rtc: rtc at 101E0000 {
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
+		interrupt-parent = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9dc2e97..d11a6ab 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -327,6 +327,7 @@
 	rtc: rtc at 101E0000 {
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
+		interrupt-parent = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
@@ -769,6 +770,9 @@
 		clock-names = "clkout16";
 		clocks = <&clock CLK_FIN_PLL>;
 		#clock-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	sysreg_system_controller: syscon at 10050000 {
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 9e9dfdf..f44c2e0 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -166,16 +166,14 @@ static void __init exynos_init_io(void)
 	exynos_map_io();
 }
 
+/*
+ * Apparently, these SoCs are not able to wake-up from suspend using
+ * the PMU. Too bad. Should they suddenly become capable of such a
+ * feat, the matches below should be moved to suspend.c.
+ */
 static const struct of_device_id exynos_dt_pmu_match[] = {
-	{ .compatible = "samsung,exynos3250-pmu" },
-	{ .compatible = "samsung,exynos4210-pmu" },
-	{ .compatible = "samsung,exynos4212-pmu" },
-	{ .compatible = "samsung,exynos4412-pmu" },
-	{ .compatible = "samsung,exynos4415-pmu" },
-	{ .compatible = "samsung,exynos5250-pmu" },
 	{ .compatible = "samsung,exynos5260-pmu" },
 	{ .compatible = "samsung,exynos5410-pmu" },
-	{ .compatible = "samsung,exynos5420-pmu" },
 	{ /*sentinel*/ },
 };
 
@@ -186,9 +184,6 @@ static void exynos_map_pmu(void)
 	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
 	if (np)
 		pmu_base_addr = of_iomap(np, 0);
-
-	if (!pmu_base_addr)
-		panic("failed to find exynos pmu register\n");
 }
 
 static void __init exynos_init_irq(void)
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 52e2b1a..891e431 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -18,7 +18,9 @@
 #include <linux/syscore_ops.h>
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
-#include <linux/irqchip/arm-gic.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
 #include <linux/err.h>
 #include <linux/regulator/machine.h>
 
@@ -43,8 +45,8 @@
 #define EXYNOS5420_CPU_STATE	0x28
 
 /**
- * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
- * @hwirq: Hardware IRQ signal of the GIC
+ * struct exynos_wkup_irq - PMU IRQ to mask mapping
+ * @hwirq: Hardware IRQ signal of the PMU
  * @mask: Mask in PMU wake-up mask register
  */
 struct exynos_wkup_irq {
@@ -87,20 +89,20 @@ static unsigned int exynos_pmu_spare3;
 static u32 exynos_irqwake_intmask = 0xffffffff;
 
 static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
-	{ 73, BIT(1) }, /* RTC alarm */
-	{ 74, BIT(2) }, /* RTC tick */
+	{ 41, BIT(1) }, /* RTC alarm */
+	{ 42, BIT(2) }, /* RTC tick */
 	{ /* sentinel */ },
 };
 
 static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
-	{ 76, BIT(1) }, /* RTC alarm */
-	{ 77, BIT(2) }, /* RTC tick */
+	{ 44, BIT(1) }, /* RTC alarm */
+	{ 45, BIT(2) }, /* RTC tick */
 	{ /* sentinel */ },
 };
 
 static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
-	{ 75, BIT(1) }, /* RTC alarm */
-	{ 76, BIT(2) }, /* RTC tick */
+	{ 43, BIT(1) }, /* RTC alarm */
+	{ 44, BIT(2) }, /* RTC tick */
 	{ /* sentinel */ },
 };
 
@@ -167,6 +169,113 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 	return -ENOENT;
 }
 
+static struct irq_chip exynos_pmu_chip = {
+	.name			= "PMU",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_wake		= exynos_irq_set_wake,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+};
+
+static int exynos_pmu_domain_xlate(struct irq_domain *domain,
+				   struct device_node *controller,
+				   const u32 *intspec,
+				   unsigned int intsize,
+				   unsigned long *out_hwirq,
+				   unsigned int *out_type)
+{
+	if (domain->of_node != controller)
+		return -EINVAL;	/* Shouldn't happen, really... */
+	if (intsize != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (intspec[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
+	return 0;
+}
+
+static int exynos_pmu_domain_alloc(struct irq_domain *domain,
+				   unsigned int virq,
+				   unsigned int nr_irqs, void *data)
+{
+	struct of_phandle_args *args = data;
+	struct of_phandle_args parent_args;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (args->args_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (args->args[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = args->args[1];
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &exynos_pmu_chip, NULL);
+
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+}
+
+static struct irq_domain_ops exynos_pmu_domain_ops = {
+	.xlate	= exynos_pmu_domain_xlate,
+	.alloc	= exynos_pmu_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int __init exynos_pmu_irq_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		return -ENXIO;
+	}
+
+	pmu_base_addr = of_iomap(node, 0);
+
+	if (!pmu_base_addr) {
+		pr_err("%s: failed to find exynos pmu register\n",
+		       node->full_name);
+		return -ENOMEM;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, 0,
+					  node, &exynos_pmu_domain_ops,
+					  NULL);
+	if (!domain) {
+		iounmap(pmu_base_addr);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#define EXYNOS_PMU_IRQ(symbol, name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+
+EXYNOS_PMU_IRQ(exynos3250_pmu_irq, "samsung,exynos3250-pmu");
+EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");
+EXYNOS_PMU_IRQ(exynos4212_pmu_irq, "samsung,exynos4212-pmu");
+EXYNOS_PMU_IRQ(exynos4412_pmu_irq, "samsung,exynos4412-pmu");
+EXYNOS_PMU_IRQ(exynos4415_pmu_irq, "samsung,exynos4415-pmu");
+EXYNOS_PMU_IRQ(exynos5250_pmu_irq, "samsung,exynos5250-pmu");
+EXYNOS_PMU_IRQ(exynos5420_pmu_irq, "samsung,exynos5420-pmu");
+
 static int exynos_cpu_do_idle(void)
 {
 	/* issue the standby signal into the pm unit. */
@@ -615,17 +724,19 @@ static struct syscore_ops exynos_pm_syscore_ops;
 void __init exynos_pm_init(void)
 {
 	const struct of_device_id *match;
+	struct device_node *np;
 	u32 tmp;
 
-	of_find_matching_node_and_match(NULL, exynos_pmu_of_device_ids, &match);
-	if (!match) {
+	np = of_find_matching_node_and_match(NULL, exynos_pmu_of_device_ids, &match);
+	if (!np) {
 		pr_err("Failed to find PMU node\n");
 		return;
 	}
-	pm_data = (struct exynos_pm_data *) match->data;
 
-	/* Platform-specific GIC callback */
-	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
+	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL)))
+		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
+
+	pm_data = (struct exynos_pm_data *) match->data;
 
 	/* All wakeup disable */
 	tmp = pmu_raw_readl(S5P_WAKEUP_MASK);
-- 
2.1.4
