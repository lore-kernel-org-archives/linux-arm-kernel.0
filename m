From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Dec 2012 16:49:28 +0000
Subject: [RFCv2 2/2] ARM: add functions to parse irq affinity from dt
In-Reply-To: <1355417368-6861-1-git-send-email-mark.rutland@arm.com>
References: <1355417368-6861-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1355417368-6861-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds functions to handle parsing the CPU affinity of
interrupts from devicetree, based on an "interrupts-affinity" parameter
list. It is assumed that drivers which may optionally use this parameter
implement their own fallback behaviour.

The patch adds:
* arm_dt_has_irq_affinity : returns whether or not a device_node has
  interrupts-affinity information
* arm_dt_affine_irq_is_single : returns whether an interrupt targets a single
  CPU (i.e. is an SPI) or multiple CPUs (i.e. is a PPI). This test is
  independent of the number of affine CPUs we can logically map.
* arm_dt_irq_get_affinity : fills a cpumask with the CPUs an interrupt is
  affine to.

The "interrupts-affinity" property consists of a list of pairs of cells
specifying how to test if a CPU is affine. This test specification consists of
a most significant affinity level to match, and values for the MPIDR affinity
bits down to this level. Each pair of cells has the form:

	< N 0x00AABBCC >
	   \   \ \ \ \__ MPIDR.Aff0
	    \   \ \ \___ MPIDR.Aff1
	     \   \ \____ MPIDR.Aff2
	      \   \_____ [must be zero]
	       \________ level-specifier

The level-specifier is in the range [0-3]. When the value is 3, MPIDR
affinity levels 2,1,0 are ignored, and all CPUs are matched. Affinity
bits which are not to be matched should be set to zero.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/dt_irq.h |    9 ++++
 arch/arm/kernel/devtree.c     |   91 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/dt_irq.h

diff --git a/arch/arm/include/asm/dt_irq.h b/arch/arm/include/asm/dt_irq.h
new file mode 100644
index 0000000..431eeda
--- /dev/null
+++ b/arch/arm/include/asm/dt_irq.h
@@ -0,0 +1,9 @@
+#ifndef ARM_ASM_DT_IRQ_H
+#define ARM_ASM_DT_IRQ_H
+
+bool arm_dt_has_irq_affinity(struct device_node *node);
+bool arm_dt_affine_irq_is_single(struct device_node *node, int idx);
+int arm_dt_irq_get_affinity(struct device_node *node, int idx,
+			    cpumask_t *mask);
+
+#endif /* ARM_ASM_DT_IRQ_H */
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 70f1bde..65d5052 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -20,6 +20,7 @@
 #include <linux/of_platform.h>
 
 #include <asm/cputype.h>
+#include <asm/dt_irq.h>
 #include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/smp_plat.h>
@@ -165,6 +166,96 @@ void __init arm_dt_init_cpu_maps(void)
 	}
 }
 
+#define PROP_IRQ_AFFINITY	"interrupts-affinity"
+#define AFFINE_LEVEL_IDX(i)	(2*(i))
+#define AFFINE_MPIDR_IDX(i)	(2*(i) + 1)
+
+/*
+ * Check whether the device has irq affinity information.
+ * Allows drivers to fall back to current behaviour with a single check.
+ */
+bool arm_dt_has_irq_affinity(struct device_node *node)
+{
+	return of_find_property(node, PROP_IRQ_AFFINITY, NULL) != NULL;
+}
+
+/*
+ * Check whether an irq with affinity information is a single cpu
+ * interrupt (rather than percpu). The node paramenter should be
+ * checked with arm_dt_has_irq_affinity first.
+ */
+bool arm_dt_affine_irq_is_single(struct device_node *node, int idx)
+{
+	u32 level;
+	of_property_read_u32_index(node, PROP_IRQ_AFFINITY, &level,
+				   AFFINE_LEVEL_IDX(idx));
+	return level == 0;
+}
+
+struct affine_match_spec {
+	u32 level;
+	u32 aff;
+};
+
+static bool arm_dt_affine_mpidr_match(u32 mpidr, struct affine_match_spec *match)
+{
+	u32 mask = 0xFFFFFFFF << (8*(match->level));
+	return (mpidr & mask) == (match->aff & mask);
+}
+
+static int arm_dt_irq_read_match(struct device_node *node, int idx,
+				 struct affine_match_spec *match)
+{
+	int ret;
+	if (!node)
+		return -EINVAL;
+
+	ret = of_property_read_u32_index(node, PROP_IRQ_AFFINITY, &match->aff,
+					 AFFINE_MPIDR_IDX(idx));
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(node, PROP_IRQ_AFFINITY, &match->level,
+					 AFFINE_LEVEL_IDX(idx));
+	if (ret)
+		return ret;
+
+	/*
+	 * To match all cpus regardless of Aff{2,1,0}, we match at the
+	 * nonexistent Aff3.
+	 */
+	if (match->level > 3)
+		return -EINVAL;
+
+	return ret;
+
+}
+
+/*
+ * Get the set of possible cpus that an interrupt at idx is affine to.
+ */
+int arm_dt_irq_get_affinity(struct device_node *node, int idx,
+			    cpumask_t *mask)
+{
+	int i, ret;
+	struct affine_match_spec match;
+	u32 mpidr;
+
+	ret = arm_dt_irq_read_match(node, idx, &match);
+	if (ret)
+		return ret;
+
+	cpumask_clear(mask);
+
+	for_each_possible_cpu(i) {
+		mpidr = cpu_logical_map(i);
+		if (arm_dt_affine_mpidr_match(mpidr, &match))
+			cpumask_set_cpu(i, mask);
+	}
+
+	return 0;
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
-- 
1.7.0.4
