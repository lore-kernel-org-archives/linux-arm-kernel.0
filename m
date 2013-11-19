From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Nov 2013 13:58:09 -0500
Subject: [PATCH v2] arm/arm64: kvm: Use virt_to_idmap instead of virt_to_phys
 for idmap mappings
Message-ID: <1384887489-15290-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM initialisation fails on architectures implementing virt_to_idmap()
because virt_to_phys() on such architectures won't fetch you the correct
idmap page.

So update the KVM ARM code to use the virt_to_idmap() to fix the issue.
Since the KVM code is shared between arm and arm64, we create
kvm_virt_to_phys() and handle the redirection in respective headers.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Update the earlier version as per Marc's suggestion

 arch/arm/include/asm/kvm_mmu.h   |    1 +
 arch/arm/kvm/mmu.c               |    8 ++++----
 arch/arm64/include/asm/kvm_mmu.h |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 77de4a4..2d122ad 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -140,6 +140,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
 }
 
 #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
+#define kvm_virt_to_phys(x)		virt_to_idmap((unsigned long)(x))
 
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 5809069..659db0e 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -916,9 +916,9 @@ int kvm_mmu_init(void)
 {
 	int err;
 
-	hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
-	hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
-	hyp_idmap_vector = virt_to_phys(__kvm_hyp_init);
+	hyp_idmap_start = kvm_virt_to_phys(__hyp_idmap_text_start);
+	hyp_idmap_end = kvm_virt_to_phys(__hyp_idmap_text_end);
+	hyp_idmap_vector = kvm_virt_to_phys(__kvm_hyp_init);
 
 	if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
 		/*
@@ -945,7 +945,7 @@ int kvm_mmu_init(void)
 		 */
 		kvm_flush_dcache_to_poc(init_bounce_page, len);
 
-		phys_base = virt_to_phys(init_bounce_page);
+		phys_base = kvm_virt_to_phys(init_bounce_page);
 		hyp_idmap_vector += phys_base - hyp_idmap_start;
 		hyp_idmap_start = phys_base;
 		hyp_idmap_end = phys_base + len;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 680f74e..7f1f940 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -136,6 +136,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
 }
 
 #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
+#define kvm_virt_to_phys(x)		__virt_to_phys((unsigned long)(x))
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
-- 
1.7.9.5
