From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 Jun 2018 14:18:42 +0100
Subject: [PATCH v2 6/7] arm64: topology: rename llc_siblings to align with
 other struct members
In-Reply-To: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1529327923-17911-7-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to core_sibling and thread_sibling, it's better to align and
rename llc_siblings to llc_sibling.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |  2 +-
 arch/arm64/kernel/topology.c      | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

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
index b60d7018e9db..e0db80252cfb 100644
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
@@ -303,8 +303,8 @@ static void clear_cpu_topology(int cpu, bool reset)
 		cpu_topo->llc_id = -1;
 	}

-	cpumask_clear(&cpu_topo->llc_siblings);
-	cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
+	cpumask_clear(&cpu_topo->llc_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);

 	cpumask_clear(&cpu_topo->core_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
@@ -320,7 +320,7 @@ static void __init reset_cpu_topology(void)
 		clear_cpu_topology(cpu, true);
 }

-#define cpu_llc_shared_mask(cpu)	(&cpu_topology[cpu].llc_siblings)
+#define cpu_llc_shared_mask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void remove_cpu_topology(unsigned int cpu)
 {
 	int sibling;
--
2.7.4
