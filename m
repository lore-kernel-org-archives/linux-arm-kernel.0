From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Jan 2012 14:36:48 +0000
Subject: [RFC PATCH 5/5] ARM: kernel: build CPU topology from DT
In-Reply-To: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1326897408-11204-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current ARM SMP systems can be described as a hierarchy of CPU layers,
each one comprised of resources (ie caches) shared between CPUs
belonging to a given hierarchy level. In order to optimize scheduling
and provide power management code with a description of CPUs topology, a
topology description must be retrieved either from SW or by probing HW.
The current solution relies on the MPIDR register to build CPU topology,
which assumes the MPIDR is wired with a reliable representation of
affinity levels for the system.

Since this hypothesis might not hold, this patch adds code allowing the CPU
topology to be parsed and built from a device tree representation (ie
bindings) provided via a device tree blob.

Topology is parsed from DT and built once for all by the boot CPU;
common code creating sibling maps has been factored out in a function

void update_siblings_masks(unsigned int);

that is executed for DT and non-DT initialization.

Documentation for the bindings is provided in the patchset.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/devicetree/bindings/arm/topology.txt |  167 ++++++++++++++++++++
 arch/arm/kernel/topology.c                         |  110 +++++++++++---
 2 files changed, 257 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/topology.txt

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
new file mode 100644
index 0000000..071cd18
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -0,0 +1,167 @@
+* ARM topology binding description
+
+The device tree notion of CPUs in a system must be extended to cater for
+systems comprised of clusters and hyper-threaded (SMT) cpus.
+
+In an ARM system CPUs hierarchy is defined through three levels (in descending
+hierarchy order):
+
+(1) cluster
+(2) core
+(3) thread
+
+The cpus node represents the lowest hierarchy level for CPUs in a system.
+For instance in a system where CPUs support SMT, "cpu" nodes represent all
+HW threads ("thread" - level (3) above) existing in the systems.
+In systems where SMT is not supported "cpu" nodes just represent a "core"
+level (level (2) above).
+
+Every "cpu" node must define two phandles:
+
+- cluster: phandle pointing to the cluster the given thread/core belongs to
+- core: phandle pointing to the core the given thread/core belongs to
+
+In an SMT system a "cpu" node must also define
+
+- thread-id: property defining the thread-id for the cpu node in question
+
+A missing "thread-id" means that the cpu does not support SMT.
+
+The topology requires the definition of a "clusters" node.
+The "clusters" node does not represent a HW device; it is a container where
+all cluster child nodes ("cluster") are defined.
+
+Each "cluster" node must contain:
+
+- reg: property defining cluster id
+- it must provide a label (eg CLUSTER0: cluster at 0x0) to be pointed to by a
+  phandle
+
+The topology requires the definition of a "cores" node.
+The "cores" node does not represent a HW device; it is a container where all
+core child nodes ("core") are defined.
+
+Each core node must contain:
+
+- reg: property defining core id
+- it must provide a label (eg CORE0: core at 0x0) to be pointed to by a
+  phandle
+
+Example (8-core system, dual-cluster, no SMT):
+
+clusters {
+
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	CLUSTER0: cluster at 0x0 {
+		reg = <0x0>;
+		cores {
+
+			#size-cells = <0>;
+			#address-cells = <1>;
+
+			CORE0: core at 0x0 {
+				reg = <0x0>;
+			};
+
+			CORE1: core at 0x1 {
+				reg = <0x1>;
+			};
+
+			CORE2: core at 0x2 {
+				reg = <0x2>;
+			};
+
+			CORE3: core at 0x3 {
+				reg = <0x3>;
+			};
+		};
+	};
+
+	CLUSTER1: cluster at 0x1 {
+		reg = <0x1>;
+		cores {
+
+			#size-cells = <0>;
+			#address-cells = <1>;
+
+			CORE4: core at 0x0 {
+				reg = <0x0>;
+			};
+
+			CORE5: core at 0x1 {
+				reg = <0x1>;
+			};
+
+			CORE6: core at 0x2 {
+				reg = <0x2>;
+			};
+
+			CORE7: core at 0x3 {
+				reg = <0x3>;
+			};
+		};
+	};
+};
+
+cpus {
+	#size-cells = <0>;
+	#address-cells = <1>;
+
+	CPU0: cpu at 0x0 {
+		device_type = "cpu";
+		reg = <0x0>;
+		cluster = <&CLUSTER0>;
+		core = <&CORE0>;
+	};
+
+	CPU1: cpu at 0x1 {
+		device_type = "cpu";
+		reg = <0x1>;
+		cluster = <&CLUSTER0>;
+		core = <&CORE1>;
+	};
+
+	CPU2: cpu at 0x2 {
+		device_type = "cpu";
+		reg = <0x2>;
+		cluster = <&CLUSTER0>;
+		core = <&CORE2>;
+	};
+
+	CPU3: cpu at 0x3 {
+		device_type = "cpu";
+		reg = <0x3>;
+		cluster = <&CLUSTER0>;
+		core = <&CORE3>;
+	};
+
+	CPU4: cpu at 0x100 {
+		device_type = "cpu";
+		reg = <0x100>;
+		cluster = <&CLUSTER1>;
+		core = <&CORE4>;
+	};
+
+	CPU5: cpu at 0x101 {
+		device_type = "cpu";
+		reg = <0x101>;
+		cluster = <&CLUSTER1>;
+		core = <&CORE5>;
+	};
+
+	CPU6: cpu at 0x102 {
+		device_type = "cpu";
+		reg = <0x102>;
+		cluster = <&CLUSTER1>;
+		core = <&CORE6>;
+	};
+
+	CPU7: cpu at 0x103 {
+		device_type = "cpu";
+		reg = <0x103>;
+		cluster = <&CLUSTER1>;
+		core = <&CORE7>;
+	};
+};
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 8200dea..f58fd20 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -17,9 +17,11 @@
 #include <linux/percpu.h>
 #include <linux/node.h>
 #include <linux/nodemask.h>
