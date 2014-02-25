From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 25 Feb 2014 16:54:11 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1393302345-18253-2-git-send-email-broonie@kernel.org>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
Message-ID: <20140225165411.GA3883@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Feb 25, 2014 at 04:25:42AM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Add basic CPU topology support to arm64, based on the existing pre-v8
> code and some work done by Mark Hambleton.  This patch does not
> implement any topology discovery support since that should be based on
> information from firmware, it merely implements the scaffolding for
> integration of topology support in the architecture.
> 
> No locking of the topology data is done since it is only modified during
> CPU bringup with external serialisation from the SMP code.
> 
> The goal is to separate the architecture hookup for providing topology
> information from the DT parsing in order to ease review and avoid
> blocking the architecture code (which will be built on by other work)
> with the DT code review by providing something simple and basic.
> 
> A following patch will implement support for parsing the DT topology
> bindings for ARM, similar patches will be needed for ACPI.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

I have been clobbering the code with some random dts configs, running on
top of the patch attached (to make code compliant with default if DT
info is missing for some CPUs). Can you give it a go please and run your
tests against it (I have just put it together) ? It should simplify things,
thoughts ?

AFAIK it should be correct, at least the info required by the scheduler
is reset to default (include/linux/topology.h) if DT nodes are
misconfigured. It applies on top of your series.

Thanks,
Lorenzo

-- >8 --
Subject: [PATCH] arm64: kernel: update topology discovery code

If the device tree does not contain topology information for a CPU,
kernel code should set-up topology information for the CPU according
to the default values defined in Documentation/cputopology.txt.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/topology.c |   34 +++++++++++++---------------------
 1 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index e85560a..22ce390 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -317,6 +317,18 @@ static void update_siblings_masks(unsigned int cpuid)
 	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
 	int cpu;
 
+	if (cpuid_topo->cluster_id == -1) {
+		/*
+		 * DT does not contain topology information for this cpu
+		 * reset it to default behaviour
+		 */
+		pr_warn("CPU%u: No topology information configured\n", cpuid);
+		cpuid_topo->core_id = 0;
+		cpumask_set_cpu(cpuid, &cpuid_topo->core_sibling);
+		cpumask_set_cpu(cpuid, &cpuid_topo->thread_sibling);
+		return;
+	}
+
 	/* update core and thread sibling masks */
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
@@ -339,14 +351,7 @@ static void update_siblings_masks(unsigned int cpuid)
 
 void store_cpu_topology(unsigned int cpuid)
 {
-	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
-
-	/* Something should have picked a topology by the time we get here */
-	if (cpuid_topo->core_id == -1)
-		pr_warn("CPU%u: No topology information configured\n", cpuid);
-	else
-		update_siblings_masks(cpuid);
-
+	update_siblings_masks(cpuid);
 	update_cpu_power(cpuid);
 }
 
@@ -372,17 +377,4 @@ void __init init_cpu_topology(void)
 	}
 
 	parse_dt_topology();
-
-	/*
-	 * Assign all remaining CPUs to a cluster so the scheduler
-	 * doesn't get confused.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
-
-		if (cpu_topo->cluster_id == -1) {
-			cpu_topo->cluster_id = INT_MAX;
-			cpu_topo->core_id = cpu;
-		}
-	}
 }
-- 
1.7.5.4
