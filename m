From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jan 2014 14:56:37 +0000
Subject: [PATCH v2 05/10] ARM: KVM: force cache clean on page fault when
 caches are off
In-Reply-To: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
References: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1390402602-22777-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for the guest with caches off to observe data written
contained in a given page, we need to make sure that page is
committed to memory, and not just hanging in the cache (as
guest accesses are completely bypassing the cache until it
decides to enable it).

For this purpose, hook into the coherent_cache_guest_page
function and flush the region if the guest SCTLR
register doesn't show the MMU and caches as being enabled.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index cbab9ba..fa023e2 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -116,9 +116,14 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 
 struct kvm;
 
+#define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
+
 static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 					     unsigned long size)
 {
+	if ((vcpu->arch.cp15[c1_SCTLR] & 0b101) != 0b101)
+		kvm_flush_dcache_to_poc((void *)hva, size);
+	
 	/*
 	 * If we are going to insert an instruction page and the icache is
 	 * either VIPT or PIPT, there is a potential problem where the host
@@ -139,8 +144,6 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	}
 }
 
-#define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
-
 void stage2_flush_vm(struct kvm *kvm);
 
 #endif	/* !__ASSEMBLY__ */
-- 
1.8.3.4
