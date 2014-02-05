From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Feb 2014 19:55:46 +0000
Subject: [PATCH v3 06/11] ARM: KVM: force cache clean on page fault when
 caches are off
In-Reply-To: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1391630151-7875-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for a guest with caches disabled to observe data written
contained in a given page, we need to make sure that page is
committed to memory, and not just hanging in the cache (as guest
accesses are completely bypassing the cache until it decides to
enable it).

For this purpose, hook into the coherent_cache_guest_page
function and flush the region if the guest SCTLR
register doesn't show the MMU and caches as being enabled.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 0931cda..b62ca91 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -122,9 +122,19 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 
 struct kvm;
 
+#define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
+
+static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
+{
+	return (vcpu->arch.cp15[c1_SCTLR] & 0b101) == 0b101;
+}
+
 static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 					     unsigned long size)
 {
+	if (!vcpu_has_cache_enabled(vcpu))
+		kvm_flush_dcache_to_poc((void *)hva, size);
+	
 	/*
 	 * If we are going to insert an instruction page and the icache is
 	 * either VIPT or PIPT, there is a potential problem where the host
@@ -145,7 +155,6 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	}
 }
 
-#define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
 #define kvm_virt_to_phys(x)		virt_to_idmap((unsigned long)(x))
 
 void stage2_flush_vm(struct kvm *kvm);
-- 
1.8.3.4
