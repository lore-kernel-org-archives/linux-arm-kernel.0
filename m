From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:41 -0500
Subject: [RFC 45/55] KVM: arm64: KVM: Inject stage-2 page faults
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-46-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Inject stage-2 page faults to the guest hypervisor.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/esr.h |  1 +
 arch/arm64/kvm/mmu-nested.c  | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index f32e3a7..6104e31 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -107,6 +107,7 @@
 #define ESR_ELx_CM 		(UL(1) << 8)
 
 /* ISS field definitions for exceptions taken in to Hyp */
+#define ESR_ELx_FSC_ADDRSZ	(0x00)
 #define ESR_ELx_CV		(UL(1) << 24)
 #define ESR_ELx_COND_SHIFT	(20)
 #define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
diff --git a/arch/arm64/kvm/mmu-nested.c b/arch/arm64/kvm/mmu-nested.c
index a2fab41..b161b55 100644
--- a/arch/arm64/kvm/mmu-nested.c
+++ b/arch/arm64/kvm/mmu-nested.c
@@ -55,22 +55,40 @@ static unsigned int pa_max(void)
 static int vcpu_inject_s2_trans_fault(struct kvm_vcpu *vcpu, gpa_t ipa,
 				      int level)
 {
-	/* TODO: Implement */
-	return -EFAULT;
+	u32 esr;
+
+	vcpu->arch.ctxt.el2_regs[FAR_EL2] = vcpu->arch.fault.far_el2;
+	vcpu->arch.ctxt.el2_regs[HPFAR_EL2] = vcpu->arch.fault.hpfar_el2;
+	esr = kvm_vcpu_get_hsr(vcpu) & ~ESR_ELx_FSC;
+	esr |= ESR_ELx_FSC_FAULT;
+	esr |= level & 0x3;
+	return kvm_inject_nested_sync(vcpu, esr);
 }
 
 static int vcpu_inject_s2_addr_sz_fault(struct kvm_vcpu *vcpu, gpa_t ipa,
 					int level)
 {
-	/* TODO: Implement */
-	return -EFAULT;
+	u32 esr;
+
+	vcpu->arch.ctxt.el2_regs[FAR_EL2] = vcpu->arch.fault.far_el2;
+	vcpu->arch.ctxt.el2_regs[HPFAR_EL2] = vcpu->arch.fault.hpfar_el2;
+	esr = kvm_vcpu_get_hsr(vcpu) & ~ESR_ELx_FSC;
+	esr |= ESR_ELx_FSC_ADDRSZ;
+	esr |= level & 0x3;
+	return kvm_inject_nested_sync(vcpu, esr);
 }
 
 static int vcpu_inject_s2_access_flag_fault(struct kvm_vcpu *vcpu, gpa_t ipa,
 					    int level)
 {
-	/* TODO: Implement */
-	return -EFAULT;
+	u32 esr;
+
+	vcpu->arch.ctxt.el2_regs[FAR_EL2] = vcpu->arch.fault.far_el2;
+	vcpu->arch.ctxt.el2_regs[HPFAR_EL2] = vcpu->arch.fault.hpfar_el2;
+	esr = kvm_vcpu_get_hsr(vcpu) & ~ESR_ELx_FSC;
+	esr |= ESR_ELx_FSC_ACCESS;
+	esr |= level & 0x3;
+	return kvm_inject_nested_sync(vcpu, esr);
 }
 
 static int check_base_s2_limits(struct kvm_vcpu *vcpu, struct s2_walk_info *wi,
-- 
1.9.1
