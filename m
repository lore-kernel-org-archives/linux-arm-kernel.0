From: hs@denx.de (Heiko Schocher)
Date: Tue, 22 May 2012 15:55:15 +0200
Subject: [PATCH v4 2/7] ARM: davinci,
 intc: Add OF support for TI interrupt controller
In-Reply-To: <1337694920-8925-1-git-send-email-hs@denx.de>
References: <1337694920-8925-1-git-send-email-hs@denx.de>
Message-ID: <1337694920-8925-3-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to initialize the Common Platform Interrupt Controller
(cp_intc) from TI used on OMAP-L1x SoCs using a device tree node.

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>

---
- changes for v4
  - split patch in 2 patches, one for irq_domain adaption
    one for DT enhancement, as Nori Sekhar suggested.
  - add comment from Grant Likely for the DT part:
    remove if/else clause, not needed.
    Make use of DT runtime configurable

 .../devicetree/bindings/arm/davinci/intc.txt       |   27 ++++++++++++++++++++
 arch/arm/mach-davinci/cp_intc.c                    |   26 ++++++++++++++++---
 2 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/intc.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/intc.txt b/Documentation/devicetree/bindings/arm/davinci/intc.txt
new file mode 100644
index 0000000..dfd6a560
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/intc.txt
@@ -0,0 +1,27 @@
+* TI Common Platform Interrupt Controller
+
+Common Platform Interrupt Controller (cp_intc) is used on
+OMAP-L1x SoCs and can support several configurable number
+of interrupts.
+
+Main node required properties:
+
+- compatible : should be:
+	"ti,cp_intc"
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
+		compatible = "ti,cp_intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		ti,intc-size = <101>;
+		reg = <0xfffee000 0x2000>;
+	};
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index bb52807..f9ad14e 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -14,6 +14,9 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <mach/common.h>
 #include <mach/cp_intc.h>
@@ -119,7 +122,7 @@ static const struct irq_domain_ops cp_intc_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-int __init __cp_intc_init(struct device_node *node)
+int __init __cp_intc_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
@@ -128,8 +131,15 @@ int __init __cp_intc_init(struct device_node *node)
 	int i, irq_base;
 
 	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
-	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
-
+	if (node) {
+		davinci_intc_base = of_iomap(node, 0);
+		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
+			pr_warn("unable to get intc-size, default to %d\n",
+				num_irq);
+	} else {
+		davinci_intc_base = ioremap(davinci_soc_info.intc_base,
+					SZ_8K);
+	}
 	if (WARN_ON(!davinci_intc_base))
 		return -EINVAL;
 
@@ -207,7 +217,15 @@ int __init __cp_intc_init(struct device_node *node)
 	return 0;
 }
 
+static struct of_device_id irq_match[] __initdata = {
+	{ .compatible = "ti,cp_intc", .data = __cp_intc_init, },
+	{ }
+};
+
 void __init cp_intc_init(void)
 {
-	__cp_intc_init(NULL);
+	if (!of_find_compatible_node(NULL, NULL, "ti,cp_intc"))
+		__cp_intc_init(NULL, NULL);
+	else
+		of_irq_init(irq_match);
 }
-- 
1.7.7.6
