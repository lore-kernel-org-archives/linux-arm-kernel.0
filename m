From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Mar 2010 12:19:07 +0200
Subject: [PATCH] ARM: sort the memory layout report by address
Message-ID: <06dbc8f0e15bf48be70cd43ee6a5ab78b82711a8.1268734689.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put the pkmap and the modules lines at the end of the list since they reside
lower than the kernel text in virtual memory address space.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mm/init.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7829cb5..876f814 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -656,13 +656,13 @@ void __init mem_init(void)
 #endif
 			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
+			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
+			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n"
 #ifdef CONFIG_HIGHMEM
 			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
-			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
-			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
-			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n",
+			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n",
 
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
@@ -672,15 +672,15 @@ void __init mem_init(void)
 #endif
 			MLM(VMALLOC_START, VMALLOC_END),
 			MLM(PAGE_OFFSET, (unsigned long)high_memory),
+
+			MLK_ROUNDUP(__init_begin, __init_end),
+			MLK_ROUNDUP(_text, _etext),
+			MLK_ROUNDUP(_data, _edata),
 #ifdef CONFIG_HIGHMEM
 			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
 				(PAGE_SIZE)),
 #endif
-			MLM(MODULES_VADDR, MODULES_END),
-
-			MLK_ROUNDUP(__init_begin, __init_end),
-			MLK_ROUNDUP(_text, _etext),
-			MLK_ROUNDUP(_data, _edata));
+			MLM(MODULES_VADDR, MODULES_END));
 
 #undef MLK
 #undef MLM
-- 
1.7.0
