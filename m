From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:44 +0100
Subject: [PATCH v3 3/7] arm64: topology: add support to remove cpu topology
 sibling masks
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-4-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to remove all the CPU topology information using
clear_cpu_topology and also resetting the sibling information on other
sibling CPUs. This will be used in cpu_disable so that all the topology
sibling information is removed on CPU hotplug out.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |  2 ++
 arch/arm64/kernel/topology.c      | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index df48212f767b..4c073d28f9e4 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -20,9 +20,11 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
+#define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_siblings)
 
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
+void remove_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #ifdef CONFIG_NUMA
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b64733c5ea28..cb81df545359 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -322,6 +322,20 @@ static void __init reset_cpu_topology(void)
 	}
 }
 
+void remove_cpu_topology(unsigned int cpu)
+{
+	int sibling;
+
+	for_each_cpu(sibling, topology_core_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+	for_each_cpu(sibling, topology_llc_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
+
+	clear_cpu_topology(cpu);
+}
+
 #ifdef CONFIG_ACPI
 /*
  * Propagate the topology information of the processor_topology_node tree to the
-- 
2.7.4
