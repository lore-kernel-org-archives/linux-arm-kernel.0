From: steve.capper@arm.com (Steve Capper)
Date: Wed, 12 Dec 2012 17:40:47 +0000
Subject: [RFC PATCH 1/3] ARM: mm: Add discontiguous memory support.
In-Reply-To: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
References: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
Message-ID: <1355334049-10247-2-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for discontiguous memory, with a view to
each discontiguous block being assigned to a NUMA node (in a future
patch).

Discontiguous memory should only be used to back NUMA on systems
where sparse memory is not available.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig              |   15 +++++++++++++
 arch/arm/include/asm/mmzone.h |   37 ++++++++++++++++++++++++++++++
 arch/arm/mm/Makefile          |    2 ++
 arch/arm/mm/init.c            |    9 ++++++++
 arch/arm/mm/numa.c            |   50 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+)
 create mode 100644 arch/arm/include/asm/mmzone.h
 create mode 100644 arch/arm/mm/numa.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9759fec..9846d89 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1159,8 +1159,23 @@ config ARM_TIMER_SP804
 	select CLKSRC_MMIO
 	select HAVE_SCHED_CLOCK
 
+config ARCH_FLATMEM_ENABLE
+	bool
+	depends on MMU
+	default y
+
+config ARCH_DISCONTIGMEM_ENABLE
+	bool
+	depends on MMU
+	default y
+
 source arch/arm/mm/Kconfig
 
+config NUMA_ALLOC_NODES
+	bool
+	depends on DISCONTIGMEM
+	default y
+
 config ARM_NR_BANKS
 	int
 	default 16 if ARCH_EP93XX
diff --git a/arch/arm/include/asm/mmzone.h b/arch/arm/include/asm/mmzone.h
new file mode 100644
index 0000000..f6d7337
--- /dev/null
+++ b/arch/arm/include/asm/mmzone.h
@@ -0,0 +1,37 @@
+/*
+ * Discontiguous memory and NUMA support, based on the PowerPC implementation.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef __ASM_ARM_MMZONE_H_
+#define __ASM_ARM_MMZONE_H_
+#ifdef __KERNEL__
+
+#include <linux/cpumask.h>
+
+#ifdef CONFIG_NUMA_ALLOC_NODES
+#define NODE_DATA(nid)		(node_data[nid])
+extern void __init arm_numa_alloc_nodes(unsigned long max_low);
+extern struct pglist_data *node_data[];
+#else
+#define arm_numa_alloc_nodes(_mlow)	do {} while (0)
+#endif
+
+#define	pfn_to_nid(pfn)		(0)
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_ARM_MMZONE_H_ */
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 8a9c4cb..57a7055 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -96,3 +96,5 @@ obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
+
+obj-$(CONFIG_NUMA_ALLOC_NODES)	+= numa.o
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index abe4eae..98488ee 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -33,6 +33,7 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mmzone.h>
 
 #include "mm.h"
 
@@ -178,6 +179,12 @@ static void __init arm_bootmem_init(unsigned long start_pfn,
 	pg_data_t *pgdat;
 
 	/*
+	 * If we have NUMA or discontiguous memory, allocate the required
+	 * nodes by reserving memblocks.
+	 */
+	arm_numa_alloc_nodes(end_pfn);
+
+	/*
 	 * Allocate the bootmem bitmap page.  This must be in a region
 	 * of memory which has already been mapped.
 	 */
@@ -620,7 +627,9 @@ void __init mem_init(void)
 	extern u32 itcm_end;
 #endif
 
+#ifdef CONFIG_FLATMEM
 	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
+#endif
 
 	/* this will put all unused low memory onto the freelists */
 	free_unused_memmap(&meminfo);
diff --git a/arch/arm/mm/numa.c b/arch/arm/mm/numa.c
new file mode 100644
index 0000000..5141134
--- /dev/null
+++ b/arch/arm/mm/numa.c
@@ -0,0 +1,50 @@
+/*
+ * Discontiguous memory and NUMA support, based on the PowerPC implementation.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/export.h>
+#include <linux/nodemask.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/node.h>
+#include <linux/cpu.h>
+#include <linux/memblock.h>
+
+#include <asm/string.h>
+#include <asm/mmzone.h>
+#include <asm/setup.h>
+
+struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
+
+static unsigned int numa_node_count = 1;
+
+void __init arm_numa_alloc_nodes(unsigned long max_low)
+{
+	int node;
+
+	for (node = 0; node < numa_node_count; node++) {
+		phys_addr_t pa = memblock_alloc_base(sizeof(pg_data_t),
+				L1_CACHE_BYTES, __pfn_to_phys(max_low));
+
+		NODE_DATA(node) = __va(pa);
+		memset(NODE_DATA(node), 0, sizeof(pg_data_t));
+		NODE_DATA(node)->bdata = &bootmem_node_data[node];
+	}
+}
-- 
1.7.9.5
