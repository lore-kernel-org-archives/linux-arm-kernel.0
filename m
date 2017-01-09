From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:49 -0500
Subject: [RFC 53/55] KVM: arm64: Reflect shadow VMPIDR_EL2 value to MPIDR_EL1
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-54-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A non-secure EL0 or EL1 read of MPIDR_EL1 should return the value of
VMPIDR_EL2. We emulate this by copying the virtual VMPIDR_EL2 value to
MPIDR_EL1 when entering VM's EL0 or EL1.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/context.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
index 9ebc38f..dd79b0e 100644
--- a/arch/arm64/kvm/context.c
+++ b/arch/arm64/kvm/context.c
@@ -173,6 +173,12 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
 		ctxt->hw_pstate = *vcpu_cpsr(vcpu);
 		ctxt->hw_sys_regs = ctxt->sys_regs;
 		ctxt->hw_sp_el1 = ctxt->gp_regs.sp_el1;
+
+		/*
+		 * A non-secure EL0 or EL1 read of MPIDR_EL1 returns
+		 * the value of VMPIDR_EL2.
+		 */
+		ctxt->hw_sys_regs[MPIDR_EL1] = ctxt->el2_regs[VMPIDR_EL2];
 	}
 
 	vgic_v2_setup_shadow_state(vcpu);
-- 
1.9.1
