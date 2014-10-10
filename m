From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 10 Oct 2014 12:14:28 +0200
Subject: [PATCH v3 1/3] arm64: KVM: Implement 48 VA support for KVM EL2 and
 Stage-2
In-Reply-To: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
References: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1412936070-18860-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary support for all host kernel PGSIZE and
VA_SPACE configuration options for both EL2 and the Stage-2 page tables.

However, for 40bit and 42bit PARange systems, the architecture mandates
that VTCR_EL2.SL0 is maximum 1, resulting in fewer levels of stage-2
pagge tables than levels of host kernel page tables.  At the same time,
systems with a PARange > 42bit, we limit the IPA range by always setting
VTCR_EL2.T0SZ to 24.

To solve the situation with different levels of page tables for Stage-2
translation than the host kernel page tables, we allocate a dummy PGD
with pointers to our actual inital level Stage-2 page table, in order
for us to reuse the kernel pgtable manipulation primitives.  Reproducing
all these in KVM does not look pretty and unnecessarily complicates the
32-bit side.

Systems with a PARange < 40bits are not yet supported.

 [ I have reworked this patch from its original form submitted by
   Jungseok to take the architecture constraints into consideration.
   There were too many changes from the original patch for me to
   preserve the authorship.  Thanks to Catalin Marinas for his help in
   figuring out a good solution to this challenge.  I have also fixed
   various bugs and missing error code handling from the original
   patch. - Christoffer ]

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changes [v2 -> v3]:
 - Calculate PTRS_PER_S2_PGD and KVM_PREALLOC_LEVEL based on PGDIR_SHIFT
   instead of complicated conditionals.
 - Add explanatory comments to the above definitions
 - Single definition of kvm_prealloc_hwpgd() and friends
 - Integrated tests for KVM_PREALLOC_LEVEL into kvm_pXd_table_empty()

Changes [v1 -> v2]:
 - Use KVM_PREALLOC_LEVELS directly instead of C-variable indirection
 - Factored out the config changes to separate patch
 - Use __GFP_ZERO instead of memset
 - Fixed error return path in kvm_alloc_stage2_pgd()
 - Added WARN_ON if pgd_none() returns true
 - Changed some macro definitions and names

 arch/arm/include/asm/kvm_mmu.h   |  29 ++++++++-
 arch/arm/kvm/arm.c               |   2 +-
 arch/arm/kvm/mmu.c               | 134 +++++++++++++++++++++++++++++++--------
 arch/arm64/include/asm/kvm_mmu.h | 125 +++++++++++++++++++++++++++++++++---
 4 files changed, 249 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 3f688b4..3b0fdd0 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -37,6 +37,11 @@
  */
 #define TRAMPOLINE_VA		UL(CONFIG_VECTORS_BASE)
 
+/*
+ * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation levels.
+ */
+#define KVM_MMU_CACHE_MIN_PAGES	2
+
 #ifndef __ASSEMBLY__
 
 #include <asm/cacheflush.h>
@@ -83,6 +88,11 @@ static inline void kvm_clean_pgd(pgd_t *pgd)
 	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
 }
 
+static inline void kvm_clean_pmd(pmd_t *pmd)
+{
+	clean_dcache_area(pmd, PTRS_PER_PMD * sizeof(pmd_t));
+}
+
 static inline void kvm_clean_pmd_entry(pmd_t *pmd)
 {
 	clean_pmd_entry(pmd);
@@ -123,10 +133,23 @@ static inline bool kvm_page_empty(void *ptr)
 }
 
 
-#define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
-#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
-#define kvm_pud_table_empty(pudp) (0)
+#define kvm_pte_table_empty(kvm, ptep) kvm_page_empty(ptep)
+#define kvm_pmd_table_empty(kvm, pmdp) kvm_page_empty(pmdp)
+#define kvm_pud_table_empty(kvm, pudp) (0)
+
+#define KVM_PREALLOC_LEVEL	0
 
