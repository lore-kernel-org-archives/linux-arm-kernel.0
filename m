From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 5 Sep 2016 19:30:22 +0800
Subject: [PATCH v2] arm64: mm: drop fixup_init() and mm.h
In-Reply-To: <20160905095239.GA6826@leverpostej>
References: <20160905095239.GA6826@leverpostej>
Message-ID: <1473075022-32287-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only fixup_init() in mm.h , and it is only called
in free_initmem(), so move the codes from fixup_init() into
free_initmem(), then drop fixup_init() and mm.h.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

v1->v2:
1) Add missing include <linux/vmalloc.h> for unmap_kernel_range(),
   suggested-by Mark Rutland.
2) Add Mark's acked-by.

 arch/arm64/mm/flush.c |  2 --
 arch/arm64/mm/init.c  | 10 +++++++---
 arch/arm64/mm/mm.h    |  2 --
 arch/arm64/mm/mmu.c   | 12 ------------
 arch/arm64/mm/pgd.c   |  2 --
 5 files changed, 7 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm64/mm/mm.h

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 43a76b0..8377329 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -25,8 +25,6 @@
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
 
-#include "mm.h"
-
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end)
 {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bbb7ee7..896932e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -34,6 +34,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
+#include <linux/vmalloc.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -47,8 +48,6 @@
 #include <asm/tlb.h>
 #include <asm/alternative.h>
 
-#include "mm.h"
-
 /*
  * We need to be able to catch inadvertent references to memstart_addr
  * that occur (potentially in generic code) before arm64_memblock_init()
@@ -485,7 +484,12 @@ void free_initmem(void)
 {
 	free_reserved_area(__va(__pa(__init_begin)), __va(__pa(__init_end)),
 			   0, "unused kernel");
-	fixup_init();
+	/*
+	 * Unmap the __init region but leave the VM area in place. This
+	 * prevents the region from being reused for kernel modules, which
+	 * is not supported by kallsyms.
+	 */
+	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
deleted file mode 100644
index 71fe989..0000000
--- a/arch/arm64/mm/mm.h
+++ /dev/null
@@ -1,2 +0,0 @@
-
-void fixup_init(void);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4989948..88f15c8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,8 +42,6 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 
-#include "mm.h"
-
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 
 u64 kimage_voffset __read_mostly;
@@ -399,16 +397,6 @@ void mark_rodata_ro(void)
 			    section_size, PAGE_KERNEL_RO);
 }
 
-void fixup_init(void)
-{
-	/*
-	 * Unmap the __init region but leave the VM area in place. This
-	 * prevents the region from being reused for kernel modules, which
-	 * is not supported by kallsyms.
-	 */
-	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
-}
-
 static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
 				      pgprot_t prot, struct vm_struct *vma)
 {
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index ae11d4e..371c5f0 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -26,8 +26,6 @@
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 
-#include "mm.h"
-
 static struct kmem_cache *pgd_cache;
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
-- 
1.7.12.4
