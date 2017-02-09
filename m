From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Feb 2017 14:59:09 +0000
Subject: [PATCH 11/25] arm/arm64: KVM: Enforce unconditional flush to PoC when
 mapping to stage-2
In-Reply-To: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
References: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1486652363-7696-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we fault in a page, we flush it to the PoC (Point of Coherency)
if the faulting vcpu has its own caches off, so that it can observe
the page we just brought it.

But if the vcpu has its caches on, we skip that step. Bad things
happen when *another* vcpu tries to access that page with its own
caches disabled. At that point, there is no garantee that the
data has made it to the PoC, and we access stale data.

The obvious fix is to always flush to PoC when a page is faulted
in, no matter what the state of the vcpu is.

Cc: stable at vger.kernel.org
Fixes: 2d58b733c876 ("arm64: KVM: force cache clean on page fault when caches are off")
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   | 9 +--------
 arch/arm64/include/asm/kvm_mmu.h | 3 +--
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 74a44727..a58bbaa 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -150,18 +150,12 @@ static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
 	 * and iterate over the range.
 	 */
 
-	bool need_flush = !vcpu_has_cache_enabled(vcpu) || ipa_uncached;
-
 	VM_BUG_ON(size & ~PAGE_MASK);
 
-	if (!need_flush && !icache_is_pipt())
-		goto vipt_cache;
-
 	while (size) {
 		void *va = kmap_atomic_pfn(pfn);
 
-		if (need_flush)
-			kvm_flush_dcache_to_poc(va, PAGE_SIZE);
+		kvm_flush_dcache_to_poc(va, PAGE_SIZE);
 
 		if (icache_is_pipt())
 			__cpuc_coherent_user_range((unsigned long)va,
@@ -173,7 +167,6 @@ static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
 		kunmap_atomic(va);
 	}
 
-vipt_cache:
 	if (!icache_is_pipt() && !icache_is_vivt_asid_tagged()) {
 		/* any kind of VIPT cache */
 		__flush_icache_all();
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6f72fe8..6d22017 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -241,8 +241,7 @@ static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
 {
 	void *va = page_address(pfn_to_page(pfn));
 
-	if (!vcpu_has_cache_enabled(vcpu) || ipa_uncached)
-		kvm_flush_dcache_to_poc(va, size);
+	kvm_flush_dcache_to_poc(va, size);
 
 	if (!icache_is_aliasing()) {		/* PIPT */
 		flush_icache_range((unsigned long)va,
-- 
2.1.4
