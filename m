From: scott.branden@broadcom.com (Scott Branden)
Date: Thu,  1 Dec 2016 16:19:58 -0800
Subject: [RFC PATCH 1/2] arm64: memory-hotplug: Add MEMORY_HOTPLUG,
 MEMORY_HOTREMOVE, MEMORY_PROBE
In-Reply-To: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
References: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1480637999-4320-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
index 969ef88..2482fdd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -576,6 +576,12 @@ config HOTPLUG_CPU
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
@@ -646,6 +652,10 @@ config ARCH_HAS_CACHE_LINE_SIZE
 
 source "mm/Kconfig"
 
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 212c4d1..687d087 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -536,3 +536,45 @@ static int __init register_mem_limit_dumper(void)
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
2.5.0
