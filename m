From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  8 Aug 2013 21:07:19 -0700
Subject: [PATCH 3/3] KVM: ARM: Transparent huge pages and hugetlbfs support
In-Reply-To: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1376021239-10532-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@cs.columbia.edu>

Support transparent huge pages in KVM/ARM 32-bit and 64-bit.  The whole
transparent_hugepage_adjust stuff is far from pretty, but this is how
it's solved on x86 so we duplicate their logic.  This should be shared
across architectures if possible (like many other things), but can
always be changed down the road.

The pud_huge checking on the unmap path may feel a bit silly as the
pud_huge check is always defined to false, but the compiler should be
smart about this.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   |   17 +++-
 arch/arm/kvm/mmu.c               |  200 ++++++++++++++++++++++++++++++++------
 arch/arm64/include/asm/kvm_mmu.h |   12 ++-
 3 files changed, 194 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 472ac70..ff3ff67 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -62,6 +62,12 @@ phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
+static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
+{
+	*pmd = new_pmd;
+	flush_pmd_entry(pmd);
+}
+
 static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
 {
 	pte_val(*pte) = new_pte;
@@ -103,9 +109,15 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
 	pte_val(*pte) |= L_PTE_S2_RDWR;
 }
 
+static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
+{
+	pmd_val(*pmd) |= L_PTE_S2_RDWR;
+}
+
 struct kvm;
 
-static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
+					      unsigned long size)
 {
 	/*
 	 * If we are going to insert an instruction page and the icache is
@@ -120,8 +132,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
 	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
 	 */
 	if (icache_is_pipt()) {
-		unsigned long hva = gfn_to_hva(kvm, gfn);
-		__cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
+		__cpuc_coherent_user_range(hva, hva + size);
 	} else if (!icache_is_vivt_asid_tagged()) {
 		/* any kind of VIPT cache */
 		__flush_icache_all();
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 0988d9e..26ced77 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -19,6 +19,7 @@
 #include <linux/mman.h>
 #include <linux/kvm_host.h>
 #include <linux/io.h>
+#include <linux/hugetlb.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
@@ -41,6 +42,8 @@ static unsigned long hyp_idmap_start;
 static unsigned long hyp_idmap_end;
 static phys_addr_t hyp_idmap_vector;
 
+#define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
+
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
 	/*
@@ -93,19 +96,27 @@ static bool page_empty(void *ptr)
 
 static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
 {
-	pmd_t *pmd_table = pmd_offset(pud, 0);
-	pud_clear(pud);
-	kvm_tlb_flush_vmid_ipa(kvm, addr);
-	pmd_free(NULL, pmd_table);
+	if (pud_huge(*pud)) {
+		pud_clear(pud);
+	} else {
+		pmd_t *pmd_table = pmd_offset(pud, 0);
+		pud_clear(pud);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+		pmd_free(NULL, pmd_table);
+	}
 	put_page(virt_to_page(pud));
 }
 
 static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
 {
-	pte_t *pte_table = pte_offset_kernel(pmd, 0);
-	pmd_clear(pmd);
-	kvm_tlb_flush_vmid_ipa(kvm, addr);
-	pte_free_kernel(NULL, pte_table);
+	if (kvm_pmd_huge(*pmd)) {
+		pmd_clear(pmd);
+	} else {
+		pte_t *pte_table = pte_offset_kernel(pmd, 0);
+		pmd_clear(pmd);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+		pte_free_kernel(NULL, pte_table);
+	}
 	put_page(virt_to_page(pmd));
 }
 
@@ -136,12 +147,37 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 			continue;
 		}
 
+		if (pud_huge(*pud)) {
+			/*
+			 * If we are dealing with a huge pud, just clear it and
+			 * move on.
+			 */
+			clear_pud_entry(kvm, pud, addr);
+			addr = pud_addr_end(addr, end);
+			continue;
+		}
+
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
 			addr = pmd_addr_end(addr, end);
 			continue;
 		}
 
+		if (kvm_pmd_huge(*pmd)) {
+			/*
+			 * If we are dealing with a huge pmd, just clear it and
+			 * walk back up the ladder.
+			 */
+			clear_pmd_entry(kvm, pmd, addr);
+			next = pmd_addr_end(addr, end);
+			if (page_empty(pmd) && !page_empty(pud)) {
+				clear_pud_entry(kvm, pud, addr);
+				next = pud_addr_end(addr, end);
+			}
+			addr = next;
+			continue;
+		}
+
 		pte = pte_offset_kernel(pmd, addr);
 		clear_pte_entry(kvm, pte, addr);
 		next = addr + PAGE_SIZE;
@@ -420,6 +456,46 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 	kvm->arch.pgd = NULL;
 }
 
+/* Set a huge page pmd entry */
+static int stage2_set_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			  phys_addr_t addr, const pmd_t *new_pmd)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd, old_pmd;
+
+	/* Create stage-2 page table mapping - Level 1 */
+	pgd = kvm->arch.pgd + pgd_index(addr);
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud)) {
+		if (!cache)
+			return 0; /* ignore calls from kvm_set_spte_hva */
+		pmd = mmu_memory_cache_alloc(cache);
+		pud_populate(NULL, pud, pmd);
+		get_page(virt_to_page(pud));
+	}
+
+	pmd = pmd_offset(pud, addr);
+
+	/*
+	 * Mapping in huge pages should only happen through a fault.  If a
+	 * page is merged into a transparent huge page, the individual
+	 * subpages of that huge page should be unmapped through MMU
+	 * notifiers before we get here.
+	 *
+	 * Merging of CompoundPages is not supported; they should become
+	 * splitting first, unmapped, merged, and mapped back in on-demand.
+	 */
+	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
+
+	old_pmd = *pmd;
+	kvm_set_pmd(pmd, *new_pmd);
+	if (pmd_present(old_pmd))
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+	else
+		get_page(virt_to_page(pmd));
+	return 0;
+}
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
@@ -442,7 +518,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 
 	pmd = pmd_offset(pud, addr);
 
