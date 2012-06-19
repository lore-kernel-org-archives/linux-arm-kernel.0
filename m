From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 19 Jun 2012 10:28:52 +0200
Subject: [PATCH v2 1/5] ARM: topology: Add arch_scale_freq_power function
In-Reply-To: <1340094536-20873-1-git-send-email-vincent.guittot@linaro.org>
References: <1340094536-20873-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1340094536-20873-2-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add infrastructure to be able to modify the cpu_power of each core

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/include/asm/topology.h |    2 ++
 arch/arm/kernel/topology.c      |   38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 58b8b84..78e4c85 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -27,11 +27,13 @@ void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
+void set_power_scale(unsigned int cpu, unsigned long power);
 #else
 
 static inline void init_cpu_topology(void) { }
 static inline void store_cpu_topology(unsigned int cpuid) { }
 
+static inline void set_power_scale(unsigned int cpu, unsigned long power) { }
 #endif
 
 #include <asm-generic/topology.h>
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 8200dea..37e2e57 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -22,6 +22,37 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
+/*
+ * cpu power scale management
+ */
+
+/*
+ * cpu power table
+ * This per cpu data structure describes the relative capacity of each core.
+ * On a heteregenous system, cores don't have the same computation capacity
+ * and we reflect that difference in the cpu_power field so the scheduler can
+ * take this difference into account during load balance. A per cpu structure
+ * is preferred because each CPU updates its own cpu_power field during the
+ * load balance except for idle cores. One idle core is selected to run the
+ * rebalance_domains for all idle cores and the cpu_power can be updated
+ * during this sequence.
+ */
+static DEFINE_PER_CPU(unsigned long, cpu_scale);
+
+unsigned long arch_scale_freq_power(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
+
+void set_power_scale(unsigned int cpu, unsigned long power)
+{
+	per_cpu(cpu_scale, cpu) = power;
+}
+
+/*
+ * cpu topology management
+ */
+
 #define MPIDR_SMP_BITMASK (0x3 << 30)
 #define MPIDR_SMP_VALUE (0x2 << 30)
 
@@ -41,6 +72,9 @@
 #define MPIDR_LEVEL2_MASK 0xFF
 #define MPIDR_LEVEL2_SHIFT 16
 
+/*
+ * cpu topology table
+ */
 struct cputopo_arm cpu_topology[NR_CPUS];
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
@@ -134,7 +168,7 @@ void init_cpu_topology(void)
 {
 	unsigned int cpu;
 
-	/* init core mask */
+	/* init core mask and power*/
 	for_each_possible_cpu(cpu) {
 		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
 
@@ -143,6 +177,8 @@ void init_cpu_topology(void)
 		cpu_topo->socket_id = -1;
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
+
+		per_cpu(cpu_scale, cpu) = SCHED_POWER_SCALE;
 	}
 	smp_wmb();
 }
-- 
1.7.9.5
