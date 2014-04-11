From: dave.long@linaro.org (David Long)
Date: Thu, 10 Apr 2014 23:45:31 -0400
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper cache
 flushing
In-Reply-To: <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
 <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
Message-ID: <5347655B.3080307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace memcpy and dcache flush in generic uprobes with a call to
copy_to_user_page(), which will do a proper flushing of kernel and
user cache.  Also modify the inmplementation of copy_to_user_page
to assume a NULL vma pointer means the user icache corresponding
to this right is stale and needs to be flushed.  Note that this patch
does not fix copy_to_user page for the sh, alpha, sparc, or mips
architectures (which do not currently support uprobes).

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arc/include/asm/cacheflush.h        | 2 +-
 arch/arm/mm/flush.c                      | 4 ++--
 arch/arm64/mm/flush.c                    | 2 +-
 arch/avr32/mm/cache.c                    | 2 +-
 arch/hexagon/include/asm/cacheflush.h    | 2 +-
 arch/m68k/include/asm/cacheflush_mm.h    | 2 +-
 arch/microblaze/include/asm/cacheflush.h | 2 +-
 arch/mips/mm/init.c                      | 2 +-
 arch/parisc/include/asm/tlbflush.h       | 4 ++++
 arch/parisc/kernel/cache.c               | 4 ++--
 arch/score/include/asm/cacheflush.h      | 2 +-
 arch/score/mm/cache.c                    | 2 +-
 arch/sh/mm/cache.c                       | 2 +-
 arch/sparc/mm/leon_mm.c                  | 2 +-
 arch/tile/include/asm/cacheflush.h       | 2 +-
 arch/unicore32/mm/flush.c                | 2 +-
 arch/xtensa/mm/cache.c                   | 4 ++--
 kernel/events/uprobes.c                  | 7 +------
 18 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index 6abc497..64d67e4 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -110,7 +110,7 @@ static inline int cache_is_vipt_aliasing(void)
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
 do {									\
 	memcpy(dst, src, len);						\
-	if (vma->vm_flags & VM_EXEC)					\
+	if (!vma || vma->vm_flags & VM_EXEC)					\
 		__sync_icache_dcache((unsigned long)(dst), vaddr, len);	\
 } while (0)
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 3387e60..dd19ad4 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -114,7 +114,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 			 unsigned long uaddr, void *kaddr, unsigned long len)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+		if (!vma || cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
 			unsigned long addr = (unsigned long)kaddr;
 			__cpuc_coherent_kern_range(addr, addr + len);
 		}
@@ -128,7 +128,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 	}
 
 	/* VIPT non-aliasing D-cache */
