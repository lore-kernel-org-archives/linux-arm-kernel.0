From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Feb 2014 11:30:49 +0000
Subject: [PATCH 2/6] arm64: barriers: make use of barrier options with
 explicit barriers
In-Reply-To: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391686253-13436-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When calling our low-level barrier macros directly, we can often suffice
with more relaxed behaviour than the default "all accesses, full system"
option.

This patch updates the users of dsb() to specify the option whith they
actually require. The sev() macro is also updated so that a sevl can
be emitted if necessary.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h    |  4 ++--
 arch/arm64/include/asm/cacheflush.h |  2 +-
 arch/arm64/include/asm/pgtable.h    |  4 ++--
 arch/arm64/include/asm/tlbflush.h   | 14 +++++++-------
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kvm/sys_regs.c           |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 409ca370cfe2..09f4cb4b665e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -20,14 +20,14 @@
 
 #ifndef __ASSEMBLY__
 
-#define sev()		asm volatile("sev" : : : "memory")
+#define sev(l)		asm volatile("sev" #l : : : "memory")
 #define wfe()		asm volatile("wfe" : : : "memory")
 #define wfi()		asm volatile("wfi" : : : "memory")
 
 #define isb()		asm volatile("isb" : : : "memory")
 #define dsb(opt)	asm volatile("dsb sy" : : : "memory")
 
-#define mb()		dsb()
+#define mb()		dsb(sy)
 #define rmb()		asm volatile("dsb ld" : : : "memory")
 #define wmb()		asm volatile("dsb st" : : : "memory")
 
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index fea9ee327206..b9495549cb08 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -142,7 +142,7 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 	 * set_pte_at() called from vmap_pte_range() does not
 	 * have a DSB after cleaning the cache line.
 	 */
-	dsb();
+	dsb(ishst);
 }
 
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b524dcd17243..54aa68f61008 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -310,7 +310,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	*pmdp = pmd;
-	dsb();
+	dsb(ishst);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -340,7 +340,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 	*pudp = pud;
-	dsb();
+	dsb(ishst);
 }
 
 static inline void pud_clear(pud_t *pudp)
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 8b482035cfc2..3083a08f9622 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -72,9 +72,9 @@ extern struct cpu_tlb_fns cpu_tlb;
  */
 static inline void flush_tlb_all(void)
 {
-	dsb();
+	dsb(ishst);
 	asm("tlbi	vmalle1is");
-	dsb();
+	dsb(ish);
 	isb();
 }
 
@@ -82,9 +82,9 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 {
 	unsigned long asid = (unsigned long)ASID(mm) << 48;
 
-	dsb();
+	dsb(ishst);
 	asm("tlbi	aside1is, %0" : : "r" (asid));
-	dsb();
+	dsb(ish);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -93,9 +93,9 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	unsigned long addr = uaddr >> 12 |
 		((unsigned long)ASID(vma->vm_mm) << 48);
 
-	dsb();
+	dsb(ishst);
 	asm("tlbi	vae1is, %0" : : "r" (addr));
-	dsb();
+	dsb(ish);
 }
 
 /*
@@ -114,7 +114,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 * set_pte() does not have a DSB, so make sure that the page table
 	 * write is visible.
 	 */
-	dsb();
+	dsb(ishst);
 }
 
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1c0a9be2ffa8..8e78cb238376 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -294,7 +294,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 * Complete any pending TLB or cache maintenance on this CPU in case
 	 * the thread migrates to a different CPU.
 	 */
-	dsb();
+	dsb(ish);
 
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 02e9d09e1d80..bbaaabe8e899 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -70,13 +70,13 @@ static u32 get_ccsidr(u32 csselr)
 static void do_dc_cisw(u32 val)
 {
 	asm volatile("dc cisw, %x0" : : "r" (val));
-	dsb();
+	dsb(ishst);
 }
 
 static void do_dc_csw(u32 val)
 {
 	asm volatile("dc csw, %x0" : : "r" (val));
-	dsb();
+	dsb(ishst);
 }
 
 /* See note@ARM ARM B1.14.4 */
-- 
1.8.2.2
