From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:16 -0500
Subject: [RFC 20/55] KVM: arm64: Forward CPACR_EL1 traps to the guest
 hypervisor
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-21-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward CPACR_EL1 traps to the guest hypervisor if it has configured the
virtual CPTR_EL2 to do so.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/sys_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 321ecbc..e66f40d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -951,6 +951,11 @@ static bool access_cpacr(struct kvm_vcpu *vcpu,
 		struct sys_reg_params *p,
 		const struct sys_reg_desc *r)
 {
+	/* Forward this trap to the guest hypervisor if it expects */
+	if (!vcpu_mode_el2(vcpu) &&
+	    (vcpu_el2_reg(vcpu, CPTR_EL2) & CPTR_EL2_TCPAC))
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
+
 	access_rw(p, &vcpu_sys_reg(vcpu, r->reg));
 	return true;
 }
-- 
1.9.1