-	/* Create 2nd stage page table mapping - Level 2 */
+	/* Create 2nd stage page mappings - Level 2 */
 	if (pmd_none(*pmd)) {
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
@@ -508,16 +584,53 @@ out:
 	return ret;
 }
 
+static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
+{
+	pfn_t pfn = *pfnp;
+	gfn_t gfn = *ipap >> PAGE_SHIFT;
+
+	if (PageTransCompound(pfn_to_page(pfn))) {
+		unsigned long mask;
+		/*
+		 * mmu_notifier_retry was successful and we hold the
+		 * mmu_lock here, so the pmd can't become splitting
+		 * from under us, and in turn
+		 * __split_huge_page_refcount() can't run from under
+		 * us and we can safely transfer the refcount from
+		 * PG_tail to PG_head as we switch the pfn from tail to
+		 * head.
+		 */
+		mask = (PMD_SIZE / PAGE_SIZE) - 1;
+		VM_BUG_ON((gfn & mask) != (pfn & mask));
+		if (pfn & mask) {
+			gfn &= ~mask;
+			*ipap &= ~(PMD_SIZE - 1);
+			kvm_release_pfn_clean(pfn);
+			pfn &= ~mask;
+			kvm_get_pfn(pfn);
+			*pfnp = pfn;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  gfn_t gfn, struct kvm_memory_slot *memslot,
+			  struct kvm_memory_slot *memslot,
 			  unsigned long fault_status)
 {
-	pte_t new_pte;
-	pfn_t pfn;
 	int ret;
-	bool write_fault, writable;
+	bool write_fault, writable, hugetlb = false, force_pte = false;
 	unsigned long mmu_seq;
+	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
+	unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
+	struct vm_area_struct *vma;
+	pfn_t pfn;
+	unsigned long psize;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -525,6 +638,27 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	/* Let's check if we will get back a huge page */
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma_intersection(current->mm, hva, hva + 1);
+	if (is_vm_hugetlb_page(vma)) {
+		hugetlb = true;
+		hva &= PMD_MASK;
+		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
+		psize = PMD_SIZE;
+	} else {
+		psize = PAGE_SIZE;
+		if (vma->vm_start & ~PMD_MASK)
+			force_pte = true;
+	}
+	up_read(&current->mm->mmap_sem);
+
+	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
+	if (is_error_pfn(pfn))
+		return -EFAULT;
+
+	coherent_icache_guest_page(kvm, hva, psize);
+
 	/* We need minimum second+third level pages */
 	ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
 	if (ret)
@@ -542,26 +676,34 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 */
 	smp_rmb();
 
-	pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
-	if (is_error_pfn(pfn))
-		return -EFAULT;
-
-	new_pte = pfn_pte(pfn, PAGE_S2);
-	coherent_icache_guest_page(vcpu->kvm, gfn);
-
-	spin_lock(&vcpu->kvm->mmu_lock);
-	if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
+	spin_lock(&kvm->mmu_lock);
+	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
-	if (writable) {
-		kvm_set_s2pte_writable(&new_pte);
-		kvm_set_pfn_dirty(pfn);
+	if (!hugetlb && !force_pte)
+		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
+
+	if (hugetlb) {
+		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
+		new_pmd = pmd_mkhuge(new_pmd);
+		if (writable) {
+			kvm_set_s2pmd_writable(&new_pmd);
+			kvm_set_pfn_dirty(pfn);
+		}
+		ret = stage2_set_pmd(kvm, memcache, fault_ipa, &new_pmd);
+	} else {
+		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
+		if (writable) {
+			kvm_set_s2pte_writable(&new_pte);
+			kvm_set_pfn_dirty(pfn);
+		}
+		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
 	}
-	stage2_set_pte(vcpu->kvm, memcache, fault_ipa, &new_pte, false);
+
 
 out_unlock:
-	spin_unlock(&vcpu->kvm->mmu_lock);
+	spin_unlock(&kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
-	return 0;
+	return ret;
 }
 
 /**
@@ -630,7 +772,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 
-	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot, fault_status);
+	ret = user_mem_abort(vcpu, fault_ipa, memslot, fault_status);
 	if (ret == 0)
 		ret = 1;
 out_unlock:
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index efe609c..e7f3852 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -91,6 +91,7 @@ int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
 #define	kvm_set_pte(ptep, pte)		set_pte(ptep, pte)
+#define	kvm_set_pmd(pmdp, pmd)		set_pmd(pmdp, pmd)
 
 static inline bool kvm_is_write_fault(unsigned long esr)
 {
@@ -116,13 +117,18 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
 	pte_val(*pte) |= PTE_S2_RDWR;
 }
 
+static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
+{
+	pmd_val(*pmd) |= PTE_S2_RDWR;
+}
+
 struct kvm;
 
-static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
+					      unsigned long size)
 {
 	if (!icache_is_aliasing()) {		/* PIPT */
-		unsigned long hva = gfn_to_hva(kvm, gfn);
-		flush_icache_range(hva, hva + PAGE_SIZE);
+		flush_icache_range(hva, hva + size);
 	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
 		/* any kind of VIPT cache */
 		__flush_icache_all();
-- 
1.7.10.4
