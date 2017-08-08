From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  8 Aug 2017 12:37:22 +0100
Subject: [PATCH v5 2/6] of: Add helper for mapping device node to logical CPU
 number
In-Reply-To: <1502192246-5623-1-git-send-email-suzuki.poulose@arm.com>
References: <1502192246-5623-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1502192246-5623-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to map a device node to a logical CPU number to avoid
duplication. Currently this is open coded in different places (e.g
gic-v3, coresight). The helper tries to map device node to a "possible"
logical CPU id, which may not be online yet. It is the responsibility
of the user to make sure that the CPU is online. The helper uses
of_get_cpu_node() which uses arch specific backends to match the phyiscal
ids.

Cc: devicetree at vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V3:
 - Renamed the helper to of_cpu_node_to_id(), suggested by Rob
 - Return -ENODEV on failure than nr_cpus_id
---
 drivers/of/base.c  | 26 ++++++++++++++++++++++++++
 include/linux/of.h |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 686628d..e8625ff 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -420,6 +420,32 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
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
+		np = of_get_cpu_node(cpu, NULL);
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
index 4a8a709..23cf02d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -539,6 +539,8 @@ const char *of_prop_next_string(struct property *prop, const char *cur);
 
 bool of_console_check(struct device_node *dn, char *name, int index);
 
+extern int of_cpu_node_to_id(struct device_node *np);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -863,6 +865,11 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
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
2.7.5
