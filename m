From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:44:32 +0000
Subject: [PATCH v6] ARM: imx6: convert GPC to stacked domains
Message-ID: <1426088672-15587-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX6 has been (ab)using the gic_arch_extn to provide
wakeup from suspend, and it makes a lot of sense to convert
this code to use stacked domains instead.

This patch does just this, updating the DT files to actually
reflect what the HW provides.

BIG FAT WARNING: because the DTs were so far lying by not
exposing the fact that the GPC block is actually the first
interrupt controller in the chain, kernels with this patch
applied wont have any suspend-resume facility when booted
with old DTs, and old kernels with updated DTs won't even boot.

Tested-by: Stefan Agner <stefan@agner.ch>
Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v5:
- Added a big fat warning when an old DT is detected (as requested by Jason)
- Allow interrupt affinity to be changed

 arch/arm/boot/dts/imx6qdl.dtsi  |   7 ++-
 arch/arm/boot/dts/imx6sl.dtsi   |   6 +-
 arch/arm/boot/dts/imx6sx.dtsi   |   6 +-
 arch/arm/mach-imx/common.h      |   1 -
 arch/arm/mach-imx/gpc.c         | 130 ++++++++++++++++++++++++++++++++--------
 arch/arm/mach-imx/mach-imx6q.c  |   1 -
 arch/arm/mach-imx/mach-imx6sl.c |   1 -
 arch/arm/mach-imx/mach-imx6sx.c |   1 -
 arch/arm/mach-imx/pm-imx6.c     |  12 +++-
 9 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d6c69ec..19f2c3c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -53,6 +53,7 @@
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
 		      <0x00a00100 0x100>;
