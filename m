From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Jan 2017 12:00:16 +0000
Subject: [PATCH 1/2][UPDATE] of: base: add support to get the number of cache
 levels
In-Reply-To: <1484048479-19767-1-git-send-email-sudeep.holla@arm.com>
References: <1484048479-19767-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1484049616-22388-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to have helper function just to get the number of cache
levels for a given logical cpu. This patch adds the support for the
same.

It will be used on ARM64 platform where the device tree provides the
information for the additional non-architected/transparent/external
last level caches that are not integrated with the processors.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/of/base.c  | 23 +++++++++++++++++++++++
 include/linux/of.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4bea3c797d6..80e557eca858 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -2268,6 +2269,28 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 }
 
 /**
+ * of_count_cache_levels - Find the total number of cache levels for the
+ *			   given logical cpu
+ *
+ * @cpu: cpu number(logical index) for which cache levels is being counted
+ *
+ * Returns the total number of cache levels for the given logical cpu
+ */
+int of_count_cache_levels(unsigned int cpu)
+{
+	int level = 0;
+	struct device_node *np = of_cpu_device_node_get(cpu);
+
+	while (np) {
+		level++;
+		of_node_put(np);
+		np = of_find_next_cache_node(np);
+	}
+
+	return level;
+}
+
+/**
  * of_graph_parse_endpoint() - parse common endpoint node properties
  * @node: pointer to endpoint device_node
  * @endpoint: pointer to the OF endpoint data structure
diff --git a/include/linux/of.h b/include/linux/of.h
index d72f01009297..c8597ae71ff3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -280,6 +280,7 @@ extern struct device_node *of_get_child_by_name(const struct device_node *node,
 
 /* cache lookup */
 extern struct device_node *of_find_next_cache_node(const struct device_node *);
+extern int of_count_cache_levels(unsigned int cpu);
 extern struct device_node *of_find_node_with_property(
 	struct device_node *from, const char *prop_name);
 
-- 
2.7.4
