From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 08 Jan 2010 10:44:12 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
Message-ID: <1262907852.736281.78480196040.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have 21 definitions of struct clk in the ARM architecture,
each defined on a per-platform basis.

This change is an effort to unify struct clk where possible, by defining
a common struct clk, containing a set of function pointers. Different
clock implementations can set their own callbacks, and have a standard
interface for generic code. The callback interface is exposed to the
kernel proper, while the clock implementations only need to be seen by
the platform internals.

This allows us to share clock code among platforms, and makes it
possible to dynamically create clock devices in platform-independent
code.

Platforms can enable the generic struct clock through
CONFIG_HAVE_COMMON_STRUCT_CLK.

The common clock definitions are based on a development patch from Ben
Herrenschmidt <benh@kernel.crashing.org>.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/Kconfig              |    4 +
 arch/arm/common/Makefile      |    1 
 arch/arm/common/clk.c         |   78 ++++++++++++++++++++++++++++++++++
 arch/arm/common/clkdev.c      |    2 
 arch/arm/include/asm/clk.h    |   37 ++++++++++++++++
 arch/arm/include/asm/clkdev.h |    2 
 6 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..b6eaf10 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -46,6 +46,10 @@ config GENERIC_CLOCKEVENTS_BROADCAST
 	depends on GENERIC_CLOCKEVENTS
 	default y if SMP && !LOCAL_TIMERS
 
+config HAVE_COMMON_STRUCT_CLK
+	bool
+	default n
+
 config HAVE_TCM
 	bool
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 76be7ff..6073dbe 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
+obj-$(CONFIG_HAVE_COMMON_STRUCT_CLK) += clk.o
diff --git a/arch/arm/common/clk.c b/arch/arm/common/clk.c
new file mode 100644
index 0000000..0357d02
--- /dev/null
+++ b/arch/arm/common/clk.c
@@ -0,0 +1,78 @@
+/*
+ *  arch/arm/common/clk.c
+ *
+ *  Copyright (C) 2010 Canonical Ltd <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <asm/clk.h>
+
+int clk_enable(struct clk *clk)
+{
+	if (clk->enable)
+		return clk->enable(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+ 
+void clk_disable(struct clk *clk)
+{
+	if (clk->disable)
+		clk->disable(clk);
+}
+EXPORT_SYMBOL(clk_disable);
+ 
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (clk->get_rate)
+		return clk->get_rate(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_get_rate);
+ 
+void clk_put(struct clk *clk)
+{
+	if (clk->put)
+		clk->put(clk);
+}
+EXPORT_SYMBOL(clk_put);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk->round_rate)
+		return clk->round_rate(clk, rate);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_round_rate);
+ 
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk->set_rate)
+		return clk->set_rate(clk, rate);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_rate);
+ 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	if (clk->set_parent)
+		return clk->set_parent(clk, parent);
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (clk->get_parent)
+		return clk->get_parent(clk);
+	return ERR_PTR(-ENOSYS);
+}
+EXPORT_SYMBOL(clk_get_parent);
diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index aae5bc0..bd3866b 100644
--- a/arch/arm/common/clkdev.c
+++ b/arch/arm/common/clkdev.c
@@ -85,11 +85,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get);
 
+#ifndef CONFIG_HAVE_COMMON_STRUCT_CLK
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
 }
 EXPORT_SYMBOL(clk_put);
+#endif /* CONFIG_HAVE_COMMON_STRUCT_CLK */
 
 void clkdev_add(struct clk_lookup *cl)
 {
diff --git a/arch/arm/include/asm/clk.h b/arch/arm/include/asm/clk.h
new file mode 100644
index 0000000..87fcfae
--- /dev/null
+++ b/arch/arm/include/asm/clk.h
@@ -0,0 +1,37 @@
+/*
+ *  arch/arm/include/asm/clk.h
+ *
+ *  Copyright (C) 2010 Canonical Ltd <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Generic definitions for struct clk
+ */
+#ifndef __ASM_CLK_H
+#define __ASM_CLK_H
+
+#ifdef CONFIG_HAVE_COMMON_STRUCT_CLK
+
+/* The definition of struct clk is global, clock providers should
+ * generate "subclasses" embedding struct clk.
+ */
+struct clk {
+       int             (*enable)(struct clk *);
+       void            (*disable)(struct clk *);
+       unsigned long   (*get_rate)(struct clk *);
+       void            (*put)(struct clk *);
+       long            (*round_rate)(struct clk *, unsigned long);
+       int             (*set_rate)(struct clk *, unsigned long);
+       int             (*set_parent)(struct clk *, struct clk *);
+       struct clk*     (*get_parent)(struct clk *);
+};
+
+#else /* CONFIG_HAVE_COMMON_STRUCT_CLK */
+
+struct clk;
+
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index b6ec7c6..e994a74 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -12,7 +12,7 @@
 #ifndef __ASM_CLKDEV_H
 #define __ASM_CLKDEV_H
 
-struct clk;
+#include <asm/clk.h>
 
 struct clk_lookup {
 	struct list_head	node;
