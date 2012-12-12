From: steve.capper@arm.com (Steve Capper)
Date: Wed, 12 Dec 2012 17:40:48 +0000
Subject: [RFC PATCH 2/3] ARM: mm: Add NUMA support.
In-Reply-To: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
References: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
Message-ID: <1355334049-10247-3-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for NUMA (running on either discontiguous
and sparse memory).

At the moment, the number of nodes has to be specified on the
commandline. One can also, optionally, specify the memory size of
each node. (Otherwise the memory range is split roughly equally
between nodes).

CPUs can be striped across nodes (cpu number modulo the number of
nodes), or assigned to a node based on their
topology_physical_package_id. So for instance on a TC2, the A7
cores can be grouped together in one node and the A15s grouped
together in another node.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                |   28 ++++-
 arch/arm/include/asm/mmzone.h   |   14 ++-
 arch/arm/include/asm/topology.h |   15 +++
 arch/arm/kernel/setup.c         |    6 ++
 arch/arm/mm/init.c              |   53 +++------
 arch/arm/mm/numa.c              |  228 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 303 insertions(+), 41 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9846d89..739ea5d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,6 +55,7 @@ config ARM
 	select SYS_SUPPORTS_APM_EMULATION
 	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
 	select MODULES_USE_ELF_REL
+	select HAVE_MEMBLOCK_NODE_MAP
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
@@ -1171,9 +1172,34 @@ config ARCH_DISCONTIGMEM_ENABLE
 
 source arch/arm/mm/Kconfig
 
+config NUMA
+	bool "NUMA Support (EXPERIMENTAL)"
+	depends on MMU && !FLATMEM && EXPERIMENTAL
+	help
+	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
+	  Access). At the moment, one has to specify the number of nodes using
+	  the commandline:
+	  numa=fake=x,[size0],[size1],...,[sizeN-1],[usetopology]
+	  where x is the number of nodes, and sizeY is the size of node Y in
+	  bytes (one can suffix m or g for megabytes or gigabytes). If no sizes
+	  are specified, the memory is distributed roughly evenly between nodes.
+	  If "usetopology" is specified, the "topology_physical_package_id" is
+	  used to assign CPUs to nodes (so for instance on the TC2, the A7s are
+	  grouped together in one node and the A15s are grouped together in
+	  another node).
+
+config NODES_SHIFT
+	int "Maximum NUMA Nodes (as a power of 2)" if NUMA
+	range 1 10
+	default "1"
+	depends on NEED_MULTIPLE_NODES
+	---help---
+	  Specify the maximum number of NUMA Nodes available on the target
+	  system.  Increases memory reserved to accommodate various tables.
+
 config NUMA_ALLOC_NODES
 	bool
-	depends on DISCONTIGMEM
+	depends on DISCONTIGMEM || NUMA
 	default y
 
 config ARM_NR_BANKS
diff --git a/arch/arm/include/asm/mmzone.h b/arch/arm/include/asm/mmzone.h
index f6d7337..628e503 100644
--- a/arch/arm/include/asm/mmzone.h
+++ b/arch/arm/include/asm/mmzone.h
@@ -31,7 +31,19 @@ extern struct pglist_data *node_data[];
 #define arm_numa_alloc_nodes(_mlow)	do {} while (0)
 #endif
 
-#define	pfn_to_nid(pfn)		(0)
+#ifdef CONFIG_NUMA
+extern cpumask_var_t *node_to_cpumask_map;
+extern int numa_cpu_lookup_table[];
+extern int pfn_to_nid(unsigned long pfn);
+extern void __init arm_setup_nodes(unsigned long min, unsigned long max_high);
+extern void __init arm_numa_alloc_cpumask(unsigned long max_low);
+#else
+#define	pfn_to_nid(pfn)			(0)
+#define arm_setup_nodes(min, max_high) memblock_set_node(		\
+					__pfn_to_phys(min), 		\
+					__pfn_to_phys(max_high - min), 0)
+#define arm_numa_alloc_cpumask(max_low)	do {} while (0)
+#endif /* CONFIG_NUMA */
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_ARM_MMZONE_H_ */
diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 58b8b84..44cba52 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -34,6 +34,21 @@ static inline void store_cpu_topology(unsigned int cpuid) { }
 
 #endif
 
