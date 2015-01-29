From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 Jan 2015 23:37:57 +0100
Subject: [GIT PULL 3/3] arm/arm64: KVM: Use kernel mapping to perform
 invalidation on page fault
In-Reply-To: <1422571077-14576-1-git-send-email-christoffer.dall@linaro.org>
References: <1422571077-14576-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422571077-14576-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When handling a fault in stage-2, we need to resync I$ and D$, just
to be sure we don't leave any old cache line behind.

That's very good, except that we do so using the *user* address.
Under heavy load (swapping like crazy), we may end up in a situation
where the page gets mapped in stage-2 while being unmapped from
userspace by another CPU.

At that point, the DC/IC instructions can generate a fault, which
we handle with kvm->mmu_lock held. The box quickly deadlocks, user
is unhappy.

Instead, perform this invalidation through the kernel mapping,
which is guaranteed to be present. The box is much happier, and so
am I.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   | 43 +++++++++++++++++++++++++++++++---------
 arch/arm/kvm/mmu.c               | 12 +++++++----
 arch/arm64/include/asm/kvm_mmu.h | 13 +++++++-----
 3 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 552c31f..1bca8f8 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -162,13 +162,10 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 	return (vcpu->arch.cp15[c1_SCTLR] & 0b101) == 0b101;
 }
 
-static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
-					     unsigned long size,
-					     bool ipa_uncached)
+static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu, pfn_t pfn,
+					       unsigned long size,
+					       bool ipa_uncached)
 {
-	if (!vcpu_has_cache_enabled(vcpu) || ipa_uncached)
-		kvm_flush_dcache_to_poc((void *)hva, size);
-	
 	/*
 	 * If we are going to insert an instruction page and the icache is
 	 * either VIPT or PIPT, there is a potential problem where the host
@@ -180,10 +177,38 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	 *
 	 * VIVT caches are tagged using both the ASID and the VMID and doesn't
 	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
+	 *
+	 * We need to do this through a kernel mapping (using the
+	 * user-space mapping has proved to be the wrong
+	 * solution). For that, we need to kmap one page at a time,
+	 * and iterate over the range.
 	 */
-	if (icache_is_pipt()) {
-		__cpuc_coherent_user_range(hva, hva + size);
-	} else if (!icache_is_vivt_asid_tagged()) {
+
+	bool need_flush = !vcpu_has_cache_enabled(vcpu) || ipa_uncached;
+
+	VM_BUG_ON(size & PAGE_MASK);
+
+	if (!need_flush && !icache_is_pipt())
+		goto vipt_cache;
+
+	while (size) {
+		void *va = kmap_atomic_pfn(pfn);
+
+		if (need_flush)
+			kvm_flush_dcache_to_poc(va, PAGE_SIZE);
+
+		if (icache_is_pipt())
+			__cpuc_coherent_user_range((unsigned long)va,
+						   (unsigned long)va + PAGE_SIZE);
+
+		size -= PAGE_SIZE;
+		pfn++;
+
+		kunmap_atomic(va);
+	}
+
+vipt_cache:
+	if (!icache_is_pipt() && !icache_is_vivt_asid_tagged()) {
 		/* any kind of VIPT cache */
 		__flush_icache_all();
 	}
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 78e68ab..1366625 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -957,6 +957,12 @@ static bool kvm_is_device_pfn(unsigned long pfn)
 	return !pfn_valid(pfn);
 }
 
+static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, pfn_t pfn,
+				      unsigned long size, bool uncached)
+{
+	__coherent_cache_guest_page(vcpu, pfn, size, uncached);
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1046,8 +1052,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_s2pmd_writable(&new_pmd);
 			kvm_set_pfn_dirty(pfn);
 		}
-		coherent_cache_guest_page(vcpu, hva & PMD_MASK, PMD_SIZE,
-					  fault_ipa_uncached);
+		coherent_cache_guest_page(vcpu, pfn, PMD_SIZE, fault_ipa_uncached);
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
 		pte_t new_pte = pfn_pte(pfn, mem_type);
@@ -1055,8 +1060,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
-		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
-					  fault_ipa_uncached);
+		coherent_cache_guest_page(vcpu, pfn, PAGE_SIZE, fault_ipa_uncached);
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
 			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
 	}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index cbdc236..adcf495 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -243,15 +243,18 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 	return (vcpu_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
 }
 
-static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
-					     unsigned long size,
-					     bool ipa_uncached)
+static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu, pfn_t pfn,
+					       unsigned long size,
+					       bool ipa_uncached)
 {
+	void *va = page_address(pfn_to_page(pfn));
+
 	if (!vcpu_has_cache_enabled(vcpu) || ipa_uncached)
-		kvm_flush_dcache_to_poc((void *)hva, size);
+		kvm_flush_dcache_to_poc(va, size);
 
 	if (!icache_is_aliasing()) {		/* PIPT */
-		flush_icache_range(hva, hva + size);
+		flush_icache_range((unsigned long)va,
+				   (unsigned long)va + size);
 	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
 		/* any kind of VIPT cache */
 		__flush_icache_all();
-- 
2.1.2.330.g565301e.dirty
