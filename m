From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 05/11] arm-dt: Add CONFIG_ARM_DEVTREE
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.247114.799279819521.5.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some basic empty infrastructure for DT support on ARM.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/Kconfig            |   13 +++++++++++++
 arch/arm/include/asm/prom.h |   28 ++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c     |   28 ++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..2e53d33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1225,6 +1225,19 @@ endmenu
 
 menu "Boot options"
 
+config OF
+	bool
+	default n
+
+config ARM_DEVTREE
+	bool "Device tree support"
+	default y
+	depends on !DEBUG_LL
+	select OF
+	select OF_FLATTREE
+	help
+	  Support for OpenFirmware-style device trees
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
new file mode 100644
index 0000000..5260d22
--- /dev/null
+++ b/arch/arm/include/asm/prom.h
@@ -0,0 +1,28 @@
+/*
+ *  arch/arm/include/asm/prom.h
+ *
+ *  Copyright (C) 2009 Canonical Ltd. <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ASMARM_PROM_H
+#define __ASMARM_PROM_H
+
+#include <asm/setup.h>
+
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
+#define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+
+/* _ALIGN expects upwards alignment */
+#define _ALIGN(addr, size)		(((addr)+((size)-1))&(~((size)-1)))
+
+extern struct device_node *of_chosen;
+
+#endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84fd876..e662d17 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -47,6 +47,11 @@
 #include "atags.h"
 #include "tcm.h"
 
+#ifdef CONFIG_ARM_DEVTREE
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#endif
+
 #ifndef MEM_SIZE
 #define MEM_SIZE	(16*1024*1024)
 #endif
@@ -659,6 +664,29 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
+/* arch-specific device tree handling */
+#ifdef CONFIG_ARM_DEVTREE
+void early_init_dt_scan_chosen_arch(unsigned long node) { }
+
+void early_init_dt_setup_initrd_arch(unsigned long start, unsigned long_end) { }
+
+void early_init_devtree_arch(void) { }
+
+int early_init_dt_scan_memory(unsigned long node, const char *uname,
+			      int depth, void *data)
+{
+	return 0;
+}
+
+int early_init_dt_scan_cpus(unsigned long node, const char *uname,
+			    int depth, void *data)
+{
+	return 0;
+}
+
+struct device_node *of_chosen;
+#endif /* CONFIG_ARM_DEVTREE */
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
