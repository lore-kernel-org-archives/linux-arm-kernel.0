From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Tue, 11 Apr 2017 15:54:37 +0100
Subject: [PATCH 1/5] arm64: memory-hotplug: Add MEMORY_HOTPLUG,
 MEMORY_HOTREMOVE, MEMORY_PROBE
In-Reply-To: <cover.1491920513.git.ar@linux.vnet.ibm.com>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
Message-ID: <2edd1a6b64ea9b4c9b8126d840844d624fe8e0d4.1491920513.git.ar@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Branden <scott.branden@broadcom.com>

Add memory-hotplug support for ARM64 platform.

This requires addition of
ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE config options.

MEMORY_PROBE config option is added to support
/sys/devices/system/memory/probe functionality.

In addition architecture specific arch_add_memory and
arch_remove memory management functions are added.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/Kconfig   | 10 ++++++++++
 arch/arm64/mm/init.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3741859..d930f73 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -620,6 +620,12 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
@@ -694,6 +700,10 @@ config ARCH_HAS_CACHE_LINE_SIZE
 
 source "mm/Kconfig"
 
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e19e065..4dcb8f7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -541,3 +541,45 @@ static int __init register_mem_limit_dumper(void)
 	return 0;
 }
 __initcall(register_mem_limit_dumper);
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
+{
+	pg_data_t *pgdat;
+	struct zone *zone;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int ret;
+
+	pgdat = NODE_DATA(nid);
+
+	zone = pgdat->node_zones +
+		zone_for_memory(nid, start, size, ZONE_NORMAL, for_device);
+	ret = __add_pages(nid, zone, start_pfn, nr_pages);
+
+	if (ret)
+		pr_warn("%s: Problem encountered in __add_pages() ret=%d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+int arch_remove_memory(u64 start, u64 size)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone;
+	int ret;
+
+	zone = page_zone(pfn_to_page(start_pfn));
+	ret = __remove_pages(zone, start_pfn, nr_pages);
+	if (ret)
+		pr_warn("%s: Problem encountered in __remove_pages() ret=%d\n",
+			__func__, ret);
+
+	return ret;
+}
+#endif
+#endif
+
-- 
1.9.1
