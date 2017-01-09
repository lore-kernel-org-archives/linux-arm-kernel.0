From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:12 -0500
Subject: [RFC 16/55] KVM: arm64: Forward VM reg traps to the guest hypervisor
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-17-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward virtual memory register traps to the guest hypervisor
if it has set corresponding bits to the virtual HCR_EL2.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/sys_regs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b8e993a..0f5d21b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -90,6 +90,23 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool forward_vm_traps(struct kvm_vcpu *vcpu, struct sys_reg_params *p)
+{
+	u64 hcr_el2 = vcpu_el2_reg(vcpu, HCR_EL2);
+
+	/* If this is a trap from the virtual EL2, the host handles */
+	if (vcpu_mode_el2(vcpu))
+		return false;
+
+	/* If the guest wants to trap on R/W operation, forward this trap */
+	if ((hcr_el2 & HCR_TVM) && p->is_write)
+		return true;
+	else if ((hcr_el2 & HCR_TRVM) && !p->is_write)
+		return true;
+
+	return false;
+}
+
 /*
  * Generic accessor for VM registers. Only called as long as HCR_TVM
  * is set. If the guest enables the MMU, we stop trapping the VM
@@ -101,6 +118,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 {
 	bool was_enabled = vcpu_has_cache_enabled(vcpu);
 
+	if (forward_vm_traps(vcpu, p))
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
+
 	BUG_ON(!vcpu_mode_el2(vcpu) && !p->is_write);
 
 	if (!p->is_write) {
-- 
1.9.1
