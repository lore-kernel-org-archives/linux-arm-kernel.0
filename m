From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 8 Jul 2016 09:44:31 +0200
Subject: [PATCH v3] xen/arm: enable clocks used by the hypervisor
Message-ID: <1467963871-31556-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xen hypervisor drivers might replace native OS drivers. The result is
that some important clocks that are enabled by the OS in the non-Xen
case are not properly enabled in the presence of Xen. The clocks
property enumerates the clocks that must be enabled by the Xen clock
consumer.

An example is a serial driver enabled by the hypervisor. Xen must
consume and enable these clocks in the OS to ensure behavior continues
after firmware configures the UART hardware and corresponding clock
harder.

Up to now, the workaround for this has been to use the Linux kernel
command line parameter 'clk_ignore_unused'. See Xen bug

http://bugs.xenproject.org/xen/bug/45

too.

To fix this, we will add the "unused" clocks in Xen to the hypervisor
node. The OS has to consume and enable the clocks from the hypervisor
node, then.

Therefore, check if there is a "clocks" entry in the hypervisor node
and if so consume and enable the given clocks. This prevents the clocks
from being disabled by the OS.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v3: Use the xen.txt description proposed by Michael. Thanks!

Changes in v2: Drop the Linux implementation details like clk_disable_unused
	       in xen.txt.

 Documentation/devicetree/bindings/arm/xen.txt | 13 ++++++++
 arch/arm/xen/enlighten.c                      | 47 +++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
index c9b9321..00f2165 100644
--- a/Documentation/devicetree/bindings/arm/xen.txt
+++ b/Documentation/devicetree/bindings/arm/xen.txt
@@ -17,6 +17,19 @@ the following properties:
   A GIC node is also required.
   This property is unnecessary when booting Dom0 using ACPI.
 
+Optional properties:
+
+clocks: one or more clocks to be enabled
+  Xen hypervisor drivers might replace native OS drivers. The result is
+  that some important clocks that are enabled by the OS in the non-Xen
+  case are not properly enabled in the presence of Xen. The clocks
+  property enumerates the clocks that must be enabled by the Xen clock
+  consumer.
+  An example is a serial driver enabled by the hypervisor. Xen must
+  consume and enable these clocks in the OS to ensure behavior continues
+  after firmware configures the UART hardware and corresponding clock
+  harder.
+
 To support UEFI on Xen ARM virtual platforms, Xen populates the FDT "uefi" node
 under /hypervisor with following parameters:
 
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 47acb36..5c546d0 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -24,6 +24,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/clk-provider.h>
 #include <linux/cpuidle.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
@@ -444,6 +445,52 @@ static int __init xen_pm_init(void)
 }
 late_initcall(xen_pm_init);
 
+/*
+ * Check if we want to register some clocks, that they
+ * are not freed because unused by clk_disable_unused().
+ * E.g. the serial console clock.
+ */
+static int __init xen_arm_register_clks(void)
+{
+	struct clk *clk;
+	struct device_node *xen_node;
+	unsigned int i, count;
+	int ret = 0;
+
+	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
+	if (!xen_node) {
+		pr_err("Xen support was detected before, but it has disappeared\n");
+		return -EINVAL;
+	}
+
+	count = of_clk_get_parent_count(xen_node);
+	if (!count)
+		goto out;
+
+	for (i = 0; i < count; i++) {
+		clk = of_clk_get(xen_node, i);
+		if (IS_ERR(clk)) {
+			pr_err("Xen failed to register clock %i. Error: %li\n",
+			       i, PTR_ERR(clk));
+			ret = PTR_ERR(clk);
+			goto out;
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret < 0) {
+			pr_err("Xen failed to enable clock %i. Error: %i\n",
+			       i, ret);
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	of_node_put(xen_node);
+	return ret;
+}
+late_initcall(xen_arm_register_clks);
 
 /* empty stubs */
 void xen_arch_pre_suspend(void) { }
-- 
2.8.0
