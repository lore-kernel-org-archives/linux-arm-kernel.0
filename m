From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:04 +0100
Subject: [GIT PULL 5/9] arm,
 arm64: KVM: allow forced dcache flush on page faults
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laszlo Ersek <lersek@redhat.com>

To allow handling of incoherent memslots in a subsequent patch, this
patch adds a paramater 'ipa_uncached' to cache_coherent_guest_page()
so that we can instruct it to flush the page's contents to DRAM even
if the guest has caching globally enabled.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   | 5 +++--
 arch/arm/kvm/mmu.c               | 9 +++++++--
 arch/arm64/include/asm/kvm_mmu.h | 5 +++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index acb0d57..f867060 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -161,9 +161,10 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 }
 
 static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
-					     unsigned long size)
+					     unsigned long size,
+					     bool ipa_uncached)
 {
-	if (!vcpu_has_cache_enabled(vcpu))
+	if (!vcpu_has_cache_enabled(vcpu) || ipa_uncached)
 		kvm_flush_dcache_to_poc((void *)hva, size);
 	
 	/*
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b007438..cb924c6 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -852,6 +852,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct vm_area_struct *vma;
 	pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
+	bool fault_ipa_uncached;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -918,6 +919,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (!hugetlb && !force_pte)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
+	fault_ipa_uncached = false;
+
 	if (hugetlb) {
 		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
 		new_pmd = pmd_mkhuge(new_pmd);
@@ -925,7 +928,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_s2pmd_writable(&new_pmd);
 			kvm_set_pfn_dirty(pfn);
 		}
-		coherent_cache_guest_page(vcpu, hva & PMD_MASK, PMD_SIZE);
+		coherent_cache_guest_page(vcpu, hva & PMD_MASK, PMD_SIZE,
+					  fault_ipa_uncached);
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
 		pte_t new_pte = pfn_pte(pfn, mem_type);
@@ -933,7 +937,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
-		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
+		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
+					  fault_ipa_uncached);
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
 			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
 	}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 0caf7a5..123b521 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -243,9 +243,10 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 }
 
 static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
-					     unsigned long size)
+					     unsigned long size,
+					     bool ipa_uncached)
 {
-	if (!vcpu_has_cache_enabled(vcpu))
+	if (!vcpu_has_cache_enabled(vcpu) || ipa_uncached)
 		kvm_flush_dcache_to_poc((void *)hva, size);
 
 	if (!icache_is_aliasing()) {		/* PIPT */
-- 
2.1.2.330.g565301e.dirty
