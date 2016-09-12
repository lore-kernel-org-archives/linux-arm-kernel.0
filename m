From: labbott@redhat.com (Laura Abbott)
Date: Mon, 12 Sep 2016 14:32:55 -0700
Subject: [RFCv3][PATCH 2/5] arm: Impelment ARCH_HAS_FORCE_CACHE
In-Reply-To: <1473715978-11633-1-git-send-email-labbott@redhat.com>
References: <1473715978-11633-1-git-send-email-labbott@redhat.com>
Message-ID: <1473715978-11633-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


arm64 may need to guarantee the caches are synced. Implement
versions of the kernel_force_cache API for v7. Other versions
are stubbed out and can be added as appropriate.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Switch to force implementations per CPU instead of relying
on dma_map/dma_unmap. v7 is the only one implemented right
now, others can be added as needed.
---
 arch/arm/include/asm/cacheflush.h | 11 ++++++
 arch/arm/include/asm/glue-cache.h |  2 ++
 arch/arm/mm/Makefile              |  2 +-
 arch/arm/mm/cache-fa.S            |  8 +++++
 arch/arm/mm/cache-nop.S           |  6 ++++
 arch/arm/mm/cache-v4.S            | 10 ++++++
 arch/arm/mm/cache-v4wb.S          |  8 +++++
 arch/arm/mm/cache-v4wt.S          |  8 +++++
 arch/arm/mm/cache-v6.S            |  8 +++++
 arch/arm/mm/cache-v7.S            | 13 +++++++
 arch/arm/mm/cacheflush.c          | 71 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-arm920.S         |  8 +++++
 arch/arm/mm/proc-arm922.S         |  8 +++++
 arch/arm/mm/proc-arm925.S         |  8 +++++
 arch/arm/mm/proc-arm926.S         |  8 +++++
 arch/arm/mm/proc-feroceon.S       | 11 ++++++
 arch/arm/mm/proc-macros.S         |  2 ++
 arch/arm/mm/proc-xsc3.S           |  9 +++++
 arch/arm/mm/proc-xscale.S         |  9 +++++
 19 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mm/cacheflush.c

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 9156fc3..2d9a4d3 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -116,6 +116,9 @@ struct cpu_cache_fns {
 	void (*dma_unmap_area)(const void *, size_t, int);
 
 	void (*dma_flush_range)(const void *, const void *);
+
+	void (*force_dcache_clean)(void *, size_t);
+	void (*force_dcache_invalidate)(void *, size_t);
 };
 
 /*
@@ -133,6 +136,8 @@ extern struct cpu_cache_fns cpu_cache;
 #define __cpuc_coherent_kern_range	cpu_cache.coherent_kern_range
 #define __cpuc_coherent_user_range	cpu_cache.coherent_user_range
 #define __cpuc_flush_dcache_area	cpu_cache.flush_kern_dcache_area
+#define __cpuc_force_dcache_clean	cpu_cache.force_dcache_clean
+#define __cpuc_force_dcache_invalidate	cpu_cache.force_dcache_invalidate
 
 /*
  * These are private to the dma-mapping API.  Do not use directly.
@@ -152,6 +157,8 @@ extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned int);
 extern void __cpuc_coherent_kern_range(unsigned long, unsigned long);
 extern int  __cpuc_coherent_user_range(unsigned long, unsigned long);
 extern void __cpuc_flush_dcache_area(void *, size_t);
+extern void __cpuc_force_dcache_clean(void *, size_t);
+extern void __cpuc_force_dcache_invalidate(void *, size_t);
 
 /*
  * These are private to the dma-mapping API.  Do not use directly.
@@ -518,4 +525,8 @@ static inline void secure_flush_area(const void *addr, size_t size)
 	outer_flush_range(phys, phys + size);
 }
 
+#define ARCH_HAS_FORCE_CACHE 1
+void kernel_force_cache_clean(struct page *page, size_t size);
+void kernel_force_cache_invalidate(struct page *page, size_t size);
+
 #endif
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index cab07f6..232938f 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -157,6 +157,8 @@ static inline void nop_dma_unmap_area(const void *s, size_t l, int f) { }
 #define __cpuc_coherent_kern_range	__glue(_CACHE,_coherent_kern_range)
 #define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
 #define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
+#define __cpuc_force_dcache_clean	__glue(_CACHE,_force_dcache_clean)
+#define __cpuc_force_dcache_invalidate	__glue(_CACHE,_force_dcache_invalidate)
 
 #define dmac_flush_range		__glue(_CACHE,_dma_flush_range)
 #endif
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7f76d96..3afcdd0 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
-				   iomap.o
+				   iomap.o cacheflush.o
 
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
 				   mmap.o pgd.o mmu.o pageattr.o
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 2f0c588..f1fe5df 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -244,6 +244,14 @@ ENDPROC(fa_dma_unmap_area)
 	.globl	fa_flush_kern_cache_louis
 	.equ	fa_flush_kern_cache_louis, fa_flush_kern_cache_all
 
+ENTRY(fa_force_dcache_invalidate)
+	ret     lr
+ENDPROC(fa_force_dcache_invalidate)
+
+ENTRY(fa_force_dcache_clean)
+	ret     lr
+ENDPROC(fa_force_dcache_clean)
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-nop.S b/arch/arm/mm/cache-nop.S
index f1cc986..983f96f 100644
--- a/arch/arm/mm/cache-nop.S
+++ b/arch/arm/mm/cache-nop.S
@@ -45,6 +45,12 @@ ENDPROC(nop_coherent_user_range)
 	.globl nop_dma_unmap_area
 	.equ nop_dma_unmap_area, nop_flush_icache_all
 
+	.globl nop_force_dcache_clean
+	.equ nop_force_dcache_clean, nop_flush_icache_all
+
+	.globl nop_force_dcache_invalidate
+	.equ nop_force_dcache_invalidate, nop_flush_icache_all
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 91e3adf..db07995 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -144,6 +144,16 @@ ENDPROC(v4_dma_map_area)
 	.globl	v4_flush_kern_cache_louis
 	.equ	v4_flush_kern_cache_louis, v4_flush_kern_cache_all
 
+
+ENTRY(v4_force_dcache_invalidate)
+	ret     lr
+ENDPROC(v4_force_dcache_invalidate)
+
+ENTRY(v4_force_dcache_clean)
+	ret     lr
+ENDPROC(v4_force_dcache_clean)
+
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 2522f8c..897f333 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -255,6 +255,14 @@ ENDPROC(v4wb_dma_unmap_area)
 	.globl	v4wb_flush_kern_cache_louis
 	.equ	v4wb_flush_kern_cache_louis, v4wb_flush_kern_cache_all
 
+ENTRY(v4wb_force_dcache_invalidate)
+        ret     lr
+ENDPROC(v4wb_force_dcache_invalidate)
+
+ENTRY(v4wb_force_dcache_clean)
+        ret     lr
+ENDPROC(v4wb_force_dcache_clean)
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v4wt.S b/arch/arm/mm/cache-v4wt.S
index a0982ce..2e77e4a 100644
--- a/arch/arm/mm/cache-v4wt.S
+++ b/arch/arm/mm/cache-v4wt.S
@@ -200,6 +200,14 @@ ENDPROC(v4wt_dma_map_area)
 	.globl	v4wt_flush_kern_cache_louis
 	.equ	v4wt_flush_kern_cache_louis, v4wt_flush_kern_cache_all
 
+ENTRY(v4wt_force_dcache_invalidate)
+	ret     lr
+ENDPROC(v4wt_force_dcache_invalidate)
+
+ENTRY(v4wt_force_dcache_clean)
+	ret     lr
+ENDPROC(v4wt_force_dcache_clean)
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 2465995..4911634 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -333,3 +333,11 @@ ENDPROC(v6_dma_unmap_area)
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions v6
+
+ENTRY(v6_force_dcache_invalidate)
+	ret     lr
+ENDPROC(v6_force_dcache_invalidate)
+
+ENTRY(v6_force_dcache_clean)
+	ret     lr
+ENDPROC(v6_force_dcache_clean)
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a134d8a..2750b27 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -442,6 +442,19 @@ ENTRY(v7_dma_unmap_area)
 	ret	lr
 ENDPROC(v7_dma_unmap_area)
 
+
+ENTRY(v7_force_dcache_invalidate)
+	add	r1, r1, r0
+	b	v7_dma_inv_range
+	ret	lr
+ENDPROC(v7_force_dcache_invalidate)
+
+ENTRY(v7_force_dcache_clean)
+	add	r1, r1, r0
+	b	v7_dma_clean_range
+	ret	lr
+ENDPROC(v7_force_dcache_clean)
+
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
diff --git a/arch/arm/mm/cacheflush.c b/arch/arm/mm/cacheflush.c
new file mode 100644
index 0000000..5daa98e
--- /dev/null
+++ b/arch/arm/mm/cacheflush.c
@@ -0,0 +1,71 @@
+/*
+ *  Based on arch/arm/mm/dma-mapping.c which is
+ *  Copyright (C) 2000-2004 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+
+#include <asm/highmem.h>
+#include <asm/cacheflush.h>
+
+static void __force_cache_op(struct page *page, size_t size,
+				void (*op)(void *start, size_t size))
+{
+	unsigned long pfn;
+	size_t left = size;
+
+	pfn = page_to_pfn(page);
+
+	do {
+		size_t len = left;
+		void *vaddr;
+
+		page = pfn_to_page(pfn);
+
+		if (PageHighMem(page)) {
+			if (len > PAGE_SIZE)
+				len = PAGE_SIZE;
+			if (cache_is_vipt_nonaliasing()) {
+				vaddr = kmap_atomic(page);
+				op(vaddr, len);
+				kunmap_atomic(vaddr);
+			} else {
+				vaddr = kmap_high_get(page);
+				if (vaddr) {
+					op(vaddr, len);
+					kunmap_high(page);
+				}
+			}
+		} else {
+
+			op(page_address(page), len);
+		}
+		pfn++;
+		left -= len;
+	} while(left);
+}
+
+void kernel_force_cache_clean(struct page *page, size_t size)
+{
+	phys_addr_t paddr;
+
+	paddr = page_to_phys(page);
+	__force_cache_op(page, size, __cpuc_force_dcache_clean);
+	outer_clean_range(paddr, paddr + size);
+}
+
+void kernel_force_cache_invalidate(struct page *page, size_t size)
+{
+	phys_addr_t paddr;
+
+	paddr = page_to_phys(page);
+	__force_cache_op(page, size, __cpuc_force_dcache_invalidate);
+	outer_inv_range(paddr, paddr + size);
+}
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 7a14bd4..ead3060 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -334,6 +334,14 @@ ENTRY(cpu_arm920_dcache_clean_area)
 	bhi	1b
 	ret	lr
 
+ENTRY(arm920_force_dcache_invalidate)
+	ret     lr
+ENDPROC(arm920_force_dcache_invalidate)
+
+ENTRY(arm920_force_dcache_clean)
+	ret     lr
+ENDPROC(arm920_force_dcache_clean)
+
 /* =============================== PageTable ============================== */
 
 /*
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index edccfcd..4645a98 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -338,6 +338,14 @@ ENTRY(cpu_arm922_dcache_clean_area)
 #endif
 	ret	lr
 
+ENTRY(arm922_force_dcache_invalidate)
+        ret     lr
+ENDPROC(arm922_force_dcache_invalidate)
+
+ENTRY(arm922_force_dcache_clean)
+        ret     lr
+ENDPROC(arm922_force_dcache_clean)
+
 /* =============================== PageTable ============================== */
 
 /*
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 32a47cc..866d623 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -392,6 +392,14 @@ ENTRY(cpu_arm925_dcache_clean_area)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	ret	lr
 
+ENTRY(arm925_force_dcache_invalidate)
+	ret     lr
+ENDPROC(arm925_force_dcache_invalidate)
+
+ENTRY(arm925_force_dcache_clean)
+	ret     lr
+ENDPROC(arm925_force_dcache_clean)
+
 /* =============================== PageTable ============================== */
 
 /*
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index fb827c6..2257b00 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -355,6 +355,14 @@ ENTRY(cpu_arm926_dcache_clean_area)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	ret	lr
 
+ENTRY(arm926_force_dcache_invalidate)
+        ret     lr
+ENDPROC(arm926_force_dcache_invalidate)
+
+ENTRY(arm926_force_dcache_clean)
+        ret     lr
+ENDPROC(arm926_force_dcache_clean)
+
 /* =============================== PageTable ============================== */
 
 /*
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 92e08bf..fca0e42 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -439,6 +439,8 @@ ENDPROC(feroceon_dma_unmap_area)
 	range_alias coherent_kern_range
 	range_alias coherent_user_range
 	range_alias dma_unmap_area
+	range_alias force_dcache_clean
+	range_alias force_dcache_invalidate
 
 	define_cache_functions feroceon_range
 
@@ -463,6 +465,15 @@ ENTRY(cpu_feroceon_dcache_clean_area)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	ret	lr
 
+ENTRY(feroceon_force_dcache_invalidate)
+        ret     lr
+ENDPROC(feroceon_force_dcache_invalidate)
+
+ENTRY(feroceon_force_dcache_clean)
+        ret     lr
+ENDPROC(feroceon_force_dcache_clean)
+
+
 /* =============================== PageTable ============================== */
 
 /*
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index c671f34..cc2d6cf 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -310,6 +310,8 @@ ENTRY(\name\()_cache_fns)
 	.long	\name\()_dma_map_area
 	.long	\name\()_dma_unmap_area
 	.long	\name\()_dma_flush_range
+	.long	\name\()_force_dcache_clean
+	.long	\name\()_force_dcache_invalidate
 	.size	\name\()_cache_fns, . - \name\()_cache_fns
 .endm
 
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 293dcc2..924d304 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -343,6 +343,15 @@ ENDPROC(xsc3_dma_unmap_area)
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions xsc3
 
+ENTRY(xsc3_force_dcache_clean)
+	ret	lr
+ENDPROC(xsc3_force_dcache_clean)
+
+ENTRY(xsc3_force_dcache_invalidate)
+	ret	lr
+ENDPROC(xsc3_force_dcache_invalidate)
+
+
 ENTRY(cpu_xsc3_dcache_clean_area)
 1:	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
 	add	r0, r0, #CACHELINESIZE
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index b6bbfdb..a8f4c74 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -449,6 +449,8 @@ ENDPROC(xscale_dma_unmap_area)
 	a0_alias flush_kern_dcache_area
 	a0_alias dma_flush_range
 	a0_alias dma_unmap_area
+	a0_alias force_dcache_clean
+	a0_alias force_dcache_invalidate
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions xscale_80200_A0_A1
@@ -460,6 +462,13 @@ ENTRY(cpu_xscale_dcache_clean_area)
 	bhi	1b
 	ret	lr
 
+ENTRY(xscale_force_dcache_invalidate)
+	ret     lr
+ENDPROC(xscale_force_dcache_invalidate)
+
+ENTRY(xscale_force_dcache_clean)
+	ret     lr
+ENDPROC(xscale_force_dcache_clean)
 /* =============================== PageTable ============================== */
 
 /*
-- 
2.7.4