+#ifdef CONFIG_NUMA
+
+static inline int cpu_to_node(int cpu)
+{
+	return numa_cpu_lookup_table[cpu];
+}
+
+#define cpumask_of_node(node) ((node) == -1 ?				\
+			       cpu_all_mask :				\
+			       node_to_cpumask_map[node])
+
+#define parent_node(node)	(node)
+
+#endif /* CONFIG_NUMA */
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d15f1c5..b7e5772 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -795,6 +795,12 @@ static int __init topology_init(void)
 {
 	int cpu;
 
+#ifdef CONFIG_NUMA
+	int node;
+	for_each_online_node(node)
+		register_one_node(node);
+#endif
+
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
 		cpuinfo->cpu.hotpluggable = 1;
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 98488ee..b96c90f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -268,56 +268,31 @@ void __init setup_dma_zone(struct machine_desc *mdesc)
 static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 	unsigned long max_high)
 {
-	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	struct memblock_region *reg;
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 	/*
-	 * initialise the zones.
+	 * On NUMA systems we register a CPU notifier, split the memory between
+	 * the nodes and bring them online before free_area_init_nodes).
+	 *
+	 * Otherwise, we put all memory into node 0.
 	 */
-	memset(zone_size, 0, sizeof(zone_size));
-
+	arm_setup_nodes(min, max_high);
+	
 	/*
-	 * The memory size has already been determined.  If we need
-	 * to do anything fancy with the allocation of this memory
-	 * to the zones, now is the time to do it.
+	 * initialise the zones.
 	 */
-	zone_size[0] = max_low - min;
-#ifdef CONFIG_HIGHMEM
-	zone_size[ZONE_HIGHMEM] = max_high - max_low;
-#endif
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_NORMAL] = max_low;
 
-	/*
-	 * Calculate the size of the holes.
-	 *  holes = node_size - sum(bank_sizes)
-	 */
-	memcpy(zhole_size, zone_size, sizeof(zhole_size));
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (start < max_low) {
-			unsigned long low_end = min(end, max_low);
-			zhole_size[0] -= low_end - start;
-		}
 #ifdef CONFIG_HIGHMEM
-		if (end > max_low) {
-			unsigned long high_start = max(start, max_low);
-			zhole_size[ZONE_HIGHMEM] -= end - high_start;
-		}
+	max_zone_pfns[ZONE_HIGHMEM] = max_high;
 #endif
-	}
 
-#ifdef CONFIG_ZONE_DMA
-	/*
-	 * Adjust the sizes according to any special requirements for
-	 * this machine type.
-	 */
-	if (arm_dma_zone_size)
-		arm_adjust_dma_zone(zone_size, zhole_size,
-			arm_dma_zone_size >> PAGE_SHIFT);
+#ifdef CONFIG_DMA
+	max_zone_pfns[ZONE_DMA] = __phys_to_pfn(arm_dma_limit);
 #endif
 
-	free_area_init_node(0, zone_size, min, zhole_size);
+	free_area_init_nodes(max_zone_pfns);
 }
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
diff --git a/arch/arm/mm/numa.c b/arch/arm/mm/numa.c
index 5141134..5933e2c 100644
--- a/arch/arm/mm/numa.c
+++ b/arch/arm/mm/numa.c
@@ -35,10 +35,15 @@ EXPORT_SYMBOL(node_data);
 
 static unsigned int numa_node_count = 1;
 
