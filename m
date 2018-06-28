From: drjones@redhat.com (Andrew Jones)
Date: Thu, 28 Jun 2018 16:51:28 +0200
Subject: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180628145128.10057-1-drjones@redhat.com>
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
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---

v1:
Reworked this since the RFC in order to make the algorithm more
obvious. It wasn't clear in the RFC that the ACPI nodes could be
in any order, although they could have been. I've tested that
this works with nodes in arbitrary order by hacking the QEMU
PPTT table generator[*].

Note, while this produces equivalent topology IDs to what the
DT cpu-map node produces for all sane configs, if PEs are
threads (have MPIDR.MT set), but the cpu-map does not specify
threads, then, while the DT parsing code will happily call the
threads "cores", ACPI will see that the PPTT leaf nodes are for
threads and produce different topology IDs. I see this difference
as a bug with the DT parsing which can be addressed separately.

[*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology


 arch/arm64/kernel/topology.c | 70 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f845a8617812..7ef457401b24 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -316,6 +316,10 @@ static void __init reset_cpu_topology(void)
 }
 
 #ifdef CONFIG_ACPI
+
+#define acpi_topology_mktag(x)	(-((x) + 1))
+#define acpi_topology_istag(x)	((x) < 0)
+
 /*
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
@@ -323,27 +327,31 @@ static void __init reset_cpu_topology(void)
 static int __init parse_acpi_topology(void)
 {
 	bool is_threaded;
-	int cpu, topology_id;
+	int package_id = 0;
+	int cpu, ret;
 
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
+	/*
+	 * Loop through all PEs twice. In the first loop store parent
+	 * tags into the IDs. In the second loop we reset the IDs as
+	 * 0..N-1 per parent tag.
+	 */
+
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
-		topology_id = find_acpi_cpu_topology(cpu, 0);
-		if (topology_id < 0)
-			return topology_id;
-
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
+		ret = find_acpi_cpu_topology(cpu, 0);
+		if (ret < 0)
+			return ret;
+
+		if (is_threaded)
+			ret = find_acpi_cpu_topology(cpu, 1);
+		else
+			cpu_topology[cpu].thread_id = -1;
+		cpu_topology[cpu].core_id = acpi_topology_mktag(ret);
+		ret = find_acpi_cpu_topology_package(cpu);
+		cpu_topology[cpu].package_id = acpi_topology_mktag(ret);
 
 		i = acpi_find_last_cache_level(cpu);
 
@@ -358,6 +366,38 @@ static int __init parse_acpi_topology(void)
 		}
 	}
 
+	for_each_possible_cpu(cpu) {
+		int package_tag = cpu_topology[cpu].package_id;
+		int core_id = 0, cpu2;
+
+		if (!acpi_topology_istag(package_tag))
+			continue;
+
+		for_each_possible_cpu(cpu2) {
+			if (cpu_topology[cpu2].package_id != package_tag)
+				continue;
+
+			if (is_threaded) {
+				int core_tag = cpu_topology[cpu2].core_id;
+				int thread_id = 0, cpu3;
+
+				for_each_possible_cpu(cpu3) {
+					if (cpu_topology[cpu3].core_id != core_tag)
+						continue;
+
+					cpu_topology[cpu3].thread_id = thread_id++;
+					cpu_topology[cpu3].core_id = core_id;
+					cpu_topology[cpu3].package_id = package_id;
+				}
+				++core_id;
+			} else {
+				cpu_topology[cpu2].core_id = core_id++;
+				cpu_topology[cpu2].package_id = package_id;
+			}
+		}
+		++package_id;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.1
