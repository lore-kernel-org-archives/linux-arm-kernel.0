From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri,  5 Oct 2018 10:16:38 -0600
Subject: [PATCH 1/5] mm/sparse: add common helper to mark all memblocks present
In-Reply-To: <20181005161642.2462-1-logang@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
Message-ID: <20181005161642.2462-2-logang@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Presently the arches arm64, arm, sh have a function which loops through
each memblock and calls memory present. riscv will require a similar
function.

Introduce a common memblocks_present() function that can be used by
all the arches. Subsequent patches will cleanup the arches that
make use of this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mmzone.h |  6 ++++++
 mm/sparse.c            | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1e22d96734e0..a10fc3c18b07 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -794,6 +794,12 @@ void memory_present(int nid, unsigned long start, unsigned long end);
 static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
 #endif
 
+#if defined(CONFIG_SPARSEMEM) && defined(CONFIG_HAVE_MEMBLOCK)
+void memblocks_present(void);
+#else
+static inline void memblocks_present(void) {}
+#endif
+
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..109159574208 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/mmzone.h>
+#include <linux/memblock.h>
 #include <linux/bootmem.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
@@ -238,6 +239,20 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 	}
 }
 
+#ifdef CONFIG_HAVE_MEMBLOCK
+void __init memblocks_present(void)
+{
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		int nid = memblock_get_region_node(reg);
+
+		memory_present(nid, memblock_region_memory_base_pfn(reg),
+			       memblock_region_memory_end_pfn(reg));
+	}
+}
+#endif
+
 /*
  * Subtle, we encode the real pfn into the mem_map such that
  * the identity pfn - section_mem_map will return the actual
-- 
2.19.0
