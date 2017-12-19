From: labbott@redhat.com (Laura Abbott)
Date: Tue, 19 Dec 2017 11:28:10 -0800
Subject: [PATCH] arm64: Stop printing the virtual memory layout
Message-ID: <20171219192810.22537-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing kernel addresses should be done in limited circumstances, mostly
for debugging purposes. Printing out the virtual memory layout at every
kernel bootup doesn't really fall into this category so delete the prints.
There are other ways to get the same information.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Follow up to my previous proposal to switch all these to %px
---
 arch/arm64/mm/init.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5960bef0170d..672094ed7e07 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -599,49 +599,6 @@ void __init mem_init(void)
 
 	mem_init_print_info(NULL);
 
-#define MLK(b, t) b, t, ((t) - (b)) >> 10
-#define MLM(b, t) b, t, ((t) - (b)) >> 20
-#define MLG(b, t) b, t, ((t) - (b)) >> 30
-#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
-
-	pr_notice("Virtual kernel memory layout:\n");
-#ifdef CONFIG_KASAN
-	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
-		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
-#endif
-	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
-		MLM(MODULES_VADDR, MODULES_END));
-	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
-		MLG(VMALLOC_START, VMALLOC_END));
-	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-		MLK_ROUNDUP(_text, _etext));
-	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-		MLK_ROUNDUP(__start_rodata, __init_begin));
-	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-		MLK_ROUNDUP(__init_begin, __init_end));
-	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-		MLK_ROUNDUP(_sdata, _edata));
-	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-		MLK_ROUNDUP(__bss_start, __bss_stop));
-	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
-		MLK(FIXADDR_START, FIXADDR_TOP));
-	pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
-		MLM(PCI_IO_START, PCI_IO_END));
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-	pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
-		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
-	pr_notice("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
-		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
-		    (unsigned long)virt_to_page(high_memory)));
-#endif
-	pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
-		MLM(__phys_to_virt(memblock_start_of_DRAM()),
-		    (unsigned long)high_memory));
-
-#undef MLK
-#undef MLM
-#undef MLK_ROUNDUP
-
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
 	 * detected at build time already.
-- 
2.14.3