+#include <linux/of.h>
 #include <linux/sched.h>
 
 #include <asm/cputype.h>
+#include <asm/smp_plat.h>
 #include <asm/topology.h>
 
 #define MPIDR_SMP_BITMASK (0x3 << 30)
@@ -48,6 +50,30 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return &cpu_topology[cpu].core_sibling;
 }
 
+void update_siblings_masks(unsigned int cpuid)
+{
+	struct cputopo_arm *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
+	int cpu;
+	/* update core and thread sibling masks */
+	for_each_possible_cpu(cpu) {
+		cpu_topo = &cpu_topology[cpu];
+
+		if (cpuid_topo->socket_id == cpu_topo->socket_id) {
+			cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
+			if (cpu != cpuid)
+				cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
+
+			if (cpuid_topo->core_id == cpu_topo->core_id) {
+				cpumask_set_cpu(cpuid,
+					&cpu_topo->thread_sibling);
+				if (cpu != cpuid)
+					cpumask_set_cpu(cpu,
+						&cpuid_topo->thread_sibling);
+			}
+		}
+	}
+}
+
 /*
  * store_cpu_topology is called at boot when only one cpu is running
  * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
@@ -57,7 +83,6 @@ void store_cpu_topology(unsigned int cpuid)
 {
 	struct cputopo_arm *cpuid_topo = &cpu_topology[cpuid];
 	unsigned int mpidr;
-	unsigned int cpu;
 
 	/* If the cpu topology has been already set, just return */
 	if (cpuid_topo->core_id != -1)
@@ -99,25 +124,7 @@ void store_cpu_topology(unsigned int cpuid)
 		cpuid_topo->socket_id = -1;
 	}
 
-	/* update core and thread sibling masks */
-	for_each_possible_cpu(cpu) {
-		struct cputopo_arm *cpu_topo = &cpu_topology[cpu];
-
-		if (cpuid_topo->socket_id == cpu_topo->socket_id) {
-			cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-			if (cpu != cpuid)
-				cpumask_set_cpu(cpu,
-					&cpuid_topo->core_sibling);
-
-			if (cpuid_topo->core_id == cpu_topo->core_id) {
-				cpumask_set_cpu(cpuid,
-					&cpu_topo->thread_sibling);
-				if (cpu != cpuid)
-					cpumask_set_cpu(cpu,
-						&cpuid_topo->thread_sibling);
-			}
-		}
-	}
+	update_siblings_masks(cpuid);
 	smp_wmb();
 
 	printk(KERN_INFO "CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
@@ -126,6 +133,67 @@ void store_cpu_topology(unsigned int cpuid)
 		cpu_topology[cpuid].socket_id, mpidr);
 }
 
+#ifdef CONFIG_OF
+static void __init parse_dt_topology(void)
+{
+	struct cputopo_arm *cpu_info;
+	struct device_node *dn, *cn = NULL;
+	int cpu;
+
+	while ((cn = of_find_node_by_type(cn, "cpu"))) {
+		const u32 *hwid;
+		int len;
+
+		pr_debug("  * %s...\n", cn->full_name);
+
+		hwid = of_get_property(cn, "reg", &len);
+
+		if (!hwid || len != 4) {
+			pr_err("  * %s missing reg property\n", cn->full_name);
+			continue;
+		}
+
+		cpu = get_logical_index(be32_to_cpup(hwid));
+
+		if (cpu < 0) {
+			pr_err("  * %s wrong logical index %d\n", cn->full_name,
+							cpu);
+			continue;
+		}
+
+		cpu_info = &cpu_topology[cpu];
+
+		hwid = of_get_property(cn, "thread-id", &len);
+
+		if (hwid && len == 4)
+			cpu_info->thread_id = be32_to_cpup(hwid);
+
+		dn = of_parse_phandle(cn, "core", 0);
+
+		hwid = of_get_property(dn, "reg", &len);
+
+		if (hwid && len == 4)
+			cpu_info->core_id = be32_to_cpup(hwid);
+
+		dn = of_parse_phandle(cn, "cluster", 0);
+
+		hwid = of_get_property(dn, "reg", &len);
+
+		if (hwid && len == 4)
+			cpu_info->socket_id = be32_to_cpup(hwid);
+
+		update_siblings_masks(cpu);
+
+		printk(KERN_INFO "CPU%u: thread %d, core %d, socket %d\n",
+			cpu, cpu_topology[cpu].thread_id,
+			cpu_topology[cpu].core_id,
+			cpu_topology[cpu].socket_id);
+	}
+}
+#else
+static inline void parse_dt_topology(void) {}
+#endif
+
 /*
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
@@ -145,4 +213,6 @@ void init_cpu_topology(void)
 		cpumask_clear(&cpu_topo->thread_sibling);
 	}
 	smp_wmb();
+
+	parse_dt_topology();
 }
-- 
1.7.4.4
