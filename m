From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Wed, 14 Aug 2013 17:17:12 +0530
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host with
 external L3-cache.
Message-ID: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Systems with large external L3-cache (few MBs), might have dirty
content belonging to the guest page in L3-cache. To tackle this,
we need to flush such dirty content from d-cache so that guest
will see correct contents of guest page when guest MMU is disabled.

The patch fixes coherent_icache_guest_page() for external L3-cache.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/include/asm/kvm_mmu.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index efe609c..5129038 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -123,6 +123,8 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
 	if (!icache_is_aliasing()) {		/* PIPT */
 		unsigned long hva = gfn_to_hva(kvm, gfn);
 		flush_icache_range(hva, hva + PAGE_SIZE);
+		/* Flush d-cache for systems with external caches. */
+		__flush_dcache_area((void *) hva, PAGE_SIZE);
 	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
 		/* any kind of VIPT cache */
 		__flush_icache_all();
-- 
1.7.9.5
