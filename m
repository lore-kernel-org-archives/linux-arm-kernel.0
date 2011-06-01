From: robherring2@gmail.com (Rob Herring)
Date: Wed,  1 Jun 2011 11:37:49 -0500
Subject: [PATCH 2/3] ARM: gic: add OF based initialization
In-Reply-To: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
References: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
Message-ID: <1306946270-18379-3-git-send-email-robherring2@gmail.com>
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
        irq-start = <29>;
};

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/common/gic.c               |   35 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    1 +
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4ddd0a6..d44ca5b 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -28,6 +28,8 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
@@ -401,3 +403,36 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
 }
 #endif
+
+#ifdef CONFIG_OF
+static struct of_device_id gic_ids[] __initdata = {
+	{ .compatible = "arm,cortex-a9-gic" },
+};
+
+void __init gic_of_init(void)
+{
+	struct device_node *np;
+	void __iomem *cpu_base;
+	void __iomem *dist_base;
+	__u32 irq_start = 16;
+	const __be32 *val;
+
+	np = of_find_matching_node(NULL, gic_ids);
+	if (!np)
+		panic("unable to find compatible gic node in dtb\n");
+
+	dist_base = of_iomap(np, 0);
+	if (!dist_base)
+		panic("unable to map gic dist registers\n");
+
+	cpu_base = of_iomap(np, 1);
+	if (!cpu_base)
+		panic("unable to map gic cpu registers\n");
+
+	if ((val = of_get_property(np, "irq-start", NULL)) != NULL)
+		irq_start = of_read_ulong(val, 1);
+	of_node_put(np);
+
+	gic_init(0, irq_start, dist_base, cpu_base);
+}
+#endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 0691f9d..954a08e 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -37,6 +37,7 @@ extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
+void gic_of_init(void);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-- 
1.7.4.1
