From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 12 May 2014 18:56:00 +0900
Subject: [RESEND PATCH v6 7/7] arm64: KVM: Implement 4 levels of translation
 tables for HYP and stage2
Message-ID: <000001cf6dc8$60eaa170$22bfe450$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 4 levels of translation tables implementation for both
HYP and stage2.

Both symmetric and asymmetric configurations for page size and translation
levels are are validated on Fast Models:

 1) 4KB  + 3 levels guest on 4KB  + 4 levels host
 2) 4KB  + 4 levels guest on 4KB  + 4 levels host
 3) 64KB + 2 levels guest on 4KB  + 4 levels host
 4) 4KB  + 3 levels guest on 64KB + 2 levels host
 5) 4KB  + 4 levels guest on 64KB + 2 levels host
 6) 64KB + 2 levels guest on 64KB + 2 levels host

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
Please ignore the previous patch since it has a critical error
on KVM_MMU_CACHE_MIN_PAGES.

I'm really sorry about noise. My email client terminated unexpectedly,
so some words are dropped :(
---
 arch/arm/include/asm/kvm_mmu.h   |   10 +++++
 arch/arm/kvm/arm.c               |    8 ++++
 arch/arm/kvm/mmu.c               |   77 ++++++++++++++++++++++++++++++++------
 arch/arm64/include/asm/kvm_arm.h |   12 ++++++
 arch/arm64/include/asm/kvm_mmu.h |   12 ++++++
 5 files changed, 108 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 5c7aa3c..d319ef6 100644
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
@@ -94,6 +99,11 @@ static inline void kvm_clean_pgd(pgd_t *pgd)
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
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9f19f2c..0785291 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -473,11 +473,19 @@ static int set_vttbr_baddr_mask(void)
 	 * 21 <= T0SZ <= 30 is valid under 3 level of translation tables
 	 * 30 <= T0SZ <= 39 is valid under 2 level of translation tables
 	 */
+#ifdef CONFIG_ARM64_3_LEVELS
 	if (t0sz <= 20) {
 		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
 		return -EINVAL;
 	}
 	vttbr_x = 37 - t0sz;
+#else
+	if (t0sz <= 15) {
+		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
+		return -EINVAL;
+	}
+	vttbr_x = 28 - t0sz;
+#endif
 #endif
 	vttbr_baddr_mask = (((1LLU << (48 - vttbr_x)) - 1) << (vttbr_x - 1));
 #endif
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 16f8049..6e2a0b0 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -390,13 +390,44 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 	return 0;
 }
 
+static int create_hyp_pud_mappings(pgd_t *pgd, unsigned long start,
+				   unsigned long end, unsigned long pfn,
+				   pgprot_t prot)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+	unsigned long addr, next;
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
+
+		create_hyp_pmd_mappings(pud, addr, next, pfn, prot);
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
 
@@ -405,22 +436,21 @@ static int __create_hyp_mappings(pgd_t *pgdp,
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
@@ -565,6 +595,24 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 	kvm->arch.pgd = NULL;
 }
 
+static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			     phys_addr_t addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+
+	pgd = kvm->arch.pgd + pgd_index(addr);
+	if (pgd_none(*pgd)) {
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
 static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			     phys_addr_t addr)
 {
@@ -616,9 +664,15 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
 {
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
 
+	/* Create stage-2 page table mapping - Level 0 */
+	pud = stage2_get_pud(kvm, cache, addr);
+	if (!pud)
+		return 0;
+
 	/* Create stage-2 page table mapping - Level 1 */
 	pmd = stage2_get_pmd(kvm, cache, addr);
 	if (!pmd) {
@@ -677,7 +731,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
 		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
 
-		ret = mmu_topup_memory_cache(&cache, 2, 2);
+		ret = mmu_topup_memory_cache(&cache, KVM_MMU_CACHE_MIN_PAGES,
+						KVM_MMU_CACHE_MIN_PAGES);
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8dbef70..ac796d0 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -114,6 +114,7 @@
 #define VTCR_EL2_IRGN0_MASK	(3 << 8)
 #define VTCR_EL2_IRGN0_WBWA	(1 << 8)
 #define VTCR_EL2_SL0_MASK	(3 << 6)
+#define VTCR_EL2_SL0_LVL0	(2 << 6)
 #define VTCR_EL2_SL0_LVL1	(1 << 6)
 #define VTCR_EL2_T0SZ_MASK	0x3f
 #define VTCR_EL2_T0SZ(bits)	(64 - (bits))
@@ -128,6 +129,7 @@
 				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
 				 VTCR_EL2_SL0_LVL1)
 #else
+#ifdef CONFIG_ARM64_3_LEVELS
 /*
  * Stage2 translation configuration:
  * 4kB pages (TG0 = 0)
@@ -136,6 +138,16 @@
 #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
 				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
 				 VTCR_EL2_SL0_LVL1)
+#else
+/*
+ * Stage2 translation configuration:
+ * 4kB pages (TG0 = 0)
+ * 4 level page tables (SL = 2)
+ */
+#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
+				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
+				 VTCR_EL2_SL0_LVL0)
+#endif
 #endif
 
 #define VTTBR_VMID_SHIFT  (48LLU)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 7d29847..778bf42 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -41,6 +41,17 @@
  */
 #define TRAMPOLINE_VA		(HYP_PAGE_OFFSET_MASK & PAGE_MASK)
 
+/*
+ * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation levels.
+ */
+#ifdef CONFIG_ARM64_2_LEVELS
+#define KVM_MMU_CACHE_MIN_PAGES	1
+#elif defined(CONFIG_ARM64_3_LEVELS)
+#define KVM_MMU_CACHE_MIN_PAGES	2
+#else
+#define KVM_MMU_CACHE_MIN_PAGES	3
+#endif
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -107,6 +118,7 @@ static inline bool kvm_is_write_fault(unsigned long esr)
 }
 
 static inline void kvm_clean_pgd(pgd_t *pgd) {}
+static inline void kvm_clean_pmd(pmd_t *pmd) {}
 static inline void kvm_clean_pmd_entry(pmd_t *pmd) {}
 static inline void kvm_clean_pte(pte_t *pte) {}
 static inline void kvm_clean_pte_entry(pte_t *pte) {}
-- 
1.7.10.4