+static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
+{
+	return 0;
+}
+
+static inline void kvm_free_hwpgd(struct kvm *kvm) { }
+
+static inline void *kvm_get_hwpgd(struct kvm *kvm)
+{
+	return kvm->arch.pgd;
+}
 
 struct kvm;
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 45e5f67..9e193c8 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -409,7 +409,7 @@ static void update_vttbr(struct kvm *kvm)
 	kvm_next_vmid++;
 
 	/* update vttbr to be used with the new vmid */
-	pgd_phys = virt_to_phys(kvm->arch.pgd);
+	pgd_phys = virt_to_phys(kvm_get_hwpgd(kvm));
 	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
 	kvm->arch.vttbr = pgd_phys | vmid;
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index eea0306..6e87233 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -42,7 +42,7 @@ static unsigned long hyp_idmap_start;
 static unsigned long hyp_idmap_end;
 static phys_addr_t hyp_idmap_vector;
 
-#define pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
+#define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
 
 #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
 
@@ -134,7 +134,7 @@ static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-	if (kvm_pte_table_empty(start_pte))
+	if (kvm_pte_table_empty(kvm, start_pte))
 		clear_pmd_entry(kvm, pmd, start_addr);
 }
 
@@ -158,7 +158,7 @@ static void unmap_pmds(struct kvm *kvm, pud_t *pud,
 		}
 	} while (pmd++, addr = next, addr != end);
 
-	if (kvm_pmd_table_empty(start_pmd))
+	if (kvm_pmd_table_empty(kvm, start_pmd))
 		clear_pud_entry(kvm, pud, start_addr);
 }
 
@@ -182,7 +182,7 @@ static void unmap_puds(struct kvm *kvm, pgd_t *pgd,
 		}
 	} while (pud++, addr = next, addr != end);
 
-	if (kvm_pud_table_empty(start_pud))
+	if (kvm_pud_table_empty(kvm, start_pud))
 		clear_pgd_entry(kvm, pgd, start_addr);
 }
 
@@ -306,7 +306,7 @@ void free_boot_hyp_pgd(void)
 	if (boot_hyp_pgd) {
 		unmap_range(NULL, boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
 		unmap_range(NULL, boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
-		free_pages((unsigned long)boot_hyp_pgd, pgd_order);
+		free_pages((unsigned long)boot_hyp_pgd, hyp_pgd_order);
 		boot_hyp_pgd = NULL;
 	}
 
@@ -343,7 +343,7 @@ void free_hyp_pgds(void)
 		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
 			unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
 
-		free_pages((unsigned long)hyp_pgd, pgd_order);
+		free_pages((unsigned long)hyp_pgd, hyp_pgd_order);
 		hyp_pgd = NULL;
 	}
 
@@ -401,13 +401,46 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 	return 0;
 }
 
+static int create_hyp_pud_mappings(pgd_t *pgd, unsigned long start,
+				   unsigned long end, unsigned long pfn,
+				   pgprot_t prot)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+	unsigned long addr, next;
+	int ret;
+
+	addr = start;
+	do {
+		pud = pud_offset(pgd, addr);
+
+		if (pud_none_or_clear_bad(pud)) {
+			pmd = pmd_alloc_one(NULL, addr);
+			if (!pmd) {
+				kvm_err("Cannot allocate Hyp pmd\n");
+				return -ENOMEM;
+			}
+			pud_populate(NULL, pud, pmd);
+			get_page(virt_to_page(pud));
+			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
+		}
+
+		next = pud_addr_end(addr, end);
+		ret = create_hyp_pmd_mappings(pud, addr, next, pfn, prot);
+		if (ret)
+			return ret;
+		pfn += (next - addr) >> PAGE_SHIFT;
+	} while (addr = next, addr != end);
+
+	return 0;
+}
+
 static int __create_hyp_mappings(pgd_t *pgdp,
 				 unsigned long start, unsigned long end,
 				 unsigned long pfn, pgprot_t prot)
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd;
 	unsigned long addr, next;
 	int err = 0;
 
