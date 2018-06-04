From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  4 Jun 2018 11:39:57 +0100
Subject: [PATCH 5/5] arm64: topology: rename llc_siblings to align with other
 struct members
In-Reply-To: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
References: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1528108797-13743-6-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to core_sibling and thread_sibling, it's better to align and
rename llc_siblings to llc_sibling.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |  2 +-
 arch/arm64/kernel/topology.c      | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index fb996f454305..dda4b6dba6b4 100644
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
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index bf522bcf40ec..082f76f7a94d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -223,8 +223,8 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 		core_mask = &cpu_topology[cpu].core_sibling;
 	}
 	if (cpu_topology[cpu].llc_id != -1) {
-		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
-			core_mask = &cpu_topology[cpu].llc_siblings;
+		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
+			core_mask = &cpu_topology[cpu].llc_sibling;
 	}
 
 	return core_mask;
@@ -240,7 +240,7 @@ static void update_siblings_masks(unsigned int cpuid)
 		cpu_topo = &cpu_topology[cpu];
 
 		if (cpuid_topo->llc_id == cpu_topo->llc_id)
-			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
+			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
 
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
@@ -305,13 +305,13 @@ static void clear_cpu_topology(int cpu, bool reset)
 	cpu_topo->package_id = -1;
 	cpu_topo->llc_id = -1;
 
-	cpumask_clear(&cpu_topo->llc_siblings);
+	cpumask_clear(&cpu_topo->llc_sibling);
 	cpumask_clear(&cpu_topo->core_sibling);
 	cpumask_clear(&cpu_topo->thread_sibling);
 
 	if (reset) {
 		cpu_topo->core_id = 0;
-		cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
+		cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
 	}
@@ -325,7 +325,7 @@ static void __init reset_cpu_topology(void)
 		clear_cpu_topology(cpu, true);
 }
 
-#define cpu_llc_shared_mask(cpu)	(&cpu_topology[cpu].llc_siblings)
+#define cpu_llc_shared_mask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void remove_cpu_topology(unsigned int cpu)
 {
 	int sibling;
-- 
2.7.4
