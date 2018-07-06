From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:47 +0100
Subject: [PATCH v3 6/7] arm64: topology: rename llc_siblings to align with
 other struct members
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-7-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to core_sibling and thread_sibling, it's better to align and
rename llc_siblings to llc_sibling.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |  4 ++--
 arch/arm64/kernel/topology.c      | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 4c073d28f9e4..49a0fee4f89b 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -11,7 +11,7 @@ struct cpu_topology {
 	int llc_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
-	cpumask_t llc_siblings;
+	cpumask_t llc_sibling;
 };
 
 extern struct cpu_topology cpu_topology[NR_CPUS];
@@ -20,7 +20,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
-#define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_siblings)
+#define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a3f8ab455d0..03b0ed2480aa 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -218,8 +218,8 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
 
 	if (cpu_topology[cpu].llc_id != -1) {
-		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
-			core_mask = &cpu_topology[cpu].llc_siblings;
+		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
+			core_mask = &cpu_topology[cpu].llc_sibling;
 	}
 
 	return core_mask;
@@ -235,8 +235,8 @@ static void update_siblings_masks(unsigned int cpuid)
 		cpu_topo = &cpu_topology[cpu];
 
 		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
-			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
-			cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
+			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
+			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
 		}
 
 		if (cpuid_topo->package_id != cpu_topo->package_id)
@@ -295,8 +295,8 @@ static void clear_cpu_topology(int cpu)
 {
 	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
 
-	cpumask_clear(&cpu_topo->llc_siblings);
-	cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
+	cpumask_clear(&cpu_topo->llc_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
 
 	cpumask_clear(&cpu_topo->core_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
-- 
2.7.4
