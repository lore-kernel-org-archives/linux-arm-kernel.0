From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 Jun 2018 14:18:37 +0100
Subject: [PATCH v2 1/7] arm64: topology: refactor reset_cpu_topology to add
 support for removing topology
In-Reply-To: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1529327923-17911-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently reset_cpu_topology clears all the CPU topology information
and resets to default values. However we may need to just clear the
information when we hotplug out the CPU. In preparation to add the
support the same, let's refactor reset_cpu_topology to clear out the
information and reset them only if explicitly requested.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f845a8617812..6ea3ec49d418 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -293,26 +293,33 @@ void store_cpu_topology(unsigned int cpuid)
 	update_siblings_masks(cpuid);
 }

-static void __init reset_cpu_topology(void)
+static void clear_cpu_topology(int cpu, bool reset)
 {
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
+	struct cpu_topology *cpu_topo = &cpu_topology[cpu];

+	if (reset) {
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id = 0;
 		cpu_topo->package_id = -1;

 		cpu_topo->llc_id = -1;
-		cpumask_clear(&cpu_topo->llc_siblings);
-		cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
-
-		cpumask_clear(&cpu_topo->core_sibling);
-		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
-		cpumask_clear(&cpu_topo->thread_sibling);
-		cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
 	}
+
+	cpumask_clear(&cpu_topo->llc_siblings);
+	cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
+
+	cpumask_clear(&cpu_topo->core_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
+	cpumask_clear(&cpu_topo->thread_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
+}
+
+static void __init reset_cpu_topology(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		clear_cpu_topology(cpu, true);
 }

 #ifdef CONFIG_ACPI
--
2.7.4
