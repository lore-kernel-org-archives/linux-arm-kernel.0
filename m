From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Nov 2018 18:41:05 +0000
Subject: [PATCH v2 6/8] arm64: KVM: Add synchronization on translation regime
 change for erratum 1165522
In-Reply-To: <20181123184107.39334-1-marc.zyngier@arm.com>
References: <20181123184107.39334-1-marc.zyngier@arm.com>
Message-ID: <20181123184107.39334-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to ensure that slipping HCR_EL2.TGE is done at the right
time when switching translation regime, let insert the required ISBs
that will be patched in when erratum 1165522 is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_hyp.h |  7 +++++++
 arch/arm64/kvm/hyp/switch.c      | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 23aca66767f9..ce46bb1c5f4b 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -163,6 +163,13 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
 {
 	write_sysreg(kvm->arch.vtcr, vtcr_el2);
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+
+	/*
+	 * ARM erratum 1165522 requires the actual execution of the above
+	 * before we can switch to the EL1/EL0 translation regime used by
+	 * the guest.
+	 */
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
 }
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index a8fa61c68c32..31ee0bfc432f 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -143,6 +143,14 @@ static void deactivate_traps_vhe(void)
 {
 	extern char vectors[];	/* kernel exception vectors */
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+
+	/*
+	 * ARM erratum 1165522 requires the actual execution of the above
+	 * before we can switch to the EL2/EL0 translation regime used by
+	 * the host.
+	 */
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
 }
@@ -499,6 +507,17 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	/*
+	 * ARM erratum 1165522 requires us to configure both stage 1 and
+	 * stage 2 translation for the guest context before we clear
+	 * HCR_EL2.TGE.
+	 *
+	 * We have already configured the guest's stage 1 translation in
+	 * kvm_vcpu_load_sysregs above.  We must now call __activate_vm
+	 * before __activate_traps, because __activate_vm configures
+	 * stage 2 translation, and __activate_traps clear HCR_EL2.TGE
+	 * (among other things).
+	 */
 	__activate_vm(vcpu->kvm);
 	__activate_traps(vcpu);
 
-- 
2.19.1
