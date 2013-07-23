From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:24 -0400
Subject: [PATCH 08/13] ARM: bL_switcher: do not hardcode GIC IDs in the code
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, GIC IDs are hardcoded making the code dependent on the 4+4 b.L
configuration.  Let's allow for GIC IDs to be discovered upon switcher
initialization to support other b.L configurations such as the 1+1 one,
or 2+3 as on the VExpress TC2.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c   | 14 +++++++++++++-
 drivers/irqchip/irq-gic.c       | 21 +++++++++++++++++++++
 include/linux/irqchip/arm-gic.h |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 4273be76ba..34eff3bc25 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -111,6 +111,8 @@ static int bL_switchpoint(unsigned long _arg)
  * Generic switcher interface
  */
 
+static unsigned int bL_gic_id[MAX_CPUS_PER_CLUSTER][MAX_NR_CLUSTERS];
+
 /*
  * bL_switch_to - Switch to a specific cluster for the current CPU
  * @new_cluster_id: the ID of the cluster to switch to.
@@ -160,7 +162,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	this_cpu = smp_processor_id();
 
 	/* redirect GIC's SGIs to our counterpart */
-	gic_migrate_target(cpuid + ib_cluster*4);
+	gic_migrate_target(bL_gic_id[cpuid][ib_cluster]);
 
 	/*
 	 * Raise a SGI on the inbound CPU to make sure it doesn't stall
@@ -338,6 +340,16 @@ static int __init bL_switcher_halve_cpus(void)
 		cluster = (cpu_logical_map(i) >> 8) & 0xff;
 
 		if (cpumask_test_cpu(cpu, &common_mask)) {
+			/* Let's take note of the GIC ID for this CPU */
+			int gic_id = gic_get_cpu_id(i);
+			if (gic_id < 0) {
+				pr_err("%s: bad GIC ID for CPU %d\n", __func__, i);
+				return -EINVAL;
+			}
+			bL_gic_id[cpu][cluster] = gic_id;
+			pr_info("GIC ID for CPU %u cluster %u is %u\n",
+				cpu, cluster, gic_id);
+
 			/*
 			 * We keep only those logical CPUs which number
 			 * is equal to their physical CPU number. This is
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6bd5a8c1aa..0b6b8bf5df 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -668,6 +668,27 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 #ifdef CONFIG_BL_SWITCHER
 /*
+ * gic_get_cpu_id - get the CPU interface ID for the specified CPU
+ *
+ * @cpu: the logical CPU number to get the GIC ID for.
+ *
+ * Return the CPU interface ID for the given logical CPU number,
+ * or -1 if the CPU number is too large or the interface ID is
+ * unknown (more than one bit set).
+ */
+int gic_get_cpu_id(unsigned int cpu)
+{
+	unsigned int cpu_bit;
+
+	if (cpu >= NR_GIC_CPU_IF)
+		return -1;
+	cpu_bit = gic_cpu_map[cpu];
+	if (cpu_bit & (cpu_bit - 1))
+		return -1;
+	return __ffs(cpu_bit);
+}
+
+/*
  * gic_migrate_target - migrate IRQs to another PU interface
  *
  * @new_cpu_id: the CPU target ID to migrate IRQs to
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 40bfcac959..2d7d47e8df 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -75,6 +75,7 @@ static inline void gic_init(unsigned int nr, int start,
 	gic_init_bases(nr, start, dist, cpu, 0, NULL);
 }
 
+int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
 
 #endif /* __ASSEMBLY */
-- 
1.8.1.2
