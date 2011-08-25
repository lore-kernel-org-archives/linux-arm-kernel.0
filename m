From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Aug 2011 16:49:00 -0500
Subject: [PATCH v2] ARM: gic: add OF based initialization
In-Reply-To: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
References: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
Message-ID: <1314308940-8847-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds gic initialization using device tree data. The initialization
functions are intended to be called by a generic OF interrupt
controller parsing function once the right pieces are in place.

PPI binding support based on work by Marc Zyngier.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Changes in v2:
- Add bindings and documentation for PPI
- change interrupt-cells to 2
- Move init of np pointer to after intc_desc ptr NULL check

 Documentation/devicetree/bindings/arm/gic.txt |   62 +++++++++++++++++++++++++
 arch/arm/common/gic.c                         |   41 ++++++++++++++++
 arch/arm/include/asm/hardware/gic.h           |    3 +
 3 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
new file mode 100644
index 0000000..85be7c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -0,0 +1,62 @@
+* ARM Generic Interrupt Controller
+
+ARM SMP cores are often associated with a GIC, providing per processor
+interrupts (PPI), shared processor interrupts (SPI) and software
+generated interrupts (SGI).
+
+Primary GIC is attached directly to the CPU and typically has PPIs. Secondary GICs are
+cascaded into the upward interrupt controller and do not have PPIs.
+
+Main node required properties:
+
+- compatible : should be one of:
+	"arm,cortex-a9-gic"
+	"arm,arm11mp-gic"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source.  The type shall be a <u32> and the value shall be 2.
+- reg : Specifies base physical address(s) and size of the GIC registers. The
+  first 2 values are the GIC distributor register base and size. The 2nd 2
+  values are the GIC cpu interface register base and size.
+- #size-cells : Shall be <0> as PPIs don't have size for reg property. Optional
+  for secondary GICs.
+
+Optional
+- interrupts	: optional, used on secondary GICs only
+
+PPI sub-nodes required properties:
+
+- compatible : should match the main node with "-ppi" appended. one of:
+	"arm,cortex-a9-gic-ppi"
+	"arm,arm11mp-gic-ppi"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source.  The type shall be a <u32> and the value shall be 1 as PPIs
+  don't have edge/level settings.
+- reg : Specifies cpu number the PPIs are attached to.
+
+Example:
+
+	intc: interrupt-controller at fff11000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <2>;
+		#size-cells = <0>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0xfff11000 0x1000>,
+		      <0xfff10100 0x100>;
+		      
+		gicppi0: gic-ppi at 0 {
+			compatible = "arm,cortex-a9-gic-ppi";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <0>;
+		};
+		gicppi1: gic-ppi at 1 {
+			compatible = "arm,cortex-a9-gic-ppi";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <1>;
+		};
+	};
+
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index f13298e..a796299 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -28,6 +28,10 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
@@ -394,3 +398,40 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
 }
 #endif
+
+#ifdef CONFIG_OF
+static int gic_cnt __initdata = 0;
+
+void __init gic_of_init(struct of_intc_desc *d)
+{
+	struct device_node *np;
+	void __iomem *cpu_base;
+	void __iomem *dist_base;
+	int irq;
+
+	if (WARN_ON(!d || !d->controller))
+		return;
+
+	np = d->controller;
+	dist_base = of_iomap(np, 0);
+	WARN(!dist_base, "unable to map gic dist registers\n");
+
+	cpu_base = of_iomap(np, 1);
+	WARN(!cpu_base, "unable to map gic cpu registers\n");
+
+	gic_init(gic_cnt, d->irq_base, dist_base, cpu_base);
+	irq_domain_add_simple(d->controller, d->irq_base);
+
+	if (d->parent) {
+		irq = irq_of_parse_and_map(np, 0);
+		gic_cascade_irq(gic_cnt, irq);
+	}
+	gic_cnt++;
+}
+
+void __init gic_of_ppi_init(struct of_intc_desc *d)
+{
+	irq_domain_add_simple(d->controller, d->irq_base);
+}
+
+#endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 435d3f8..a6594d4 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -37,6 +37,9 @@ extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
+struct of_intc_desc;
+void gic_of_init(struct of_intc_desc *d);
+void gic_of_ppi_init(struct of_intc_desc *d);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-- 
1.7.4.1
