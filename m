From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:12 +0200
Subject: [PATCH] FCSE: Conversions between VA and MVA.
In-Reply-To: <1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to asm/fcse.h the functions needed to allow conversion between
virtual addresses (a.k.a VA) and modified virtual addresses (a.k.a
MVA), that is virtual addresses translated by the FCSE pid.

Though the whole kernel handles VA, and do not see MVA, there are a
few exceptions:
- the function handling page table walking must use MVA, this is
solved by getting the pgd_offset function to use fcse_va_to_mva, which
turns out to be sufficient;
- the TLB and cache operations which may be passed user-space
addresses must use MVA, so, they call fcse_va_to_mva too;
- the function do_DataAbort is passed an MVA which has to be converted
into a VA, this is done by calling fcse_mva_to_va.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/cacheflush.h |   26 ++++++++++++++++++++------
 arch/arm/include/asm/fcse.h       |   29 +++++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable.h    |   10 ++++++++--
 arch/arm/include/asm/tlbflush.h   |   14 ++++++++++++--
 arch/arm/mm/fault.c               |    6 ++++++
 arch/arm/mm/flush.c               |   15 ++++++++++-----
 arch/arm/mm/pgd.c                 |    7 ++++++-
 7 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index fd03fb6..db43631 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -15,6 +15,7 @@
 #include <asm/glue.h>
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
+#include <asm/fcse.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
@@ -341,16 +342,20 @@ static inline void flush_cache_mm(struct mm_struct *mm)
 static inline void
 flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
+	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+		start = fcse_va_to_mva(vma->vm_mm, start);
+		end = fcse_va_to_mva(vma->vm_mm, end);
 		__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
 					vma->vm_flags);
+	}
 }
 
 static inline void
 flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
 	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-		unsigned long addr = user_addr & PAGE_MASK;
+		unsigned long addr;
+		addr = fcse_va_to_mva(vma->vm_mm, user_addr) & PAGE_MASK;
 		__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
 	}
 }
@@ -381,14 +386,22 @@ extern void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(vma,start,end) \
-	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
+#define flush_cache_user_range(vma, start, end)				\
+	({								\
+		struct mm_struct *_mm = (vma)->vm_mm;			\
+		unsigned long _start, _end;				\
+		_start = fcse_va_to_mva(_mm, start) & PAGE_MASK;	\
+		_end = PAGE_ALIGN(fcse_va_to_mva(_mm, end));		\
+		__cpuc_coherent_user_range(_start, _end);		\
+	})
 
 /*
  * Perform necessary cache operations to ensure that data previously
  * stored within this range of addresses can be executed by the CPU.
  */
-#define flush_icache_range(s,e)		__cpuc_coherent_kern_range(s,e)
+#define flush_icache_range(s,e)						\
+	__cpuc_coherent_kern_range(fcse_va_to_mva(current->mm, (s)),	\
+				   fcse_va_to_mva(current->mm, (e)))
 
 /*
  * Perform necessary cache operations to ensure that the TLB will
@@ -426,7 +439,8 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 	extern void __flush_anon_page(struct vm_area_struct *vma,
 				struct page *, unsigned long);
 	if (PageAnon(page))
-		__flush_anon_page(vma, page, vmaddr);
+		__flush_anon_page(vma, page,
+				  fcse_va_to_mva(vma->vm_mm, vmaddr));
 }
 
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
diff --git a/arch/arm/include/asm/fcse.h b/arch/arm/include/asm/fcse.h
index b44e866..e443278 100644
--- a/arch/arm/include/asm/fcse.h
+++ b/arch/arm/include/asm/fcse.h
@@ -27,6 +27,9 @@
 /* Size of PID relocation area */
 #define FCSE_PID_TASK_SIZE (1UL << FCSE_PID_SHIFT)
 
+/* Mask to get rid of PID from relocated address */
+#define FCSE_PID_MASK (FCSE_PID_TASK_SIZE - 1)
+
 /* Sets the CPU's PID Register */
 static inline void fcse_pid_set(unsigned long pid)
 {
@@ -34,11 +37,37 @@ static inline void fcse_pid_set(unsigned long pid)
 			      : /* */: "r" (pid) : "memory");
 }
 
+/* Returns the state of the CPU's PID Register */
+static inline unsigned long fcse_pid_get(void)
+{
+	unsigned long pid;
+	__asm__ __volatile__("mrc p15, 0, %0, c13, c0, 0" : "=&r" (pid));
+	return pid & ~FCSE_PID_MASK;
+}
+
+static inline unsigned long fcse_mva_to_va(unsigned long mva)
+{
+	unsigned long pid = fcse_pid_get();
+	if (pid && (pid == (mva & ~FCSE_PID_MASK)))
+		return mva & FCSE_PID_MASK;
+	return mva;
+}
+
+static inline unsigned long
+fcse_va_to_mva(struct mm_struct *mm, unsigned long va)
+{
+	if (va < FCSE_PID_TASK_SIZE)
+		return mm->context.pid | va;
+	return va;
+}
+
 int fcse_pid_alloc(void);
 void fcse_pid_free(unsigned pid);
 
 #else /* ! CONFIG_ARM_FCSE */
 #define fcse_pid_set(pid) do { } while (0)
