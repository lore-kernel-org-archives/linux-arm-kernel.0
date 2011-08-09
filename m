From: robherring2@gmail.com (Rob Herring)
Date: Tue,  9 Aug 2011 15:17:00 -0500
Subject: [RFC PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
References: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
Message-ID: <1312921020-6820-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds gic initialization using device tree data. An example device tree
binding looks like this:

intc: interrupt-controller at fff11000 {
        compatible = "arm,cortex-a9-gic";
        #interrupt-cells = <1>;
        interrupt-controller;
        reg = <0xfff11000 0x1000>,
              <0xfff10100 0x100>;
};

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 Documentation/devicetree/bindings/arm/gic.txt |   28 ++++++++++++++++++++
 arch/arm/common/gic.c                         |   34 +++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h           |    2 +
 3 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
new file mode 100644
index 0000000..78012e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -0,0 +1,28 @@
+* ARM Generic Interrupt Controller
+
+Some ARM cores have an interrupt controller called GIC. The ARM GIC
+representation in the device tree should be done as under:-
+
+Required properties:
+
+- compatible : should be one of:
+	"arm,cortex-a9-gic"
+	"arm,arm11mp-gic"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source.  The type shall be a <u32> and the value shall be 1.
+- reg : Specifies base physical address(s) and size of the GIC registers. The
+  first 2 values are the GIC distributor register base and size. The 2nd 2
+  values are the GIC cpu interface register base and size.
+
+Example:
+
+intc: interrupt-controller at fff11000 {
+        compatible = "arm,cortex-a9-gic";
+        #interrupt-cells = <1>;
+        interrupt-controller;
+        reg = <0xfff11000 0x1000>,
+              <0xfff10100 0x100>;
+};
+
+
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index f13298e..0626bb7 100644
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
@@ -394,3 +398,33 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
 }
 #endif
+
+#ifdef CONFIG_OF
+static int gic_cnt __initdata = 0;
+
+void __init gic_of_init(struct of_intc_desc *d)
+{
+	struct device_node *np = d->controller;
+	void __iomem *cpu_base;
+	void __iomem *dist_base;
+	int irq;
+
+	if (WARN_ON(!d || !d->controller))
+		return;
+
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
+#endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 435d3f8..64ef90d 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -37,6 +37,8 @@ extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
+struct of_intc_desc;
+void gic_of_init(struct of_intc_desc *d);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-- 
1.7.4.1