+		interrupt-parent = <&intc>;
 	};
 
 	clocks {
@@ -82,7 +83,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		interrupt-parent = <&intc>;
+		interrupt-parent = <&gpc>;
 		ranges;
 
 		dma_apbh: dma-apbh at 00110000 {
@@ -122,6 +123,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
 			interrupts = <1 13 0xf01>;
+			interrupt-parent = <&intc>;
 			clocks = <&clks IMX6QDL_CLK_TWD>;
 		};
 
@@ -693,8 +695,11 @@
 			gpc: gpc at 020dc000 {
 				compatible = "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&intc>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 36ab8e0..0d0962b 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -72,6 +72,7 @@
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
 		      <0x00a00100 0x100>;
+		interrupt-parent = <&intc>;
 	};
 
 	clocks {
@@ -95,7 +96,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		interrupt-parent = <&intc>;
+		interrupt-parent = <&gpc>;
 		ranges;
 
 		ocram: sram at 00900000 {
@@ -603,7 +604,10 @@
 			gpc: gpc at 020dc000 {
 				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&intc>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7a24fee..dabaf89 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -88,6 +88,7 @@
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
 		      <0x00a00100 0x100>;
+		interrupt-parent = <&intc>;
 	};
 
 	clocks {
@@ -131,7 +132,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		interrupt-parent = <&intc>;
+		interrupt-parent = <&gpc>;
 		ranges;
 
 		pmu {
@@ -700,7 +701,10 @@
 			gpc: gpc at 020dc000 {
 				compatible = "fsl,imx6sx-gpc", "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&intc>;
 			};
 
 			iomuxc: iomuxc at 020e0000 {
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 1028b6c..f22e400 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -106,7 +106,6 @@ static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
 #endif
 void imx_src_init(void);
-void imx_gpc_init(void);
 void imx_gpc_pre_suspend(bool arm_power_off);
 void imx_gpc_post_resume(void);
 void imx_gpc_mask_all(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 745caa1..24525e3 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -26,6 +26,7 @@
 #define GPC_PGC_SW_SHIFT	0x0
 
 #define IMR_NUM			4
+#define GPC_MAX_IRQS		(IMR_NUM * 32)
 
 static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
@@ -77,17 +78,17 @@ void imx_gpc_post_resume(void)
 
 static int imx_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	unsigned int idx = d->hwirq / 32 - 1;
+	unsigned int idx = d->hwirq / 32;
 	u32 mask;
 
-	/* Sanity check for SPI irq */
-	if (d->hwirq < 32)
-		return -EINVAL;
-
 	mask = 1 << d->hwirq % 32;
 	gpc_wake_irqs[idx] = on ? gpc_wake_irqs[idx] | mask :
 				  gpc_wake_irqs[idx] & ~mask;
 
+	/*
+	 * Do *not* call into the parent, as the GIC doesn't have any
+	 * wake-up facility...
+	 */
 	return 0;
 }
 
@@ -117,7 +118,7 @@ void imx_gpc_hwirq_unmask(unsigned int hwirq)
 	void __iomem *reg;
 	u32 val;
 
-	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
+	reg = gpc_base + GPC_IMR1 + hwirq / 32 * 4;
 	val = readl_relaxed(reg);
 	val &= ~(1 << hwirq % 32);
 	writel_relaxed(val, reg);
@@ -128,7 +129,7 @@ void imx_gpc_hwirq_mask(unsigned int hwirq)
 	void __iomem *reg;
 	u32 val;
 
-	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
+	reg = gpc_base + GPC_IMR1 + hwirq / 32 * 4;
 	val = readl_relaxed(reg);
 	val |= 1 << (hwirq % 32);
 	writel_relaxed(val, reg);
@@ -136,37 +137,118 @@ void imx_gpc_hwirq_mask(unsigned int hwirq)
 
 static void imx_gpc_irq_unmask(struct irq_data *d)
 {
-	/* Sanity check for SPI irq */
-	if (d->hwirq < 32)
-		return;
-
 	imx_gpc_hwirq_unmask(d->hwirq);
+	irq_chip_unmask_parent(d);
 }
 
 static void imx_gpc_irq_mask(struct irq_data *d)
 {
-	/* Sanity check for SPI irq */
-	if (d->hwirq < 32)
-		return;
-
 	imx_gpc_hwirq_mask(d->hwirq);
+	irq_chip_mask_parent(d);
+}
+
+static struct irq_chip imx_gpc_chip = {
+	.name			= "GPC",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= imx_gpc_irq_mask,
+	.irq_unmask		= imx_gpc_irq_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_wake		= imx_gpc_irq_set_wake,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+};
+
+static int imx_gpc_domain_xlate(struct irq_domain *domain,
+				struct device_node *controller,
+				const u32 *intspec,
+				unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
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
+static int imx_gpc_domain_alloc(struct irq_domain *domain,
+				  unsigned int irq,
+				  unsigned int nr_irqs, void *data)
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
+	if (hwirq >= GPC_MAX_IRQS)
+		return -EINVAL;	/* Can't deal with this */
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
+					      &imx_gpc_chip, NULL);
+
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
 }
 
-void __init imx_gpc_init(void)
+static struct irq_domain_ops imx_gpc_domain_ops = {
+	.xlate	= imx_gpc_domain_xlate,
+	.alloc	= imx_gpc_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int __init imx_gpc_init(struct device_node *node,
+			       struct device_node *parent)
 {
-	struct device_node *np;
+	struct irq_domain *parent_domain, *domain;
 	int i;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
-	gpc_base = of_iomap(np, 0);
-	WARN_ON(!gpc_base);
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
+	gpc_base = of_iomap(node, 0);
+	if (WARN_ON(!gpc_base))
+	        return -ENOMEM;
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
+					  node, &imx_gpc_domain_ops,
+					  NULL);
+	if (!domain) {
+		iounmap(gpc_base);
+		return -ENOMEM;
+	}
 
 	/* Initially mask all interrupts */
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
 
-	/* Register GPC as the secondary interrupt controller behind GIC */
-	gic_arch_extn.irq_mask = imx_gpc_irq_mask;
-	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
-	gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
+	return 0;
 }
+
+/*
+ * We cannot use the IRQCHIP_DECLARE macro that lives in
+ * drivers/irqchip, so we're forced to roll our own. Not very nice.
+ */
+OF_DECLARE_2(irqchip, imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4ad6e47..6fc2b7e 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -390,7 +390,6 @@ static void __init imx6q_init_irq(void)
 	imx_init_revision_from_anatop();
 	imx_init_l2cache();
 	imx_src_init();
-	imx_gpc_init();
 	irqchip_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 24bfaaf..d39c274 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -64,7 +64,6 @@ static void __init imx6sl_init_irq(void)
 	imx_init_revision_from_anatop();
 	imx_init_l2cache();
 	imx_src_init();
-	imx_gpc_init();
 	irqchip_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 66988eb..8595f9e 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -84,7 +84,6 @@ static void __init imx6sx_init_irq(void)
 	imx_init_revision_from_anatop();
 	imx_init_l2cache();
 	imx_src_init();
-	imx_gpc_init();
 	irqchip_init();
 }
 
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 46fd695..f03f30f0 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -310,10 +310,12 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	 *    Low-Power mode.
 	 * 3) Software should mask IRQ #32 right after CCM Low-Power mode
 	 *    is set (set bits 0-1 of CCM_CLPCR).
+	 *
+	 * Note that IRQ #32 is GIC SPI #0.
 	 */
-	imx_gpc_hwirq_unmask(32);
+	imx_gpc_hwirq_unmask(0);
 	writel_relaxed(val, ccm_base + CLPCR);
-	imx_gpc_hwirq_mask(32);
+	imx_gpc_hwirq_mask(0);
 
 	return 0;
 }
@@ -552,11 +554,17 @@ put_node:
 static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 					*socdata)
 {
+	struct device_node *np;
 	struct regmap *gpr;
 	int ret;
 
 	WARN_ON(!ccm_base);
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
+	if (WARN_ON(!np ||
+		    !of_find_property(np, "interrupt-controller", NULL)))
+		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
+
 	if (IS_ENABLED(CONFIG_SUSPEND)) {
 		ret = imx6q_suspend_init(socdata);
 		if (ret)
-- 
2.1.4
