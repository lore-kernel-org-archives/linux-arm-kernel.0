From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 14 Jan 2010 11:36:06 +0100
Subject: [PATCH 1/5] Add "virtual kernel memory..." printout.
In-Reply-To: <1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code based on parisc and x86_32.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/mm/init.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a04ffbb..29d5866 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -23,6 +23,7 @@
 #include <asm/setup.h>
 #include <asm/sizes.h>
 #include <asm/tlb.h>
+#include <asm/fixmap.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -560,7 +561,7 @@ static void __init free_unused_memmap_node(int node, struct meminfo *mi)
  */
 void __init mem_init(void)
 {
-	unsigned int codesize, datasize, initsize;
+	unsigned long reserved_pages, free_pages;
 	int i, node;
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -596,6 +597,33 @@ void __init mem_init(void)
 	totalram_pages += totalhigh_pages;
 #endif
 
+	reserved_pages = free_pages = 0;
+
+	for_each_online_node(node) {
+		pg_data_t *n = NODE_DATA(node);
+		struct page *map = pgdat_page_nr(n, 0) - n->node_start_pfn;
+
+		for_each_nodebank(i, &meminfo, node) {
+			struct membank *bank = &meminfo.bank[i];
+			unsigned int pfn1, pfn2;
+			struct page *page, *end;
+
+			pfn1 = bank_pfn_start(bank);
+			pfn2 = bank_pfn_end(bank);
+
+			page = map + pfn1;
+			end  = map + pfn2;
+
+			do {
+				if (PageReserved(page))
+					reserved_pages++;
+				else if (!page_count(page))
+					free_pages++;
+				page++;
+			} while (page < end);
+		}
+	}
+
 	/*
 	 * Since our memory may not be contiguous, calculate the
 	 * real number of pages we have in this system
@@ -608,16 +636,48 @@ void __init mem_init(void)
 	}
 	printk(" = %luMB total\n", num_physpages >> (20 - PAGE_SHIFT));
 
-	codesize = _etext - _text;
-	datasize = _end - _data;
-	initsize = __init_end - __init_begin;
-
-	printk(KERN_NOTICE "Memory: %luKB available (%dK code, "
-		"%dK data, %dK init, %luK highmem)\n",
-		nr_free_pages() << (PAGE_SHIFT-10), codesize >> 10,
-		datasize >> 10, initsize >> 10,
+	printk(KERN_NOTICE "Memory: %luk/%luk available, %luk reserved, %luK highmem\n",
+		nr_free_pages() << (PAGE_SHIFT-10),
+		free_pages << (PAGE_SHIFT-10),
+		reserved_pages << (PAGE_SHIFT-10),
 		totalhigh_pages << (PAGE_SHIFT-10));
 
+#define MLK(b, t) b, t, ((t) - (b)) >> 10
+#define MLM(b, t) b, t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+
+	printk(KERN_NOTICE "virtual kernel memory layout:\n"
+			"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#ifdef CONFIG_HIGHMEM
+			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
+			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
+			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
+			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n",
+
+			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
+				(PAGE_SIZE)),
+			MLK(FIXADDR_START, FIXADDR_TOP),
+			MLM(VMALLOC_START, (unsigned long)VMALLOC_END),
+			MLM(PAGE_SIZE, (unsigned long)high_memory),
+#ifdef CONFIG_HIGHMEM
+			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
+				(PAGE_SIZE)),
+#endif
+			MLM(MODULES_VADDR, MODULES_END),
+
+			MLK_ROUNDUP(__init_begin, __init_end),
+			MLK_ROUNDUP(_text, _etext),
+			MLK_ROUNDUP(_data, _edata));
+
+#undef MLK
+#undef MLM
+#undef MLK_ROUNDUP
+
 	if (PAGE_SIZE >= 16384 && num_physpages <= 128) {
 		extern int sysctl_overcommit_memory;
 		/*
-- 
1.6.6
