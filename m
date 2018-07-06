From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:45 +0100
Subject: [PATCH v3 4/7] arm64: topology: restrict updating siblings_masks to
 online cpus only
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's incorrect to iterate over all the possible CPUs to update the
sibling masks when any CPU is hotplugged in. In case the topology
siblings masks of the CPU is removed when is it hotplugged out, we
end up updating those masks when one of it's sibling is powered up
again. This will provide inconsistent view.

Further, since the CPU calling update_sibling_masks is yet to be set
online, there's no need to compare itself with each online CPU when
updating the siblings masks.

This patch restricts updation of sibling masks only for CPUs that are
already online. It also the drops the unnecessary cpuid check.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index cb81df545359..1a3f8ab455d0 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -231,7 +231,7 @@ static void update_siblings_masks(unsigned int cpuid)
 	int cpu;
 
 	/* update core and thread sibling masks */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
 		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
@@ -243,15 +243,13 @@ static void update_siblings_masks(unsigned int cpuid)
 			continue;
 
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-		if (cpu != cpuid)
-			cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
+		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
 
 		if (cpuid_topo->core_id != cpu_topo->core_id)
 			continue;
 
 		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
-		if (cpu != cpuid)
-			cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
+		cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
 	}
 }
 
-- 
2.7.4