@@ -416,22 +449,21 @@ static int __create_hyp_mappings(pgd_t *pgdp,
 	end = PAGE_ALIGN(end);
 	do {
 		pgd = pgdp + pgd_index(addr);
-		pud = pud_offset(pgd, addr);
 
-		if (pud_none_or_clear_bad(pud)) {
-			pmd = pmd_alloc_one(NULL, addr);
-			if (!pmd) {
-				kvm_err("Cannot allocate Hyp pmd\n");
+		if (pgd_none(*pgd)) {
+			pud = pud_alloc_one(NULL, addr);
+			if (!pud) {
+				kvm_err("Cannot allocate Hyp pud\n");
 				err = -ENOMEM;
 				goto out;
 			}
-			pud_populate(NULL, pud, pmd);
-			get_page(virt_to_page(pud));
-			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
+			pgd_populate(NULL, pgd, pud);
+			get_page(virt_to_page(pgd));
+			kvm_flush_dcache_to_poc(pgd, sizeof(*pgd));
 		}
 
 		next = pgd_addr_end(addr, end);
-		err = create_hyp_pmd_mappings(pud, addr, next, pfn, prot);
+		err = create_hyp_pud_mappings(pgd, addr, next, pfn, prot);
 		if (err)
 			goto out;
 		pfn += (next - addr) >> PAGE_SHIFT;
@@ -521,6 +553,7 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t phys_addr)
  */
 int kvm_alloc_stage2_pgd(struct kvm *kvm)
 {
+	int ret;
 	pgd_t *pgd;
 
 	if (kvm->arch.pgd != NULL) {
@@ -528,15 +561,38 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 		return -EINVAL;
 	}
 
-	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
+	if (KVM_PREALLOC_LEVEL > 0) {
+		/*
+		 * Allocate fake pgd for the page table manipulation macros to
+		 * work.  This is not used by the hardware and we have no
+		 * alignment requirement for this allocation.
+		 */
+		pgd = (pgd_t *)kmalloc(PTRS_PER_S2_PGD * sizeof(pgd_t),
+				       GFP_KERNEL | __GFP_ZERO);
+	} else {
+		/*
+		 * Allocate actual first-level Stage-2 page table used by the
+		 * hardware for Stage-2 page table walks.
+		 */
+		pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, S2_PGD_ORDER);
+	}
+
 	if (!pgd)
 		return -ENOMEM;
 
-	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
+	ret = kvm_prealloc_hwpgd(kvm, pgd);
+	if (ret)
+		goto out_err;
+
 	kvm_clean_pgd(pgd);
 	kvm->arch.pgd = pgd;
-
 	return 0;
+out_err:
+	if (KVM_PREALLOC_LEVEL > 0)
+		kfree(pgd);
+	else
+		free_pages((unsigned long)pgd, S2_PGD_ORDER);
+	return ret;
 }
 
 /**
@@ -572,19 +628,39 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 		return;
 
 	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
-	free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
+	kvm_free_hwpgd(kvm);
+	if (KVM_PREALLOC_LEVEL > 0)
+		kfree(kvm->arch.pgd);
+	else
+		free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
 	kvm->arch.pgd = NULL;
 }
 
-static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			     phys_addr_t addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd;
 
 	pgd = kvm->arch.pgd + pgd_index(addr);
-	pud = pud_offset(pgd, addr);
+	if (WARN_ON(pgd_none(*pgd))) {
+		if (!cache)
+			return NULL;
+		pud = mmu_memory_cache_alloc(cache);
+		pgd_populate(NULL, pgd, pud);
+		get_page(virt_to_page(pgd));
+	}
+
+	return pud_offset(pgd, addr);
+}
+
+static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			     phys_addr_t addr)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pud = stage2_get_pud(kvm, cache, addr);
 	if (pud_none(*pud)) {
 		if (!cache)
 			return NULL;
@@ -630,7 +706,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
 
-	/* Create stage-2 page table mapping - Level 1 */
+	/* Create stage-2 page table mapping - Levels 0 and 1 */
 	pmd = stage2_get_pmd(kvm, cache, addr);
 	if (!pmd) {
 		/*
@@ -688,7 +764,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
 		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
 
-		ret = mmu_topup_memory_cache(&cache, 2, 2);
+		ret = mmu_topup_memory_cache(&cache, KVM_MMU_CACHE_MIN_PAGES,
+						KVM_MMU_CACHE_MIN_PAGES);
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
@@ -797,7 +874,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	up_read(&current->mm->mmap_sem);
 
 	/* We need minimum second+third level pages */
-	ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
+	ret = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
+				     KVM_NR_MEM_OBJS);
 	if (ret)
 		return ret;
 
@@ -1072,8 +1150,8 @@ int kvm_mmu_init(void)
 			 (unsigned long)phys_base);
 	}
 
