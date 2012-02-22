From: hs@denx.de (Heiko Schocher)
Date: Wed, 22 Feb 2012 07:50:04 +0100
Subject: [PATCH v2 1/7] ARM: davinci,
 intc: Add OF support for TI interrupt controller
In-Reply-To: <1329893410-24413-1-git-send-email-hs@denx.de>
References: <1329893410-24413-1-git-send-email-hs@denx.de>
Message-ID: <1329893410-24413-2-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to initialize the davinci interrupt controller (INTC)
using a device tree node.

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>

---
- changes for v2:
- add comment from Grant Likely:
  - migrate the whole interrupt controller to natively use an
    irq_domain. Rebased complete patchserie to:
    http://git.secretlab.ca/?p=linux-2.6.git;a=shortlog;h=refs/heads/irqdomain/next

    commit 2462bacd0334d918f9fcd79fc59c403b76b36f8a
    Author: Grant Likely <grant.likely@secretlab.ca>
    Date:   Thu Jan 26 14:10:13 2012 -0700

    irq_domain/microblaze: Convert microblaze to use irq_domains

 .../devicetree/bindings/arm/davinci/intc.txt       |   26 ++++
 arch/arm/mach-davinci/cp_intc.c                    |  133 ++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/cp_intc.h       |    1 +
 3 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/intc.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/intc.txt b/Documentation/devicetree/bindings/arm/davinci/intc.txt
new file mode 100644
index 0000000..dac2f69
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/intc.txt
@@ -0,0 +1,26 @@
+* TI Davinci Interrupt Controller
+
+davinci are using a TI interrupt controller that can support several
+configurable number of interrupts.
+
+Main node required properties:
+
+- compatible : should be:
+	"ti,davinci-intc"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The type shall be a <u32> and the value shall be 1.
+
+  The cell contains the interrupt number in the range [0-128].
+- ti,intc-size: Number of interrupts handled by the interrupt controller.
+- reg: physical base address and size of the intc registers map.
+
+Example:
+
+	intc: interrupt-controller at 1 {
+		compatible = "ti,davinci-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		ti,intc-size = <101>;
+		reg = <0xfffee000 0x2000>;
+	};
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f83152d..6f11daf 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -9,9 +9,14 @@
  * kind, whether express or implied.
  */
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <mach/common.h>
 #include <mach/cp_intc.h>
@@ -175,3 +180,131 @@ void __init cp_intc_init(void)
 	/* Enable global interrupt */
 	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
 }
+
+#ifdef CONFIG_OF
+static struct irq_domain *cp_intc_domain;
+
+static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	pr_debug("cp_intc_host_map(%d, 0x%lx)\n", virq, hw);
+
+	irq_set_chip(virq, &cp_intc_irq_chip);
+	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+	irq_set_handler(virq, handle_edge_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops cp_intc_host_ops = {
+	.map = cp_intc_host_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+int __init cp_intc_domain_init(struct device_node *node,
+		struct device_node *parent)
+{
+	u32 num_irq;
+	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
+	u32 *host_map		= davinci_soc_info.intc_host_map;
+	unsigned num_reg;
+	int i, irq_base;
+
+	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
+	davinci_intc_base = of_iomap(node, 0);
+	if (WARN_ON(!davinci_intc_base))
+		return -EINVAL;
+
+	if (of_property_read_u32(node, "ti,intc-size", &num_irq)) {
+		WARN(1, "unable to get intc-size\n");
+		return -EINVAL;
+	}
+	num_reg	= BITS_TO_LONGS(num_irq);
+
+	cp_intc_write(0, CP_INTC_GLOBAL_ENABLE);
+
+	/* Disable all host interrupts */
+	cp_intc_write(0, CP_INTC_HOST_ENABLE(0));
+
+	/* Disable system interrupts */
+	for (i = 0; i < num_reg; i++)
+		cp_intc_write(~0, CP_INTC_SYS_ENABLE_CLR(i));
+
+	/* Set to normal mode, no nesting, no priority hold */
+	cp_intc_write(0, CP_INTC_CTRL);
+	cp_intc_write(0, CP_INTC_HOST_CTRL);
+
+	/* Clear system interrupt status */
+	for (i = 0; i < num_reg; i++)
+		cp_intc_write(~0, CP_INTC_SYS_STAT_CLR(i));
+
+	/* Enable nIRQ (what about nFIQ?) */
+	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_SET);
+
+	/*
+	 * Priority is determined by host channel: lower channel number has
+	 * higher priority i.e. channel 0 has highest priority and channel 31
+	 * had the lowest priority.
+	 */
+	num_reg = (num_irq + 3) >> 2;	/* 4 channels per register */
+	if (irq_prio) {
+		unsigned j, k;
+		u32 val;
+
+		for (k = i = 0; i < num_reg; i++) {
+			for (val = j = 0; j < 4; j++, k++) {
+				val >>= 8;
+				if (k < num_irq)
+					val |= irq_prio[k] << 24;
+			}
+
+			cp_intc_write(val, CP_INTC_CHAN_MAP(i));
+		}
+	} else	{
+		/*
+		 * Default everything to channel 15 if priority not specified.
+		 * Note that channel 0-1 are mapped to nFIQ and channels 2-31
+		 * are mapped to nIRQ.
+		 */
+		for (i = 0; i < num_reg; i++)
+			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
+	}
+
+	if (host_map)
+		for (i = 0; host_map[i] != -1; i++)
+			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
+
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (irq_base < 0) {
+		pr_warn("Couldn't allocate IRQ numbers\n");
+		irq_base = 0;
+	}
+
+	/* create a legacy host */
+	cp_intc_domain = irq_domain_add_legacy(node, num_irq, irq_base, 0,
+				&cp_intc_host_ops, NULL);
+	if (cp_intc_domain == NULL) {
+		printk(KERN_ERR "CP INTC: failed to allocate irq host!\n");
+		return -EINVAL;
+	}
+
+	/* Enable global interrupt */
+	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
+
+	return 0;
+}
+
+static struct of_device_id irq_match[] __initdata = {
+	{ .compatible = "ti,davinci-intc", .data = cp_intc_domain_init, },
+	{ }
+};
+
+void __init davinci_init_irq(void)
+{
+	of_irq_init(irq_match);
+}
+#else
+void __init davinci_init_irq(void)
+{
+	cp_intc_init();
+}
+#endif
diff --git a/arch/arm/mach-davinci/include/mach/cp_intc.h b/arch/arm/mach-davinci/include/mach/cp_intc.h
index 4e8190e..d674b95 100644
--- a/arch/arm/mach-davinci/include/mach/cp_intc.h
+++ b/arch/arm/mach-davinci/include/mach/cp_intc.h
@@ -52,5 +52,6 @@
 #define CP_INTC_VECTOR_ADDR(n)		(0x2000 + (n << 2))
 
 void __init cp_intc_init(void);
+void __init davinci_init_irq(void);
 
 #endif	/* __ASM_HARDWARE_CP_INTC_H */
-- 
1.7.7.6