+cpumask_var_t *node_to_cpumask_map;
+EXPORT_SYMBOL(node_to_cpumask_map);
+
 void __init arm_numa_alloc_nodes(unsigned long max_low)
 {
 	int node;
 
+	arm_numa_alloc_cpumask(max_low);
+
 	for (node = 0; node < numa_node_count; node++) {
 		phys_addr_t pa = memblock_alloc_base(sizeof(pg_data_t),
 				L1_CACHE_BYTES, __pfn_to_phys(max_low));
@@ -48,3 +53,226 @@ void __init arm_numa_alloc_nodes(unsigned long max_low)
 		NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	}
 }
+
+#ifdef CONFIG_NUMA
+
+static unsigned int numa_use_topology;
+
+static char *memcmdline __initdata;
+
+int numa_cpu_lookup_table[NR_CPUS];
+EXPORT_SYMBOL(numa_cpu_lookup_table);
+
+static unsigned long pfn_starts[MAX_NUMNODES];
+
+#ifdef CONFIG_DISCONTIGMEM
+int pfn_to_nid(unsigned long pfn)
+{
+	int node;
+
+	for (node = numa_node_count - 1; node >= 0; node--)
+		if (pfn >= pfn_starts[node])
+			return node;
+
+	panic("NUMA: Unable to locate nid for %lX\n", pfn);
+	return 0;
+}
+#endif
+
+void __init arm_numa_alloc_cpumask(unsigned long max_low)
+{
+	size_t size = sizeof(cpumask_var_t) * numa_node_count;
+	node_to_cpumask_map = __va(memblock_alloc_base(size,
+				L1_CACHE_BYTES, __pfn_to_phys(max_low)));
+	memset(node_to_cpumask_map, 0, size);
+}
+
+/*
+ * Add a CPU to a NUMA node.
+ * Default assignment policy is the cpu number modulo the number of nodes.
+ *
+ * We can also group CPUs via the topology_physical_package_id.
+ * (if the user adds "usetopology" to the command line).
+ * When we add CPU 0 (the boot CPU), it is always to node 0, as we don't have
+ * the topology information at that time.
+ * Subsequent CPUs get added based on the topology_physical_package_id.
+ * To stop CPU0 being added to the same node as CPUs on a different cluster,
+ * we subtract the topology_physical_package_id of node 0.
+ *
+ * This ensures that the TC2 has equivalent node configurations when booted
+ * off the A15s or the A7s.
+ */
+static void add_cpu_to_node(int cpu)
+{
+	unsigned int node;
+	unsigned int n0 = topology_physical_package_id(0);
+	unsigned int nc = topology_physical_package_id(cpu);
+
+	if (numa_use_topology)
+		node = cpu ? (numa_node_count + nc - n0) % numa_node_count : 0;
+	else
+		node = cpu % numa_node_count;
+
+	cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
+	numa_cpu_lookup_table[cpu] = node;
+	pr_info("NUMA: Adding CPU %d to node %d\n", cpu, node);
+}
+
+static int __cpuinit numa_add_cpu(struct notifier_block *self,
+				unsigned long action, void *cpu)
+{
+	if (action == CPU_ONLINE)
+		add_cpu_to_node((int)cpu);
+
+	return NOTIFY_OK;
+
+}
+
+static struct notifier_block __cpuinitdata numa_node_nb = {
+	.notifier_call = numa_add_cpu,
+	.priority = 1, /* Must run before sched domains notifier. */
+};
+
+/*
+ * Split the available memory between the NUMA nodes.
+ * We want all the pages mapped by a pmd to belong to the same node; as code,
+ * such as the THP splitting code, assumes pmds are backed by contiguous
+ * struct page *s. So we mask off the sizes with "rmask".
+ *
+ * By default, the memory is distributed roughly evenly between nodes.
+ *
+ * One can also specify requested node sizes on the command line, if
+ * "memcmdline" is not NULL, we try to parse it as a size.
+ *
+ * We traverse memory blocks rather than the pfn addressable range to allow for
+ * sparse memory configurations and memory holes.
+ */
+static void __init arm_numa_split_memblocks(void)
+{
+	const unsigned long rmask = ~((1UL << (PMD_SHIFT - PAGE_SHIFT)) - 1);
+	unsigned int node;
+	unsigned long pfnsrem = 0, pfnsblock, pfncurr, pfnend = 0;
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		pfnend = memblock_region_memory_end_pfn(reg);
+		pfnsrem += pfnend - memblock_region_memory_base_pfn(reg);
+	}
+
+	reg = memblock.memory.regions;
+	pfnsblock = memblock_region_memory_end_pfn(reg)
+		    - memblock_region_memory_base_pfn(reg);
+
+	pfncurr = memblock_region_memory_base_pfn(reg);
+	pfn_starts[0] = pfncurr;
+
+	for (node = 0; node < numa_node_count - 1; node++) {
+		unsigned long pfnsnode = pfnsrem / (numa_node_count - node)
+					& rmask;
+
+		if (memcmdline) {
+			unsigned long nsize = __phys_to_pfn(
+					     memparse(memcmdline, &memcmdline))
+						& rmask;
+			if (*memcmdline == ',')
+				++memcmdline;
+
+			if ((nsize > 0) && (nsize < pfnsrem))
+				pfnsnode = nsize;
+			else
+				memcmdline = NULL;
+		}
+
+		while (pfnsnode > 0) {
+			unsigned long pfnsset = min(pfnsnode, pfnsblock);
+
+			pfncurr += pfnsset;
+
+			pfnsblock -= pfnsset;
+			pfnsrem -= pfnsset;
+			pfnsnode -= pfnsset;
+
+			if (pfnsblock == 0) {
+				reg++;
+				pfnsblock = memblock_region_memory_end_pfn(reg)
+					    - memblock_region_memory_base_pfn(reg);
+				pfncurr = memblock_region_memory_base_pfn(reg);
+			}
+		}
+
+		pfn_starts[node + 1] = pfncurr;
+	}
+
+	for (node = 0; node < numa_node_count - 1; node++)
+		memblock_set_node(__pfn_to_phys(pfn_starts[node]),
+			__pfn_to_phys(pfn_starts[node + 1] - pfn_starts[node]),
+			node);
+
+	memblock_set_node(__pfn_to_phys(pfn_starts[node]),
+		__pfn_to_phys(pfnend - pfn_starts[node]), node);
+
+}
+
+void __init arm_setup_nodes(unsigned long min, unsigned long max_high)
+{
+	int node;
+
+	register_cpu_notifier(&numa_node_nb);
+	arm_numa_split_memblocks();
+
+
+	for (node = 0; node < numa_node_count; node++) {
+		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
+		node_set_online(node);
+	}
+
+	add_cpu_to_node(0);
+
+}
+
+static int __init early_numa(char *p)
+{
+	if (!p)
+		return 0;
+
+	p = strstr(p, "fake=");
+	if (p) {
+		int num_nodes = 0;
+		int optres;
+
+		p += strlen("fake=");
+		optres = get_option(&p, &num_nodes);
+		if ((optres == 0) || (optres == 3))
+			return -EINVAL;
+
+		if ((num_nodes > 0) && (num_nodes <= MAX_NUMNODES)) {
+			pr_info("NUMA: setting up fake NUMA with %d nodes.\n",
+				num_nodes);
+
+			numa_node_count = num_nodes;
+		} else {
+			pr_info("NUMA: can't set up %d nodes for NUMA (MAX_NUMNODES = %d)\n",
+				num_nodes, MAX_NUMNODES);
+			return -EINVAL;
+		}
+
+		/*
+		 * If a comma was specified after the number of nodes then subsequent
+		 * numbers should be regarded as memory sizes for each node for as
+		 * many nodes as are supplied.
+		 */
+		if (optres == 2)
+			memcmdline = p;
+
+		if (strstr(p, "usetopology")) {
+			numa_use_topology = 1;
+			pr_info("NUMA: using CPU topology to assign nodes.\n");
+		} else
+			pr_info("NUMA: NOT using CPU topology.\n");
+	}
+
+	return 0;
+}
+early_param("numa", early_numa);
+
+#endif /* CONFIG_NUMA */
-- 
1.7.9.5
