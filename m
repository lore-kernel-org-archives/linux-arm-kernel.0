From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:56 -0500
Subject: [RFC PATCH v2 30/38] KVM: arm64: Allow the virtual EL2 to access EL2
 states without trap
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-31-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the virtual E2H bit is set, we can support EL2 register accesses
via EL1 registers from the virtual EL2 by doing trap-and-emulate. A
better alternative, however, is to allow the virtual EL2 to access EL2
register states without trap. This can be easily achieved by not traping
EL1 registers since those registers already have EL2 register states.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index d513da9..fffd0c7 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -74,6 +74,7 @@ static hyp_alternate_select(__activate_traps_arch,
 static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
+	u64 vhcr_el2;
 
 	/*
 	 * We are about to set CPTR_EL2.TFP to trap all floating point
@@ -89,8 +90,26 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 		write_sysreg(1 << 30, fpexc32_el2);
 		isb();
 	}
-	if (vcpu_mode_el2(vcpu))
-		val |= HCR_TVM | HCR_TRVM;
+
+	if (is_hyp_ctxt(vcpu)) {
+		/*
+		 * For a guest hypervisor on v8.0, trap and emulate the EL1
+		 * virtual memory control register accesses.
+		 */
+		if (!vcpu_el2_e2h_is_set(vcpu))
+			val |= HCR_TVM | HCR_TRVM;
+		/*
+		 * For a guest hypervisor on v8.1 (VHE), allow to access the
+		 * EL1 virtual memory control registers natively. These accesses
+		 * are to access EL2 register states.
+		 * Note that we stil need to respect the virtual HCR_EL2 state.
+		 */
+		else {
+			vhcr_el2 = vcpu_sys_reg(vcpu, HCR_EL2);
+			val |= vhcr_el2 & (HCR_TVM | HCR_TRVM);
+		}
+	}
+
 	write_sysreg(val, hcr_el2);
 	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
 	write_sysreg(1 << 15, hstr_el2);
-- 
1.9.1
