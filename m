From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:59:02 -0500
Subject: [RFC PATCH v2 36/38] KVM: arm64: Respect virtual HCR_EL2.TVM and TRVM
 settings
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-37-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward the EL1 virtual memory register traps to the virtual EL2 if they
are not coming from the virtual EL2 and the virtual HCR_EL2.TVM or TRVM
bit is set.

This is for recursive nested virtualization.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3559cf7..3e4ec5e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -135,6 +135,27 @@ static inline bool el12_reg(struct sys_reg_params *p)
 	return (p->Op1 == 5);
 }
 
+/* This function is to support the recursive nested virtualization */
+static bool forward_vm_traps(struct kvm_vcpu *vcpu, struct sys_reg_params *p)
+{
+	u64 hcr_el2 = vcpu_sys_reg(vcpu, HCR_EL2);
+
+	/* If a trap comes from the virtual EL2, the host hypervisor handles. */
+	if (vcpu_mode_el2(vcpu))
+		return false;
+
+	/*
+	 * If the virtual HCR_EL2.TVM or TRVM bit is set, we need to foward
+	 * this trap to the virtual EL2.
+	 */
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
@@ -152,6 +173,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 	if (el12_reg(p) && forward_nv_traps(vcpu))
 		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
 
+	if (!el12_reg(p) && forward_vm_traps(vcpu, p))
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
+
 	/*
 	 * Redirect EL1 register accesses to the corresponding EL2 registers if
 	 * they are meant to access EL2 registers.
-- 
1.9.1
