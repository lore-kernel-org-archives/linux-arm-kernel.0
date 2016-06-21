From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 21 Jun 2016 12:16:05 +0200
Subject: [PATCH] xen/arm: register clocks used by the hypervisor
Message-ID: <1466504165-9214-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks might be used by the Xen hypervisor and not by the Linux
kernel. If these are not registered by the Linux kernel, they might be
disabled by clk_disable_unused() as the kernel doesn't know that they
are used. The clock of the serial console handled by Xen is one
example for this. It might be disabled by clk_disable_unused() which
stops the whole serial output, even from Xen, then.

Up to now, the workaround for this has been to use the Linux kernel
command line parameter 'clk_ignore_unused'. See Xen bug

http://bugs.xenproject.org/xen/bug/45

too.

To fix this, we will add the "unused" clocks in Xen to the hypervisor
node. The Linux kernel has to register the clocks from the hypervisor
node, then.

Therefore, check if there is a "clocks" entry in the hypervisor node
and if so register the given clocks to the Linux kernel clock
framework and with this mark them as used. This prevents the clocks
from being disabled.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm/xen/enlighten.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 75cd734..ee6e81f 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/clk-provider.h>
 #include <linux/cpuidle.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
@@ -381,6 +382,40 @@ static int __init xen_pm_init(void)
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
+	unsigned int i, count;
+	int ret;
+
+	count = of_clk_get_parent_count(xen_node);
+	if (!count)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+		clk = of_clk_get(xen_node, i);
+		if (IS_ERR(clk)) {
+			pr_err("Xen failed to register clock %i. Error: %li\n",
+			       i, PTR_ERR(clk));
+			return PTR_ERR(clk);
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret < 0) {
+			pr_err("Xen failed to enable clock %i. Error: %i\n",
+			       i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+late_initcall(xen_arm_register_clks);
 
 /* empty stubs */
 void xen_arch_pre_suspend(void) { }
-- 
2.8.0