-	hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, pgd_order);
-	boot_hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, pgd_order);
+	hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
+	boot_hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
 
 	if (!hyp_pgd || !boot_hyp_pgd) {
 		kvm_err("Hyp mode PGD not allocated\n");
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a030d16..fe3a47a 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -41,6 +41,18 @@
  */
 #define TRAMPOLINE_VA		(HYP_PAGE_OFFSET_MASK & PAGE_MASK)
 
+/*
+ * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation
+ * levels in addition to the PGD and potentially the PUD which are
+ * pre-allocated (we pre-allocate the fake PGD and the PUD when the Stage-2
+ * tables use one level of tables less than the kernel.
+ */
+#ifdef CONFIG_ARM64_64K_PAGES
+#define KVM_MMU_CACHE_MIN_PAGES	1
+#else
+#define KVM_MMU_CACHE_MIN_PAGES	2
+#endif
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -53,6 +65,7 @@
 
 #else
 
+#include <asm/pgalloc.h>
 #include <asm/cachetype.h>
 #include <asm/cacheflush.h>
 
@@ -65,10 +78,6 @@
 #define KVM_PHYS_SIZE	(1UL << KVM_PHYS_SHIFT)
 #define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1UL)
 
-/* Make sure we get the right size, and thus the right alignment */
-#define PTRS_PER_S2_PGD (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
-#define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
-
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_boot_hyp_pgd(void);
@@ -93,6 +102,7 @@ void kvm_clear_hyp_idmap(void);
 #define	kvm_set_pmd(pmdp, pmd)		set_pmd(pmdp, pmd)
 
 static inline void kvm_clean_pgd(pgd_t *pgd) {}
+static inline void kvm_clean_pmd(pmd_t *pmd) {}
 static inline void kvm_clean_pmd_entry(pmd_t *pmd) {}
 static inline void kvm_clean_pte(pte_t *pte) {}
 static inline void kvm_clean_pte_entry(pte_t *pte) {}
@@ -111,19 +121,116 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 #define kvm_pud_addr_end(addr, end)	pud_addr_end(addr, end)
 #define kvm_pmd_addr_end(addr, end)	pmd_addr_end(addr, end)
 
+/*
+ * In the case where PGDIR_SHIFT is larger than KVM_PHYS_SHIFT, we can address
+ * the entire IPA input range with a single pgd entry, and we would only need
+ * one pgd entry.  Note that in this case, the pgd is actually not used by
+ * the MMU for Stage-2 translations, but is merely a fake pgd used as a data
+ * structure for the kernel pgtable macros to work.
+ */
+#if PGDIR_SHIFT > KVM_PHYS_SHIFT
+#define PTRS_PER_S2_PGD_SHIFT	0
+#else
+#define PTRS_PER_S2_PGD_SHIFT	(KVM_PHYS_SHIFT - PGDIR_SHIFT)
+#endif
+#define PTRS_PER_S2_PGD		(1 << PTRS_PER_S2_PGD_SHIFT)
+#define S2_PGD_ORDER		get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
+
+/*
+ * If we are concatenating first level stage-2 page tables, we would have less
+ * than or equal to 16 pointers in the fake PGD, because that's what the
+ * architecture allows.  In this case, (4 - CONFIG_ARM64_PGTABLE_LEVELS)
+ * represents the first level for the host, and we add 1 to go to the next
+ * level (which uses contatenation) for the stage-2 tables.
+ */
+#if PTRS_PER_S2_PGD <= 16
+#define KVM_PREALLOC_LEVEL	(4 - CONFIG_ARM64_PGTABLE_LEVELS + 1)
+#else
+#define KVM_PREALLOC_LEVEL	(0)
+#endif
+
+/**
+ * kvm_prealloc_hwpgd - allocate inital table for VTTBR
+ * @kvm:	The KVM struct pointer for the VM.
+ * @pgd:	The kernel pseudo pgd
+ *
+ * When the kernel uses more levels of page tables than the guest, we allocate
+ * a fake PGD and pre-populate it to point to the next-level page table, which
+ * will be the real initial page table pointed to by the VTTBR.
+ *
+ * When KVM_PREALLOC_LEVEL==2, we allocate a single page for the PMD and
+ * the kernel will use folded pud.  When KVM_PREALLOC_LEVEL==1, we
+ * allocate 2 consecutive PUD pages.
+ */
+static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
+{
+	unsigned int i;
+	unsigned long hwpgd;
+
+	if (KVM_PREALLOC_LEVEL == 0)
+		return 0;
+
+	hwpgd = __get_free_pages(GFP_KERNEL | __GFP_ZERO, PTRS_PER_S2_PGD_SHIFT);
+	if (!hwpgd)
+		return -ENOMEM;
+
+	for (i = 0; i < PTRS_PER_S2_PGD; i++) {
+		if (KVM_PREALLOC_LEVEL == 1)
+			pgd_populate(NULL, pgd + i,
+				     (pud_t *)hwpgd + i * PTRS_PER_PUD);
+		else if (KVM_PREALLOC_LEVEL == 2)
+			pud_populate(NULL, pud_offset(pgd, 0) + i,
+				     (pmd_t *)hwpgd + i * PTRS_PER_PMD);
+	}
+
+	return 0;
+}
+
+static inline void *kvm_get_hwpgd(struct kvm *kvm)
+{
+	pgd_t *pgd = kvm->arch.pgd;
+	pud_t *pud;
+
+	if (KVM_PREALLOC_LEVEL == 0)
+		return pgd;
+
+	pud = pud_offset(pgd, 0);
+	if (KVM_PREALLOC_LEVEL == 1)
+		return pud;
+
+	BUG_ON(KVM_PREALLOC_LEVEL != 2);
+	return pmd_offset(pud, 0);
+}
+
+static inline void kvm_free_hwpgd(struct kvm *kvm)
+{
+	if (KVM_PREALLOC_LEVEL > 0) {
+		unsigned long hwpgd = (unsigned long)kvm_get_hwpgd(kvm);
+		free_pages(hwpgd, PTRS_PER_S2_PGD_SHIFT);
+	}
+}
+
 static inline bool kvm_page_empty(void *ptr)
 {
 	struct page *ptr_page = virt_to_page(ptr);
 	return page_count(ptr_page) == 1;
 }
 
-#define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
-#ifndef CONFIG_ARM64_64K_PAGES
-#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
+#define kvm_pte_table_empty(kvm, ptep) kvm_page_empty(ptep)
+
+#ifdef __PAGETABLE_PMD_FOLDED
+#define kvm_pmd_table_empty(kvm, pmdp) (0)
+#else
+#define kvm_pmd_table_empty(kvm, pmdp) \
+	(kvm_page_empty(pmdp) && (!(kvm) || KVM_PREALLOC_LEVEL < 2))
+#endif
+
+#ifdef __PAGETABLE_PUD_FOLDED
+#define kvm_pud_table_empty(kvm, pudp) (0)
 #else
-#define kvm_pmd_table_empty(pmdp) (0)
+#define kvm_pud_table_empty(kvm, pudp) \
+	(kvm_page_empty(pudp) && (!(kvm) || KVM_PREALLOC_LEVEL < 1))
 #endif
-#define kvm_pud_table_empty(pudp) (0)
 
 
 struct kvm;
-- 
2.1.2.330.g565301e.dirty
