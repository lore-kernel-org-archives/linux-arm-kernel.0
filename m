From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jun 2011 15:10:58 +0100
Subject: [RFC PATCH 3/4] ARM: dt: add GIC bindings and driver support
In-Reply-To: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308924659-31894-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the GIC driver to use the DT infrastructure. That involves
introducing IRQ domains for the various types of interrupts (PPI and
SPI).

The DT bindings for the GIC are defined as such:
- one interrupt-controller for SPIs
- one interrupt-controller for PPIs per CPU
- interrupt signalling for secondary GICs.

Tested on RealView PB11MPCore and VExpress.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt |   92 ++++++++
 arch/arm/common/gic.c                         |  312 ++++++++++++++++++++-----
 arch/arm/include/asm/hardware/gic.h           |    4 +
 3 files changed, 352 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
new file mode 100644
index 0000000..9975345
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -0,0 +1,92 @@
+* ARM Generic Interrupt Controller
+
+ARM SMP cores are often associated with a GIC, providing per processor
+interrupts (PPI), shared processor interrupts (SPI) and software
+generated interrupts (SGI).
+
+Primary GIC is attached directly to the CPU. Secondary GICs are
+cascaded into the upward interrupt controller.
+
+Main node properties:
+
+- compatible	: "arm,gic"
+- reg		: one register mapping for the distributor interface
+  		  another one for the CPU interface
+- #address-cells: <1>
+- #size-cells	: <0>
+- interrupts	: optionnal, used on secondary GICs only
+
+PPI sub nodes: one node per CPU (primary GIC only)
+
+- interrupt-controller	: required
+- #interrupt-cells	: <1>
+- reg			: index of the CPU this PPI controller is
+			  connected to.
+
+SPI sub node:
+
+- interrupt-controller	: required
+- #interrupt-cells	: <2> First parameter is the interrupt number,
+  			  second is 0 for level-high, 1 for edge-rising.
+
+Primary GIC example (ARM RealView PB11-MPCore):
+
+gic at 1f001000 {
+	compatible = "arm,gic";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	reg = <0x1f001000 0x1000>, /* Distributor interface */
+	      <0x1f000100 0x100>;  /* CPU interface */
+
+	/* One PPI controller per CPU, only on primary GIC */
+	gic0ppi0: gic-ppi at 0 {
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0>;
+	};
+
+	gic0ppi1: gic-ppi at 1 {
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <1>;
+	};
+
+	gic0ppi2: gic-ppi at 2 {
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <2>;
+	};
+
+	gic0ppi3: gic-ppi at 3 {
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <3>;
+	};
+
+	/* One global SPI controller per GIC, defined on all GICs */
+	gic0spi: gic-spi {
+		interrupt-controller;
+		#interrupt-cells = <2>; /* IRQ, level/edge */
+	};
+};
+
+Secondary GIC example (ARM RealView PB11-MPCore):
+
+gic at 1e001000 {
+	compatible = "arm,gic";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupt-parent = <&gic0spi>;
+
+	reg = <0x1e001000 0x1000>, /* Distributor interface */
+	      <0x1e000000 0x100>;  /* CPU interface */
+
+	interrupts = <42 0>; /* Cascade */
+
+	/* One global SPI controller per GIC, defined on all GICs */
+	gic1spi: gic-spi {
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index c5acc76..34907ea 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -28,6 +28,9 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
@@ -40,15 +43,15 @@ void __iomem *gic_cpu_base_addr __read_mostly;
 
 struct gic_chip_data {
 	unsigned int irq_offset;
+	unsigned int nr_irqs;
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
+	struct irq_domain spi_dom;
+};
+
 #ifdef CONFIG_ARM_GIC_VPPI
-	/* These fields must be 0 on secondary GICs */
-	int	     ppi_base;
-	int	     vppi_base;
-	u16	     nrppis;
+static DEFINE_PER_CPU(struct irq_domain, gic_ppi_domains);
 #endif
-};
 
 /*
  * Supported arch specific GIC irq extension.
@@ -271,36 +274,26 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 #ifdef CONFIG_ARM_GIC_VPPI
 unsigned int gic_ppi_to_vppi(unsigned int irq)
 {
-	struct gic_chip_data *chip_data = irq_get_chip_data(irq);
-	unsigned int vppi_irq;
-	unsigned int ppi;
+	struct irq_domain *dom = &__get_cpu_var(gic_ppi_domains);
 
-	WARN_ON(!chip_data->vppi_base);
+	return irq_domain_to_irq(dom, irq);
+}
 
-	ppi = irq - chip_data->ppi_base;
-	vppi_irq = ppi + chip_data->nrppis * smp_processor_id();
-	vppi_irq += chip_data->vppi_base;
+unsigned int gic_ppi_to_cpu_vppi(unsigned int irq, int cpu)
+{
+	struct irq_domain *dom = &per_cpu(gic_ppi_domains, cpu);
 
-	return vppi_irq;
+	return irq_domain_to_irq(dom, irq);
 }
 
 static void gic_handle_ppi(unsigned int irq, struct irq_desc *desc)
 {
-	unsigned int vppi_irq;
-
-	vppi_irq = gic_ppi_to_vppi(irq);
-	generic_handle_irq(vppi_irq);
+	generic_handle_irq(gic_ppi_to_vppi(irq));
 }
 
 static struct irq_data *gic_vppi_to_ppi(struct irq_data *d)
 {
-	struct gic_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	unsigned int ppi_irq;
-
-	ppi_irq = d->irq - chip_data->vppi_base - chip_data->nrppis * smp_processor_id();
-	ppi_irq += chip_data->ppi_base;
-
-	return irq_get_irq_data(ppi_irq);
+	return irq_get_irq_data(d->irq - d->domain->irq_base);
 }
 
 static void gic_ppi_eoi_irq(struct irq_data *d)
@@ -345,15 +338,115 @@ static struct irq_chip gic_ppi_chip = {
 	.irq_set_type		= gic_ppi_set_type,
 	.irq_set_wake		= gic_ppi_set_wake,
 };
+
+#ifdef CONFIG_OF
+static int git_dt_translate(struct irq_domain *dom,
+			    struct device_node *controler,
+			    const u32 *intspec, unsigned int intsize,
+			    irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	if (dom->of_node != controler)
+		return -1;
+
+	if (intsize > 1) {
+		if (intspec[1])
+ 			*out_type = IRQ_TYPE_EDGE_RISING;
+		else
+			*out_type = IRQ_TYPE_LEVEL_HIGH;
+	} else
+		*out_type = IRQ_TYPE_NONE;
+
+	*out_hwirq = intspec[0];
+	return 0;
+}
+
+static struct irq_domain_ops gic_ppi_domain_ops = {
+	.dt_translate = git_dt_translate,
+};
+
+static struct of_device_id gic_ids[] = {
+	{ .compatible = "arm,gic", },
+	{ },
+};
+
+static struct device_node *gic_get_node(struct device_node *np)
+{
+	return of_find_matching_node(np, gic_ids);
+}
+
+static struct device_node *gic_get_ppi_node(struct device_node *gic_np,
+					    int cpu_nr)
+{
+	struct device_node *np = NULL;
+
+	if (!gic_np)
+		return NULL;
+
+	while ((np = of_get_next_child(gic_np, np))) {
+		const __be32 *reg;
+
+		if (strcmp(np->name, "gic-ppi"))
+			continue;
+		reg = of_get_property(np, "reg", NULL);
+		if (!reg)	/* Duh? */
+			continue;
+		if (be32_to_cpu(*reg) == cpu_nr)
+			break;
+	}
+
+	return np;
+}
+
+static struct device_node *gic_get_spi_node(struct device_node *gic_np)
+{
+	struct device_node *np = NULL;
+
+	if (!gic_np)
+		return NULL;
+
+	while ((np = of_get_next_child(gic_np, np))) {
+		if (!strcmp(np->name, "gic-spi"))
+			break;
+	}
+
+	return np;
+}
+#else
+static struct irq_domain_ops gic_ppi_domain_ops; /* Use the defaults */
+
+static struct device_node *gic_get_node(struct device_node *np)
+{
+	return NULL;
+}
+
+static struct device_node *gic_get_ppi_node(struct device_node *gic_np,
+					    int cpu_nr)
+{
+	return NULL;
+}
+
+static struct device_node *gic_get_spi_node(struct device_node *gic_np)
+{
+	return NULL;
+}
+#endif
 #endif
 
