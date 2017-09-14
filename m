From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 14 Sep 2017 13:49:11 -0500
Subject: [PATCH 6/6] arm64: topology: Enable ACPI/PPTT based CPU topology.
In-Reply-To: <20170914184918.20406-1-jeremy.linton@arm.com>
References: <20170914184918.20406-1-jeremy.linton@arm.com>
Message-ID: <20170914184918.20406-7-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Propagate the topology information from the PPTT tree to the
cpu_topology array. We can get the thread id, core_id and
cluster_id by assuming certain levels of the PPTT tree correspond
to those concepts. The package_id is flagged in the tree and can be
found by passing an arbitrary large level to setup_acpi_cpu_topology()
which terminates its search when it finds an ACPI node flagged
as the physical package. If the tree doesn't contain enough
levels to represent all of thread/core/cod/package then the package
id will be used for the missing levels.

Since arm64 machines can have 3 distinct topology levels, and the
scheduler only handles sockets/threads well today, we compromise
by collapsing into one of three diffrent configurations. These are
thread/socket, thread/cluster or cluster/socket depending on whether
the machine has threading and multisocket, threading in a single
socket, or doesn't have threading.

This code is loosely based on a combination of code from:
Xiongfeng Wang <wangxiongfeng2@huawei.com>
John Garry <john.garry@huawei.com>
Jeffrey Hugo <jhugo@codeaurora.org>

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/topology.c | 68 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/topology.h     |  2 ++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 9147e5b6326d..8ee5cc5ba9bd 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -22,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include <asm/cpu.h>
@@ -304,6 +306,68 @@ static void __init reset_cpu_topology(void)
 	}
 }
 
+#ifdef CONFIG_ACPI
+/*
+ * Propagate the topology information of the processor_topology_node tree to the
+ * cpu_topology array.
+ */
+static int __init parse_acpi_topology(void)
+{
+	u64 is_threaded;
+	int is_multisocket;
+	int cpu;
+	int topology_id;
+	/* set a large depth, to hit ACPI_PPTT_PHYSICAL_PACKAGE if one exists */
+	const int max_topo = 0xFF;
+
+	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
+	is_multisocket = acpi_multisocket_count();
+	if (is_multisocket < 0)
+		return is_multisocket;
+
+	for_each_possible_cpu(cpu) {
+		topology_id = setup_acpi_cpu_topology(cpu, 0);
+		if (topology_id < 0)
+			return topology_id;
+
+		if ((is_threaded) && (is_multisocket > 1)) {
+			/* MT per core, and multiple sockets */
+			cpu_topology[cpu].thread_id = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, 1);
+			cpu_topology[cpu].core_id   = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, 2);
+			cpu_topology[cpu].cluster_id = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, max_topo);
+			cpu_topology[cpu].package_id = topology_id;
+		} else if (is_threaded) {
+			/* mutltiple threads, but only a single socket */
+			cpu_topology[cpu].thread_id  = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, 1);
+			cpu_topology[cpu].core_id    = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, 2);
+			cpu_topology[cpu].cluster_id = topology_id;
+			cpu_topology[cpu].package_id = topology_id;
+		} else {
+			/* no threads, clusters behave like threads */
+			cpu_topology[cpu].thread_id  = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, 1);
+			cpu_topology[cpu].core_id    = topology_id;
+			cpu_topology[cpu].cluster_id = topology_id;
+			topology_id = setup_acpi_cpu_topology(cpu, max_topo);
+			cpu_topology[cpu].package_id = topology_id;
+		}
+	}
+	return 0;
+}
+
+#else
+static int __init parse_acpi_topology(void)
+{
+	/*ACPI kernels should be built with PPTT support*/
+	return -EINVAL;
+}
+#endif
+
 void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
@@ -312,6 +376,8 @@ void __init init_cpu_topology(void)
 	 * Discard anything that was parsed if we hit an error so we
 	 * don't use partial information.
 	 */
-	if (of_have_populated_dt() && parse_dt_topology())
+	if ((!acpi_disabled) && parse_acpi_topology())
+		reset_cpu_topology();
+	else if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
 }
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 4660749a7303..08bf736be7c1 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -43,6 +43,8 @@
 		if (nr_cpus_node(node))
 
 int arch_update_cpu_topology(void);
+int setup_acpi_cpu_topology(unsigned int cpu, int level);
+int acpi_multisocket_count(void);
 
 /* Conform to ACPI 2.0 SLIT distance definitions */
 #define LOCAL_DISTANCE		10
-- 
2.13.5
