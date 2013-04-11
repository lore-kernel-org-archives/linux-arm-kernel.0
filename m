From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:33 +0100
Subject: [RFC PATCH 02/11] arm: add functions to parse cpu affinity from dt
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on hardware configuration, some devices may only be accessible
from certain CPUs, may have interrupts wired up to a subset of CPUs, or
may have operations which affect subsets of CPUs. To handle these
devices it is necessary to describe this affinity information in
devicetree.

This patch adds functions to handle parsing the CPU affinity of
properties from devicetree, based on Lorenzo's topology binding,
allowing subsets of CPUs to be associated with interrupts, hardware
ports, etc. The functions can be used to build cpumasks and also to test
whether an affinity property only targets one CPU independent of the
current configuration (e.g. when the kernel supports fewer CPUs than are
physically present). This is useful for dealing with mixed SPI/PPI
devices.

A device may have an arbitrary number of affinity properties, the
meaning of which is device-specific and should be specified in a given
device's binding document.

For example, an affinity property describing interrupt routing may
consist of a phandle pointing to a subtree of the topology nodes,
indicating the set of CPUs an interrupt originates from or may be taken
on. Bindings may have restrictions on the topology nodes referenced -
for describing coherency controls an affinity property may indicate a
whole cluster (uncluding any non-CPU logic it contains) is affected by
some configuration.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/dt_affinity.h |  12 ++++
 arch/arm/kernel/devtree.c          | 139 +++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 arch/arm/include/asm/dt_affinity.h

diff --git a/arch/arm/include/asm/dt_affinity.h b/arch/arm/include/asm/dt_affinity.h
new file mode 100644
index 0000000..3acc7ce
--- /dev/null
+++ b/arch/arm/include/asm/dt_affinity.h
@@ -0,0 +1,12 @@
+#ifndef ARM_ASM_DT_IRQ_H
+#define ARM_ASM_DT_IRQ_H
+
+#include <linux/cpumask.h>
+#include <linux/of.h>
+#include <linux/types.h>
+
+int arm_dt_affine_get_mask(struct device_node *node, char *prop,
+			   int idx, cpumask_t *mask);
+bool arm_dt_affine_is_single(struct device_node *node, char *prop,
+			     int idx);
+#endif /* ARM_ASM_DT_IRQ_H */
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 70f1bde..f31ab1e 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -20,6 +20,7 @@
 #include <linux/of_platform.h>
 
 #include <asm/cputype.h>
+#include <asm/dt_affinity.h>
 #include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/smp_plat.h>
@@ -165,6 +166,144 @@ void __init arm_dt_init_cpu_maps(void)
 	}
 }
 
+/*
+ * Test if the node is within the topology tree.
+ * Walk up to the root, keeping refcounts balanced.
+ */
+static bool is_topology_node(struct device_node *node)
+{
+	/*
+	 * of_get_next_parent decrements the refcount of the provided node.
+	 * Increment it first to keep things balanced.
+	 */
+	struct device_node *parent = of_node_get(node);
+	if (!parent)
+		return false;
+
+	do {
+		if (parent->name && of_node_cmp(parent->name, "cpu-map") == 0) {
+			of_node_put(parent);
+			return true;
+		}
+	} while ((parent = of_get_next_parent(parent)));
+
+	return false;
+}
+
+static int cpu_node_to_id(struct device_node *node)
+{
+	u32 reg;
+
+	if (of_property_read_u32(node, "reg", &reg) != 0)
+		return -EINVAL;
+
+	return get_logical_index(reg);
+}
+
+static int arm_dt_affine_build_mask(struct device_node *affine,
+				    cpumask_t *mask)
+{
+	struct device_node *child, *parent = NULL;
+	int ret = -EINVAL;
+
+	if (!is_topology_node(affine))
+		return -EINVAL;
+
+	child = of_node_get(affine);
+	if (!child)
+		goto out_invalid;
+
+	parent = of_get_parent(child);
+	if (!parent)
+		goto out_invalid;
+
+	if (!cpumask_empty(mask))
+		goto out_invalid;
+
+	/*
+	 * Depth-first search over the topology tree, iterating over leaf nodes
+	 * and adding all referenced CPUs to the cpumask. Almost all of the
+	 * of_* iterators are built for breadth-first search, which means we
+	 * have to do a little more work to ensure refcounts are balanced.
+	 */
+	do {
+		struct device_node *tmp, *cpu_node;
+		int cpu;
+
+		/* head down to the leaf */
+		while ((tmp = of_get_next_child(child, NULL))) {
+			of_node_put(parent);
+			parent = child;
+			child = tmp;
+		}
+
+		cpu_node = of_parse_phandle(child, "cpu", 0);
+		cpu = cpu_node_to_id(cpu_node);
+
+		if (cpu < 0)
+			pr_warn("Invalid or unused cpu in topology description '%s', skipping\n",
+				cpu_node->full_name);
+		else
+			cpumask_set_cpu(cpu, mask);
+
+		of_node_put(cpu_node);
+
+		/*
+		 * Find the next sibling, or transitively a parent's sibling.
+		 * Don't go further up the tree than the affine node we were
+		 * handed.
+		 */
+		while (child != affine &&
+			!(child = of_get_next_child(parent, child))) {
+			child = parent;
+			parent = of_get_parent(parent);
+		}
+
+	} while (child != affine); /* all children covered. Time to stop */
+
+	ret = 0;
+
+out_invalid:
+	of_node_put(child);
+	of_node_put(parent);
+	return ret;
+}
+
+int arm_dt_affine_get_mask(struct device_node *node, char *prop,
+				  int idx, cpumask_t *mask)
+{
+	int ret = -EINVAL;
+	struct device_node *affine = of_parse_phandle(node, prop, idx);
+	if (!affine)
+		return -EINVAL;
+
+	if (!is_topology_node(affine))
+		goto out;
+
+	ret = arm_dt_affine_build_mask(affine, mask);
+
+out:
+	of_node_put(affine);
+	return ret;
+}
+
+bool arm_dt_affine_is_single(struct device_node *node, char *prop,
+			     int idx)
+{
+	bool ret;
+	struct device_node *affine = of_parse_phandle(node, prop, idx);
+	if (!affine || !is_topology_node(affine)) {
+		pr_warn("%s called on invalid node '%s'", __func__,
+			node ? node->full_name : "NULL");
+		of_node_put(affine);
+		return true;
+	}
+
+	ret = !!of_get_property(affine, "cpu", NULL);
+	of_node_put(affine);
+	return ret;
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
-- 
1.8.1.1
