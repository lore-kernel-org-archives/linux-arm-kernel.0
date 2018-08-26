From: peterz@infradead.org (Peter Zijlstra)
Date: Sun, 26 Aug 2018 12:56:48 +0200
Subject: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <CA+55aFxNs5B=j_g_OpAd=Xp_iiO_+idT-ogd_WM2EcL_6brbqg@mail.gmail.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <CA+55aFxNs5B=j_g_OpAd=Xp_iiO_+idT-ogd_WM2EcL_6brbqg@mail.gmail.com>
Message-ID: <20180826105648.GU24124@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 09:20:00AM -0700, Linus Torvalds wrote:
> On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > I hacked up this RFC on the back of the recent changes to the mmu_gather
> > stuff in mainline. It's had a bit of testing and it looks pretty good so
> > far.
> 
> Looks good to me.
> 
> Apart from the arm64-specific question I had, I wonder whether we need
> to have that single "freed_tables" bit at all, since you wanted to
> have the four individual bits for the different levels.

I think so; because he also sets those size bits for things like hugetlb
and thp user page frees, not only table page frees. So they're not
exactly the same.

And I think x86 could use this too; if we know we only freed 2M
pages, we can use that in flush_tlb_mm_range() to range flush in 2M
increments instead of 4K.

Something a little like so..

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index cb0a1f470980..cb0898fe9d37 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -8,10 +8,15 @@
 
 #define tlb_flush(tlb)							\
 {									\
-	if (!tlb->fullmm && !tlb->need_flush_all) 			\
-		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end, 0UL);	\
-	else								\
-		flush_tlb_mm_range(tlb->mm, 0UL, TLB_FLUSH_ALL, 0UL);	\
+	unsigned long start = 0UL, end = TLB_FLUSH_ALL;			\
+	unsigned int invl_shift = tlb_get_unmap_shift(tlb);		\
+									\
+	if (!tlb->fullmm && !tlb->need_flush_all) {			\
+		start = tlb->start;					\
+		end = tlb->end;						\
+	}								\
+									\
+	flush_tlb_mm_range(tlb->mm, start, end, invl_shift);		\
 }
 
 #include <asm-generic/tlb.h>
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 511bf5fae8b8..8ac1cac34f63 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -491,23 +491,25 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
+	unsigned int		invl_shift;
 };
 
 #define local_flush_tlb() __flush_tlb()
 
 #define flush_tlb_mm(mm)	flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL)
 
-#define flush_tlb_range(vma, start, end)	\
-		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
+#define flush_tlb_range(vma, start, end)			\
+		flush_tlb_mm_range(vma->vm_mm, start, end,	\
+				vma->vm_flags & VM_HUGETLB ? PMD_SHUFT : PAGE_SHIFT)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag);
+				unsigned long end, unsigned int invl_shift);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, VM_NONE);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT);
 }
 
 void native_flush_tlb_others(const struct cpumask *cpumask,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 752dbf4e0e50..806aa74a8fb4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -537,12 +537,12 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	    f->new_tlb_gen == mm_tlb_gen) {
 		/* Partial flush */
 		unsigned long addr;
-		unsigned long nr_pages = (f->end - f->start) >> PAGE_SHIFT;
+		unsigned long nr_pages = (f->end - f->start) >> f->invl_shift;
 
 		addr = f->start;
 		while (addr < f->end) {
 			__flush_tlb_one_user(addr);
-			addr += PAGE_SIZE;
+			addr += 1UL << f->invl_shift;
 		}
 		if (local)
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_pages);
@@ -653,12 +653,13 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag)
+				unsigned long end, unsigned int invl_shift)
 {
 	int cpu;
 
 	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
 		.mm = mm,
+		.invl_shift = invl_shift;
 	};
 
 	cpu = get_cpu();
@@ -668,8 +669,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 
 	/* Should we flush just the requested range? */
 	if ((end != TLB_FLUSH_ALL) &&
-	    !(vmflag & VM_HUGETLB) &&
-	    ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
+	    ((end - start) >> invl_shift) <= tlb_single_page_flush_ceiling) {
 		info.start = start;
 		info.end = end;
 	} else {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e811ef7b8350..cdde0cdb23e7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -175,6 +200,25 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 }
 #endif
 
+static inline unsigned long tlb_get_unmap_shift(struct mmu_gather *tlb)
+{
+	if (tlb->cleared_ptes)
+		return PAGE_SHIFT;
+	if (tlb->cleared_pmds)
+		return PMD_SHIFT;
+	if (tlb->cleared_puds)
+		return PUD_SHIFT;
+	if (tlb->cleared_p4ds)
+		return P4D_SHIFT;
+
+	return PAGE_SHIFT;
+}
+
+static inline unsigned long tlb_get_unmap_size(struct mmu_gather *tlb)
+{
+	return 1ULL << tlb_get_unmap_shift(tlb);
+}
+
 /*
  * In the case of tlb vma handling, we can optimise these away in the
  * case where we're doing a full MM flush.  When we're doing a munmap,
