From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 08/11] arm-dt: parse memory info from DT
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.248065.310822124208.8.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the early_init_dt hooks into a new file, and populate the
_alloc_memory and _add_memory functions.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/kernel/devtree.c |   42 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c   |   23 --------------------
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 864eab5..a8496f6 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -8,6 +8,48 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/bootmem.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+#include <asm/setup.h>
+#include <asm/page.h>
+
+struct device_node *of_chosen;
+
+void __init early_init_dt_scan_chosen_arch(unsigned long node) { }
+
+void __init early_init_dt_setup_initrd_arch(unsigned long start,
+					    unsigned long end) { }
+
+void __init early_init_devtree_arch(void) { }
+
+int __init early_init_dt_scan_memory_arch(unsigned long node,
+					    const char *uname,
+					    int depth, void *data)
+{
+	return -EINVAL;
+}
+
+void __init early_init_dt_add_memory(u64 base, u64 size)
+{
+	arm_add_memory(base, size);
+}
+
+u64 __init early_init_dt_alloc_memory(u64 size, u64 align)
+{
+	return __pa(__alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS)));
+}
+
+int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
+			    int depth, void *data)
+{
+	return 0;
+}
+
 struct machine_desc * __init parse_devicetree(void *devtree)
 {
 	return NULL;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8abb4be..88d4def 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -676,29 +676,6 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
-/* arch-specific device tree handling */
-#ifdef CONFIG_ARM_DEVTREE
-void early_init_dt_scan_chosen_arch(unsigned long node) { }
-
-void early_init_dt_setup_initrd_arch(unsigned long start, unsigned long_end) { }
-
-void early_init_devtree_arch(void) { }
-
-int early_init_dt_scan_memory(unsigned long node, const char *uname,
-			      int depth, void *data)
-{
-	return 0;
-}
-
-int early_init_dt_scan_cpus(unsigned long node, const char *uname,
-			    int depth, void *data)
-{
-	return 0;
-}
-
-struct device_node *of_chosen;
-#endif /* CONFIG_ARM_DEVTREE */
-
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
