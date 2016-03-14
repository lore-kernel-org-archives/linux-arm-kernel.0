From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 14 Mar 2016 16:53:10 +0000
Subject: [RFC PATCH 11/12] kvm-arm: Cleanup stage2 pgd handling
In-Reply-To: <1457974391-28456-1-git-send-email-suzuki.poulose@arm.com>
References: <1457974391-28456-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1457974391-28456-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we don't have any fake page table levels for arm64,
cleanup the common code to get rid of the dead code.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |   20 --------------------
 arch/arm/kvm/arm.c               |    2 +-
 arch/arm/kvm/mmu.c               |   25 ++++++++-----------------
 arch/arm64/include/asm/kvm_mmu.h |   18 ------------------
 4 files changed, 9 insertions(+), 56 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index e670afa..02b2b3d 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -254,26 +254,6 @@ static inline bool kvm_pud_table_empty(struct kvm *kvm, pud_t *pudp)
 	return 0;
 }
 
-
-static inline void *kvm_get_hwpgd(struct kvm *kvm)
-{
-	return kvm->arch.pgd;
-}
-
-static inline unsigned int kvm_get_hwpgd_size(void)
-{
-	return PTRS_PER_S2_PGD * sizeof(pgd_t);
-}
-
-static inline pgd_t *kvm_setup_fake_pgd(pgd_t *hwpgd)
-{
-	return hwpgd;
-}
-
-static inline void kvm_free_fake_pgd(pgd_t *pgd)
-{
-}
-
 struct kvm;
 
 #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index dda1959..a1443ef 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -443,7 +443,7 @@ static void update_vttbr(struct kvm *kvm)
 	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
 
 	/* update vttbr to be used with the new vmid */
-	pgd_phys = virt_to_phys(kvm_get_hwpgd(kvm));
+	pgd_phys = virt_to_phys(kvm->arch.pgd);
 	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
 	kvm->arch.vttbr = pgd_phys | vmid;
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 8568790..a283e7b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -637,6 +637,11 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t phys_addr)
 				     __phys_to_pfn(phys_addr), PAGE_HYP_DEVICE);
 }
 
+static inline unsigned int kvm_get_hwpgd_size(void)
+{
+	return PTRS_PER_S2_PGD * sizeof(pgd_t);
+}
+
 /* Free the HW pgd, one page at a time */
 static void kvm_free_hwpgd(void *hwpgd)
 {
@@ -665,29 +670,16 @@ static void *kvm_alloc_hwpgd(void)
 int kvm_alloc_stage2_pgd(struct kvm *kvm)
 {
 	pgd_t *pgd;
-	void *hwpgd;
 
 	if (kvm->arch.pgd != NULL) {
 		kvm_err("kvm_arch already initialized?\n");
 		return -EINVAL;
 	}
 
-	hwpgd = kvm_alloc_hwpgd();
-	if (!hwpgd)
+	pgd = kvm_alloc_hwpgd();
+	if (!pgd)
 		return -ENOMEM;
 
-	/*
-	 * When the kernel uses more levels of page tables than the
-	 * guest, we allocate a fake PGD and pre-populate it to point
-	 * to the next-level page table, which will be the real
-	 * initial page table pointed to by the VTTBR.
-	 */
-	pgd = kvm_setup_fake_pgd(hwpgd);
-	if (IS_ERR(pgd)) {
-		kvm_free_hwpgd(hwpgd);
-		return PTR_ERR(pgd);
-	}
-
 	kvm_clean_pgd(pgd);
 	kvm->arch.pgd = pgd;
 	return 0;
@@ -791,8 +783,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 		return;
 
 	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
-	kvm_free_hwpgd(kvm_get_hwpgd(kvm));
-	kvm_free_fake_pgd(kvm->arch.pgd);
+	kvm_free_hwpgd(kvm->arch.pgd);
 	kvm->arch.pgd = NULL;
 }
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a6f9846..e998f63 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -242,24 +242,6 @@ static inline phys_addr_t kvm_pgd_index(struct kvm *kvm, phys_addr_t addr)
 	return kvm ? stage2_pgd_index(addr) : pgd_index(addr);
 }
 
-static inline void *kvm_get_hwpgd(struct kvm *kvm)
-{
-	return kvm->arch.pgd;
-}
-
-static inline unsigned int kvm_get_hwpgd_size(void)
-{
-	return PTRS_PER_S2_PGD * sizeof(pgd_t);
-}
-
-static inline pgd_t *kvm_setup_fake_pgd(pgd_t *hwpgd)
-{
-	return hwpgd;
-}
-
-static inline void kvm_free_fake_pgd(pgd_t *pgd)
-{
-}
 static inline bool kvm_page_empty(void *ptr)
 {
 	struct page *ptr_page = virt_to_page(ptr);
-- 
1.7.9.5
