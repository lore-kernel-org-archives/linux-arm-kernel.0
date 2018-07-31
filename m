From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 31 Jul 2018 14:08:57 +0100
Subject: [PATCH v6 2/3] arm64: KVM: Enable Common Not Private translations
In-Reply-To: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
References: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1533042538-26184-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We rely on cpufeature framework to detect and enable CNP so for KVM we
need to patch hyp to set CNP bit just before TTBR0_EL2 gets written.

For the guest we encode CNP bit while building vttbr, so we don't need
to bother with that in a world switch.

Reviewed-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/kvm_arm.h   | 1 +
 arch/arm/include/asm/kvm_mmu.h   | 5 +++++
 arch/arm64/include/asm/kvm_arm.h | 1 +
 arch/arm64/include/asm/kvm_mmu.h | 5 +++++
 arch/arm64/kvm/hyp-init.S        | 3 +++
 virt/kvm/arm/arm.c               | 4 ++--
 6 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 3ab8b37..2d43dca 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -161,6 +161,7 @@
 #else
 #define VTTBR_X		(5 - KVM_T0SZ)
 #endif
+#define VTTBR_CNP_BIT     _AC(1, UL)
 #define VTTBR_BADDR_MASK  (((_AC(1, ULL) << (40 - VTTBR_X)) - 1) << VTTBR_X)
 #define VTTBR_VMID_SHIFT  _AC(48, ULL)
 #define VTTBR_VMID_MASK(size)	(_AT(u64, (1 << size) - 1) << VTTBR_VMID_SHIFT)
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 8553d68..98d1753 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -363,6 +363,11 @@ static inline int hyp_map_aux_data(void)
 
 #define kvm_phys_to_vttbr(addr)		(addr)
 
+static inline bool kvm_cpu_has_cnp(void)
+{
+	return false;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6dd285e..0b5a849 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -174,6 +174,7 @@
 #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
 #define VTTBR_X				(VTTBR_X_TGRAN_MAGIC - VTCR_EL2_T0SZ_IPA)
 
+#define VTTBR_CNP_BIT     (UL(1))
 #define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_X)
 #define VTTBR_VMID_SHIFT  (UL(48))
 #define VTTBR_VMID_MASK(size) (_AT(u64, (1 << size) - 1) << VTTBR_VMID_SHIFT)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index fb9a712..b66b13f 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -498,5 +498,10 @@ static inline int hyp_map_aux_data(void)
 
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
index 04e554c..221b127 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -490,7 +490,7 @@ static bool need_new_vmid_gen(struct kvm *kvm)
 static void update_vttbr(struct kvm *kvm)
 {
 	phys_addr_t pgd_phys;
-	u64 vmid;
+	u64 vmid, cnp = kvm_cpu_has_cnp() ? VTTBR_CNP_BIT : 0;
 	bool new_gen;
 
 	read_lock(&kvm_vmid_lock);
@@ -540,7 +540,7 @@ static void update_vttbr(struct kvm *kvm)
 	pgd_phys = virt_to_phys(kvm->arch.pgd);
 	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
-	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
+	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
 
 	write_unlock(&kvm_vmid_lock);
 }
-- 
2.0.0
