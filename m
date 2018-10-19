From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:38 +0100
Subject: [PATCH 03/26] kvm: arm64: Add helper for loading the stage2 setting
 for a VM
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We load the stage2 context of a guest for different operations,
including running the guest and tlb maintenance on behalf of the
guest. As of now only the vttbr is private to the guest, but this
is about to change with IPA per VM. Add a helper to load the stage2
configuration for a VM, which could do the right thing with the
future changes.

Cc: Christoffer Dall <cdall@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_hyp.h | 9 +++++++++
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 arch/arm64/kvm/hyp/tlb.c         | 4 ++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 384c34397619..d1bd1e0f14d7 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -155,5 +155,14 @@ void deactivate_traps_vhe_put(void);
 u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
 void __noreturn __hyp_do_panic(unsigned long, ...);
 
+/*
+ * Must be called from hyp code running at EL2 with an updated VTTBR
+ * and interrupts disabled.
+ */
+static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
+{
+	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+}
+
 #endif /* __ARM64_KVM_HYP_H__ */
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index ca46153d7915..9d5ce1a3039a 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -198,7 +198,7 @@ void deactivate_traps_vhe_put(void)
 
 static void __hyp_text __activate_vm(struct kvm *kvm)
 {
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	__load_guest_stage2(kvm);
 }
 
 static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index 131c7772703c..4dbd9c69a96d 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -30,7 +30,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
 	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
 	 * let's flip TGE before executing the TLB operation.
 	 */
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	__load_guest_stage2(kvm);
 	val = read_sysreg(hcr_el2);
 	val &= ~HCR_TGE;
 	write_sysreg(val, hcr_el2);
@@ -39,7 +39,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
 
 static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
 {
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	__load_guest_stage2(kvm);
 	isb();
 }
 
-- 
2.19.1