-	if (vma->vm_flags & VM_EXEC) {
+	if (!vma || vma->vm_flags & VM_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
 		if (icache_is_vipt_aliasing())
 			flush_icache_alias(page_to_pfn(page), uaddr, len);
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index e4193e3..cde3cb4 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -38,7 +38,7 @@ static void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 				unsigned long uaddr, void *kaddr,
 				unsigned long len)
 {
-	if (vma->vm_flags & VM_EXEC) {
+	if (!vma || vma->vm_flags & VM_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
 		if (icache_is_aliasing()) {
 			__flush_dcache_area(kaddr, len);
diff --git a/arch/avr32/mm/cache.c b/arch/avr32/mm/cache.c
index 6a46ecd..cd3d378 100644
--- a/arch/avr32/mm/cache.c
+++ b/arch/avr32/mm/cache.c
@@ -156,7 +156,7 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		unsigned long len)
 {
 	memcpy(dst, src, len);
-	if (vma->vm_flags & VM_EXEC)
+	if (!vma || vma->vm_flags & VM_EXEC)
 		flush_icache_range((unsigned long)dst,
 				(unsigned long)dst + len);
 }
diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index 49e0896..9bea768 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -86,7 +86,7 @@ static inline void copy_to_user_page(struct vm_area_struct *vma,
 					     void *dst, void *src, int len)
 {
 	memcpy(dst, src, len);
-	if (vma->vm_flags & VM_EXEC) {
+	if (!vma || vma->vm_flags & VM_EXEC) {
 		flush_icache_range((unsigned long) dst,
 		(unsigned long) dst + len);
 	}
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index fa2c3d6..afefdeb 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -212,7 +212,7 @@ static inline void flush_cache_range(struct vm_area_struct *vma,
 
 static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr, unsigned long pfn)
 {
-	if (vma->vm_mm == current->mm)
+	if (!vma || vma->vm_mm == current->mm)
 	        __flush_cache_030();
 }
 
diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
index ffea82a..9eef956 100644
--- a/arch/microblaze/include/asm/cacheflush.h
+++ b/arch/microblaze/include/asm/cacheflush.h
@@ -108,7 +108,7 @@ static inline void copy_to_user_page(struct vm_area_struct *vma,
 {
 	u32 addr = virt_to_phys(dst);
 	memcpy(dst, src, len);
-	if (vma->vm_flags & VM_EXEC) {
+	if (!vma || vma->vm_flags & VM_EXEC) {
 		invalidate_icache_range(addr, addr + PAGE_SIZE);
 		flush_dcache_range(addr, addr + PAGE_SIZE);
 	}
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6b59617..e428551 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -232,7 +232,7 @@ void copy_to_user_page(struct vm_area_struct *vma,
 		if (cpu_has_dc_aliases)
 			SetPageDcacheDirty(page);
 	}
-	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
+	if ((!vma || vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
 		flush_cache_page(vma, vaddr, page_to_pfn(page));
 }
 
diff --git a/arch/parisc/include/asm/tlbflush.h b/arch/parisc/include/asm/tlbflush.h
index 9d086a5..7aad1b6 100644
--- a/arch/parisc/include/asm/tlbflush.h
+++ b/arch/parisc/include/asm/tlbflush.h
@@ -68,6 +68,10 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	/* For one page, it's not worth testing the split_tlb variable */
 
 	mb();
+	if (!vma) {
+		flush_tlb_all();
+		return;
+	}
 	sid = vma->vm_mm->context;
 	purge_tlb_start(flags);
 	mtsp(sid, 1);
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index ac87a40..ff09f05 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -278,7 +278,7 @@ __flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
 {
 	preempt_disable();
 	flush_dcache_page_asm(physaddr, vmaddr);
-	if (vma->vm_flags & VM_EXEC)
+	if (!vma || vma->vm_flags & VM_EXEC)
 		flush_icache_page_asm(physaddr, vmaddr);
 	preempt_enable();
 }
@@ -574,7 +574,7 @@ void flush_cache_range(struct vm_area_struct *vma,
 void
 flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr, unsigned long pfn)
 {
-	BUG_ON(!vma->vm_mm->context);
+	BUG_ON(vma && !vma->vm_mm->context);
 
 	if (pfn_valid(pfn)) {
 		flush_tlb_page(vma, vmaddr);
diff --git a/arch/score/include/asm/cacheflush.h b/arch/score/include/asm/cacheflush.h
index 1d545d0..63e7b4e 100644
--- a/arch/score/include/asm/cacheflush.h
+++ b/arch/score/include/asm/cacheflush.h
@@ -41,7 +41,7 @@ static inline void flush_icache_page(struct vm_area_struct *vma,
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do {							\
 		memcpy(dst, src, len);				\
-		if ((vma->vm_flags & VM_EXEC))			\
+		if (!vma || (vma->vm_flags & VM_EXEC))			\
 			flush_cache_page(vma, vaddr, page_to_pfn(page));\
 	} while (0)
 
diff --git a/arch/score/mm/cache.c b/arch/score/mm/cache.c
index f85ec1a..8464575 100644
--- a/arch/score/mm/cache.c
+++ b/arch/score/mm/cache.c
@@ -210,7 +210,7 @@ void flush_cache_range(struct vm_area_struct *vma,
 void flush_cache_page(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long pfn)
 {
-	int exec = vma->vm_flags & VM_EXEC;
+	int exec = !vma || vma->vm_flags & VM_EXEC;
 	unsigned long kaddr = 0xa0000000 | (pfn << PAGE_SHIFT);
 
 	flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 616966a..ba2313a 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -70,7 +70,7 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 			clear_bit(PG_dcache_clean, &page->flags);
 	}
 
-	if (vma->vm_flags & VM_EXEC)
+	if (!vma || vma->vm_flags & VM_EXEC)
 		flush_cache_page(vma, vaddr, page_to_pfn(page));
 }
 
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 5bed085..dca5e18 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -192,7 +192,7 @@ void leon_flush_dcache_all(void)
 
 void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page)
 {
-	if (vma->vm_flags & VM_EXEC)
+	if (!vma || vma->vm_flags & VM_EXEC)
 		leon_flush_icache_all();
 	leon_flush_dcache_all();
 }
diff --git a/arch/tile/include/asm/cacheflush.h b/arch/tile/include/asm/cacheflush.h
index 92ee4c8..7b7022c 100644
--- a/arch/tile/include/asm/cacheflush.h
+++ b/arch/tile/include/asm/cacheflush.h
@@ -66,7 +66,7 @@ static inline void copy_to_user_page(struct vm_area_struct *vma,
 				     void *dst, void *src, int len)
 {
 	memcpy(dst, src, len);
-	if (vma->vm_flags & VM_EXEC) {
+	if (!vma || vma->vm_flags & VM_EXEC) {
 		flush_icache_range((unsigned long) dst,
 				   (unsigned long) dst + len);
 	}
diff --git a/arch/unicore32/mm/flush.c b/arch/unicore32/mm/flush.c
index 6d4c096..10ddab3 100644
--- a/arch/unicore32/mm/flush.c
+++ b/arch/unicore32/mm/flush.c
@@ -36,7 +36,7 @@ static void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 			 unsigned long uaddr, void *kaddr, unsigned long len)
 {
 	/* VIPT non-aliasing D-cache */
-	if (vma->vm_flags & VM_EXEC) {
+	if (!vma || vma->vm_flags & VM_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
 
 		__cpuc_coherent_kern_range(addr, addr + len);
diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index ba4c47f..d34c06c 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -221,10 +221,10 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		unsigned long t = TLBTEMP_BASE_1 + (vaddr & DCACHE_ALIAS_MASK);
 
 		__flush_invalidate_dcache_range((unsigned long) dst, len);
-		if ((vma->vm_flags & VM_EXEC) != 0)
+		if (!vma || (vma->vm_flags & VM_EXEC) != 0)
 			__invalidate_icache_page_alias(t, phys);
 
-	} else if ((vma->vm_flags & VM_EXEC) != 0) {
+	} else if (!vma || (vma->vm_flags & VM_EXEC) != 0) {
 		__flush_dcache_range((unsigned long)dst,len);
 		__invalidate_icache_range((unsigned long) dst, len);
 	}
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04709b6..2e976fb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -241,7 +241,7 @@ static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, in
 static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
+	copy_to_user_page(NULL, page, vaddr, kaddr + (vaddr & ~PAGE_MASK), src, len);
 	kunmap_atomic(kaddr);
 }
 
@@ -1299,11 +1299,6 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 	/* Initialize the slot */
 	copy_to_page(area->page, xol_vaddr,
 			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
-	 * This should work on supported architectures too.
-	 */
-	flush_dcache_page(area->page);
 
 	return xol_vaddr;
 }
-- 
1.8.1.2
