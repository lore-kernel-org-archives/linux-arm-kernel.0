From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 17:42:54 +0100
Subject: [PATCH v4 1/9] drivers/of: Introduce of_node_alloc
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443458582-7497-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to be able to generate "fake" device nodes that can be
used as an identifier for irq domains. For that, we reuse the
dynamic DT layer in order to generate DT nodes in a detached state
(so that it doesn't interfere with the rest of the tree).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/dynamic.c | 22 ++++++++++++++++++++++
 include/linux/of.h   |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 53826b8..709d363 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -445,6 +445,28 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
 	return NULL;
 }
 
+/**
+ * of_node_alloc() - Allocate an empty device node dynamically.
+ * @fmt: Format string (plus vargs) for new full name of the device node
+ *
+ * Create an device tree node, either by by allocating an empty one
+ * suitable for further modification.  The node data are dynamically
+ * allocated and all the node flags have the OF_DYNAMIC & OF_DETACHED
+ * bits set. Returns the newly allocated node or NULL on out of memory
+ * error.
+ */
+struct device_node *of_node_alloc(const char *fmt, ...)
+{
+	struct device_node *np;
+	va_list vargs;
+
+	va_start(vargs, fmt);
+	np = __of_node_dup(NULL, fmt, vargs);
+	va_end(vargs);
+
+	return np;
+}
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	of_node_put(ce->np);
diff --git a/include/linux/of.h b/include/linux/of.h
index 2194b8c..f7f11f7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -104,6 +104,7 @@ static inline int of_node_is_attached(struct device_node *node)
 #ifdef CONFIG_OF_DYNAMIC
 extern struct device_node *of_node_get(struct device_node *node);
 extern void of_node_put(struct device_node *node);
+extern struct device_node *of_node_alloc(const char *fmt, ...);
 #else /* CONFIG_OF_DYNAMIC */
 /* Dummy ref counting routines - to be implemented later */
 static inline struct device_node *of_node_get(struct device_node *node)
@@ -111,6 +112,10 @@ static inline struct device_node *of_node_get(struct device_node *node)
 	return node;
 }
 static inline void of_node_put(struct device_node *node) { }
+static inline struct device_node *of_node_alloc(const char *fmt, ...)
+{
+	return NULL;
+}
 #endif /* !CONFIG_OF_DYNAMIC */
 
 /* Pointer for first entry in chain of all nodes. */
-- 
2.1.4
