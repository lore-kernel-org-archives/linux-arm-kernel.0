From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 13:11:54 +0000
Subject: [PATCH 16/21] arm64: KVM: Add compatibility aliases
In-Reply-To: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
References: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1447679519-17888-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we've implemented the new world switch with a completely
different namespace, so that we could have both implementation
compiled in.

Let's take things one step further by adding weak aliases that
have the same names as the original implementation. The weak
attributes allows the new implementation to be overriden by the
old one, and everything still work.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/debug-sr.c   | 3 +++
 arch/arm64/kvm/hyp/hyp-entry.S  | 3 +++
 arch/arm64/kvm/hyp/switch.c     | 3 +++
 arch/arm64/kvm/hyp/tlb.c        | 9 +++++++++
 arch/arm64/kvm/hyp/vgic-v3-sr.c | 3 +++
 5 files changed, 21 insertions(+)

diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
index 118ea39..042d074 100644
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@ -130,3 +130,6 @@ u32 __hyp_text __debug_read_mdcr_el2(void)
 {
 	return read_sysreg(mdcr_el2);
 }
+
+__alias(__debug_read_mdcr_el2)
+u32 __weak __kvm_get_mdcr_el2(void);
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 7218eed..28de58f 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -175,6 +175,8 @@ ENDPROC(\label)
 
 	.align 11
 
+	.weak	__kvm_hyp_vector
+ENTRY(__kvm_hyp_vector)
 ENTRY(__hyp_vector)
 	ventry	el2t_sync_invalid		// Synchronous EL2t
 	ventry	el2t_irq_invalid		// IRQ EL2t
@@ -196,3 +198,4 @@ ENTRY(__hyp_vector)
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
 ENDPROC(__hyp_vector)
+ENDPROC(__kvm_hyp_vector)
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index cdc2a96..ef58066 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -141,6 +141,9 @@ int __hyp_text __guest_run(struct kvm_vcpu *vcpu)
 	return exit_code;
 }
 
+__alias(__guest_run)
+int __weak __kvm_vcpu_run(struct kvm_vcpu *vcpu);
+
 static const char *__hyp_panic_string = "HYP panic:\nPS:%08x PC:%p ESR:%p\nFAR:%p HPFAR:%p PAR:%p\nVCPU:%p\n";
 
 void __hyp_text __noreturn __hyp_panic(void)
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index d4a07d0..2c279a8 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -47,6 +47,9 @@ void __hyp_text __tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	write_sysreg(0, vttbr_el2);
 }
 
+__alias(__tlb_flush_vmid_ipa)
+void __weak __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
+
 void __hyp_text __tlb_flush_vmid(struct kvm *kvm)
 {
 	dsb(ishst);
@@ -63,6 +66,9 @@ void __hyp_text __tlb_flush_vmid(struct kvm *kvm)
 	write_sysreg(0, vttbr_el2);
 }
 
+__alias(__tlb_flush_vmid)
+void __weak __kvm_tlb_flush_vmid(struct kvm *kvm);
+
 void __hyp_text __tlb_flush_vm_context(void)
 {
 	dsb(ishst);
@@ -70,3 +76,6 @@ void __hyp_text __tlb_flush_vm_context(void)
 		     "ic ialluis	  ": : );
 	dsb(ish);
 }
+
+__alias(__tlb_flush_vm_context)
+void __weak __kvm_flush_vm_context(void);
diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index f2289ab..0cf316c 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -220,3 +220,6 @@ u64 __hyp_text __vgic_v3_read_ich_vtr_el2(void)
 {
 	return read_gicreg(ICH_VTR_EL2);
 }
+
+__alias(__vgic_v3_read_ich_vtr_el2)
+u64 __weak __vgic_v3_get_ich_vtr_el2(void);
-- 
2.1.4