+static const char *get_of_name(struct device_node *np)
+{
+	return np ? np->full_name : "";
+}
+
 static void __init gic_dist_init(struct gic_chip_data *gic,
-	unsigned int irq_start)
+				 unsigned int irq_start,
+				 struct device_node *gic_node)
 {
-	unsigned int gic_irqs, irq_limit, i, nrvppis = 0;
+	unsigned int gic_irqs, irq_limit, i, c;
 	void __iomem *base = gic->dist_base;
 	u32 cpumask = 1 << smp_processor_id();
-	u32 dist_ctr, nrcpus;
+	u32 dist_ctr, nrcpus, reg;
+	u32 ppi_base = 0;
+	u16 nrppis = 0;
 
 	cpumask |= cpumask << 8;
 	cpumask |= cpumask << 16;
@@ -372,29 +465,26 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	/* Find out how many CPUs are supported (8 max). */
 	nrcpus = ((dist_ctr >> 5) & 7) + 1;
 
-#ifdef CONFIG_ARM_GIC_VPPI
 	/*
 	 * Nobody would be insane enough to use PPIs on a secondary
 	 * GIC, right?
 	 */
 	if (gic == &gic_data[0]) {
-		gic->nrppis = 16 - (irq_start % 16);
-		gic->ppi_base = gic->irq_offset + 32 - gic->nrppis;
-		nrvppis = gic->nrppis * nrcpus;
-	} else {
-		gic->ppi_base = 0;
-		gic->vppi_base = 0;
+		ppi_base = irq_start & 31;
+		nrppis = 16 - (ppi_base & 15);
 	}
-#endif
 
 	pr_info("Configuring GIC with %d sources (%d additional PPIs)\n",
-		gic_irqs, nrvppis);
+		gic_irqs, nrppis * nrcpus);
 
 	/*
-	 * Set all global interrupts to be level triggered, active low.
+	 * Set all global interrupts to be level triggered, active high.
 	 */
