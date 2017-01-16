From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 16 Jan 2017 10:40:43 +0000
Subject: [PATCH v3 1/2] of: base: add support to find the level of the last
 cache
Message-ID: <1484563244-14743-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to have helper function just to get the number of cache
levels for a given logical cpu. We can obtain the same by just checking
the level at which the last cache is present. This patch adds support
to find the level of the last cache for a given cpu.

It will be used on ARM64 platform where the device tree provides the
information for the additional non-architected/transparent/external
last level caches that are not integrated with the processors.

Cc: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Rob Herring <robh+dt@kernel.org>
Acked-by: Rob Herring <robh+dt@kernel.org>
Tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/of/base.c  | 26 ++++++++++++++++++++++++++
 include/linux/of.h |  1 +
 2 files changed, 27 insertions(+)

v2->v3:
	- Dropped unnecessary pointer check
	- Added Rob's Ack and Tan's Tested-by tags

v1->v2:
	- Moved to using "cache-level" in the last level cache instead
	  of counting through all the nodes as suggested by Rob

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4bea3c797d6..a30f541f0825 100644
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
@@ -2268,6 +2269,31 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 }

 /**
+ * of_find_last_cache_level - Find the level at which the last cache is
+ * 		present for the given logical cpu
+ *
+ * @cpu: cpu number(logical index) for which the last cache level is needed
+ *
+ * Returns the the level at which the last cache is present. It is exactly
+ * same as  the total number of cache levels for the given logical cpu.
+ */
+int of_find_last_cache_level(unsigned int cpu)
+{
+	int cache_level = 0;
+	struct device_node *prev = NULL, *np = of_cpu_device_node_get(cpu);
+
+	while (np) {
+		prev = np;
+		of_node_put(np);
+		np = of_find_next_cache_node(np);
+	}
+
+	of_property_read_u32(prev, "cache-level", &cache_level);
+
+	return cache_level;
+}
+
+/**
  * of_graph_parse_endpoint() - parse common endpoint node properties
  * @node: pointer to endpoint device_node
  * @endpoint: pointer to the OF endpoint data structure
diff --git a/include/linux/of.h b/include/linux/of.h
index d72f01009297..21e6323de0f3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -280,6 +280,7 @@ extern struct device_node *of_get_child_by_name(const struct device_node *node,

 /* cache lookup */
 extern struct device_node *of_find_next_cache_node(const struct device_node *);
+extern int of_find_last_cache_level(unsigned int cpu);
 extern struct device_node *of_find_node_with_property(
 	struct device_node *from, const char *prop_name);

--
2.7.4
