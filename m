From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 10/11] arm-dt: parse initrd from device tree
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.248651.573624023295.10.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move early_init_dt_setup_initrd_arch to arch/arm/mm/init.c, and populate
it to set the properties of the parsed initrd area.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/kernel/devtree.c |    3 ---
 arch/arm/mm/init.c        |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 2ff4bd0..9fd1f24 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -23,9 +23,6 @@ struct device_node *of_chosen;
 
 void __init early_init_dt_scan_chosen_arch(unsigned long node) { }
 
-void __init early_init_dt_setup_initrd_arch(unsigned long start,
-					    unsigned long end) { }
-
 void __init early_init_devtree_arch(void) { }
 
 int __init early_init_dt_scan_memory_arch(unsigned long node,
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4d3c90f..77f09d6 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -18,6 +18,11 @@
 #include <linux/sort.h>
 #include <linux/highmem.h>
 
+#ifdef CONFIG_ARM_DEVTREEE
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#endif /* CONFIG_ARM_DEVTREEE */
+
 #include <asm/mach-types.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -68,6 +73,16 @@ static int __init parse_tag_initrd2(const struct tag *tag)
 
 __tagtable(ATAG_INITRD2, parse_tag_initrd2);
 
+#if defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_ARM_DEVTREE)
+void __init early_init_dt_setup_initrd_arch(unsigned long start,
+					    unsigned long end)
+{
+	phys_initrd_start = start;
+	phys_initrd_size = end - start;
+}
+#endif /* CONFIG_BLK_DEV_INITRD && CONFIG_ARM_DEVTREE */
+
+
 /*
  * This keeps memory configuration data used by a couple memory
  * initialization functions, as well as show_mem() for the skipping
