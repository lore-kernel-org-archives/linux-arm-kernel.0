From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 06 Aug 2013 17:51:56 +0200
Subject: [PATCH RFC 1/2] clk: add common __clk_get(),
 __clk_put() implementations
In-Reply-To: <1375804317-10576-1-git-send-email-s.nawrocki@samsung.com>
References: <1375804317-10576-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1375804317-10576-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common __clk_get(), __clk_put() clkdev helpers
which replace their platform specific counterparts when the
common clock API enabled.

An owner module pointer is added to struct clk so a reference
to the clock supplier module is taken when the clock has active
consumers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/include/asm/clkdev.h      |    2 ++
 arch/blackfin/include/asm/clkdev.h |    2 ++
 arch/mips/include/asm/clkdev.h     |    2 ++
 arch/sh/include/asm/clkdev.h       |    2 ++
 drivers/clk/clk.c                  |   24 ++++++++++++++++++++++++
 include/linux/clk-private.h        |    3 +++
 include/linux/clkdev.h             |    5 +++++
 7 files changed, 40 insertions(+)

diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index 80751c1..4e8a4b2 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -14,12 +14,14 @@

 #include <linux/slab.h>

+#ifndef CONFIG_COMMON_CLK
 #ifdef CONFIG_HAVE_MACH_CLKDEV
 #include <mach/clkdev.h>
 #else
 #define __clk_get(clk)	({ 1; })
 #define __clk_put(clk)	do { } while (0)
 #endif
+#endif

 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
diff --git a/arch/blackfin/include/asm/clkdev.h b/arch/blackfin/include/asm/clkdev.h
index 9053bed..7ac2436 100644
--- a/arch/blackfin/include/asm/clkdev.h
+++ b/arch/blackfin/include/asm/clkdev.h
@@ -8,7 +8,9 @@ static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 	return kzalloc(size, GFP_KERNEL);
 }

+#ifndef CONFIG_COMMON_CLK
 #define __clk_put(clk)
 #define __clk_get(clk) ({ 1; })
+#endif

 #endif
diff --git a/arch/mips/include/asm/clkdev.h b/arch/mips/include/asm/clkdev.h
index 2624754..1b3ad7b 100644
--- a/arch/mips/include/asm/clkdev.h
+++ b/arch/mips/include/asm/clkdev.h
@@ -14,8 +14,10 @@

 #include <linux/slab.h>

+#ifndef CONFIG_COMMON_CLK
 #define __clk_get(clk)	({ 1; })
 #define __clk_put(clk)	do { } while (0)
+#endif

 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkdev.h
index 6ba9186..c419014 100644
--- a/arch/sh/include/asm/clkdev.h
+++ b/arch/sh/include/asm/clkdev.h
@@ -25,7 +25,9 @@ static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 		return kzalloc(size, GFP_KERNEL);
 }

+#ifndef CONFIG_COMMON_CLK
 #define __clk_put(clk)
 #define __clk_get(clk) ({ 1; })
+#endif

 #endif /* __CLKDEV_H__ */
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 54a191c..4877bd6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1850,6 +1850,30 @@ void devm_clk_unregister(struct device *dev, struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(devm_clk_unregister);

+/*
+ * clkdev helpers
+ */
+int __clk_get(struct clk *clk)
+{
+	if (WARN_ON((!clk)))
+		return 0;
+
+	if (!try_module_get(clk->owner))
+		return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL(__clk_get);
+
+void __clk_put(struct clk *clk)
+{
+	if (!clk || IS_ERR(clk))
+		return;
+
+	module_put(clk->owner);
+}
+EXPORT_SYMBOL(__clk_put);
+
 /***        clk rate change notifiers        ***/

 /**
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index dd7adff..b7c0b58 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -25,10 +25,13 @@

 #ifdef CONFIG_COMMON_CLK

+struct module;
+
 struct clk {
 	const char		*name;
 	const struct clk_ops	*ops;
 	struct clk_hw		*hw;
+	struct module		*owner;
 	struct clk		*parent;
 	const char		**parent_names;
 	struct clk		**parents;
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index a6a6f60..94bad77 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -43,4 +43,9 @@ int clk_add_alias(const char *, const char *, char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *, ...);
 int clk_register_clkdevs(struct clk *, struct clk_lookup *, size_t);

+#ifdef CONFIG_COMMON_CLK
+int __clk_get(struct clk *clk);
+void __clk_put(struct clk *clk);
+#endif
+
 #endif
--
1.7.9.5
