From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 07/11] arm-dt: parse devtree pointer on boot
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.247761.990648813393.7.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to parse the device tree pointer from the atags, and an (empty)
routine to create an mdesc from the discovered device tree.

Split the parsing code in setup_arch to handle both device-tree and tags
based machine discovery.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/devtree.h |   22 +++++++++
 arch/arm/kernel/Makefile       |    1 
 arch/arm/kernel/devtree.c      |   14 +++++
 arch/arm/kernel/setup.c        |   80 +++++++++++++++++++++------------
 4 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/devtree.h b/arch/arm/include/asm/devtree.h
new file mode 100644
index 0000000..0914ac2
--- /dev/null
+++ b/arch/arm/include/asm/devtree.h
@@ -0,0 +1,22 @@
+/*
+ *  linux/arch/arm/include/asm/devtree.h
+ *
+ *  Copyright (C) 2009 Canonical Ltd. <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_ARM_DEVTREE
+
+extern struct machine_desc *parse_devicetree(void *devtree);
+
+#else
+
+static inline struct machine_desc *parse_devicetree(void *devtree)
+{
+	return NULL;
+}
+
+#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 79087dd..45d2d82 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_ARM_DEVTREE)	+= devtree.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
new file mode 100644
index 0000000..864eab5
--- /dev/null
+++ b/arch/arm/kernel/devtree.c
@@ -0,0 +1,14 @@
+/*
+ *  linux/arch/arm/kernel/devtree.c
+ *
+ *  Copyright (C) 2009 Canonical Ltd. <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+struct machine_desc * __init parse_devicetree(void *devtree)
+{
+	return NULL;
+}
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e662d17..8abb4be 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <asm/mach/time.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
+#include <asm/devtree.h>
 
 #include "compat.h"
 #include "atags.h"
@@ -636,6 +637,17 @@ static void __init parse_tags(const struct tag *t)
 				t->hdr.tag);
 }
 
+static void * __init find_devtree(const struct tag *tags)
+{
+	const struct tag *t;
+
+	for_each_tag(t, tags)
+		if (t->hdr.tag == ATAG_DEVTREE)
+			return __va(t->u.devtree.devtree);
+
+	return NULL;
+}
+
 /*
  * This holds our defaults.
  */
@@ -692,48 +704,62 @@ void __init setup_arch(char **cmdline_p)
 	struct tag *tags = (struct tag *)&init_tags;
 	struct machine_desc *mdesc;
 	char *from = default_command_line;
+	void *devtree;
 
 	unwind_init();
 
 	setup_processor();
-	mdesc = setup_machine(machine_arch_type);
-	machine_name = mdesc->name;
-
-	if (mdesc->soft_reboot)
-		reboot_setup("s");
 
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
-	else if (mdesc->boot_params)
-		tags = phys_to_virt(mdesc->boot_params);
 
-	/*
-	 * If we have the old style parameters, convert them to
-	 * a tag list.
-	 */
-	if (tags->hdr.tag != ATAG_CORE)
-		convert_to_tag_list(tags);
-	if (tags->hdr.tag != ATAG_CORE)
-		tags = (struct tag *)&init_tags;
-
-	if (mdesc->fixup)
-		mdesc->fixup(mdesc, tags, &from, &meminfo);
-
-	if (tags->hdr.tag == ATAG_CORE) {
-		if (meminfo.nr_banks != 0)
-			squash_mem_tags(tags);
-		save_atags(tags);
-		parse_tags(tags);
+	devtree = find_devtree(tags);
+	if (devtree) {
+		mdesc = parse_devicetree(devtree);
+
+		/*
+		 * todo: fallback to arch-number-based mdesc discovery
+		 * if device tree doesn't match
+		 */
+	} else {
+		mdesc = setup_machine(machine_arch_type);
+
+		if (!__atags_pointer && mdesc->boot_params)
+			tags = phys_to_virt(mdesc->boot_params);
+
+		/*
+		 * If we have the old style parameters, convert them to
+		 * a tag list.
+		 */
+		if (tags->hdr.tag != ATAG_CORE)
+			convert_to_tag_list(tags);
+		if (tags->hdr.tag != ATAG_CORE)
+			tags = (struct tag *)&init_tags;
+
+		if (mdesc->fixup)
+			mdesc->fixup(mdesc, tags, &from, &meminfo);
+
+		if (tags->hdr.tag == ATAG_CORE) {
+			if (meminfo.nr_banks != 0)
+				squash_mem_tags(tags);
+			save_atags(tags);
+			parse_tags(tags);
+		}
+
+		/* Copy discovered command line to boot_command_line */
+		strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+
 	}
 
+	machine_name = mdesc->name;
+	if (mdesc->soft_reboot)
+		reboot_setup("s");
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
 	init_mm.brk	   = (unsigned long) _end;
 
-	/* parse_early_param needs a boot_command_line */
-	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
-
 	/* populate cmd_line too for later use, preserving boot_command_line */
 	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
