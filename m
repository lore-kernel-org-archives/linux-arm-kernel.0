From: drjones@redhat.com (Andrew Jones)
Date: Fri, 22 Jun 2018 16:22:28 +0200
Subject: [PATCH RFC] arm64: acpi: reenumerate topology ids
Message-ID: <20180622142228.19645-1-drjones@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with devicetree, and the devicetree has the cpu-map
node, the topology IDs that are visible from sysfs are generated
with counters. ACPI, on the other hand, uses ACPI table pointer
offsets, which, while guaranteed to be unique, look a bit weird.
Instead, we can generate DT identical topology IDs for ACPI by
just using counters for the leaf nodes and by remapping the
non-leaf table pointer offsets to counters.

Cc: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/kernel/topology.c | 68 ++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f845a8617812..4c6aa9eec3d3 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -316,6 +316,10 @@ static void __init reset_cpu_topology(void)
 }
 
 #ifdef CONFIG_ACPI
+
+#define acpi_topology_mktag(id)	(-((id) + 1))
+#define acpi_topology_istag(id)	((id) < 0)
+
 /*
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
@@ -323,27 +327,24 @@ static void __init reset_cpu_topology(void)
 static int __init parse_acpi_topology(void)
 {
 	bool is_threaded;
-	int cpu, topology_id;
+	int package_id = 0, core_id, thread_id;
+	int cpu, ret;
 
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
-		topology_id = find_acpi_cpu_topology(cpu, 0);
-		if (topology_id < 0)
-			return topology_id;
+		ret = find_acpi_cpu_topology(cpu, 0);
+		if (ret < 0)
+			return ret;
 
-		if (is_threaded) {
-			cpu_topology[cpu].thread_id = topology_id;
-			topology_id = find_acpi_cpu_topology(cpu, 1);
-			cpu_topology[cpu].core_id   = topology_id;
-		} else {
-			cpu_topology[cpu].thread_id  = -1;
-			cpu_topology[cpu].core_id    = topology_id;
-		}
-		topology_id = find_acpi_cpu_topology_package(cpu);
-		cpu_topology[cpu].package_id = topology_id;
+		if (is_threaded)
+			ret = find_acpi_cpu_topology(cpu, 1);
+		cpu_topology[cpu].core_id = acpi_topology_mktag(ret);
+
+		ret = find_acpi_cpu_topology_package(cpu);
+		cpu_topology[cpu].package_id = acpi_topology_mktag(ret);
 
 		i = acpi_find_last_cache_level(cpu);
 
@@ -358,6 +359,45 @@ static int __init parse_acpi_topology(void)
 		}
 	}
 
+	for_each_possible_cpu(cpu) {
+		int tag, cpu2;
+
+		if (is_threaded) {
+			if (acpi_topology_istag(cpu_topology[cpu].core_id))
+				thread_id = 0;
+			cpu_topology[cpu].thread_id = thread_id;
+			++thread_id;
+		} else {
+			cpu_topology[cpu].thread_id = -1;
+		}
+
+		if (acpi_topology_istag(cpu_topology[cpu].core_id)) {
+			if (acpi_topology_istag(cpu_topology[cpu].package_id))
+				core_id = 0;
+			tag = cpu_topology[cpu].core_id;
+			cpu_topology[cpu].core_id = core_id;
+
+			if (is_threaded) {
+				for_each_possible_cpu(cpu2) {
+					if (cpu_topology[cpu2].core_id == tag)
+						cpu_topology[cpu2].core_id = core_id;
+				}
+			}
+			++core_id;
+		}
+
+		if (acpi_topology_istag(cpu_topology[cpu].package_id)) {
+			tag = cpu_topology[cpu].package_id;
+			cpu_topology[cpu].package_id = package_id;
+
+			for_each_possible_cpu(cpu2) {
+				if (cpu_topology[cpu2].package_id == tag)
+					cpu_topology[cpu2].package_id = package_id;
+			}
+			++package_id;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1
