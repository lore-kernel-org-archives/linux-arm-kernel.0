From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Jun 2013 19:17:40 -0700
Subject: [RFC PATCH 1/2] KVM: ARM: Transparent huge pages and hugetlbfs support
Message-ID: <1371521861-372-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@cs.columbia.edu>

Support transparent huge pages in 32-bit KVM/ARM.  The whole
transparent_hugepage_adjust stuff is far from pretty, but this is how
it's solved on x86 so we duplicate their logic.  This should be shared
across architectures if possible (like many other things), but can
always be changed down the road.

The pud_huge checking on the unmap path may feel a bit silly as the
pud_huge check is always defined to false, but the compiler should be
smart about this.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_host.h |   7 +-
 arch/arm/include/asm/kvm_mmu.h  |   6 +-
 arch/arm/kvm/mmu.c              | 158 +++++++++++++++++++++++++++++++++-------
 3 files changed, 137 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 1f3cee2..45a165e 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -33,10 +33,9 @@
 
 #define KVM_VCPU_MAX_FEATURES 1
 
-/* We don't currently support large pages. */
-#define KVM_HPAGE_GFN_SHIFT(x)	0
-#define KVM_NR_PAGE_SIZES	1
-#define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
+#define KVM_HPAGE_GFN_SHIFT(_level)	(((_level) - 1) * 21)
+#define KVM_HPAGE_SIZE			(1UL << KVM_HPAGE_GFN_SHIFT(2))
+#define KVM_PAGES_PER_HPAGE		(KVM_HPAGE_SIZE / PAGE_SIZE)
 
 #include <kvm/arm_vgic.h>
 
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 472ac70..9ef71b1 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -105,7 +105,8 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
 
 struct kvm;
 
-static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
+					      unsigned long size)
 {
 	/*
 	 * If we are going to insert an instruction page and the icache is
@@ -120,8 +121,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
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
index ca6bea4..9170c98 100644
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
@@ -87,19 +88,27 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 
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
+	if (pmd_huge(*pmd)) {
+		pmd_clear(pmd);
+	} else {
+		pte_t *pte_table = pte_offset_kernel(pmd, 0);
+		pmd_clear(pmd);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
+		pte_free_kernel(NULL, pte_table);
+	}
 	put_page(virt_to_page(pmd));
 }
 
@@ -142,12 +151,34 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 			continue;
 		}
 
+		if (pud_huge(*pud)) {
+			/*
+			 * If we are dealing with a huge pud, just clear it and
+			 * move on.
+			 */
+			clear_pud_entry(kvm, pud, addr);
+			addr += PUD_SIZE;
+			continue;
+		}
+
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
 			addr += PMD_SIZE;
 			continue;
 		}
 
+		if (pmd_huge(*pmd)) {
+			/*
+			 * If we are dealing with a huge pmd, just clear it and
+			 * walk back up the ladder.
+			 */
+			clear_pmd_entry(kvm, pmd, addr);
+			if (pmd_empty(pmd))
+				clear_pud_entry(kvm, pud, addr);
+			addr += PMD_SIZE;
+			continue;
+		}
+
 		pte = pte_offset_kernel(pmd, addr);
 		clear_pte_entry(kvm, pte, addr);
 		range = PAGE_SIZE;
@@ -432,7 +463,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd;
+	pmd_t *pmd, old_pmd;
 	pte_t *pte, old_pte;
 
 	/* Create 2nd stage page table mapping - Level 1 */
@@ -448,7 +479,22 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 
 	pmd = pmd_offset(pud, addr);
 
-	/* Create 2nd stage page table mapping - Level 2 */
+	/* Create 2nd stage section mappings (huge tlb pages) - Level 2 */
+	if (pte_huge(*new_pte) || pmd_huge(*pmd)) {
+		pte_t *huge_pte = (pte_t *)pmd;
+		VM_BUG_ON(pmd_present(*pmd) && !pmd_huge(*pmd));
+
+		old_pmd = *pmd;
+		kvm_set_pte(huge_pte, *new_pte); /* new_pte really new_pmd */
+		if (pmd_present(old_pmd))
+			kvm_tlb_flush_vmid_ipa(kvm, addr);
+		else
+			get_page(virt_to_page(pmd));
+		return 0;
+	}
+
+	/* Create 2nd stage page mappings - Level 2 */
+	BUG_ON(pmd_present(*pmd) && pmd_huge(*pmd));
 	if (pmd_none(*pmd)) {
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
@@ -514,16 +560,55 @@ out:
 	return ret;
 }
 
+static bool transparent_hugepage_adjust(struct kvm *kvm, pfn_t *pfnp,
+					phys_addr_t *ipap)
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
+		mask = KVM_PAGES_PER_HPAGE - 1;
+		VM_BUG_ON((gfn & mask) != (pfn & mask));
+		if (pfn & mask) {
+			gfn &= ~mask;
+			*ipap &= ~(KVM_HPAGE_SIZE - 1);
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
+	pte_t new_pte;
+	unsigned long psize;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -531,6 +616,27 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
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
@@ -548,26 +654,24 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
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
+	if (!hugetlb && !force_pte)
+		hugetlb = transparent_hugepage_adjust(kvm, &pfn, &fault_ipa);
+	new_pte = pfn_pte(pfn, PAGE_S2);
+	if (hugetlb)
+		new_pte = pte_mkhuge(new_pte);
 	if (writable) {
 		kvm_set_s2pte_writable(&new_pte);
 		kvm_set_pfn_dirty(pfn);
 	}
-	stage2_set_pte(vcpu->kvm, memcache, fault_ipa, &new_pte, false);
+	ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
 
 out_unlock:
-	spin_unlock(&vcpu->kvm->mmu_lock);
+	spin_unlock(&kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
-	return 0;
+	return ret;
 }
 
 /**
@@ -636,7 +740,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 
-	ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot, fault_status);
+	ret = user_mem_abort(vcpu, fault_ipa, memslot, fault_status);
 	if (ret == 0)
 		ret = 1;
 out_unlock:
-- 
1.8.1.2
