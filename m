From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:00 +0800
Subject: [PATCH v8 09/16] arm64/numa: support HAVE_SETUP_PER_CPU_AREA
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-10-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make each percpu area allocated from its local numa node. Without this
patch, all percpu areas will be allocated from the node which cpu0 belongs
to.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/Kconfig   |  8 ++++++++
 arch/arm64/mm/numa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..2815af6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -603,6 +603,14 @@ config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA

+config HAVE_SETUP_PER_CPU_AREA
+	def_bool y
+	depends on NUMA
+
+config NEED_PER_CPU_EMBED_FIRST_CHUNK
+	def_bool y
+	depends on NUMA
+
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 0e75b53..087064d 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>

 #include <asm/acpi.h>
+#include <asm/sections.h>

 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
@@ -131,6 +132,57 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 	cpu_to_node_map[cpu] = nid;
 }

+#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
+unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(__per_cpu_offset);
+
+static int __init early_cpu_to_node(int cpu)
+{
+	return cpu_to_node_map[cpu];
+}
+
+static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
+{
+	return node_distance(from, to);
+}
+
+static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
+				       size_t align)
+{
+	int nid = early_cpu_to_node(cpu);
+
+	return  memblock_virt_alloc_try_nid(size, align,
+			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+}
+
+static void __init pcpu_fc_free(void *ptr, size_t size)
+{
+	memblock_free_early(__pa(ptr), size);
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long delta;
+	unsigned int cpu;
+	int rc;
+
+	/*
+	 * Always reserve area for module percpu variables.  That's
+	 * what the legacy allocator did.
+	 */
+	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
+				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
+				    pcpu_cpu_distance,
+				    pcpu_fc_alloc, pcpu_fc_free);
+	if (rc < 0)
+		panic("Failed to initialize percpu areas.");
+
+	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
+	for_each_possible_cpu(cpu)
+		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
+}
+#endif
+
 /**
  * numa_add_memblk - Set node id to memblk
  * @nid: NUMA node ID of the new memblk
--
2.5.0
