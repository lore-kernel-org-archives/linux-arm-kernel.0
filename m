From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 04 Jun 2010 15:30:08 +0800
Subject: [RFC,PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1275636608.606606.450179637764.0.gpush@pororo>
Message-ID: <1275636608.607356.414998699566.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since most platforms will need a fixed-rate clock, add one. This will
also serve as a basic example of an implementation of struct clk.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 include/linux/clk.h |   13 +++++++++++++
 kernel/Makefile     |    1 +
 kernel/clk.c        |   25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index bb6957a..6269b44 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -123,6 +123,19 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 	return ERR_PTR(-ENOSYS);
 }
 
+/* Simple fixed-rate clock */
+struct clk_fixed {
+	struct clk	clk;
+	unsigned long	rate;
+};
+
+extern struct clk_ops clk_fixed_ops;
+
+#define INIT_CLK_FIXED(name, r) { \
+	.clk = INIT_CLK(name.clk, clk_fixed_ops), \
+	.rate = (r) \
+}
+
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /*
diff --git a/kernel/Makefile b/kernel/Makefile
index 057472f..1ae15aa 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_PERF_EVENTS) += perf_event.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
+obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
 
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --git a/kernel/clk.c b/kernel/clk.c
new file mode 100644
index 0000000..85c0670
--- /dev/null
+++ b/kernel/clk.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2010 Canonical Ltd <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Standard functionality for the common clock API.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+
+#define to_clk_fixed(clk) (container_of(clk, struct clk_fixed, clk))
+
+static unsigned long clk_fixed_get_rate(struct clk *clk)
+{
+	return to_clk_fixed(clk)->rate;
+}
+
+struct clk_ops clk_fixed_ops = {
+	.get_rate = clk_fixed_get_rate,
+};
+
+EXPORT_SYMBOL_GPL(clk_fixed_ops);
