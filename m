From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  4 Jun 2018 11:39:54 +0100
Subject: [PATCH 2/5] arm64: topology: add support to remove cpu topology
In-Reply-To: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
References: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1528108797-13743-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to remove all the CPU topology information using
clear_cpu_topology and also resetting the sibling information on other
sibling CPUs. This will be used in cpu_disable so that all the topology
information is removed on CPU hotplug out.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |  1 +
 arch/arm64/kernel/topology.c      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index df48212f767b..fb996f454305 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -23,6 +23,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
+void remove_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #ifdef CONFIG_NUMA
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f10babcc112b..bf522bcf40ec 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -325,6 +325,21 @@ static void __init reset_cpu_topology(void)
 		clear_cpu_topology(cpu, true);
 }
 
+#define cpu_llc_shared_mask(cpu)	(&cpu_topology[cpu].llc_siblings)
+void remove_cpu_topology(unsigned int cpu)
+{
+	int sibling;
+
+	for_each_cpu(sibling, topology_core_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
+		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+
+	clear_cpu_topology(cpu, false);
+}
+
 #ifdef CONFIG_ACPI
 /*
  * Propagate the topology information of the processor_topology_node tree to the
-- 
2.7.4
