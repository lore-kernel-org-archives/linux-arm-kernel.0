From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 18 May 2018 11:07:01 +0100
Subject: [PATCH v4 2/3] arm64: KVM: Enable Common Not Private translations
In-Reply-To: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1526638022-4137-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We rely on cpufeature framework to detect and enable CNP so for KVM we
need to patch hyp to set CNP bit just before TTBR0_EL2 gets written.

For the guest we encode CNP bit while building vttbr, so we don't need
to bother with that in a world switch.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   | 5 +++++
 arch/arm64/include/asm/kvm_mmu.h | 5 +++++
 arch/arm64/kvm/hyp-init.S        | 3 +++
 virt/kvm/arm/arm.c               | 4 ++--
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 707a1f0..9c83710 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -321,6 +321,11 @@ static inline int kvm_map_vectors(void)
 
 #define kvm_phys_to_vttbr(addr)		(addr)
 
+static inline bool kvm_cpu_has_cnp(void)
+{
+	return false;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 0821109..c9ee6c3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -459,5 +459,10 @@ static inline int kvm_map_vectors(void)
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 
+static inline bool kvm_cpu_has_cnp(void)
+{
+	return system_supports_cnp();
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 6fd91b3..94998d5 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -64,6 +64,9 @@ __do_hyp_init:
 	b.lo	__kvm_handle_stub_hvc
 
 	phys_to_ttbr x4, x0
+alternative_if ARM64_HAS_CNP
+	orr	x4, x4, #TTBR_CNP_BIT
+alternative_else_nop_endif
 	msr	ttbr0_el2, x4
 
 	mrs	x4, tcr_el1
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a4c1b76..9a651a2 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -472,7 +472,7 @@ static bool need_new_vmid_gen(struct kvm *kvm)
 static void update_vttbr(struct kvm *kvm)
 {
 	phys_addr_t pgd_phys;
-	u64 vmid;
+	u64 vmid, cnp = kvm_cpu_has_cnp() ? 1 : 0;
 	bool new_gen;
 
 	read_lock(&kvm_vmid_lock);
@@ -522,7 +522,7 @@ static void update_vttbr(struct kvm *kvm)
 	pgd_phys = virt_to_phys(kvm->arch.pgd);
 	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
-	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
+	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
 
 	write_unlock(&kvm_vmid_lock);
 }
-- 
2.0.0
