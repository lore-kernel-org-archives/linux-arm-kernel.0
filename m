From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue,  5 Jun 2018 14:08:37 -0500
Subject: [PATCH] arm64: topology: Avoid checking numa mask for scheduler MC
 selection
Message-ID: <20180605190837.493505-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
operations or during early boot. Lets disable the NUMA siblings checks
for the time being, as NUMA in socket machines have LLC's that will
assure that the scheduler topology isn't "borken".

Futher, as a defensive mechanism during hotplug, lets assure that the
LLC siblings are also masked.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/topology.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7415c166281f..f845a8617812 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -215,13 +215,8 @@ EXPORT_SYMBOL_GPL(cpu_topology);
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
+	const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
 
-	/* Find the smaller of NUMA, core or LLC siblings */
-	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
-		/* not numa in package, lets use the package siblings */
-		core_mask = &cpu_topology[cpu].core_sibling;
-	}
 	if (cpu_topology[cpu].llc_id != -1) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
 			core_mask = &cpu_topology[cpu].llc_siblings;
@@ -239,8 +234,10 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->llc_id == cpu_topo->llc_id)
+		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
+			cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
+		}
 
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
-- 
2.14.3
