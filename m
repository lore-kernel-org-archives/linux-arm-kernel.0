From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 12:11:34 +0100
Subject: [PATCH v3 1/7] ARM: KVM: be more thorough when invalidating TLBs
In-Reply-To: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368529900-22572-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KVM/ARM MMU code doesn't take care of invalidating TLBs before
freeing a {pte,pmd} table. This could cause problems if the page
is reallocated and then speculated into by another CPU.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 9657065..84ba67b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -43,7 +43,14 @@ static phys_addr_t hyp_idmap_vector;
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
-	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
+	/*
+	 * This function also gets called when dealing with HYP page
+	 * tables. As HYP doesn't have an associated struct kvm (and
+	 * the HYP page tables are fairly static), we don't do
+	 * anything there.
+	 */
+	if (kvm)
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
@@ -78,18 +85,20 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 	return p;
 }
 
-static void clear_pud_entry(pud_t *pud)
+static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
 {
 	pmd_t *pmd_table = pmd_offset(pud, 0);
 	pud_clear(pud);
+	kvm_tlb_flush_vmid_ipa(kvm, addr);
 	pmd_free(NULL, pmd_table);
 	put_page(virt_to_page(pud));
 }
 
-static void clear_pmd_entry(pmd_t *pmd)
+static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
 {
 	pte_t *pte_table = pte_offset_kernel(pmd, 0);
 	pmd_clear(pmd);
+	kvm_tlb_flush_vmid_ipa(kvm, addr);
 	pte_free_kernel(NULL, pte_table);
 	put_page(virt_to_page(pmd));
 }
@@ -100,11 +109,12 @@ static bool pmd_empty(pmd_t *pmd)
 	return page_count(pmd_page) == 1;
 }
 
-static void clear_pte_entry(pte_t *pte)
+static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
 {
 	if (pte_present(*pte)) {
 		kvm_set_pte(pte, __pte(0));
 		put_page(virt_to_page(pte));
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	}
 }
 
@@ -114,7 +124,8 @@ static bool pte_empty(pte_t *pte)
 	return page_count(pte_page) == 1;
 }
 
-static void unmap_range(pgd_t *pgdp, unsigned long long start, u64 size)
+static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
+			unsigned long long start, u64 size)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -138,15 +149,15 @@ static void unmap_range(pgd_t *pgdp, unsigned long long start, u64 size)
 		}
 
 		pte = pte_offset_kernel(pmd, addr);
-		clear_pte_entry(pte);
+		clear_pte_entry(kvm, pte, addr);
 		range = PAGE_SIZE;
 
 		/* If we emptied the pte, walk back up the ladder */
 		if (pte_empty(pte)) {
-			clear_pmd_entry(pmd);
+			clear_pmd_entry(kvm, pmd, addr);
 			range = PMD_SIZE;
 			if (pmd_empty(pmd)) {
-				clear_pud_entry(pud);
+				clear_pud_entry(kvm, pud, addr);
 				range = PUD_SIZE;
 			}
 		}
@@ -165,14 +176,14 @@ void free_boot_hyp_pgd(void)
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	if (boot_hyp_pgd) {
-		unmap_range(boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
-		unmap_range(boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
+		unmap_range(NULL, boot_hyp_pgd, hyp_idmap_start, PAGE_SIZE);
+		unmap_range(NULL, boot_hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
 		kfree(boot_hyp_pgd);
 		boot_hyp_pgd = NULL;
 	}
 
 	if (hyp_pgd)
-		unmap_range(hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
+		unmap_range(NULL, hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
 
 	kfree(init_bounce_page);
 	init_bounce_page = NULL;
@@ -200,9 +211,10 @@ void free_hyp_pgds(void)
 
 	if (hyp_pgd) {
 		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
-			unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
+			unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
 		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
-			unmap_range(hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
+			unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
+
 		kfree(hyp_pgd);
 		hyp_pgd = NULL;
 	}
@@ -393,7 +405,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
  */
 static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
 {
-	unmap_range(kvm->arch.pgd, start, size);
+	unmap_range(kvm, kvm->arch.pgd, start, size);
 }
 
 /**
@@ -675,7 +687,6 @@ static void handle_hva_to_gpa(struct kvm *kvm,
 static void kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	unmap_stage2_range(kvm, gpa, PAGE_SIZE);
-	kvm_tlb_flush_vmid_ipa(kvm, gpa);
 }
 
 int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
-- 
1.8.2.3
