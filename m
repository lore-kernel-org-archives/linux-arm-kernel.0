From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  6 Oct 2017 11:36:06 +0100
Subject: [PATCH v7 2/6] of: Add helper for mapping device node to logical CPU
 number
In-Reply-To: <20171006103610.11853-1-suzuki.poulose@arm.com>
References: <20171006103610.11853-1-suzuki.poulose@arm.com>
Message-ID: <20171006103610.11853-3-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to map a device node to a logical CPU number to avoid
duplication. Currently this is open coded in different places (e.g
gic-v3, coresight). The helper tries to map device node to a "possible"
logical CPU id, which may not be online yet. It is the responsibility
of the user to make sure that the CPU is online. The helper uses
of_cpu_device_node_get() to retrieve the device node for a given CPU
(which uses per_cpu data if available else falls back to slower
of_get_cpu_node()).

Cc: devicetree at vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V6:
 - Use faster of_cpu_device_node_get instead of of_get_cpu_node(),
   which now falls back to latter if called in early.
Changes since V3:
 - Renamed the helper to of_cpu_node_to_id(), suggested by Rob
 - Return -ENODEV on failure than nr_cpus_id
---
 drivers/of/base.c  | 26 ++++++++++++++++++++++++++
 include/linux/of.h |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 260d33c0f26c..e3f46daeee07 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -418,6 +418,32 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 EXPORT_SYMBOL(of_get_cpu_node);
 
 /**
+ * of_cpu_node_to_id: Get the logical CPU number for a given device_node
+ *
+ * @cpu_node: Pointer to the device_node for CPU.
+ *
+ * Returns the logical CPU number of the given CPU device_node.
+ * Returns -ENODEV if the CPU is not found.
+ */
+int of_cpu_node_to_id(struct device_node *cpu_node)
+{
+	int cpu;
+	bool found = false;
+	struct device_node *np;
+
+	for_each_possible_cpu(cpu) {
+		np = of_cpu_device_node_get(cpu);
+		found = (cpu_node == np);
+		of_node_put(np);
+		if (found)
+			return cpu;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(of_cpu_node_to_id);
+
+/**
  * __of_device_is_compatible() - Check if the node matches given constraints
  * @device: pointer to node
  * @compat: required compatible string, NULL or "" for any match
diff --git a/include/linux/of.h b/include/linux/of.h
index cfc34117fc92..27b54bcc420a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -538,6 +538,8 @@ const char *of_prop_next_string(struct property *prop, const char *cur);
 
 bool of_console_check(struct device_node *dn, char *name, int index);
 
+extern int of_cpu_node_to_id(struct device_node *np);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -862,6 +864,11 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 {
 }
 
+static inline int of_cpu_node_to_id(struct device_node *np)
+{
+	return -ENODEV;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
-- 
2.13.6
