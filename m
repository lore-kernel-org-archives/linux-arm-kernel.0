From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:42 +0100
Subject: [PATCH v3 1/7] arm64: topology: refactor reset_cpu_topology to add
 support for removing topology
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently reset_cpu_topology clears all the CPU topology information
and resets to default values. However we may need to just clear the
information when we hotplug out the CPU. In preparation to add the
support the same, let's refactor reset_cpu_topology to just reset
the information and move clearing out the topology information to
clear_cpu_topology.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f845a8617812..b64733c5ea28 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -293,6 +293,19 @@ void store_cpu_topology(unsigned int cpuid)
 	update_siblings_masks(cpuid);
 }
 
+static void clear_cpu_topology(int cpu)
+{
+	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
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
 static void __init reset_cpu_topology(void)
 {
 	unsigned int cpu;
@@ -303,15 +316,9 @@ static void __init reset_cpu_topology(void)
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id = 0;
 		cpu_topo->package_id = -1;
-
 		cpu_topo->llc_id = -1;
-		cpumask_clear(&cpu_topo->llc_siblings);
-		cpumask_set_cpu(cpu, &cpu_topo->llc_siblings);
 
-		cpumask_clear(&cpu_topo->core_sibling);
-		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
-		cpumask_clear(&cpu_topo->thread_sibling);
-		cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
+		clear_cpu_topology(cpu);
 	}
 }
 
-- 
2.7.4
