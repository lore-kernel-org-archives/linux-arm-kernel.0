From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:46 -0500
Subject: [RFC 50/55] KVM: arm/arm64: Abstract kvm_phys_addr_ioremap() function
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-51-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original kvm_phys_addr_ioremap function only uses mmu pointing to
the VM's mmu context. However, it would be very useful to reuse this
function for the nested mmu context. Therefore, create a function named
__kvm_phys_addr_ioremapp which takes mmu as an argument, and let
kvm_phys_addr_ioremap calls this function with the VM's mmu context.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/kvm/mmu.c               | 18 +++++++++++++-----
 arch/arm64/include/asm/kvm_mmu.h |  3 +++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 344bc01..2cd6a19 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1058,15 +1058,16 @@ static int stage2_pmdp_test_and_clear_young(pmd_t *pmd)
 }
 
 /**
- * kvm_phys_addr_ioremap - map a device range to guest IPA
+ * __kvm_phys_addr_ioremap - map a device range to guest IPA
  *
  * @kvm:	The KVM pointer
  * @guest_ipa:	The IPA at which to insert the mapping
  * @pa:		The physical address of the device
  * @size:	The size of the mapping
  */
-int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size, bool writable)
+int __kvm_phys_addr_ioremap(struct kvm *kvm, struct kvm_s2_mmu *mmu,
+			    phys_addr_t guest_ipa, phys_addr_t pa,
+			    unsigned long size, bool writable)
 {
 	phys_addr_t addr, end;
 	int ret = 0;
@@ -1087,8 +1088,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(&kvm->arch.mmu, &cache, addr, &pte,
-						KVM_S2PTE_FLAG_IS_IOMAP);
+		ret = stage2_set_pte(mmu, &cache, addr, &pte,
+				     KVM_S2PTE_FLAG_IS_IOMAP);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -1101,6 +1102,13 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	return ret;
 }
 
+int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size, bool writable)
+{
+	return __kvm_phys_addr_ioremap(kvm, &kvm->arch.mmu, guest_ipa, pa,
+				       size, writable);
+}
+
 static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, gfn_t gfn,
 					phys_addr_t *ipap)
 {
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 7754f3e..ec9e5e9 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -149,6 +149,9 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
 int __kvm_alloc_stage2_pgd(struct kvm_s2_mmu *mmu);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 void __kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
+int __kvm_phys_addr_ioremap(struct kvm *kvm, struct kvm_s2_mmu *mmu,
+			    phys_addr_t guest_ipa, phys_addr_t pa,
+			    unsigned long size, bool writable);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 			  phys_addr_t pa, unsigned long size, bool writable);
 void kvm_unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
-- 
1.9.1
