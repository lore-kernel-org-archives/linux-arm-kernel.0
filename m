From: miles.chen@mediatek.com (Miles Chen)
Date: Mon, 7 Aug 2017 19:04:46 +0800
Subject: [PATCH] arm64: correct modules range of kernel virtual memory layout
Message-ID: <1502103886-19725-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit f80fb3a3d508 ("arm64: add support for kernel ASLR")
moved module virtual address to
[module_alloc_base, module_alloc_base + MODULES_VSIZE).

Display module information of the virtual kernel
memory layout by using module_alloc_base.

testing output:
1) Current implementation:
Virtual kernel memory layout:
	modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
2) this patch + KASLR:
Virtual kernel memory layout:
	modules : 0xffffff8000560000 - 0xffffff8008560000   (   128 MB)
3) this patch + KASLR and a dummy seed:
Virtual kernel memory layout:
	modules : 0xffffffa7df637000 - 0xffffffa7e7637000   (   128 MB)

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5960bef..57a11d5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -52,6 +52,7 @@
 #include <asm/sizes.h>
 #include <asm/tlb.h>
 #include <asm/alternative.h>
+#include <asm/module.h>
 
 /*
  * We need to be able to catch inadvertent references to memstart_addr
@@ -609,8 +610,8 @@ void __init mem_init(void)
 	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
 #endif
-	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
-		MLM(MODULES_VADDR, MODULES_END));
+	pr_notice("    modules : 0x%16llx - 0x%16llx   (%6lld MB)\n",
+		MLM(module_alloc_base, module_alloc_base + MODULES_VSIZE));
 	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
 	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
-- 
1.9.1