+#define fcse_mva_to_va(x) (x)
+#define fcse_va_to_mva(mm, x) ({ (void)(mm); (x); })
 #endif /* ! CONFIG_ARM_FCSE */
 
 #endif /* __ASM_ARM_FCSE_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 201ccaa..197c596 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -112,6 +112,8 @@
 #define LIBRARY_TEXT_START	0x0c000000
 
 #ifndef __ASSEMBLY__
+#include <asm/fcse.h>
+
 extern void __pte_error(const char *file, int line, unsigned long val);
 extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pgd_error(const char *file, int line, unsigned long val);
@@ -362,10 +364,14 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 /* to find an entry in a page-table-directory */
 #define pgd_index(addr)		((addr) >> PGDIR_SHIFT)
 
-#define pgd_offset(mm, addr)	((mm)->pgd+pgd_index(addr))
+#define pgd_offset(mm, addr)						\
+	({								\
+		struct mm_struct *_mm = (mm);				\
+		(_mm->pgd + pgd_index(fcse_va_to_mva(_mm, (addr))));	\
+	})
 
 /* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
+#define pgd_offset_k(addr)	(init_mm.pgd + pgd_index(addr))
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir, addr)	((pmd_t *)(dir))
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index a45ab5d..7e14a84 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -210,6 +210,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/sched.h>
+#include <asm/fcse.h>
 
 struct cpu_tlb_fns {
 	void (*flush_user_range)(unsigned long, unsigned long, struct vm_area_struct *);
@@ -383,7 +384,8 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
+	uaddr = (fcse_va_to_mva(vma->vm_mm, uaddr) & PAGE_MASK)
+		| ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
 		dsb();
@@ -504,7 +506,15 @@ static inline void clean_pmd_entry(pmd_t *pmd)
 /*
  * Convert calls to our calling convention.
  */
-#define local_flush_tlb_range(vma,start,end)	__cpu_flush_user_tlb_range(start,end,vma)
+#define local_flush_tlb_range(vma, start, end)			\
+	({							\
+		struct mm_struct *_mm = (vma)->vm_mm;		\
+		unsigned long _start, _end;			\
+		_start = fcse_va_to_mva(_mm, start);		\
+		_end = fcse_va_to_mva(_mm, end);		\
+		__cpu_flush_user_tlb_range(_start, _end, vma);	\
+	})
+
 #define local_flush_tlb_kernel_range(s,e)	__cpu_flush_kern_tlb_range(s,e)
 
 #ifndef CONFIG_SMP
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 379f785..493c980 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -73,6 +73,10 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 	if (!mm)
 		mm = &init_mm;
 
+#ifdef CONFIG_ARM_FCSE
+	printk(KERN_ALERT "fcse pid: %ld, 0x%08lx\n",
+	       mm->context.pid >> FCSE_PID_SHIFT, mm->context.pid);
+#endif /* CONFIG_ARM_FCSE */
 	printk(KERN_ALERT "pgd = %p\n", mm->pgd);
 	pgd = pgd_offset(mm, addr);
 	printk(KERN_ALERT "[%08lx] *pgd=%08lx", addr, pgd_val(*pgd));
@@ -506,6 +510,8 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
 	struct siginfo info;
 
+	addr = fcse_mva_to_va(addr);
+
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index b279429..ec6fcda 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -73,9 +73,11 @@ void flush_cache_mm(struct mm_struct *mm)
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
-			__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
-						vma->vm_flags);
+		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+			start = fcse_va_to_mva(vma->vm_mm, start) & PAGE_MASK;
+			end = PAGE_ALIGN(fcse_va_to_mva(vma->vm_mm, end));
+			__cpuc_flush_user_range(start, end, vma->vm_flags);
+		}
 		return;
 	}
 
@@ -98,8 +100,11 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 {
 	if (cache_is_vivt()) {
 		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-			unsigned long addr = user_addr & PAGE_MASK;
-			__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
+			unsigned long addr;
+			addr = fcse_va_to_mva(vma->vm_mm, user_addr);
+			addr &= PAGE_MASK;
+			__cpuc_flush_user_range(addr, addr + PAGE_SIZE,
+						vma->vm_flags);
 		}
 		return;
 	}
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index 2690146..9796798 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -43,6 +43,11 @@ pgd_t *get_pgd_slow(struct mm_struct *mm)
 	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
 
 	if (!vectors_high()) {
+#ifdef CONFIG_ARM_FCSE
+		/* FCSE does not work without high vectors. */
+		BUG();
+#endif /* CONFIG_ARM_FCSE */
+
 		/*
 		 * On ARM, first page must always be allocated since it
 		 * contains the machine vectors.
@@ -81,7 +86,7 @@ void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd)
 		return;
 
 	/* pgd is always present and good */
-	pmd = pmd_off(pgd, 0);
+	pmd = pmd_off(pgd + pgd_index(fcse_va_to_mva(mm, 0)), 0);
 	if (pmd_none(*pmd))
 		goto free;
 	if (pmd_bad(*pmd)) {
-- 
1.5.6.5