-	for (i = 32; i < gic_irqs; i += 16)
-		writel_relaxed(0, base + GIC_DIST_CONFIG + i * 4 / 16);
+	for (i = 32; i < gic_irqs; i += 16) {
+		reg = readl_relaxed(base + GIC_DIST_CONFIG + i * 4 / 16);
+		reg &= 0x55555555;
+		writel_relaxed(reg, base + GIC_DIST_CONFIG + i * 4 / 16);
+	}
 
 	/*
 	 * Set all global interrupts to this CPU only.
@@ -425,30 +515,69 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
 	/*
 	 * Setup the Linux IRQ subsystem.
 	 */
-	for (i = irq_start; i < irq_limit; i++) {
+
+	gic->nr_irqs = gic_irqs;
+	gic->spi_dom.irq_base = irq_start & ~31;
+	gic->spi_dom.ops = &gic_ppi_domain_ops;
+	gic->spi_dom.of_node = gic_get_spi_node(gic_node);
+
+	pr_info("GIC SPI domain %s [%d:%d]\n",
+		get_of_name(gic->spi_dom.of_node), irq_start, irq_limit - 1);
+
+	irq_domain_add(&gic->spi_dom);
+	
+	for (i = ppi_base; i < (irq_limit - gic->spi_dom.irq_base); i++) {
+		unsigned int irq = irq_domain_map(&gic->spi_dom, i);
+		pr_debug("GIC mapping %s:%d to IRQ%d\n",
+			 get_of_name(gic->spi_dom.of_node), i, irq);
 #ifdef CONFIG_ARM_GIC_VPPI
-		if (nrvppis && gic_irq_is_ppi(gic, i))
-			irq_set_chip_and_handler(i, &gic_chip, gic_handle_ppi);
+		if (nrppis && gic_irq_is_ppi(gic, irq))
+			irq_set_chip_and_handler(irq, &gic_chip, gic_handle_ppi);
 		else
 #endif
 		{
-			irq_set_chip_and_handler(i, &gic_chip,
+			irq_set_chip_and_handler(irq, &gic_chip,
 						 handle_fasteoi_irq);
-			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 		}
-		irq_set_chip_data(i, gic);
+		irq_set_chip_data(irq, gic);
 	}
 
 #ifdef CONFIG_ARM_GIC_VPPI
-	if (!nrvppis)
+	if (!nrppis)
 		goto out;
-	gic->vppi_base = irq_alloc_descs(-1, 0, nrvppis, 0);
-	if (WARN_ON(gic->vppi_base < 0))
-		goto out;
-	for (i = gic->vppi_base; i < (gic->vppi_base + nrvppis); i++) {
-		irq_set_chip_and_handler(i, &gic_ppi_chip, handle_percpu_irq);
-		irq_set_chip_data(i, gic);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	for (c = 0; c < nrcpus; c++) {
+		struct irq_domain *dom = &per_cpu(gic_ppi_domains, c);
+		int base;
+
+		base = irq_alloc_descs(-1, 0, nrppis, 0);
+		if (WARN_ON(base < 0))
+			goto out;
+
+		/*
+		 * We cheat here, and fold ppi_base into irq_base, as
+		 * it saves us some work@runtime.
+		 */
+		dom->irq_base = base - ppi_base;
+		dom->ops = &gic_ppi_domain_ops;
+		dom->of_node = gic_get_ppi_node(gic_node, c);
+
+		pr_info("GIC PPI domain %s [%d:%d] for CPU %d\n",
+			get_of_name(dom->of_node), base, base + nrppis - 1, c);
+
+		irq_domain_add(dom);
+
+		for (i = 0; i < nrppis; i++) {
+			unsigned int irq = irq_domain_map(dom, i + irq_start);
+
+			pr_debug("GIC mapping %s:%d to IRQ%d\n",
+				 get_of_name(dom->of_node), i, irq);
+
+			irq_set_chip_and_handler(irq, &gic_ppi_chip,
+						 handle_percpu_irq);
+			irq_set_chip_data(irq, gic);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
 	}
 out:
 #endif
@@ -479,8 +608,9 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 	writel_relaxed(1, base + GIC_CPU_CTRL);
 }
 
-void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
-	void __iomem *dist_base, void __iomem *cpu_base)
+static void __init gic_init_one(unsigned int gic_nr, unsigned int irq_start,
+				void __iomem *dist_base, void __iomem *cpu_base,
+				struct device_node *gic_node)
 {
 	struct gic_chip_data *gic;
 
@@ -494,10 +624,80 @@ void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	if (gic_nr == 0)
 		gic_cpu_base_addr = cpu_base;
 
-	gic_dist_init(gic, irq_start);
+	gic_dist_init(gic, irq_start, gic_node);
 	gic_cpu_init(gic);
 }
 
+void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
+		     void __iomem *dist_base, void __iomem *cpu_base)
+{
+	gic_init_one(gic_nr, irq_start, dist_base, cpu_base, NULL);
+}
+
+#ifdef CONFIG_OF
+static void __init gic_of_init_one(int idx, unsigned int irq_start,
+				   struct device_node *np)
+{
+	void __iomem *dist_base;
+	void __iomem *cpu_base;
+
+	dist_base = of_iomap(np, 0);
+	cpu_base  = of_iomap(np, 1);
+	if (!dist_base || ! cpu_base) {
+		pr_err("Cannot map %s\n", np->full_name);
+		return;
+	}
+
+	/* Assume we use the full 16 PPIs */
+	gic_init_one(idx, irq_start, dist_base, cpu_base, np);
+}
+
+void __init gic_of_init(void)
+{
+	struct device_node *np = NULL;
+	unsigned int irq_start = 0;
+	int i = 0;
+
+	/* Look for the GIC providing PPIs first */
+	while((np = gic_get_node(np))) {
+		struct device_node *ppi_np;
+		ppi_np = gic_get_ppi_node(np, 0);
+		of_node_put(ppi_np);
+		if (!ppi_np)
+			continue;
+			
+		/* Assume we use the full 16 PPIs */
+		gic_of_init_one(i, 16, np);
+		irq_start += gic_data[i].nr_irqs;
+		i++;
+		break;
+	}
+	of_node_put(np);
+	np = NULL;
+
+	/* Now all the others */
+	while((np = gic_get_node(np))) {
+		struct device_node *ppi_np;
+		int irq;
+		ppi_np = gic_get_ppi_node(np, 0);
+		of_node_put(ppi_np);
+		if (ppi_np)
+			continue;
+			
+		gic_of_init_one(i, irq_start, np);
+		irq = irq_of_parse_and_map(np, 0);
+		if (irq != IRQ_NONE) {
+			pr_info("GIC %s cascading to IRQ%d",
+				np->full_name, irq);
+			gic_cascade_irq(i, irq);
+		}
+		irq_start += gic_data[i].nr_irqs;
+		i++;
+	}
+	of_node_put(np);
+}
+#endif
+
 void __cpuinit gic_secondary_init(unsigned int gic_nr)
 {
 	BUG_ON(gic_nr >= MAX_GIC_NR);
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 069d4c0..04cfe33 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -39,16 +39,20 @@ extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
+void gic_of_init(void);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 #ifdef CONFIG_ARM_GIC_VPPI
 unsigned int gic_ppi_to_vppi(unsigned int irq);
+unsigned int gic_ppi_to_cpu_vppi(unsigned int irq, int cpu);
 #else
 static inline unsigned int gic_ppi_to_vppi(unsigned int irq)
 {
 	return irq;
 }
+
+#define gic_ppi_to_cpu_vppi(i,c) gic_ppi_to_vppi(i)
 #endif
 
 #endif
-- 
1.7.0.4
